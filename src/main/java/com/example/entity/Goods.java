package com.example.entity;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 二手商品
 */
@Data
public class Goods implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 名称 */
    private String name;
    /** 价格 */
    private BigDecimal price;
    /** 详情 */
    private String content;
    /** 发货地址 */
    private String address;
    /** 图片 */
    private String img;
    /** 上架日期 */
    private String date;
    /** 审核状态 */
    private String status;
    /** 分类 */
    private String category;
    /** 所属用户ID */
    private Integer userId;
    /** 上架状态 */
    private String saleStatus;
    /** 浏览量 */
    private Integer readCount;

    private String sort;

    //点赞收藏
    private Boolean userLikes;
    private Boolean userCollect;
    private Integer likesCount;
    private Integer collectCount;

    //关联查询字段
    private String userName;

}