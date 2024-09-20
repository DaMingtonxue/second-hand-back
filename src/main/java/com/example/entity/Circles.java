package com.example.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * 圈子
 */
@Data
public class Circles implements Serializable {
    private static final long serialVersionUID = 1L;

    /** ID */
    private Integer id;
    /** 缩略图 */
    private String img;
    /** 名称 */
    private String name;

}