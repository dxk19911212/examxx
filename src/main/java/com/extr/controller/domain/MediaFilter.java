package com.extr.controller.domain;

import java.io.Serializable;
import java.util.Date;

/**
 * @author Ocelot
 * @date 2014年6月8日 下午10:15:55
 */
public class MediaFilter implements Serializable {

	private static final long serialVersionUID = -4365234128110911302L;

	private Integer type;

	private String title;

	private Date beginTime;

	private Date endTime;

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
}
