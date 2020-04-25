package com.extr.persistence;

import com.extr.controller.domain.MediaFilter;
import com.extr.domain.Media;
import com.extr.util.Page;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MediaMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Media record);

    int insertSelective(Media record);

    Media selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Media record);

    int updateByPrimaryKey(Media record);

    List<Media> selectByCondition(@Param("filter") MediaFilter filter,
                                  @Param("page") Page<Media> page);
}