package com.extr.controller;

import com.extr.controller.domain.MediaFilter;
import com.extr.controller.domain.Message;
import com.extr.domain.Media;
import com.extr.file.util.FileTypeUtil;
import com.extr.security.UserInfo;
import com.extr.service.MediaService;
import com.extr.util.Page;
import com.extr.util.PagingUtil;
import com.qiniu.util.Auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

/**
 * Copyright (c) 2020 Choice, Inc. All Rights Reserved. Choice Proprietary and Confidential.
 *
 * @author jiyu@myweimai.com
 * @since 2020-04-26
 */
@Controller
public class MediaController {

    @Autowired
    private MediaService mediaService;

    @Value("${qiniu.ak}")
    private String accessKey;
    @Value("${qiniu.sk}")
    private String secretKey;
    @Value("${qiniu.bucket}")
    private String bucket;
    @Value("${qiniu.domain}")
    private String domain;

    /**
     * 资料上传
     */
    @RequestMapping(value = { "/admin/media" }, method = RequestMethod.GET)
    public String adminMedia(Model model, HttpServletRequest request) {
        return "redirect:media-0-0-1.html";
    }

    /**
     * 资料列表
     */
    @RequestMapping(value = "/admin/media-{type}-{title}-{page}.html", method = RequestMethod.GET)
    public String mediaListFilterPage(Model model,
                                      @PathVariable("type") Integer type,
                                      @PathVariable("title") String title,
                                      @PathVariable("page") int page) {
        try {
            UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext()
                    .getAuthentication()
                    .getPrincipal();
        } catch (Exception e) {
            return "login";
        }

        Page<Media> pageModel = new Page<>();
        pageModel.setPageNo(page);
        pageModel.setPageSize(10);

        MediaFilter mf = new MediaFilter();
        mf.setType(type);
        mf.setTitle("0".equals(title) ? "" : title);

        List<Media> mediaList = mediaService.getMediaListByCondition(mf, pageModel);
        String pageStr = PagingUtil.getPageBtnlink(page, pageModel.getTotalPage());

        // 保存筛选信息
        model.addAttribute("mediaFilter", mf);
        model.addAttribute("mediaList", mediaList);
        model.addAttribute("pageStr", pageStr);
        return "admin2/media";
    }

    /**
     * 首页展示-管理员
     */
    @RequestMapping(value = "/admin/homemedia-{title}.html", method = RequestMethod.GET)
    public String mediaListFilterPageAdmin(Model model,
                                           @PathVariable("title") String title) {
        Page<Media> pageModel = new Page<>();
        pageModel.setPageNo(1);
        pageModel.setPageSize(10);

        MediaFilter mf = new MediaFilter();
        mf.setTitle("0".equals(title) ? "" : title);

        List<Media> mediaList = mediaService.getMediaListByCondition(mf, pageModel);
        // 文档list
        mf.setType(2);
        pageModel.setPageSize(20);
        List<Media> mediaList2 = mediaService.getMediaListByCondition(mf, pageModel);

        // 保存筛选信息
        model.addAttribute("mediaFilter", mf);
        model.addAttribute("mediaList", mediaList);
        model.addAttribute("mediaList2", mediaList2);
        return "admin2/home";
    }

    /**
     * 资料保存
     */
    @RequestMapping(value = "admin/media-add", method = RequestMethod.POST)
    public @ResponseBody
    Message saveMedia(@RequestBody Media media){
        Message message = new Message();
        String url = media.getUrl();
        // 类型判断
        media.setType(String.valueOf(FileTypeUtil.getType(url)));
        // 去掉url后缀
        if (!StringUtils.isEmpty(url)) {
            media.setUrl(url.substring(0, url.lastIndexOf(".")));
        }
        // 如果没有缩略图，则用同一个url
        if (StringUtils.isEmpty(media.getThumbnailUrl())) {
            media.setThumbnailUrl(url.substring(0, url.lastIndexOf(".")));
        }
        media.setCreator("admin");
        media.setCreateTime(new Date());
        try{
            mediaService.saveMedia(media);
            message.setObject(media);
        }catch(Exception e){
            message.setResult(e.getClass().getName());
        }
        return message;
    }

    /**
     * 资料删除
     */
    @RequestMapping(value = "admin/media-delete", method = RequestMethod.POST)
    public @ResponseBody Message deleteMedia(@RequestBody Integer mediaId){
        Message message = new Message();
        try{
            mediaService.deleteMedia(mediaId);
        }catch(Exception e){
            message.setResult(e.getClass().getName());
        }
        return message;
    }

    /**
     * 七牛上传-前端获取token
     */
    @RequestMapping(value = { "/get-qiniu-token" }, method = RequestMethod.GET)
    public @ResponseBody
    Map<String, Object> qiniuUpToken() {
        Map<String, Object> result = new HashMap<>(6);
        try {
            // 验证七牛云身份是否通过
            Auth auth = Auth.create(accessKey, secretKey);
            // 生成凭证
            String upToken = auth.uploadToken(bucket);
            result.put("token", upToken);
            // 存入外链默认域名，用于拼接完整的资源外链路径
            result.put("domain", domain);
            // 生成实际路径名
            String randomFileName = UUID.randomUUID().toString();
            result.put("imgUrl", randomFileName);
            result.put("success", 1);
        } catch (Exception e) {
            result.put("message", "获取凭证失败，" + e.getMessage());
            result.put("success", 0);
        }
        return result;
    }
}
