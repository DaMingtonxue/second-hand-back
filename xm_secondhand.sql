/*
Navicat MySQL Data Transfer

Source Server         : ylm
Source Server Version : 80023
Source Host           : localhost:3306
Source Database       : xm_secondhand

Target Server Type    : MYSQL
Target Server Version : 80023
File Encoding         : 65001

Date: 2024-07-02 21:43:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系人姓名',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系地址',
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系电话',
  `user_id` int NOT NULL COMMENT '关联用户ID',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户地址信息表';

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('1', '联系人1', '联系地址1', '13088888888', '1');
INSERT INTO `address` VALUES ('2', 'user1', '广州市白云区', '12345678941', '3');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='管理员';

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', 'admin', '管理员', 'http://localhost:9090/files/1697438073596-avatar.png', 'ADMIN', '13677889922', 'admin@xm.com');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分类信息表';

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '类别1');
INSERT INTO `category` VALUES ('2', '类别2');
INSERT INTO `category` VALUES ('3', '类别3');

-- ----------------------------
-- Table structure for circles
-- ----------------------------
DROP TABLE IF EXISTS `circles`;
CREATE TABLE `circles` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '圈子ID',
  `img` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '圈子缩略图URL',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '圈子名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='圈子信息表';

-- ----------------------------
-- Records of circles
-- ----------------------------
INSERT INTO `circles` VALUES ('1', 'http://localhost:9090/files/1719735028997-0ac965634816934a2a51cdb1b1db4e12.png', '圈子1');
INSERT INTO `circles` VALUES ('2', 'http://localhost:9090/files/1719907393957-10e0feeb1fef923e1f764602589f0939.jpeg', '吐槽');
INSERT INTO `circles` VALUES ('3', 'http://localhost:9090/files/1719907584557-35e97ebc912ba0f5559fdf5454654df1.jpeg', '扩列');
INSERT INTO `circles` VALUES ('4', 'http://localhost:9090/files/1719907682578-d1c0e887fe073ae460cf872ed94564fa.jpeg', '八卦');

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '收藏Id',
  `fid` int DEFAULT NULL COMMENT '反馈id',
  `user_id` int DEFAULT NULL COMMENT '用户id',
  `module` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '模块',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES ('1', '3', '1', null);
INSERT INTO `collect` VALUES ('3', '2', '3', null);
INSERT INTO `collect` VALUES ('4', '8', '3', null);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '评论表id',
  `content` text NOT NULL COMMENT '评论内容',
  `user_id` int NOT NULL COMMENT '评论人ID',
  `pid` int DEFAULT NULL COMMENT '父级评论ID，用于实现评论嵌套',
  `time` datetime NOT NULL COMMENT '评论时间',
  `fid` int NOT NULL COMMENT '关联ID，可能是文章ID或帖子ID等',
  `module` varchar(50) NOT NULL COMMENT '模块，标识评论属于哪个模块或分类',
  `root_id` int DEFAULT NULL COMMENT '根节点ID，用于追踪评论的初始节点',
  `user_name` varchar(255) DEFAULT NULL COMMENT '评论人用户名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '评论人头像',
  `parent_user_name` varchar(255) DEFAULT NULL COMMENT '被回复人的用户名',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_pid` (`pid`),
  KEY `idx_fid` (`fid`),
  KEY `idx_root_id` (`root_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='评论表';

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('1', '测试评论', '1', null, '2024-06-30 15:09:50', '1', 'help', '1', null, null, null);
INSERT INTO `comment` VALUES ('2', '测试', '1', null, '2024-07-01 22:22:32', '3', 'goods', '2', null, null, null);
INSERT INTO `comment` VALUES ('3', '测试', '3', null, '2024-07-02 00:05:28', '1', 'posts', '3', null, null, null);
INSERT INTO `comment` VALUES ('5', 'v我50', '3', '3', '2024-07-02 10:39:37', '1', 'posts', '3', null, null, null);
INSERT INTO `comment` VALUES ('6', 'v', '3', '1', '2024-07-02 15:35:19', '1', 'help', '1', null, null, null);

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '反馈唯一标识ID',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '反馈主题',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '反馈内容',
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系方式',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱地址',
  `reply` text COLLATE utf8mb4_unicode_ci COMMENT '官方回复内容',
  `createtime` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `user_id` int NOT NULL COMMENT '提交人用户ID',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户反馈信息表';

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES ('1', '主题1', '内容', '13888888', '13@.com', '回复', '2024-6-29', '1');
INSERT INTO `feedback` VALUES ('2', '是', 'VS', '20240629', '123@163.com', null, '2024-06-30 15:05:12', '3');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品名称',
  `price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品价格',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品详情',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发货地址',
  `img` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品图片',
  `date` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '上架日期',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '审核状态',
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品分类',
  `user_id` int NOT NULL COMMENT '发布用户ID',
  `sale_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '上架状态',
  `read_count` int NOT NULL DEFAULT '0' COMMENT '浏览量',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_category` (`category`),
  KEY `idx_sale_status` (`sale_status`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品信息表';

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('2', '商品测试', '12', '<p>商品详情</p>', '广州市白云区', 'http://localhost:9090/files/1719728198786-f25b352ec335cbd5dd3832df9ea38a3e.jpg', '2024-06-30', '通过', '类别1', '1', '上架', '14');
INSERT INTO `goods` VALUES ('3', '11', '2222', '', '广州市白云区', 'http://localhost:9090/files/1719841560954-f25b352ec335cbd5dd3832df9ea38a3e.jpg', '2024-07-01', '通过', '类别1', '1', '未上架', '14');
INSERT INTO `goods` VALUES ('4', '测试发布视频', '12', '<p>测试</p>', '广州市白云区', 'http://localhost:9090/files/1719847448280-0ac965634816934a2a51cdb1b1db4e12.png', '2024-07-01', '通过', '类别1', '1', '上架', '4');
INSERT INTO `goods` VALUES ('5', 'user1发布商品测试', '11', '<p>user1的商品</p>', '广州市白云区', 'http://localhost:9090/files/1719851081989-66734e739074e4a91ae537bd6c52e37c.jpg', '2024-07-02', '通过', '类别1', '3', '上架', '2');
INSERT INTO `goods` VALUES ('6', '测试2', '2', '<p>测试</p>', '广州市白云区', 'http://localhost:9090/files/1719851561184-ac42d5febb21c554737f209078e49ccb.jpg', '2024-07-02', '通过', '类别1', '3', '上架', '4');
INSERT INTO `goods` VALUES ('7', '乒乓球五个', '2', '<p>测试</p>', '广州市白云区', 'http://localhost:9090/files/1719892044634-0ac965634816934a2a51cdb1b1db4e12.png', '2024-07-02', '通过', '测试', '1', '上架', '5');
INSERT INTO `goods` VALUES ('8', '测试', '12', '<p>测试</p>', '广州市白云区', 'http://localhost:9090/files/1719899509581-jishoudingdanxinxi_tupian6.jpg', '2024-07-02', '通过', '测试', '1', '上架', '1');
INSERT INTO `goods` VALUES ('9', 'test', '10', '<p>12345</p>', '广州市白云区', 'http://localhost:9090/files/1719904205780-dingdanxinxi_tupian6.jpg', '2024-07-02', '通过', '测试', '1', '上架', '7');

-- ----------------------------
-- Table structure for help
-- ----------------------------
DROP TABLE IF EXISTS `help`;
CREATE TABLE `help` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '求购信息ID',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '求购标题',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '求购内容详情',
  `img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '求购图片URL',
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '求购状态',
  `user_id` int NOT NULL COMMENT '发布用户ID',
  `time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发布时间',
  `solved` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否解决',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_solved` (`solved`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='求购信息表';

-- ----------------------------
-- Records of help
-- ----------------------------
INSERT INTO `help` VALUES ('1', '标题', '内容', 'http://localhost:9090/files/1719728258003-ac42d5febb21c554737f209078e49ccb.jpg', '通过', '1', '2024-6-29', '否');
INSERT INTO `help` VALUES ('2', '测试求购', '测试', 'http://localhost:9090/files/1719886898205-0ac965634816934a2a51cdb1b1db4e12.png', '待审核', '3', '2024-07-02 10:21:43', '未解决');

-- ----------------------------
-- Table structure for likes
-- ----------------------------
DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '点赞id',
  `fid` int DEFAULT NULL COMMENT '反馈id',
  `user_id` int DEFAULT NULL COMMENT '用户id',
  `module` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '模块',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `fid` (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of likes
-- ----------------------------
INSERT INTO `likes` VALUES ('1', null, '1', null);
INSERT INTO `likes` VALUES ('2', '1', '1', null);
INSERT INTO `likes` VALUES ('3', '1', '1', null);
INSERT INTO `likes` VALUES ('7', '8', '3', null);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建时间',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='公告信息表';

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES ('1', '今天系统正式上线，开始内测', '今天系统正式上线，开始内测', '2024-06-29', 'admin');
INSERT INTO `notice` VALUES ('2', '所有功能都已完成，可以正常使用', '所有功能都已完成，可以正常使用', '2024-06-29', 'admin');
INSERT INTO `notice` VALUES ('3', '今天天气很不错，可以出去一起玩了', '今天天气很不错，可以出去一起玩了', '2024-06-29', 'admin');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品名称',
  `goods_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品图片',
  `order_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单编号',
  `total` decimal(10,2) NOT NULL COMMENT '总价',
  `time` datetime NOT NULL COMMENT '下单时间',
  `pay_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '支付单号',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `user_id` int NOT NULL COMMENT '下单人ID',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '收货地址',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '联系方式',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '收货人名称',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '订单状态',
  `sale_id` int NOT NULL COMMENT '卖家ID',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_sale_id` (`sale_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单信息表';

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('1', '11', 'http://localhost:9090/files/1719841560954-f25b352ec335cbd5dd3832df9ea38a3e.jpg', '17198447101577258511', '2222.00', '2024-07-01 22:38:30', '20240701608161626642', null, '1', '联系地址1', '13088888888', 'null', '已完成', '1');
INSERT INTO `orders` VALUES ('2', '测试发布视频', 'http://localhost:9090/files/1719847448280-0ac965634816934a2a51cdb1b1db4e12.png', '17198475476564473667', '12.00', '2024-07-01 23:25:47', '20240702300713710038', null, '3', '广州市白云区', '12345678941', null, '已完成', '1');
INSERT INTO `orders` VALUES ('3', '测试发布视频', 'http://localhost:9090/files/1719847448280-0ac965634816934a2a51cdb1b1db4e12.png', '17198475822171655525', '12.00', '2024-07-01 23:26:22', '20240702474434795595', null, '3', '广州市白云区', '12345678941', 'user1', '已完成', '1');
INSERT INTO `orders` VALUES ('4', '商品测试', 'http://localhost:9090/files/1719728198786-f25b352ec335cbd5dd3832df9ea38a3e.jpg', '17198896641110551831', '12.00', '2024-07-02 11:07:44', '20240702353867474030', null, '3', '广州市白云区', '12345678941', '86150', '已完成', '1');
INSERT INTO `orders` VALUES ('5', '乒乓球五个', 'http://localhost:9090/files/1719892044634-0ac965634816934a2a51cdb1b1db4e12.png', '17198921380109254203', '2.00', '2024-07-02 11:48:58', '20240702590541371753', '2024-07-02 11:52:36', '3', '广州市白云区', '12345678941', null, '已完成', '1');
INSERT INTO `orders` VALUES ('6', '测试2', 'http://localhost:9090/files/1719851561184-ac42d5febb21c554737f209078e49ccb.jpg', '17198930906152246362', '2.00', '2024-07-02 12:04:50', '20240702092025567682', '2024-07-02 12:05:27', '1', '联系地址1', '13088888888', null, '已完成', '3');
INSERT INTO `orders` VALUES ('7', '测试', 'http://localhost:9090/files/1719899509581-jishoudingdanxinxi_tupian6.jpg', '17198996179802737017', '12.00', '2024-07-02 13:53:37', '20240702266870958438', '2024-07-02 14:34:49', '3', '广州市白云区', '12345678941', null, '已完成', '1');
INSERT INTO `orders` VALUES ('8', 'test', 'http://localhost:9090/files/1719904205780-dingdanxinxi_tupian6.jpg', '17199048577474110600', '10.00', '2024-07-02 15:20:57', '20240702120573172952', '2024-07-02 15:28:27', '3', '广州市白云区', '12345678941', 'user1', '已完成', '1');

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '帖子ID',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '帖子标题',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '帖子内容',
  `img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '帖子图片URL',
  `user_id` int NOT NULL COMMENT '发布用户ID',
  `time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发布时间',
  `circle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所属圈子',
  `descr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '帖子简介',
  `read_count` int NOT NULL DEFAULT '0' COMMENT '浏览量',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '审核状态',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_circle` (`circle`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='社区帖子信息表';

-- ----------------------------
-- Records of posts
-- ----------------------------
INSERT INTO `posts` VALUES ('1', '标题1', '<p>内容2</p>', 'http://localhost:9090/files/1719736245959-0ac965634816934a2a51cdb1b1db4e12.png', '1', '2024-6-30', '圈子1', '简介', '20', '通过');
INSERT INTO `posts` VALUES ('2', '吃瓜', '<p>c</p>', 'http://localhost:9090/files/1719908281529-ccad5510e17dce97f6171625c7028093.jpeg', '1', '2024-07-02 16:18:03', '八卦', '家人们', '2', '通过');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'bobo', '123456', 'bobo', 'http://localhost:9090/files/1719729019215-f25b352ec335cbd5dd3832df9ea38a3e.jpg', 'USER', '123456789', 'ada@.com');
INSERT INTO `user` VALUES ('2', 'xm', '111', '小明', 'http://localhost:9090/files/1719724346610-66734e739074e4a91ae537bd6c52e37c.jpg', 'USER', '12345678911', '123@163.com');
INSERT INTO `user` VALUES ('3', 'user1', '123456', 'user1', 'http://localhost:9090/files/1719886197821-66734e739074e4a91ae537bd6c52e37c.jpg', 'USER', '12344575557', '66666@163.com');
