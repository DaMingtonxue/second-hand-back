package com.example.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * 反馈信息
 */
@Data
public class Feedback implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 主题 */
    private String title;
    /** 内容 */
    private String content;
    /** 联系方式 */
    private String phone;
    /** 邮箱 */
    private String email;
    /** 回复 */
    private String reply;
    /** 创建时间 */
    private String createtime;
    /** 提交人ID */
    private Integer userId;


    //关联字段
    private String userName;

}