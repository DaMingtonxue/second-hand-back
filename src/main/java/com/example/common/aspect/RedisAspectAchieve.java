package com.example.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.lang.reflect.Method;

@Aspect
@Component
public class RedisAspectAchieve {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    @Around("@annotation(com.example.common.aspect.RedisAspect)")
    public Object aroundAdvice(ProceedingJoinPoint joinPoint) throws Throwable {
        RedisAspect redisAspect = getRedisAspectAnnotation(joinPoint);
        if (redisAspect != null) {
            String key = redisAspect.key();
            try {
                Object result = joinPoint.proceed();
                redisTemplate.opsForValue().set(key, null);
                return result;
            } catch (Exception e) {
                // 重新抛出异常，或者可以记录日志等处理
                throw e;
            }
        }
        return joinPoint.proceed(); // 如果没有注解，正常执行方法
    }

    /**
     * 从JoinPoint中获取RedisAspect注解实例。
     *
     * @param joinPoint AOP框架提供的JoinPoint对象，代表被拦截的方法的执行点。
     * @return 返回RedisAspect注解实例，如果被拦截的方法上有此注解定义的话。
     */
    private RedisAspect getRedisAspectAnnotation(ProceedingJoinPoint joinPoint) {
        // 从JoinPoint获取方法签名，它包含了被拦截方法的信息
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();

        // 通过方法签名获取实际的方法对象
        Method method = signature.getMethod();

        // 从方法对象中获取RedisAspect注解
        // 如果该方法上有此注解定义，则返回注解实例；否则返回null
        return method.getAnnotation(RedisAspect.class);
    }
}