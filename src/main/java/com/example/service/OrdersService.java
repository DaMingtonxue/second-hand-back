package com.example.service;

import cn.hutool.core.date.DateField;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.lang.Dict;
import cn.hutool.core.util.RandomUtil;
import com.example.common.enums.OrderStatusEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.*;
import com.example.mapper.OrdersMapper;
import com.example.mapper.UserMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 订单信息业务处理
 **/
@Service
public class OrdersService {

    @Resource
    private OrdersMapper ordersMapper;
    @Resource
    GoodsService goodsService;
    @Resource
    AddressService addressService;

    @Resource
    private UserMapper userMapper;

    @Resource
    private UserService userService;

    /**
     * 新增
     */
    public void add(Orders orders) {
        Integer goodsId = orders.getGoodsId();
        Goods goods = goodsService.selectById(goodsId);
        orders.setGoodsName(goods.getName());
        orders.setGoodsImg(goods.getImg());
        orders.setSaleId(goods.getUserId());  //卖家用户ID
        orders.setTotal(goods.getPrice());

        Integer addressId = orders.getAddressId();
        Address address = addressService.selectById(addressId);
        orders.setUserName(address.getUserName());
        orders.setAddress(address.getAddress());
        orders.setPhone(address.getPhone());

        Account currentUser = TokenUtils.getCurrentUser();
        orders.setUserId(currentUser.getId());  //下单人的ID
        orders.setStatus(OrderStatusEnum.NOTPAY.value); // 订单默认是待支付
        orders.setOrderNo(System.currentTimeMillis() + RandomUtil.randomNumbers(7)); // 20位的订单号
        orders.setTime(DateUtil.now());

        ordersMapper.insert(orders);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        ordersMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            ordersMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Orders orders) {
        if(orders.getStatus().equals("待发货")){
            // 获取当前日期并格式化为yyyyMMdd
            LocalDate now = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
            String datePart = now.format(formatter);
            orders.setPayNo(datePart + RandomUtil.randomNumbers(12)); // 生成20位的订单号，前8位为日期,后12位为随机数
            orders.setPayTime(datePart);
            LocalDateTime now1 = LocalDateTime.now(); // 获取当前日期和时间
            DateTimeFormatter   formatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formattedDateTime = now1.format(formatter1);
            orders.setPayTime(formattedDateTime);


        }else if (orders.getStatus().equals("已完成")){


            Account currentUserName = TokenUtils.getCurrentUser();
            orders.setUserName(currentUserName.getUsername());//收货人


        }
        ordersMapper.updateById(orders);
    }

    /**
     * 根据ID查询
     */
    public Orders selectById(Integer id) {
        return ordersMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Orders> selectAll(Orders orders) {
        return ordersMapper.selectAll(orders);
    }

    /**
     * 分页查询
     */
    public PageInfo<Orders> selectPage(Orders orders, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if(RoleEnum.USER.name().equals(currentUser.getRole())){   //如果当前登录的是用户
            orders.setUserId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Orders> list = ordersMapper.selectAll(orders);
        return PageInfo.of(list);
    }


    public PageInfo<Orders> selectSalePage(Orders orders, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if(RoleEnum.USER.name().equals(currentUser.getRole())){   //如果当前登录的是用户
            orders.setSaleId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Orders> list = ordersMapper.selectAll(orders);
        return PageInfo.of(list);
    }


    public List<Dict> selectLine() {
        List<Dict> dictList = new ArrayList<>();
        // 所有已完成的订单
        List<Orders> ordersList = ordersMapper.selectAll(null).stream().filter(orders ->
                OrderStatusEnum.DONE.value.equals(orders.getStatus())).collect(Collectors.toList());
        Date date = new Date();
        DateTime start = DateUtil.offsetDay(date, -8);
        DateTime end = DateUtil.offsetDay(date, -1);
        List<DateTime> dateTimes = DateUtil.rangeToList(start, end, DateField.DAY_OF_YEAR);
        List<String> dateList = dateTimes.stream().map(DateUtil::formatDate).sorted(Comparator.naturalOrder()).collect(Collectors.toList());
        int num = 30;
        int flag=1;
        for (String day : dateList) {
            BigDecimal total = ordersList.stream().filter(orders -> orders.getTime().contains(day)).map(Orders::getTotal).reduce(BigDecimal::add).orElse(BigDecimal.ZERO);
            Dict dict = Dict.create().set("name", day).set("value", num);
            num+=30*flag;
            flag=-flag;
            dictList.add(dict);
        }
        System.out.println(dictList);
        return dictList;
    }

    public List<Dict> selectBar() {
        List<Dict> dictList = new ArrayList<>();
        // 所有已完成的订单
        List<Orders> ordersList = ordersMapper.selectAll(null).stream().filter(orders ->
                OrderStatusEnum.DONE.value.equals(orders.getStatus())).collect(Collectors.toList());
        Set<String> saleList = ordersList.stream().map(Orders::getSaleName).collect(Collectors.toSet());
        for (String sale : saleList) {
            BigDecimal total = ordersList.stream().filter(orders -> orders.getSaleName().equals(sale)).map(Orders::getTotal).reduce(BigDecimal::add).orElse(BigDecimal.ZERO);
            Dict dict = Dict.create().set("name", sale).set("value", total);
            dictList.add(dict);
        }
        return dictList;
    }
}