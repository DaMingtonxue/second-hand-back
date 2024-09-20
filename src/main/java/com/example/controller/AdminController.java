package com.example.controller;

import com.example.common.Result;
import com.example.common.aspect.RedisAspect;
import com.example.entity.Admin;
import com.example.service.AdminService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;

/**
 * 管理员前端操作接口
 **/
@RestController
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private RedisTemplate redisTemplate;

    @Resource
    private AdminService adminService;

    /**
     * 新增
     */

    @RedisAspect(key="adminList")
    @PostMapping("/add")
    public Result add(@RequestBody Admin admin) {
        adminService.add(admin);
        return Result.success();
    }

    /**
     * 删除
     */
    @RedisAspect(key="adminList")
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        adminService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @RedisAspect(key="adminList")
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        adminService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @RedisAspect(key="adminList")
    @PutMapping("/update")
    public Result updateById(@RequestBody Admin admin) {
        adminService.updateById(admin);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Admin admin = adminService.selectById(id);
        return Result.success(admin);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Admin admin ) {
        List<Admin> list = adminService.selectAll(admin);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Admin admin,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
//        PageInfo<Admin> page = adminService.selectPage(admin, pageNum, pageSize);
//        return Result.success(page);
        PageInfo<Admin> page = (PageInfo<Admin>) redisTemplate.opsForValue().get("adminList");
        if(admin!=null){
            page=null;
        }
        if(page==null){
            page=adminService.selectPage(admin, pageNum, pageSize);
            redisTemplate.opsForValue().set("adminList",page);
        }
        return Result.success(page);
    }

}