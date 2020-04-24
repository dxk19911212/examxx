package com.extr.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.extr.controller.domain.PaperFilter;
import com.extr.controller.domain.QuestionFilter;
import com.extr.controller.domain.QuestionImproveResult;
import com.extr.domain.exam.ExamHistory;
import com.extr.domain.exam.ExamPaper;
import com.extr.domain.question.Field;
import com.extr.domain.question.KnowledgePoint;
import com.extr.domain.question.Question;
import com.extr.domain.question.QuestionHistory;
import com.extr.domain.question.UserQuestionHistory;
import com.extr.security.UserInfo;
import com.extr.service.ExamService;
import com.extr.service.QuestionService;
import com.extr.service.UserService;
import com.extr.util.Page;
import com.extr.util.PagingUtil;
import com.extr.util.xml.DateUtil;

@Controller
public class BaseController {

	@Autowired
	private ExamService examService;
	@Autowired
	private UserService userService;
	@Autowired
	private QuestionService questionService;

	@Value("${file.upload-path}")
	private String filePath;

	/**
	 * 网站首页
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest request) {
		return "redirect:home";
	}

	/**
	 * 管理员入口
	 */
	@RequestMapping(value = { "/admin/home" }, method = RequestMethod.GET)
	public String adminHome(Model model, HttpServletRequest request) {
		return "admin2/home";
	}

	/**
	 * 判断不同角色返回的页面
	 */
	@RequestMapping(value = { "home" }, method = RequestMethod.GET)
	public String directToBaseHomePage(Model model, HttpServletRequest request) {
		try {
			UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext()
					.getAuthentication()
					.getPrincipal();
		} catch (Exception e) {
			return "login";
		}

		String result = request.getParameter("result");
		if ("failed".equals(result)) {
			model.addAttribute("result_msg", "登录失败");
		}

		if (SecurityContextHolder.getContext().getAuthentication() == null){
			this.appendBaseInfo(model);
			return "home";
		}
		if (SecurityContextHolder.getContext().getAuthentication().getPrincipal().toString().endsWith("anonymousUser")){
			this.appendBaseInfo(model);
			return "home";
		}
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Collection<? extends GrantedAuthority> grantedAuthorities = userDetails.getAuthorities();

		if (grantedAuthorities.contains(new GrantedAuthorityImpl("ROLE_ADMIN"))) {
			return "redirect:admin/home";
		} else if (grantedAuthorities.contains(new GrantedAuthorityImpl("ROLE_TEACHER"))) {
			return "redirect:teacher/home";
		} else if (grantedAuthorities.contains(new GrantedAuthorityImpl("ROLE_STUDENT"))) {
			this.appendBaseInfo(model);

			return "home";
		} else {
			return "home";
		}
	}

	/**
	 * 跳转模拟考试（员工）
	 */
	@RequestMapping(value = { "/student/practice" }, method = RequestMethod.GET)
	public String toPractice(Model model, HttpServletRequest request) {
		try {
			UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext()
					.getAuthentication()
					.getPrincipal();
		} catch (Exception e) {
			return "login";
		}
		this.appendBaseInfo(model);
		return "student2/practice";
	}

	/**
	 * 跳转正式考试（员工）
	 */
	@RequestMapping(value = { "/student/exam" }, method = RequestMethod.GET)
	public String toExam(Model model, HttpServletRequest request) {
		try {
			UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext()
					.getAuthentication()
					.getPrincipal();
		} catch (Exception e) {
			return "login";
		}
		this.appendBaseInfo(model);
		return "student2/exam";
	}

	/**
	 * 成绩列表
	 */
	@RequestMapping(value = "/student/result", method = RequestMethod.GET)
	public String studentResult(Model model, HttpServletRequest request){

		UserInfo userInfo;
		try {
			userInfo = (UserInfo) SecurityContextHolder.getContext()
					.getAuthentication()
					.getPrincipal();
		} catch (Exception e) {
			return "login";
		}

		int index = 1;
		if(request.getParameter("page") != null) {
			index = Integer.parseInt(request.getParameter("page"));
		}

		Page<ExamHistory> pageModel = new Page<ExamHistory>();
		//pageModel.setPageSize(1);
		pageModel.setPageNo(index);
		List<ExamHistory> hisList = examService.getUserExamHistoryListByUserId(userInfo.getUserid(),pageModel);
		model.addAttribute("hisList", hisList);
		String pageStr = PagingUtil.getPagelink(index, pageModel.getTotalPage(), "", "student/exam-his");
		model.addAttribute("pageStr", pageStr);
		return "student2/result";
	}

	/**
	 * 用户信息查看
	 */
	@RequestMapping(value = { "/student/info/{username}" }, method = RequestMethod.GET)
	public String studentInfo(@PathVariable String username, Model model) {
		model.addAttribute("username", username);
		return "student2/usercenter";
	}

	/**
	 * 跳转试题管理（管理员）
	 */
	@RequestMapping(value = { "/admin/question" }, method = RequestMethod.GET)
	public String toManage(Model model, HttpServletRequest request) {
		this.appendBaseInfo(model);
		return "redirect:question-0-0-0-0-1.html";
	}

	/**
	 * 试题列表
	 */
	@RequestMapping(value = "/admin/question-{fieldId}-{knowledge}-{questionType}-{searchParam}-{page}.html", method = RequestMethod.GET)
	public String questionListFilterPage(Model model,
										 @PathVariable("fieldId") int fieldId,
										 @PathVariable("knowledge") int knowledge,
										 @PathVariable("questionType") int questionType,
										 @PathVariable("searchParam") String searchParam,
										 @PathVariable("page") int page) {

		UserInfo userInfo;
		try {
			userInfo = (UserInfo) SecurityContextHolder.getContext()
					.getAuthentication()
					.getPrincipal();
		} catch (Exception e) {
			return "login";
		}

		Page<Question> pageModel = new Page<Question>();
		pageModel.setPageNo(page);
		pageModel.setPageSize(20);

		QuestionFilter qf = new QuestionFilter();
		qf.setFieldId(fieldId);
		qf.setKnowledge(knowledge);
		qf.setQuestionType(questionType);
		qf.setSearchParam("0".equals(searchParam) ? "" : searchParam);

		List<Question> questionList = questionService.getQuestionList(pageModel, qf);
		String pageStr = PagingUtil.getPageBtnlink(page, pageModel.getTotalPage());

		// 题库
		model.addAttribute("fieldList", questionService.getAllField(null));
		// 知识点
		model.addAttribute("knowledgeList", questionService.getKnowledgePointByFieldId(fieldId,null));
		// 知识分类
		model.addAttribute("questionTypeList", questionService.getQuestionTypeList());
		// 标签
		model.addAttribute("tagList", questionService.getTagByUserId(userInfo.getUserid(), null));
		// 保存筛选信息
		model.addAttribute("questionFilter", qf);

		model.addAttribute("questionList", questionList);
		model.addAttribute("pageStr", pageStr);
		return "admin2/question";
	}

	/**
	 * 跳转试卷管理（管理员）
	 */
	@RequestMapping(value = { "/admin/paper" }, method = RequestMethod.GET)
	public String toManagePapers(Model model, HttpServletRequest request) {
		this.appendBaseInfo(model);
		return "redirect:paper-0-0-0-0-0-1.html";
	}

	/**
	 * 试卷列表
	 */
	@RequestMapping(value = "/admin/paper-{status}-{departments}-{categories}-{starttime}-{name}-{page}.html", method = RequestMethod.GET)
	public String exampaperListFilterPage(Model model,
										  @PathVariable("status") String status,
										  @PathVariable("departments") String departments,
										  @PathVariable("categories") String categories,
										  @PathVariable("starttime") String starttime,
										  @PathVariable("name") String name,
										  @PathVariable("page") int page) {
		try {
			UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext()
					.getAuthentication()
					.getPrincipal();
		} catch (Exception e) {
			return "login";
		}

		Page<ExamPaper> pageModel = new Page<ExamPaper>();
		pageModel.setPageNo(page);
		pageModel.setPageSize(15);

		PaperFilter pf = new PaperFilter();
		pf.setStatus(status);
		pf.setDepartments("0".equals(departments) ? "" : departments);
		pf.setCategories("0".equals(categories) ? "" : categories);
		pf.setStarttime("0".equals(starttime) ? "" : DateUtil.timeStamp2Date(starttime, null));
		pf.setName("0".equals(name) ? "" : name);

		List<ExamPaper> paperList = examService.getExamPaperList(pf, pageModel);
		String pageStr = PagingUtil.getPageBtnlink(page, pageModel.getTotalPage());

		// 开放部门 todo
		model.addAttribute("departmentList", null);
		// 开放警种 todo
		model.addAttribute("categoryList", null);
		// 保存筛选信息
		model.addAttribute("paperFilter", pf);

		model.addAttribute("paperList", paperList);
		model.addAttribute("pageStr", pageStr);
		return "admin2/paper";
	}

	public enum UserType {
		admin, teacher, student;
	}


	public void appendBaseInfo(Model model){
		List<ExamPaper> historypaper = examService.getExamPaperList4Exam(1);
		List<ExamPaper> practicepaper = examService.getExamPaperList4Exam(2);
		List<ExamPaper> expertpaper = examService.getExamPaperList4Exam(3);



		Object userInfo = SecurityContextHolder.getContext()
			    .getAuthentication()
			    .getPrincipal();
		List<KnowledgePoint> kl =null;
		List<Integer> idList = new ArrayList<Integer>();
		Map<String,List<QuestionImproveResult>> classifyMap = new HashMap<String,List<QuestionImproveResult>>();
		int fieldId = questionService.getMinFieldId();
		UserQuestionHistory history = new UserQuestionHistory();
		if(userInfo instanceof String){
			kl = questionService.getKnowledgePointByFieldId(fieldId,null);
		}else{
			List<KnowledgePoint> kpz = questionService.getKnowledgePointByFieldId(fieldId,null);
			kl = questionService.getKnowledgePointByFieldId( ((UserInfo)userInfo).getFieldId(),null);

			kpz.addAll(kl);
			kl = kpz;
			history = questionService.getUserQuestionHistoryByUserId(((UserInfo)userInfo).getUserid());
		}
		for(KnowledgePoint klp : kl){
			idList.add(klp.getPointId());
		}
		//错题对应的知识点
		Map<String,Map<Integer,Integer>> wrongKnowledgeMap = new HashMap<String,Map<Integer,Integer>>();
		List<QuestionImproveResult> questionImproveList = questionService.getQuestionImproveResultByQuestionPointIdList(idList);
		Map<Integer,QuestionHistory> rightMap = new HashMap<Integer,QuestionHistory>();
		Map<Integer,QuestionHistory> wrongMap = new HashMap<Integer,QuestionHistory>();
		Map<Integer,QuestionHistory> otherMap = new HashMap<Integer,QuestionHistory>();
		if(history != null){
			if(history.getHistory() != null){
				if(history.getHistory().containsKey(1))
					rightMap = history.getHistory().get(1);
				if(history.getHistory().containsKey(0))
					wrongMap = history.getHistory().get(0);
				if(history.getHistory().containsKey(-1))
					otherMap = history.getHistory().get(-1);
			}

		}

		if(wrongMap != null){
			Iterator<Integer> it = wrongMap.keySet().iterator();
			while(it.hasNext()){
				int key = it.next();
				for(KnowledgePoint klp : kl){
					if(klp.getPointId() == wrongMap.get(key).getPointId()){
						Map<Integer,Integer> map = new HashMap<Integer,Integer>();
						if(wrongKnowledgeMap.containsKey(klp.getPointName())){
							map = wrongKnowledgeMap.get(klp.getPointName());
						} else {
							map.put(klp.getPointId(), 0);
						}
						map.put(klp.getPointId(), map.get(klp.getPointId()) + 1);
						wrongKnowledgeMap.put(klp.getPointName(), map);
					}

				}
			}

		}
		for(QuestionImproveResult qir : questionImproveList){
			List<QuestionImproveResult> tmpList = new ArrayList<QuestionImproveResult>();
			if(classifyMap.containsKey(qir.getQuestionPointName()))
				tmpList = classifyMap.get(qir.getQuestionPointName());
			else
				tmpList = new ArrayList<QuestionImproveResult>();
			//错题总数和对题总数处理

			if(rightMap == null)
				qir.setRightTimes(0);
			else{
				Iterator<Integer> rightIt = rightMap.keySet().iterator();
				//客观题默认是正确的
				Iterator<Integer> otherIt = otherMap.keySet().iterator();
				int rightCount = 0;
				while(rightIt.hasNext()){
					int key = rightIt.next();
					QuestionHistory qh = rightMap.get(key);
					if(qh.getPointId() == qir.getQuestionPointId() && qh.getQuestionTypeId() == qir.getQuestionTypeId())
						rightCount ++;
				}
				while(otherIt.hasNext()){
					int key = otherIt.next();
					QuestionHistory qh = otherMap.get(key);
					if(qh.getPointId() == qir.getQuestionPointId() && qh.getQuestionTypeId() == qir.getQuestionTypeId())
						rightCount ++;
				}
				qir.setRightTimes(rightCount);
			}
			if(wrongMap == null)
				qir.setWrongTimes(0);
			else{
				Iterator<Integer> wrongIt = wrongMap.keySet().iterator();
				int wrongCount = 0;
				while(wrongIt.hasNext()){
					int key = wrongIt.next();
					QuestionHistory qh = wrongMap.get(key);
					if(qh.getPointId() == qir.getQuestionPointId() && qh.getQuestionTypeId() == qir.getQuestionTypeId())
						wrongCount ++;

				}
				qir.setWrongTimes(wrongCount);
			}
			tmpList.add(qir);
			classifyMap.put(qir.getQuestionPointName(), tmpList);
		}



		model.addAttribute("classifyMap", classifyMap);
		model.addAttribute("wrongKnowledgeMap", wrongKnowledgeMap);
		model.addAttribute("historypaper", historypaper);
		model.addAttribute("practicepaper", practicepaper);
		model.addAttribute("expertpaper", expertpaper);
		model.addAttribute("knowledgelist", kl);

	}

	/**
	 * 上传图片
	 */
	@RequestMapping(value="/upload-img", method=RequestMethod.POST)
    @ResponseBody
	public String handleFileUpload(MultipartHttpServletRequest request){
		Iterator<String> iterator = request.getFileNames();
		String fileName = "";

		while (iterator.hasNext()) {
		MultipartFile multipartFile = request.getFile(iterator.next());
		fileName = UUID.randomUUID() + "_" + multipartFile.getOriginalFilename();
			try {
				File file = new File(filePath, fileName);
				if (!file.getParentFile().exists()) {
					file.getParentFile().mkdirs();
				}
				multipartFile.transferTo(file);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return filePath + "/" + fileName;
	}

	/**
	 * 资料上传
	 */
	@RequestMapping(value = { "/admin/upload-data" }, method = RequestMethod.GET)
	public String adminDataUpload(Model model, HttpServletRequest request) {
		return "admin2/data-upload";
	}
}








