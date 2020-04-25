package com.extr.service;

import com.extr.controller.domain.MediaFilter;
import com.extr.domain.Media;
import com.extr.util.Page;

import java.util.List;

/**
 * Copyright (c) 2020 Choice, Inc. All Rights Reserved. Choice Proprietary and Confidential.
 *
 * @author jiyu@myweimai.com
 * @since 2020-04-25
 */
public interface MediaService {
    List<Media> getMediaListByCondition(MediaFilter mf, Page<Media> page);

    void saveMedia(Media media);

    void deleteMedia(Integer mediaId);
}
