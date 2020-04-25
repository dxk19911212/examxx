package com.extr.service;

import com.extr.controller.domain.MediaFilter;
import com.extr.domain.Media;
import com.extr.persistence.MediaMapper;
import com.extr.util.Page;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Copyright (c) 2020 Choice, Inc. All Rights Reserved. Choice Proprietary and Confidential.
 *
 * @author jiyu@myweimai.com
 * @since 2020-04-25
 */
@Service("mediaService")
public class MediaServiceImpl implements MediaService{

    @Autowired
    private MediaMapper mediaMapper;

    @Override
    public List<Media> getMediaListByCondition(MediaFilter mf, Page<Media> page) {
        return mediaMapper.selectByCondition(mf, page);
    }

    @Override
    public void saveMedia(Media media) {
        mediaMapper.insertSelective(media);
    }

    @Override
    public void deleteMedia(Integer mediaId) {
        mediaMapper.deleteByPrimaryKey(mediaId);
    }
}
