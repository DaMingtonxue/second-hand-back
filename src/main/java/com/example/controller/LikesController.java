package com.example.controller;

import com.example.common.Result;
import com.example.entity.Likes;
import com.example.service.LikesService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
@CrossOrigin
@RestController
@RequestMapping("/likes")
//点赞
public class LikesController {

    @Resource
    LikesService likesService;

    @PostMapping("/add")
    public Result add(@RequestBody Likes likes) {
        likesService.add(likes);
        return Result.success();
    }

}