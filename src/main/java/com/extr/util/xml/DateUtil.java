package com.extr.util.xml;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Copyright (c) 2020 Choice, Inc. All Rights Reserved. Choice Proprietary and Confidential.
 *
 * @author jiyu@myweimai.com
 * @since 2020-04-25
 */
public class DateUtil {

    public static String timeStamp2Date(String timeStamp, String format) {
        if (timeStamp == null || timeStamp.isEmpty() || timeStamp.equals("null")) {
            return "";
        }
        if (format == null || format.isEmpty()) {
            format = "yyyy-MM-dd HH:mm:ss";
        }
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(new Date(Long.parseLong(timeStamp)));
    }
}
