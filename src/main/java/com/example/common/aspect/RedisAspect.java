package com.example.common.aspect;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.METHOD) // 指定注解可以用在方法上
@Retention(RetentionPolicy.RUNTIME) // 指定注解在运行时有效
public @interface RedisAspect {
    String key(); // 添加一个名为key的属性
}