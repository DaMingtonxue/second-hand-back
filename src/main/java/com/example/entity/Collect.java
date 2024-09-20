package com.example.entity;

import lombok.Data;

@Data
/*
收藏
 */
public class Collect {
    private Integer id;
    private Integer fid;
    private Integer userId;
    private String module;

    private String goodsName;
    private String goodsImg;
}
