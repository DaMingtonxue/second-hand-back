package com.example.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * 用户信息
*/
@Data
public class Category implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 名称 */
    private String name;

}