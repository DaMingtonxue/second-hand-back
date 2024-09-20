package com.example.entity;

import lombok.Data;

@Data
public class Likes {
    private Integer id;
    private Integer fid;
    private Integer userId;
    private String module;
}
