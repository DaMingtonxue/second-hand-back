package com.example.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * 收货地址
 */
@Data
public class Address implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 联系人 */
    private String name;
    /** 联系地址 */
    private String address;
    /** 联系电话 */
    private String phone;
    /** 关联用户 */
    private Integer userId;

    //关联字段
    private String userName;
}