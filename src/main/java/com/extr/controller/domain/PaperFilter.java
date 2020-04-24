package com.extr.controller.domain;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlRootElement;

/**
 * @author Ocelot
 * @date 2014年6月8日 下午10:15:55
 */
public class PaperFilter implements Serializable {

	private static final long serialVersionUID = 7944515555283401512L;

	private String status;

	private String name;

	private String departments;

	private String categories;

	private String starttime;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDepartments() {
		return departments;
	}

	public void setDepartments(String departments) {
		this.departments = departments;
	}

	public String getCategories() {
		return categories;
	}

	public void setCategories(String categories) {
		this.categories = categories;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
}
