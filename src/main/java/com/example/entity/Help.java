package com.example.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * 求购信息
 */
@Data
public class Help implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 标题 */
    private String title;
    /** 内容 */
    private String content;
    /** 图片 */
    private String img;
    /** 状态 */
    private String status;
    /** 用户ID */
    private Integer userId;
    /** 发布时间 */
    private String time;
    /** 是否解决 */
    private String solved;


    //关联字段
    private String userName;

}