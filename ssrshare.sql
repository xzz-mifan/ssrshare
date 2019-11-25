/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : ssrshare

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2019-04-16 21:03:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for se_admin
-- ----------------------------
DROP TABLE IF EXISTS `se_admin`;
CREATE TABLE `se_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) NOT NULL DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(100) NOT NULL DEFAULT '' COMMENT '头像',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `logintime` int(10) DEFAULT NULL COMMENT '登录时间',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `token` varchar(59) NOT NULL DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理员表';

-- ----------------------------
-- Records of se_admin
-- ----------------------------
INSERT INTO `se_admin` VALUES ('1', 'admin', 'Admin', '0cb0ff9660537a46bc54707eec161581', '7d69c9', '/assets/img/avatar.png', 'admin@admin.com', '0', '1555396643', '1492186163', '1555396643', '4587f47b-68e2-4582-b6e9-f8b0caaf24a1', 'normal');

-- ----------------------------
-- Table structure for se_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `se_admin_log`;
CREATE TABLE `se_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(30) NOT NULL DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) NOT NULL DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '日志标题',
  `content` text NOT NULL COMMENT '内容',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `createtime` int(10) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `name` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理员日志表';

-- ----------------------------
-- Records of se_admin_log
-- ----------------------------
INSERT INTO `se_admin_log` VALUES ('1', '1', 'admin', '/admin/index/login?url=%2Fadmin', '登录', '{\"url\":\"\\/admin\",\"__token__\":\"cc3fdce68fbaf131d8e6721410ef679e\",\"username\":\"admin\",\"captcha\":\"hcfu\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396643');
INSERT INTO `se_admin_log` VALUES ('2', '1', 'admin', '/admin/addon/install', '插件管理 安装', '{\"name\":\"command\",\"force\":\"0\",\"uid\":\"0\",\"token\":\"\",\"version\":\"1.0.5\",\"faversion\":\"1.0.0.20190410_beta\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396655');
INSERT INTO `se_admin_log` VALUES ('3', '1', 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396656');
INSERT INTO `se_admin_log` VALUES ('4', '1', 'admin', '/admin/addon/install', '插件管理 安装', '{\"name\":\"markdown\",\"force\":\"0\",\"uid\":\"0\",\"token\":\"\",\"version\":\"1.0.1\",\"faversion\":\"1.0.0.20190410_beta\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396679');
INSERT INTO `se_admin_log` VALUES ('5', '1', 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396679');
INSERT INTO `se_admin_log` VALUES ('6', '1', 'admin', '/admin/command/get_field_list', '', '{\"table\":\"se_admin\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396691');
INSERT INTO `se_admin_log` VALUES ('7', '1', 'admin', '/admin/command/get_field_list', '', '{\"table\":\"se_admin\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396734');
INSERT INTO `se_admin_log` VALUES ('8', '1', 'admin', '/admin/command/get_field_list', '', '{\"table\":\"se_share\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396746');
INSERT INTO `se_admin_log` VALUES ('9', '1', 'admin', '/admin/command/command/action/command', '', '{\"commandtype\":\"crud\",\"isrelation\":\"0\",\"local\":\"1\",\"delete\":\"0\",\"force\":\"0\",\"table\":\"se_share\",\"controller\":\"\",\"model\":\"\",\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"action\":\"command\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396772');
INSERT INTO `se_admin_log` VALUES ('10', '1', 'admin', '/admin/command/command/action/execute', '', '{\"commandtype\":\"crud\",\"isrelation\":\"0\",\"local\":\"1\",\"delete\":\"0\",\"force\":\"0\",\"table\":\"se_share\",\"controller\":\"\",\"model\":\"\",\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"action\":\"execute\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396773');
INSERT INTO `se_admin_log` VALUES ('11', '1', 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396774');
INSERT INTO `se_admin_log` VALUES ('12', '1', 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396777');
INSERT INTO `se_admin_log` VALUES ('13', '1', 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396780');
INSERT INTO `se_admin_log` VALUES ('14', '1', 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"2\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396782');
INSERT INTO `se_admin_log` VALUES ('15', '1', 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"2\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396784');
INSERT INTO `se_admin_log` VALUES ('16', '1', 'admin', '/admin/command/command/action/command', '', '{\"commandtype\":\"menu\",\"allcontroller\":\"0\",\"delete\":\"0\",\"force\":\"0\",\"controllerfile_text\":\"\",\"controllerfile\":\"Share.php\",\"action\":\"command\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396786');
INSERT INTO `se_admin_log` VALUES ('17', '1', 'admin', '/admin/command/command/action/execute', '', '{\"commandtype\":\"menu\",\"allcontroller\":\"0\",\"delete\":\"0\",\"force\":\"0\",\"controllerfile_text\":\"\",\"controllerfile\":\"Share.php\",\"action\":\"execute\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396787');
INSERT INTO `se_admin_log` VALUES ('18', '1', 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396788');
INSERT INTO `se_admin_log` VALUES ('19', '1', 'admin', '/admin/command/command/action/command', '', '{\"commandtype\":\"menu\",\"allcontroller\":\"0\",\"delete\":\"1\",\"force\":\"0\",\"controllerfile_text\":\"\",\"controllerfile\":\"Share.php\",\"action\":\"command\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396821');
INSERT INTO `se_admin_log` VALUES ('20', '1', 'admin', '/admin/command/command/action/execute', '', '{\"commandtype\":\"menu\",\"allcontroller\":\"0\",\"delete\":\"1\",\"force\":\"0\",\"controllerfile_text\":\"\",\"controllerfile\":\"Share.php\",\"action\":\"execute\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396824');
INSERT INTO `se_admin_log` VALUES ('21', '1', 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396824');
INSERT INTO `se_admin_log` VALUES ('22', '1', 'admin', '/admin/command/command/action/command', '', '{\"commandtype\":\"crud\",\"isrelation\":\"0\",\"local\":\"1\",\"delete\":\"1\",\"force\":\"0\",\"table\":\"se_share\",\"controller\":\"\",\"model\":\"\",\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"action\":\"command\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396835');
INSERT INTO `se_admin_log` VALUES ('23', '1', 'admin', '/admin/command/get_field_list', '', '{\"table\":\"se_admin\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396925');
INSERT INTO `se_admin_log` VALUES ('24', '1', 'admin', '/admin/command/get_field_list', '', '{\"table\":\"se_share\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396953');
INSERT INTO `se_admin_log` VALUES ('25', '1', 'admin', '/admin/command/command/action/command', '', '{\"commandtype\":\"crud\",\"isrelation\":\"0\",\"local\":\"1\",\"delete\":\"0\",\"force\":\"0\",\"table\":\"se_share\",\"controller\":\"ssr\\/share\",\"model\":\"\",\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"action\":\"command\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396968');
INSERT INTO `se_admin_log` VALUES ('26', '1', 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396996');
INSERT INTO `se_admin_log` VALUES ('27', '1', 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"2\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555396999');
INSERT INTO `se_admin_log` VALUES ('28', '1', 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"2\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397001');
INSERT INTO `se_admin_log` VALUES ('29', '1', 'admin', '/admin/command/command/action/command', '', '{\"commandtype\":\"menu\",\"allcontroller\":\"0\",\"delete\":\"0\",\"force\":\"0\",\"controllerfile_text\":\"\",\"controllerfile\":\"ssr\\/Share.php\",\"action\":\"command\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397003');
INSERT INTO `se_admin_log` VALUES ('30', '1', 'admin', '/admin/command/del/ids/4', '在线命令管理 删除', '{\"action\":\"del\",\"ids\":\"4\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397023');
INSERT INTO `se_admin_log` VALUES ('31', '1', 'admin', '/admin/command/del/ids/3,2,1', '在线命令管理 删除', '{\"action\":\"del\",\"ids\":\"3,2,1\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397025');
INSERT INTO `se_admin_log` VALUES ('32', '1', 'admin', '/admin/ssr/share/add?dialog=1', 'ssr 订阅管理 添加', '{\"dialog\":\"1\",\"row\":{\"name\":\"\\u8ba2\\u9605\\u5730\\u57401\",\"url\":\"https:\\/\\/raw.githubusercontent.com\\/AmazingDM\\/sub\\/master\\/ssrshare.com\",\"marker_content\":\"\\u8ba2\\u9605\\u5730\\u57401\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397087');
INSERT INTO `se_admin_log` VALUES ('33', '1', 'admin', '/admin/ssr/share/add?dialog=1', 'ssr 订阅管理 添加', '{\"dialog\":\"1\",\"row\":{\"name\":\"\\u8ba2\\u9605\\u5730\\u57402\",\"url\":\"https:\\/\\/rocket.abyss.moe\\/link\\/OC2mEjvXhVfv8rjc\",\"marker_content\":\"\\u6587\\u4ef6\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397142');
INSERT INTO `se_admin_log` VALUES ('34', '1', 'admin', '/admin/ssr/share/add?dialog=1', 'ssr 订阅管理 添加', '{\"dialog\":\"1\",\"row\":{\"name\":\"\\u8ba2\\u9605\\u5730\\u57403\",\"url\":\"https:\\/\\/prom-php.herokuapp.com\\/cloudfra_ssr.txt\",\"marker_content\":\"\\u8ba2\\u9605\\u5730\\u57403\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397178');
INSERT INTO `se_admin_log` VALUES ('35', '1', 'admin', '/admin/ssr/share/add?dialog=1', 'ssr 订阅管理 添加', '{\"dialog\":\"1\",\"row\":{\"name\":\"\\u8ba2\\u9605\\u5730\\u57404\",\"url\":\"https:\\/\\/yzzz.ml\\/freessr\\/\",\"marker_content\":\"\\u8ba2\\u9605\\u5730\\u57404\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397208');
INSERT INTO `se_admin_log` VALUES ('36', '1', 'admin', '/admin/command/get_field_list', '', '{\"table\":\"se_admin\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397257');
INSERT INTO `se_admin_log` VALUES ('37', '1', 'admin', '/admin/command/get_field_list', '', '{\"table\":\"se_ssr_config\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397265');
INSERT INTO `se_admin_log` VALUES ('38', '1', 'admin', '/admin/command/get_field_list', '', '{\"table\":\"se_admin\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397277');
INSERT INTO `se_admin_log` VALUES ('39', '1', 'admin', '/admin/command/get_field_list', '', '{\"table\":\"se_admin\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397278');
INSERT INTO `se_admin_log` VALUES ('40', '1', 'admin', '/admin/command/get_field_list', '', '{\"table\":\"se_admin\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397278');
INSERT INTO `se_admin_log` VALUES ('41', '1', 'admin', '/admin/command/get_field_list', '', '{\"table\":\"se_admin\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397278');
INSERT INTO `se_admin_log` VALUES ('42', '1', 'admin', '/admin/command/get_field_list', '', '{\"table\":\"se_share\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397284');
INSERT INTO `se_admin_log` VALUES ('43', '1', 'admin', '/admin/command/get_field_list', '', '{\"table\":\"se_share\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397284');
INSERT INTO `se_admin_log` VALUES ('44', '1', 'admin', '/admin/command/command/action/command', '', '{\"commandtype\":\"crud\",\"isrelation\":\"1\",\"local\":\"1\",\"delete\":\"0\",\"force\":\"0\",\"table\":\"se_ssr_config\",\"controller\":\"ssr\\/config\",\"model\":\"\",\"relation\":{\"2\":{\"relation\":\"se_share\",\"relationmode\":\"belongsto\",\"relationforeignkey\":\"share_id\",\"relationprimarykey\":\"id\",\"relationfields\":[\"name\"]}},\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"action\":\"command\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397308');
INSERT INTO `se_admin_log` VALUES ('45', '1', 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397318');
INSERT INTO `se_admin_log` VALUES ('46', '1', 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"2\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397319');
INSERT INTO `se_admin_log` VALUES ('47', '1', 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"2\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397321');
INSERT INTO `se_admin_log` VALUES ('48', '1', 'admin', '/admin/command/command/action/command', '', '{\"commandtype\":\"menu\",\"allcontroller\":\"0\",\"delete\":\"0\",\"force\":\"0\",\"controllerfile_text\":\"\",\"controllerfile\":\"ssr\\/Config.php\",\"action\":\"command\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555397323');
INSERT INTO `se_admin_log` VALUES ('49', '1', 'admin', '/admin/ssr/share/edit/ids/4?dialog=1', 'ssr 订阅管理 编辑', '{\"dialog\":\"1\",\"row\":{\"name\":\"\\u8ba2\\u9605\\u5730\\u57404\",\"url\":\"https:\\/\\/yzzz.ml\\/freessr\\/\",\"marker_content\":\"\\u8ba2\\u9605\\u5730\\u57404\",\"url_status\":\"1\",\"status\":\"0\"},\"ids\":\"4\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555408558');
INSERT INTO `se_admin_log` VALUES ('50', '1', 'admin', '/admin/ssr/share/edit/ids/4?dialog=1', 'ssr 订阅管理 编辑', '{\"dialog\":\"1\",\"row\":{\"name\":\"\\u8ba2\\u9605\\u5730\\u57404\",\"url\":\"https:\\/\\/yzzz.ml\\/freessr\\/\",\"marker_content\":\"\\u8ba2\\u9605\\u5730\\u57404\",\"url_status\":\"1\",\"status\":\"1\"},\"ids\":\"4\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555409067');
INSERT INTO `se_admin_log` VALUES ('51', '1', 'admin', '/admin/ssr/share/edit/ids/4?dialog=1', 'ssr 订阅管理 编辑', '{\"dialog\":\"1\",\"row\":{\"name\":\"\\u8ba2\\u9605\\u5730\\u57404\",\"url\":\"https:\\/\\/yzzz.ml\\/freessr\\/\",\"marker_content\":\"\\u8ba2\\u9605\\u5730\\u57404\",\"url_status\":\"1\",\"status\":\"0\"},\"ids\":\"4\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555409867');
INSERT INTO `se_admin_log` VALUES ('52', '1', 'admin', '/admin/ssr/share/edit/ids/3?dialog=1', 'ssr 订阅管理 编辑', '{\"dialog\":\"1\",\"row\":{\"name\":\"\\u8ba2\\u9605\\u5730\\u57403\",\"url\":\"https:\\/\\/prom-php.herokuapp.com\\/cloudfra_ssr.txt\",\"marker_content\":\"\\u8ba2\\u9605\\u5730\\u57403\",\"url_status\":\"0\",\"status\":\"1\"},\"ids\":\"3\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555409877');
INSERT INTO `se_admin_log` VALUES ('53', '1', 'admin', '/admin/ssr/share/edit/ids/3?dialog=1', 'ssr 订阅管理 编辑', '{\"dialog\":\"1\",\"row\":{\"name\":\"\\u8ba2\\u9605\\u5730\\u57403\",\"url\":\"https:\\/\\/prom-php.herokuapp.com\\/cloudfra_ssr.txt\",\"marker_content\":\"\\u8ba2\\u9605\\u5730\\u57403\",\"url_status\":\"0\",\"status\":\"0\"},\"ids\":\"3\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555409933');
INSERT INTO `se_admin_log` VALUES ('54', '1', 'admin', '/admin/ssr/share/edit/ids/1?dialog=1', 'ssr 订阅管理 编辑', '{\"dialog\":\"1\",\"row\":{\"name\":\"\\u8ba2\\u9605\\u5730\\u57401\",\"url\":\"https:\\/\\/raw.githubusercontent.com\\/AmazingDM\\/sub\\/master\\/ssrshare.com\",\"marker_content\":\"\\u8ba2\\u9605\\u5730\\u57401\",\"url_status\":\"0\",\"status\":\"1\"},\"ids\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555409940');
INSERT INTO `se_admin_log` VALUES ('55', '1', 'admin', '/admin/ssr/share/edit/ids/1?dialog=1', 'ssr 订阅管理 编辑', '{\"dialog\":\"1\",\"row\":{\"name\":\"\\u8ba2\\u9605\\u5730\\u57401\",\"url\":\"https:\\/\\/raw.githubusercontent.com\\/AmazingDM\\/sub\\/master\\/ssrshare.com\",\"marker_content\":\"\\u8ba2\\u9605\\u5730\\u57401\",\"url_status\":\"0\",\"status\":\"1\"},\"ids\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555409956');
INSERT INTO `se_admin_log` VALUES ('56', '1', 'admin', '/admin/ssr/share/edit/ids/1?dialog=1', 'ssr 订阅管理 编辑', '{\"dialog\":\"1\",\"row\":{\"name\":\"\\u8ba2\\u9605\\u5730\\u57401\",\"url\":\"https:\\/\\/raw.githubusercontent.com\\/AmazingDM\\/sub\\/master\\/ssrshare.com\",\"marker_content\":\"\\u8ba2\\u9605\\u5730\\u57401\",\"url_status\":\"0\",\"status\":\"1\"},\"ids\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555410202');
INSERT INTO `se_admin_log` VALUES ('57', '1', 'admin', '/admin/ssr/share/edit/ids/1?dialog=1', 'ssr 订阅管理 编辑', '{\"dialog\":\"1\",\"row\":{\"name\":\"\\u8ba2\\u9605\\u5730\\u57401\",\"url\":\"https:\\/\\/raw.githubusercontent.com\\/AmazingDM\\/sub\\/master\\/ssrshare.com\",\"marker_content\":\"\\u8ba2\\u9605\\u5730\\u57401\",\"url_status\":\"0\",\"status\":\"0\"},\"ids\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555413787');
INSERT INTO `se_admin_log` VALUES ('58', '1', 'admin', '/admin/ssr/share/edit/ids/4?dialog=1', 'ssr 订阅管理 编辑', '{\"dialog\":\"1\",\"row\":{\"name\":\"\\u8ba2\\u9605\\u5730\\u57404\",\"url\":\"https:\\/\\/yzzz.ml\\/freessr\\/\",\"marker_content\":\"\\u8ba2\\u9605\\u5730\\u57404\",\"url_status\":\"1\",\"status\":\"1\"},\"ids\":\"4\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555413790');
INSERT INTO `se_admin_log` VALUES ('59', '1', 'admin', '/admin/ssr/config/del/ids/51,50,49,48,47,46,45,44,43,42', 'ssr ssr配置 删除', '{\"action\":\"del\",\"ids\":\"51,50,49,48,47,46,45,44,43,42\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555419248');
INSERT INTO `se_admin_log` VALUES ('60', '1', 'admin', '/admin/ssr/config/del/ids/41,40,39,38,37,36,35,34,33,32', 'ssr ssr配置 删除', '{\"action\":\"del\",\"ids\":\"41,40,39,38,37,36,35,34,33,32\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555419252');
INSERT INTO `se_admin_log` VALUES ('61', '1', 'admin', '/admin/ssr/config/del/ids/31,30,29,28,27,26', 'ssr ssr配置 删除', '{\"action\":\"del\",\"ids\":\"31,30,29,28,27,26\",\"params\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555419255');
INSERT INTO `se_admin_log` VALUES ('62', '1', 'admin', '/admin/general.config/edit', '常规管理 系统配置 编辑', '{\"row\":{\"name\":\"laiwiAdmin\",\"beian\":\"\",\"cdnurl\":\"\",\"version\":\"1.0.1\",\"timezone\":\"Asia\\/Shanghai\",\"forbiddenip\":\"\",\"languages\":\"{\\\"backend\\\":\\\"zh-cn\\\",\\\"frontend\\\":\\\"zh-cn\\\"}\",\"fixedpage\":\"dashboard\"}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36', '1555419751');

-- ----------------------------
-- Table structure for se_attachment
-- ----------------------------
DROP TABLE IF EXISTS `se_attachment`;
CREATE TABLE `se_attachment` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '物理路径',
  `imagewidth` varchar(30) NOT NULL DEFAULT '' COMMENT '宽度',
  `imageheight` varchar(30) NOT NULL DEFAULT '' COMMENT '高度',
  `imagetype` varchar(30) NOT NULL DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片帧数',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `mimetype` varchar(100) NOT NULL DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) NOT NULL DEFAULT '' COMMENT '透传数据',
  `createtime` int(10) DEFAULT NULL COMMENT '创建日期',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `uploadtime` int(10) DEFAULT NULL COMMENT '上传时间',
  `storage` varchar(100) NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='附件表';

-- ----------------------------
-- Records of se_attachment
-- ----------------------------
INSERT INTO `se_attachment` VALUES ('1', '1', '0', '/assets/img/qrcode.png', '150', '150', 'png', '0', '21859', 'image/png', '', '1499681848', '1499681848', '1499681848', 'local', '17163603d0263e4838b9387ff2cd4877e8b018f6');

-- ----------------------------
-- Table structure for se_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `se_auth_group`;
CREATE TABLE `se_auth_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父组别',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text NOT NULL COMMENT '规则ID',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='分组表';

-- ----------------------------
-- Records of se_auth_group
-- ----------------------------
INSERT INTO `se_auth_group` VALUES ('1', '0', 'Admin group', '*', '1490883540', '149088354', 'normal');
INSERT INTO `se_auth_group` VALUES ('2', '1', 'Second group', '13,14,16,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,1,9,10,11,7,6,8,2,4,5', '1490883540', '1505465692', 'normal');
INSERT INTO `se_auth_group` VALUES ('3', '2', 'Third group', '1,4,9,10,11,13,14,15,16,17,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,5', '1490883540', '1502205322', 'normal');
INSERT INTO `se_auth_group` VALUES ('4', '1', 'Second group 2', '1,4,13,14,15,16,17,55,56,57,58,59,60,61,62,63,64,65', '1490883540', '1502205350', 'normal');
INSERT INTO `se_auth_group` VALUES ('5', '2', 'Third group 2', '1,2,6,7,8,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34', '1490883540', '1502205344', 'normal');

-- ----------------------------
-- Table structure for se_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `se_auth_group_access`;
CREATE TABLE `se_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '会员ID',
  `group_id` int(10) unsigned NOT NULL COMMENT '级别ID',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='权限分组表';

-- ----------------------------
-- Records of se_auth_group_access
-- ----------------------------
INSERT INTO `se_auth_group_access` VALUES ('1', '1');

-- ----------------------------
-- Table structure for se_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `se_auth_rule`;
CREATE TABLE `se_auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) NOT NULL DEFAULT '' COMMENT '图标',
  `condition` varchar(255) NOT NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为菜单',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `pid` (`pid`),
  KEY `weigh` (`weigh`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='节点表';

-- ----------------------------
-- Records of se_auth_rule
-- ----------------------------
INSERT INTO `se_auth_rule` VALUES ('1', 'file', '0', 'dashboard', 'Dashboard', 'fa fa-dashboard', '', 'Dashboard tips', '1', '1497429920', '1497429920', '143', 'normal');
INSERT INTO `se_auth_rule` VALUES ('2', 'file', '0', 'general', 'General', 'fa fa-cogs', '', '', '1', '1497429920', '1497430169', '137', 'normal');
INSERT INTO `se_auth_rule` VALUES ('3', 'file', '0', 'category', 'Category', 'fa fa-list', '', 'Category tips', '1', '1497429920', '1497429920', '119', 'normal');
INSERT INTO `se_auth_rule` VALUES ('4', 'file', '0', 'addon', 'Addon', 'fa fa-rocket', '', 'Addon tips', '1', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('5', 'file', '0', 'auth', 'Auth', 'fa fa-group', '', '', '1', '1497429920', '1497430092', '99', 'normal');
INSERT INTO `se_auth_rule` VALUES ('6', 'file', '2', 'general/config', 'Config', 'fa fa-cog', '', 'Config tips', '1', '1497429920', '1497430683', '60', 'normal');
INSERT INTO `se_auth_rule` VALUES ('7', 'file', '2', 'general/attachment', 'Attachment', 'fa fa-file-image-o', '', 'Attachment tips', '1', '1497429920', '1497430699', '53', 'normal');
INSERT INTO `se_auth_rule` VALUES ('8', 'file', '2', 'general/profile', 'Profile', 'fa fa-user', '', '', '1', '1497429920', '1497429920', '34', 'normal');
INSERT INTO `se_auth_rule` VALUES ('9', 'file', '5', 'auth/admin', 'Admin', 'fa fa-user', '', 'Admin tips', '1', '1497429920', '1497430320', '118', 'normal');
INSERT INTO `se_auth_rule` VALUES ('10', 'file', '5', 'auth/adminlog', 'Admin log', 'fa fa-list-alt', '', 'Admin log tips', '1', '1497429920', '1497430307', '113', 'normal');
INSERT INTO `se_auth_rule` VALUES ('11', 'file', '5', 'auth/group', 'Group', 'fa fa-group', '', 'Group tips', '1', '1497429920', '1497429920', '109', 'normal');
INSERT INTO `se_auth_rule` VALUES ('12', 'file', '5', 'auth/rule', 'Rule', 'fa fa-bars', '', 'Rule tips', '1', '1497429920', '1497430581', '104', 'normal');
INSERT INTO `se_auth_rule` VALUES ('13', 'file', '1', 'dashboard/index', 'View', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '136', 'normal');
INSERT INTO `se_auth_rule` VALUES ('14', 'file', '1', 'dashboard/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '135', 'normal');
INSERT INTO `se_auth_rule` VALUES ('15', 'file', '1', 'dashboard/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '133', 'normal');
INSERT INTO `se_auth_rule` VALUES ('16', 'file', '1', 'dashboard/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '134', 'normal');
INSERT INTO `se_auth_rule` VALUES ('17', 'file', '1', 'dashboard/multi', 'Multi', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '132', 'normal');
INSERT INTO `se_auth_rule` VALUES ('18', 'file', '6', 'general/config/index', 'View', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '52', 'normal');
INSERT INTO `se_auth_rule` VALUES ('19', 'file', '6', 'general/config/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '51', 'normal');
INSERT INTO `se_auth_rule` VALUES ('20', 'file', '6', 'general/config/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '50', 'normal');
INSERT INTO `se_auth_rule` VALUES ('21', 'file', '6', 'general/config/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '49', 'normal');
INSERT INTO `se_auth_rule` VALUES ('22', 'file', '6', 'general/config/multi', 'Multi', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '48', 'normal');
INSERT INTO `se_auth_rule` VALUES ('23', 'file', '7', 'general/attachment/index', 'View', 'fa fa-circle-o', '', 'Attachment tips', '0', '1497429920', '1497429920', '59', 'normal');
INSERT INTO `se_auth_rule` VALUES ('24', 'file', '7', 'general/attachment/select', 'Select attachment', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '58', 'normal');
INSERT INTO `se_auth_rule` VALUES ('25', 'file', '7', 'general/attachment/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '57', 'normal');
INSERT INTO `se_auth_rule` VALUES ('26', 'file', '7', 'general/attachment/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '56', 'normal');
INSERT INTO `se_auth_rule` VALUES ('27', 'file', '7', 'general/attachment/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '55', 'normal');
INSERT INTO `se_auth_rule` VALUES ('28', 'file', '7', 'general/attachment/multi', 'Multi', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '54', 'normal');
INSERT INTO `se_auth_rule` VALUES ('29', 'file', '8', 'general/profile/index', 'View', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '33', 'normal');
INSERT INTO `se_auth_rule` VALUES ('30', 'file', '8', 'general/profile/update', 'Update profile', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '32', 'normal');
INSERT INTO `se_auth_rule` VALUES ('31', 'file', '8', 'general/profile/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '31', 'normal');
INSERT INTO `se_auth_rule` VALUES ('32', 'file', '8', 'general/profile/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '30', 'normal');
INSERT INTO `se_auth_rule` VALUES ('33', 'file', '8', 'general/profile/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '29', 'normal');
INSERT INTO `se_auth_rule` VALUES ('34', 'file', '8', 'general/profile/multi', 'Multi', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '28', 'normal');
INSERT INTO `se_auth_rule` VALUES ('35', 'file', '3', 'category/index', 'View', 'fa fa-circle-o', '', 'Category tips', '0', '1497429920', '1497429920', '142', 'normal');
INSERT INTO `se_auth_rule` VALUES ('36', 'file', '3', 'category/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '141', 'normal');
INSERT INTO `se_auth_rule` VALUES ('37', 'file', '3', 'category/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '140', 'normal');
INSERT INTO `se_auth_rule` VALUES ('38', 'file', '3', 'category/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '139', 'normal');
INSERT INTO `se_auth_rule` VALUES ('39', 'file', '3', 'category/multi', 'Multi', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '138', 'normal');
INSERT INTO `se_auth_rule` VALUES ('40', 'file', '9', 'auth/admin/index', 'View', 'fa fa-circle-o', '', 'Admin tips', '0', '1497429920', '1497429920', '117', 'normal');
INSERT INTO `se_auth_rule` VALUES ('41', 'file', '9', 'auth/admin/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '116', 'normal');
INSERT INTO `se_auth_rule` VALUES ('42', 'file', '9', 'auth/admin/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '115', 'normal');
INSERT INTO `se_auth_rule` VALUES ('43', 'file', '9', 'auth/admin/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '114', 'normal');
INSERT INTO `se_auth_rule` VALUES ('44', 'file', '10', 'auth/adminlog/index', 'View', 'fa fa-circle-o', '', 'Admin log tips', '0', '1497429920', '1497429920', '112', 'normal');
INSERT INTO `se_auth_rule` VALUES ('45', 'file', '10', 'auth/adminlog/detail', 'Detail', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '111', 'normal');
INSERT INTO `se_auth_rule` VALUES ('46', 'file', '10', 'auth/adminlog/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '110', 'normal');
INSERT INTO `se_auth_rule` VALUES ('47', 'file', '11', 'auth/group/index', 'View', 'fa fa-circle-o', '', 'Group tips', '0', '1497429920', '1497429920', '108', 'normal');
INSERT INTO `se_auth_rule` VALUES ('48', 'file', '11', 'auth/group/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '107', 'normal');
INSERT INTO `se_auth_rule` VALUES ('49', 'file', '11', 'auth/group/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '106', 'normal');
INSERT INTO `se_auth_rule` VALUES ('50', 'file', '11', 'auth/group/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '105', 'normal');
INSERT INTO `se_auth_rule` VALUES ('51', 'file', '12', 'auth/rule/index', 'View', 'fa fa-circle-o', '', 'Rule tips', '0', '1497429920', '1497429920', '103', 'normal');
INSERT INTO `se_auth_rule` VALUES ('52', 'file', '12', 'auth/rule/add', 'Add', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '102', 'normal');
INSERT INTO `se_auth_rule` VALUES ('53', 'file', '12', 'auth/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '101', 'normal');
INSERT INTO `se_auth_rule` VALUES ('54', 'file', '12', 'auth/rule/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1497429920', '1497429920', '100', 'normal');
INSERT INTO `se_auth_rule` VALUES ('55', 'file', '4', 'addon/index', 'View', 'fa fa-circle-o', '', 'Addon tips', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('56', 'file', '4', 'addon/add', 'Add', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('57', 'file', '4', 'addon/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('58', 'file', '4', 'addon/del', 'Delete', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('59', 'file', '4', 'addon/local', 'Local install', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('60', 'file', '4', 'addon/state', 'Update state', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('61', 'file', '4', 'addon/install', 'Install', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('62', 'file', '4', 'addon/uninstall', 'Uninstall', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('63', 'file', '4', 'addon/config', 'Setting', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('64', 'file', '4', 'addon/refresh', 'Refresh', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('65', 'file', '4', 'addon/multi', 'Multi', 'fa fa-circle-o', '', '', '0', '1502035509', '1502035509', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('66', 'file', '0', 'user', 'User', 'fa fa-list', '', '', '1', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('67', 'file', '66', 'user/user', 'User', 'fa fa-user', '', '', '1', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('68', 'file', '67', 'user/user/index', 'View', 'fa fa-circle-o', '', '', '0', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('69', 'file', '67', 'user/user/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('70', 'file', '67', 'user/user/add', 'Add', 'fa fa-circle-o', '', '', '0', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('71', 'file', '67', 'user/user/del', 'Del', 'fa fa-circle-o', '', '', '0', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('72', 'file', '67', 'user/user/multi', 'Multi', 'fa fa-circle-o', '', '', '0', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('73', 'file', '66', 'user/group', 'User group', 'fa fa-users', '', '', '1', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('74', 'file', '73', 'user/group/add', 'Add', 'fa fa-circle-o', '', '', '0', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('75', 'file', '73', 'user/group/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('76', 'file', '73', 'user/group/index', 'View', 'fa fa-circle-o', '', '', '0', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('77', 'file', '73', 'user/group/del', 'Del', 'fa fa-circle-o', '', '', '0', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('78', 'file', '73', 'user/group/multi', 'Multi', 'fa fa-circle-o', '', '', '0', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('79', 'file', '66', 'user/rule', 'User rule', 'fa fa-circle-o', '', '', '1', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('80', 'file', '79', 'user/rule/index', 'View', 'fa fa-circle-o', '', '', '0', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('81', 'file', '79', 'user/rule/del', 'Del', 'fa fa-circle-o', '', '', '0', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('82', 'file', '79', 'user/rule/add', 'Add', 'fa fa-circle-o', '', '', '0', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('83', 'file', '79', 'user/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '0', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('84', 'file', '79', 'user/rule/multi', 'Multi', 'fa fa-circle-o', '', '', '0', '1516374729', '1516374729', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('85', 'file', '0', 'command', '在线命令管理', 'fa fa-terminal', '', '', '1', '1555396655', '1555396655', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('86', 'file', '85', 'command/index', '查看', 'fa fa-circle-o', '', '', '0', '1555396655', '1555396655', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('87', 'file', '85', 'command/add', '添加', 'fa fa-circle-o', '', '', '0', '1555396655', '1555396655', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('88', 'file', '85', 'command/detail', '详情', 'fa fa-circle-o', '', '', '0', '1555396655', '1555396655', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('89', 'file', '85', 'command/execute', '运行', 'fa fa-circle-o', '', '', '0', '1555396655', '1555396655', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('90', 'file', '85', 'command/del', '删除', 'fa fa-circle-o', '', '', '0', '1555396655', '1555396655', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('91', 'file', '85', 'command/multi', '批量更新', 'fa fa-circle-o', '', '', '0', '1555396655', '1555396655', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('98', 'file', '0', 'ssr', 'ssr', 'fa fa-list', '', '', '1', '1555397013', '1555397013', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('99', 'file', '98', 'ssr/share', '订阅管理', 'fa fa-share', '', '', '1', '1555397013', '1555397013', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('100', 'file', '99', 'ssr/share/index', '查看', 'fa fa-circle-o', '', '', '0', '1555397013', '1555397013', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('101', 'file', '99', 'ssr/share/add', '添加', 'fa fa-circle-o', '', '', '0', '1555397013', '1555397013', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('102', 'file', '99', 'ssr/share/edit', '编辑', 'fa fa-circle-o', '', '', '0', '1555397013', '1555397013', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('103', 'file', '99', 'ssr/share/del', '删除', 'fa fa-circle-o', '', '', '0', '1555397013', '1555397013', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('104', 'file', '99', 'ssr/share/multi', '批量更新', 'fa fa-circle-o', '', '', '0', '1555397013', '1555397013', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('105', 'file', '98', 'ssr/config', 'ssr配置', 'fa fa-circle-o', '', '', '1', '1555397327', '1555397327', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('106', 'file', '105', 'ssr/config/index', '查看', 'fa fa-circle-o', '', '', '0', '1555397327', '1555397327', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('107', 'file', '105', 'ssr/config/add', '添加', 'fa fa-circle-o', '', '', '0', '1555397327', '1555397327', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('108', 'file', '105', 'ssr/config/edit', '编辑', 'fa fa-circle-o', '', '', '0', '1555397327', '1555397327', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('109', 'file', '105', 'ssr/config/del', '删除', 'fa fa-circle-o', '', '', '0', '1555397327', '1555397327', '0', 'normal');
INSERT INTO `se_auth_rule` VALUES ('110', 'file', '105', 'ssr/config/multi', '批量更新', 'fa fa-circle-o', '', '', '0', '1555397327', '1555397327', '0', 'normal');

-- ----------------------------
-- Table structure for se_category
-- ----------------------------
DROP TABLE IF EXISTS `se_category`;
CREATE TABLE `se_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) NOT NULL DEFAULT '',
  `nickname` varchar(50) NOT NULL DEFAULT '',
  `flag` set('hot','index','recommend') NOT NULL DEFAULT '',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) NOT NULL DEFAULT '' COMMENT '自定义名称',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `weigh` (`weigh`,`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='分类表';

-- ----------------------------
-- Records of se_category
-- ----------------------------
INSERT INTO `se_category` VALUES ('1', '0', 'page', '官方新闻', 'news', 'recommend', '/assets/img/qrcode.png', '', '', 'news', '1495262190', '1495262190', '1', 'normal');
INSERT INTO `se_category` VALUES ('2', '0', 'page', '移动应用', 'mobileapp', 'hot', '/assets/img/qrcode.png', '', '', 'mobileapp', '1495262244', '1495262244', '2', 'normal');
INSERT INTO `se_category` VALUES ('3', '2', 'page', '微信公众号', 'wechatpublic', 'index', '/assets/img/qrcode.png', '', '', 'wechatpublic', '1495262288', '1495262288', '3', 'normal');
INSERT INTO `se_category` VALUES ('4', '2', 'page', 'Android开发', 'android', 'recommend', '/assets/img/qrcode.png', '', '', 'android', '1495262317', '1495262317', '4', 'normal');
INSERT INTO `se_category` VALUES ('5', '0', 'page', '软件产品', 'software', 'recommend', '/assets/img/qrcode.png', '', '', 'software', '1495262336', '1499681850', '5', 'normal');
INSERT INTO `se_category` VALUES ('6', '5', 'page', '网站建站', 'website', 'recommend', '/assets/img/qrcode.png', '', '', 'website', '1495262357', '1495262357', '6', 'normal');
INSERT INTO `se_category` VALUES ('7', '5', 'page', '企业管理软件', 'company', 'index', '/assets/img/qrcode.png', '', '', 'company', '1495262391', '1495262391', '7', 'normal');
INSERT INTO `se_category` VALUES ('8', '6', 'page', 'PC端', 'website-pc', 'recommend', '/assets/img/qrcode.png', '', '', 'website-pc', '1495262424', '1495262424', '8', 'normal');
INSERT INTO `se_category` VALUES ('9', '6', 'page', '移动端', 'website-mobile', 'recommend', '/assets/img/qrcode.png', '', '', 'website-mobile', '1495262456', '1495262456', '9', 'normal');
INSERT INTO `se_category` VALUES ('10', '7', 'page', 'CRM系统 ', 'company-crm', 'recommend', '/assets/img/qrcode.png', '', '', 'company-crm', '1495262487', '1495262487', '10', 'normal');
INSERT INTO `se_category` VALUES ('11', '7', 'page', 'SASS平台软件', 'company-sass', 'recommend', '/assets/img/qrcode.png', '', '', 'company-sass', '1495262515', '1495262515', '11', 'normal');
INSERT INTO `se_category` VALUES ('12', '0', 'test', '测试1', 'test1', 'recommend', '/assets/img/qrcode.png', '', '', 'test1', '1497015727', '1497015727', '12', 'normal');
INSERT INTO `se_category` VALUES ('13', '0', 'test', '测试2', 'test2', 'recommend', '/assets/img/qrcode.png', '', '', 'test2', '1497015738', '1497015738', '13', 'normal');

-- ----------------------------
-- Table structure for se_command
-- ----------------------------
DROP TABLE IF EXISTS `se_command`;
CREATE TABLE `se_command` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '类型',
  `params` varchar(1500) NOT NULL DEFAULT '' COMMENT '参数',
  `command` varchar(1500) NOT NULL DEFAULT '' COMMENT '命令',
  `content` text COMMENT '返回结果',
  `executetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行时间',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` enum('successed','failured') NOT NULL DEFAULT 'failured' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='在线命令表';

-- ----------------------------
-- Records of se_command
-- ----------------------------

-- ----------------------------
-- Table structure for se_config
-- ----------------------------
DROP TABLE IF EXISTS `se_config`;
CREATE TABLE `se_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) NOT NULL DEFAULT '' COMMENT '分组',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) NOT NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `value` text NOT NULL COMMENT '变量值',
  `content` text NOT NULL COMMENT '变量字典数据',
  `rule` varchar(100) NOT NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) NOT NULL DEFAULT '' COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统配置';

-- ----------------------------
-- Records of se_config
-- ----------------------------
INSERT INTO `se_config` VALUES ('1', 'name', 'basic', 'Site name', '请填写站点名称', 'string', 'laiwiAdmin', '', 'required', '');
INSERT INTO `se_config` VALUES ('2', 'beian', 'basic', 'Beian', '粤ICP备15054802号-4', 'string', '', '', '', '');
INSERT INTO `se_config` VALUES ('3', 'cdnurl', 'basic', 'Cdn url', '如果静态资源使用第三方云储存请配置该值', 'string', '', '', '', '');
INSERT INTO `se_config` VALUES ('4', 'version', 'basic', 'Version', '如果静态资源有变动请重新配置该值', 'string', '1.0.1', '', 'required', '');
INSERT INTO `se_config` VALUES ('5', 'timezone', 'basic', 'Timezone', '', 'string', 'Asia/Shanghai', '', 'required', '');
INSERT INTO `se_config` VALUES ('6', 'forbiddenip', 'basic', 'Forbidden ip', '一行一条记录', 'text', '', '', '', '');
INSERT INTO `se_config` VALUES ('7', 'languages', 'basic', 'Languages', '', 'array', '{\"backend\":\"zh-cn\",\"frontend\":\"zh-cn\"}', '', 'required', '');
INSERT INTO `se_config` VALUES ('8', 'fixedpage', 'basic', 'Fixed page', '请尽量输入左侧菜单栏存在的链接', 'string', 'dashboard', '', 'required', '');
INSERT INTO `se_config` VALUES ('9', 'categorytype', 'dictionary', 'Category type', '', 'array', '{\"default\":\"Default\",\"page\":\"Page\",\"article\":\"Article\",\"test\":\"Test\"}', '', '', '');
INSERT INTO `se_config` VALUES ('10', 'configgroup', 'dictionary', 'Config group', '', 'array', '{\"basic\":\"Basic\",\"email\":\"Email\",\"dictionary\":\"Dictionary\",\"user\":\"User\",\"example\":\"Example\"}', '', '', '');
INSERT INTO `se_config` VALUES ('11', 'mail_type', 'email', 'Mail type', '选择邮件发送方式', 'select', '1', '[\"Please select\",\"SMTP\",\"Mail\"]', '', '');
INSERT INTO `se_config` VALUES ('12', 'mail_smtp_host', 'email', 'Mail smtp host', '错误的配置发送邮件会导致服务器超时', 'string', 'smtp.qq.com', '', '', '');
INSERT INTO `se_config` VALUES ('13', 'mail_smtp_port', 'email', 'Mail smtp port', '(不加密默认25,SSL默认465,TLS默认587)', 'string', '465', '', '', '');
INSERT INTO `se_config` VALUES ('14', 'mail_smtp_user', 'email', 'Mail smtp user', '（填写完整用户名）', 'string', '10000', '', '', '');
INSERT INTO `se_config` VALUES ('15', 'mail_smtp_pass', 'email', 'Mail smtp password', '（填写您的密码）', 'string', 'password', '', '', '');
INSERT INTO `se_config` VALUES ('16', 'mail_verify_type', 'email', 'Mail vertify type', '（SMTP验证方式[推荐SSL]）', 'select', '2', '[\"None\",\"TLS\",\"SSL\"]', '', '');
INSERT INTO `se_config` VALUES ('17', 'mail_from', 'email', 'Mail from', '', 'string', '10000@qq.com', '', '', '');

-- ----------------------------
-- Table structure for se_ems
-- ----------------------------
DROP TABLE IF EXISTS `se_ems`;
CREATE TABLE `se_ems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) NOT NULL DEFAULT '' COMMENT '事件',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '邮箱',
  `code` varchar(10) NOT NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) NOT NULL DEFAULT '' COMMENT 'IP',
  `createtime` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='邮箱验证码表';

-- ----------------------------
-- Records of se_ems
-- ----------------------------

-- ----------------------------
-- Table structure for se_share
-- ----------------------------
DROP TABLE IF EXISTS `se_share`;
CREATE TABLE `se_share` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '订阅地址',
  `marker_content` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `url_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '订阅状态::0=ON,1=OK',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态:0=停用,1=启用',
  `updatetime` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `createtime` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `name_index` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='订阅表';

-- ----------------------------
-- Records of se_share
-- ----------------------------
INSERT INTO `se_share` VALUES ('1', '订阅地址1', 'https://raw.githubusercontent.com/AmazingDM/sub/master/ssrshare.com', '订阅地址1', '0', '0', '1555413787', '1555397087');
INSERT INTO `se_share` VALUES ('2', '订阅地址2', 'https://rocket.abyss.moe/link/OC2mEjvXhVfv8rjc', '文件', '0', '0', '1555397142', '1555397142');
INSERT INTO `se_share` VALUES ('3', '订阅地址3', 'https://prom-php.herokuapp.com/cloudfra_ssr.txt', '订阅地址3', '0', '0', '1555409933', '1555397178');
INSERT INTO `se_share` VALUES ('4', '订阅地址4', 'https://yzzz.ml/freessr/', '订阅地址4', '1', '1', '1555413790', '1555397208');

-- ----------------------------
-- Table structure for se_sms
-- ----------------------------
DROP TABLE IF EXISTS `se_sms`;
CREATE TABLE `se_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) NOT NULL DEFAULT '' COMMENT '事件',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  `code` varchar(10) NOT NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) NOT NULL DEFAULT '' COMMENT 'IP',
  `createtime` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='短信验证码表';

-- ----------------------------
-- Records of se_sms
-- ----------------------------

-- ----------------------------
-- Table structure for se_ssr_config
-- ----------------------------
DROP TABLE IF EXISTS `se_ssr_config`;
CREATE TABLE `se_ssr_config` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `share_id` int(10) NOT NULL DEFAULT '0' COMMENT '订阅地址ID',
  `address` varchar(100) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT 'IP',
  `port` int(6) NOT NULL DEFAULT '0' COMMENT '端口',
  `password` varchar(50) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '密码',
  `method` varchar(50) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '加密算法',
  `protocol` varchar(30) NOT NULL DEFAULT '' COMMENT '协议',
  `protocol_param` varchar(200) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '协议参数',
  `obfs` varchar(30) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '混淆',
  `obfs_param` varchar(200) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '混淆参数',
  `group` varchar(150) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '分组',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `ssrurl` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '原始url',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态:0=待检测,-1=超时,1=正常',
  `timeout` int(10) NOT NULL DEFAULT '0' COMMENT '延迟时间',
  `updatetime` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `createtime` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `id_index` (`id`) USING BTREE,
  KEY `share_id_index` (`share_id`),
  KEY `address_index` (`address`),
  KEY `group_index` (`group`),
  KEY `status_index` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COMMENT='ssr 配置';

-- ----------------------------
-- Records of se_ssr_config
-- ----------------------------
INSERT INTO `se_ssr_config` VALUES ('69', '4', '157.230.159.93', '2', 'unyrtv', 'aes-128-ctr', 'auth_aes128_md5', '', 'plain', '', 'WWW.SSRTOOL.COM', '', 'ssr://MTU3LjIzMC4xNTkuOTM6MjphdXRoX2FlczEyOF9tZDU6YWVzLTEyOC1jdHI6cGxhaW46ZFc1NWNuUjIvP3JlbWFya3M9VTFOU1ZFOVBURl9udm83bG03MHQ1WXFnNVlpcDU2YVA1YkM4NUxxYTViZWVPakF3Jmdyb3VwPVYxZFhMbE5UVWxSUFQwd3VRMDlO', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('70', '4', '46.29.162.104', '21560', '9630', 'aes-128-ctr', 'origin', '', 'plain', '', 'WWW.SSRTOOL.COM', '', 'ssr://NDYuMjkuMTYyLjEwNDoyMTU2MDpvcmlnaW46YWVzLTEyOC1jdHI6cGxhaW46T1RZek1BLz9yZW1hcmtzPVUxTlNWRTlQVEZfa3Y0VG52WmZtbHE4dFRXOXpZMjkzT2pBeSZncm91cD1WMWRYTGxOVFVsUlBUMHd1UTA5Tg', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('71', '4', '1.hinet.ssr.gold', '65531', 'SSR.Gold@#65531', 'aes-256-cfb', 'auth_aes128_sha1', '', 'http_simple', '', 'WWW.SSRTOOL.COM', 'SSRTOOL_', 'ssr://MS5oaW5ldC5zc3IuZ29sZDo2NTUzMTphdXRoX2FlczEyOF9zaGExOmFlcy0yNTYtY2ZiOmh0dHBfc2ltcGxlOlUxTlNMa2R2YkdSQUl6WTFOVE14Lz9wcm90b3BhcmFtPU5qRTJOem81WXpkcE1YayZyZW1hcmtzPVUxTlNWRTlQVEZfbGo3RG11YjR0NkllNjU0R2o1NXlCSUc5eUlPV1BzT2VCby1lY2dUb3dNdyZncm91cD1WMWRYT', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('72', '4', '141.98.219.169', '11578', '6549879', 'chacha20', 'auth_sha1_v4', '', 'http_simple', '', 'WWW.SSRTOOL.COM', '', 'ssr://MTQxLjk4LjIxOS4xNjk6MTE1Nzg6YXV0aF9zaGExX3Y0OmNoYWNoYTIwOmh0dHBfc2ltcGxlOk5qVTBPVGczT1EvP3JlbWFya3M9VTFOU1ZFOVBURl9udm83bG03MHQ1WXFnNVlpcDU2YVA1YkM4NUxxYTViZWVPakEwJmdyb3VwPVYxZFhMbE5UVWxSUFQwd3VRMDlO', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('73', '4', '157.230.159.93', '3', 'g4trfed', 'aes-128-ctr', 'auth_aes128_md5', '', 'plain', '', 'WWW.SSRTOOL.COM', 'SSRTOOL_', 'ssr://MTU3LjIzMC4xNTkuOTM6MzphdXRoX2FlczEyOF9tZDU6YWVzLTEyOC1jdHI6cGxhaW46WnpSMGNtWmxaQS8_cmVtYXJrcz1VMU5TVkU5UFRGX252bzdsbTcwdDVZcWc1WWlwNTZhUDViQzg1THFhNWJlZU9qQTEmZ3JvdXA9VjFkWExsTlRVbFJQVDB3dVEwOU4', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('74', '4', '54.180.147.134', '47669', 'apext2019001', 'chacha20', 'origin', '', 'plain', '', 'WWW.SSRTOOL.COM', '', 'ssr://NTQuMTgwLjE0Ny4xMzQ6NDc2Njk6b3JpZ2luOmNoYWNoYTIwOnBsYWluOllYQmxlSFF5TURFNU1EQXgvP3JlbWFya3M9VTFOU1ZFOVBURl9wbjZubG03MHQ2YWFXNWJDVTU0bTU1WWlyNWJpQ09qQTImZ3JvdXA9VjFkWExsTlRVbFJQVDB3dVEwOU4', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('75', '4', '13.124.33.206', '42353', 'in5v5C', 'chacha20', 'auth_aes128_md5', '', 'http_simple', '', 'WWW.SSRTOOL.COM', 'SSRTOOL_', 'ssr://MTMuMTI0LjMzLjIwNjo0MjM1MzphdXRoX2FlczEyOF9tZDU6Y2hhY2hhMjA6aHR0cF9zaW1wbGU6YVc0MWRqVkQvP3Byb3RvcGFyYW09TVRFMk5EWTZhV2huZFdsdloySnEmcmVtYXJrcz1VMU5TVkU5UFRGX3BuNm5sbTcwdDZhYVc1YkNVNTRtNTVZaXI1YmlDT2pBMyZncm91cD1WMWRYTGxOVFVsUlBUMHd1UTA5Tg', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('76', '4', '92.118.45.29', '56137', 'ZqadY7', 'chacha20', 'origin', '', 'plain', '', 'WWW.SSRTOOL.COM', 'SSRTOOL_', 'ssr://OTIuMTE4LjQ1LjI5OjU2MTM3Om9yaWdpbjpjaGFjaGEyMDpwbGFpbjpXbkZoWkZrMy8_cmVtYXJrcz1VMU5TVkU5UFRGX2x1SXpvaFlvdFFYUjBhV05oT2pBNCZncm91cD1WMWRYTGxOVFVsUlBUMHd1UTA5Tg', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('77', '4', '45.124.137.185', '23800', '23800.top', 'aes-128-cfb', 'auth_aes128_sha1', '', 'plain', '', 'WWW.SSRTOOL.COM', '', 'ssr://NDUuMTI0LjEzNy4xODU6MjM4MDA6YXV0aF9hZXMxMjhfc2hhMTphZXMtMTI4LWNmYjpwbGFpbjpNak00TURBdWRHOXcvP3JlbWFya3M9VTFOU1ZFOVBURl9tbDZYbW5Ld3Q2WldfNlllTzVZNl9PakE1Jmdyb3VwPVYxZFhMbE5UVWxSUFQwd3VRMDlO', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('78', '4', 'tw1.nexitally.co', '442', 'rz0TSQR!I*&cD#7%', 'aes-128-ctr', 'auth_aes128_sha1', '', 'plain', '', 'WWW.SSRTOOL.COM', '', 'ssr://dHcxLm5leGl0YWxseS5jbzo0NDI6YXV0aF9hZXMxMjhfc2hhMTphZXMtMTI4LWN0cjpwbGFpbjpjbm93VkZOUlVpRkpLaVpqUkNNM0pRLz9yZW1hcmtzPVUxTlNWRTlQVEZfbGo3RG11YjR0NVktdzVZeVg1YmlDT2pFeCZncm91cD1WMWRYTGxOVFVsUlBUMHd1UTA5Tg', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('79', '4', '45.62.233.234', '80', 't.me/SSRSUB', 'rc4-md5', 'auth_sha1_v4', '', 'http_simple', '', 'WWW.SSRTOOL.COM', '', 'ssr://NDUuNjIuMjMzLjIzNDo4MDphdXRoX3NoYTFfdjQ6cmM0LW1kNTpodHRwX3NpbXBsZTpkQzV0WlM5VFUxSlRWVUkvP3JlbWFya3M9VTFOU1ZFOVBURl9saXFEbWk3X2xwS2N0NWE2SjVhU241NVdsT2pFeSZncm91cD1WMWRYTGxOVFVsUlBUMHd1UTA5Tg', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('80', '4', '91.188.223.72', '80', 't.me/SSRSUB', 'rc4-md5', 'auth_sha1_v4', '', 'http_simple', '', 'WWW.SSRTOOL.COM', '', 'ssr://OTEuMTg4LjIyMy43Mjo4MDphdXRoX3NoYTFfdjQ6cmM0LW1kNTpodHRwX3NpbXBsZTpkQzV0WlM5VFUxSlRWVUkvP3JlbWFya3M9VTFOU1ZFOVBURl9rdjRUbnZaZm1scTh0VG05MmIzTnBZbWx5YzJzZ1QySnNZWE4wT2pFeiZncm91cD1WMWRYTGxOVFVsUlBUMHd1UTA5Tg', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('81', '4', '91.188.223.72', '8080', 'http://t.cn/EGJIyrl', 'rc4-md5', 'auth_sha1_v4', '', 'http_simple', '', 'WWW.SSRTOOL.COM', '', 'ssr://OTEuMTg4LjIyMy43Mjo4MDgwOmF1dGhfc2hhMV92NDpyYzQtbWQ1Omh0dHBfc2ltcGxlOmFIUjBjRG92TDNRdVkyNHZSVWRLU1hseWJBLz9yZW1hcmtzPVUxTlNWRTlQVEY5U2RYTnphV0U2TVRVJmdyb3VwPVYxZFhMbE5UVWxSUFQwd3VRMDlO', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('82', '4', '198.255.103.62', '8097', 'eIW0Dnk69454e6nSwuspv9DmS201tQ0D', 'aes-256-cfb', 'origin', '', 'plain', '', 'WWW.SSRTOOL.COM', 'SSRTOOL_', 'ssr://MTk4LjI1NS4xMDMuNjI6ODA5NzpvcmlnaW46YWVzLTI1Ni1jZmI6cGxhaW46WlVsWE1FUnVhelk1TkRVMFpUWnVVM2QxYzNCMk9VUnRVekl3TVhSUk1FUS8_cmVtYXJrcz1VMU5TVkU5UFRGX252bzdsbTcwZ09qRTImZ3JvdXA9VjFkWExsTlRVbFJQVDB3dVEwOU4', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('83', '4', '109.238.6.24', '9452', 'rqa30WL4DdAvgIFG6Fs3znzTa', 'aes-256-cfb', 'origin', '', 'plain', '', 'WWW.SSRTOOL.COM', '', 'ssr://MTA5LjIzOC42LjI0Ojk0NTI6b3JpZ2luOmFlcy0yNTYtY2ZiOnBsYWluOmNuRmhNekJYVERSRVpFRjJaMGxHUnpaR2N6TjZibnBVWVEvP3JlbWFya3M9VTFOU1ZFOVBURl9tczVYbG03MGdPakUzJmdyb3VwPVYxZFhMbE5UVWxSUFQwd3VRMDlO', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('84', '4', '185.173.92.181', '443', 'sssru.icu', 'rc4-md5', 'origin', '', 'plain', '', 'WWW.SSRTOOL.COM', 'SSRTOOL_', 'ssr://MTg1LjE3My45Mi4xODE6NDQzOm9yaWdpbjpyYzQtbWQ1OnBsYWluOmMzTnpjblV1YVdOMS8_cmVtYXJrcz1VMU5TVkU5UFRGX2t2NFRudlpmbWxxOGdPakU0Jmdyb3VwPVYxZFhMbE5UVWxSUFQwd3VRMDlO', '0', '0', '1555419495', '1555419495');
INSERT INTO `se_ssr_config` VALUES ('85', '4', 'chengdu-china-proxy1.darren-lee.net', '8081', '8081', 'rc4-md5', 'origin', '', 'plain', '', 'WWW.SSRTOOL.COM', '', 'ssr://Y2hlbmdkdS1jaGluYS1wcm94eTEuZGFycmVuLWxlZS5uZXQ6ODA4MTpvcmlnaW46cmM0LW1kNTpwbGFpbjpPREE0TVEvP3JlbWFya3M9VTFOU1ZFOVBURl9sbTV2bHQ1M25uSUhtaUpEcGc3M2x1SUlnNTVTMTVMLWhPakU1Jmdyb3VwPVYxZFhMbE5UVWxSUFQwd3VRMDlO', '0', '0', '1555419495', '1555419495');

-- ----------------------------
-- Table structure for se_test
-- ----------------------------
DROP TABLE IF EXISTS `se_test`;
CREATE TABLE `se_test` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID(单选)',
  `category_ids` varchar(100) NOT NULL COMMENT '分类ID(多选)',
  `week` enum('monday','tuesday','wednesday') NOT NULL COMMENT '星期(单选):monday=星期一,tuesday=星期二,wednesday=星期三',
  `flag` set('hot','index','recommend') NOT NULL DEFAULT '' COMMENT '标志(多选):hot=热门,index=首页,recommend=推荐',
  `genderdata` enum('male','female') NOT NULL DEFAULT 'male' COMMENT '性别(单选):male=男,female=女',
  `hobbydata` set('music','reading','swimming') NOT NULL COMMENT '爱好(多选):music=音乐,reading=读书,swimming=游泳',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '图片',
  `images` varchar(1500) NOT NULL DEFAULT '' COMMENT '图片组',
  `attachfile` varchar(100) NOT NULL DEFAULT '' COMMENT '附件',
  `keywords` varchar(100) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `city` varchar(100) NOT NULL DEFAULT '' COMMENT '省市',
  `price` float(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '价格',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点击',
  `startdate` date DEFAULT NULL COMMENT '开始日期',
  `activitytime` datetime DEFAULT NULL COMMENT '活动时间(datetime)',
  `year` year(4) DEFAULT NULL COMMENT '年',
  `times` time DEFAULT NULL COMMENT '时间',
  `refreshtime` int(10) DEFAULT NULL COMMENT '刷新时间(int)',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(10) DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `switch` tinyint(1) NOT NULL DEFAULT '0' COMMENT '开关',
  `status` enum('normal','hidden') NOT NULL DEFAULT 'normal' COMMENT '状态',
  `state` enum('0','1','2') NOT NULL DEFAULT '1' COMMENT '状态值:0=禁用,1=正常,2=推荐',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='测试表';

-- ----------------------------
-- Records of se_test
-- ----------------------------
INSERT INTO `se_test` VALUES ('1', '0', '12', '12,13', 'monday', 'hot,index', 'male', 'music,reading', '我是一篇测试文章', '<p>我是测试内容</p>', '/assets/img/avatar.png', '/assets/img/avatar.png,/assets/img/qrcode.png', '/assets/img/avatar.png', '关键字', '描述', '广西壮族自治区/百色市/平果县', '0.00', '0', '2017-07-10', '2017-07-10 18:24:45', '2017', '18:24:45', '1499682285', '1499682526', '1499682526', null, '0', '1', 'normal', '1');

-- ----------------------------
-- Table structure for se_user
-- ----------------------------
DROP TABLE IF EXISTS `se_user`;
CREATE TABLE `se_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组别ID',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) NOT NULL DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '等级',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `bio` varchar(100) NOT NULL DEFAULT '' COMMENT '格言',
  `money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '余额',
  `score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分',
  `successions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '连续登录天数',
  `maxsuccessions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '最大连续登录天数',
  `prevtime` int(10) DEFAULT NULL COMMENT '上次登录时间',
  `logintime` int(10) DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) NOT NULL DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `joinip` varchar(50) NOT NULL DEFAULT '' COMMENT '加入IP',
  `jointime` int(10) DEFAULT NULL COMMENT '加入时间',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `token` varchar(50) NOT NULL DEFAULT '' COMMENT 'Token',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  `verification` varchar(255) NOT NULL DEFAULT '' COMMENT '验证',
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `email` (`email`),
  KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员表';

-- ----------------------------
-- Records of se_user
-- ----------------------------
INSERT INTO `se_user` VALUES ('1', '1', 'admin', 'admin', 'c13f62012fd6a8fdf06b3452a94430e5', 'rpR6Bv', 'admin@163.com', '13888888888', '', '0', '0', '2017-04-15', '', '0.00', '0', '1', '1', '1516170492', '1516171614', '127.0.0.1', '0', '127.0.0.1', '1491461418', '0', '1516171614', '', 'normal', '');
INSERT INTO `se_user` VALUES ('2', '0', '17737404010', '17737404010', '2f9cf24f809b5c8f055e46ae67981492', 'ZfLPkv', '867342143@qq.com', '17737404010', '', '1', '0', null, '', '0.00', '0', '1', '1', '1555386855', '1555386855', '127.0.0.1', '0', '127.0.0.1', '1555386855', '1555386855', '1555386855', '', 'normal', '');

-- ----------------------------
-- Table structure for se_user_group
-- ----------------------------
DROP TABLE IF EXISTS `se_user_group`;
CREATE TABLE `se_user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT '' COMMENT '组名',
  `rules` text COMMENT '权限节点',
  `createtime` int(10) DEFAULT NULL COMMENT '添加时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员组表';

-- ----------------------------
-- Records of se_user_group
-- ----------------------------
INSERT INTO `se_user_group` VALUES ('1', '默认组', '1,2,3,4,5,6,7,8,9,10,11,12', '1515386468', '1516168298', 'normal');

-- ----------------------------
-- Table structure for se_user_money_log
-- ----------------------------
DROP TABLE IF EXISTS `se_user_money_log`;
CREATE TABLE `se_user_money_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更余额',
  `before` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更前余额',
  `after` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更后余额',
  `memo` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员余额变动表';

-- ----------------------------
-- Records of se_user_money_log
-- ----------------------------

-- ----------------------------
-- Table structure for se_user_rule
-- ----------------------------
DROP TABLE IF EXISTS `se_user_rule`;
CREATE TABLE `se_user_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `title` varchar(50) DEFAULT '' COMMENT '标题',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) DEFAULT NULL COMMENT '是否菜单',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员规则表';

-- ----------------------------
-- Records of se_user_rule
-- ----------------------------
INSERT INTO `se_user_rule` VALUES ('1', '0', 'index', '前台', '', '1', '1516168079', '1516168079', '1', 'normal');
INSERT INTO `se_user_rule` VALUES ('2', '0', 'api', 'API接口', '', '1', '1516168062', '1516168062', '2', 'normal');
INSERT INTO `se_user_rule` VALUES ('3', '1', 'user', '会员模块', '', '1', '1515386221', '1516168103', '12', 'normal');
INSERT INTO `se_user_rule` VALUES ('4', '2', 'user', '会员模块', '', '1', '1515386221', '1516168092', '11', 'normal');
INSERT INTO `se_user_rule` VALUES ('5', '3', 'index/user/login', '登录', '', '0', '1515386247', '1515386247', '5', 'normal');
INSERT INTO `se_user_rule` VALUES ('6', '3', 'index/user/register', '注册', '', '0', '1515386262', '1516015236', '7', 'normal');
INSERT INTO `se_user_rule` VALUES ('7', '3', 'index/user/index', '会员中心', '', '0', '1516015012', '1516015012', '9', 'normal');
INSERT INTO `se_user_rule` VALUES ('8', '3', 'index/user/profile', '个人资料', '', '0', '1516015012', '1516015012', '4', 'normal');
INSERT INTO `se_user_rule` VALUES ('9', '4', 'api/user/login', '登录', '', '0', '1515386247', '1515386247', '6', 'normal');
INSERT INTO `se_user_rule` VALUES ('10', '4', 'api/user/register', '注册', '', '0', '1515386262', '1516015236', '8', 'normal');
INSERT INTO `se_user_rule` VALUES ('11', '4', 'api/user/index', '会员中心', '', '0', '1516015012', '1516015012', '10', 'normal');
INSERT INTO `se_user_rule` VALUES ('12', '4', 'api/user/profile', '个人资料', '', '0', '1516015012', '1516015012', '3', 'normal');

-- ----------------------------
-- Table structure for se_user_score_log
-- ----------------------------
DROP TABLE IF EXISTS `se_user_score_log`;
CREATE TABLE `se_user_score_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '变更积分',
  `before` int(10) NOT NULL DEFAULT '0' COMMENT '变更前积分',
  `after` int(10) NOT NULL DEFAULT '0' COMMENT '变更后积分',
  `memo` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员积分变动表';

-- ----------------------------
-- Records of se_user_score_log
-- ----------------------------

-- ----------------------------
-- Table structure for se_user_token
-- ----------------------------
DROP TABLE IF EXISTS `se_user_token`;
CREATE TABLE `se_user_token` (
  `token` varchar(50) NOT NULL COMMENT 'Token',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `expiretime` int(10) DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员Token表';

-- ----------------------------
-- Records of se_user_token
-- ----------------------------
INSERT INTO `se_user_token` VALUES ('503fb5fb7857c6ff216e5fc1ed1c35e1dad3357b', '2', '1555386855', '1557978855');

-- ----------------------------
-- Table structure for se_version
-- ----------------------------
DROP TABLE IF EXISTS `se_version`;
CREATE TABLE `se_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oldversion` varchar(30) NOT NULL DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) NOT NULL DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) NOT NULL DEFAULT '' COMMENT '包大小',
  `content` varchar(500) NOT NULL DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) NOT NULL DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '强制更新',
  `createtime` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='版本表';

-- ----------------------------
-- Records of se_version
-- ----------------------------
INSERT INTO `se_version` VALUES ('1', '1.1.1,2', '1.2.1', '20M', '更新内容', 'https://www.fastadmin.net/download.html', '1', '1520425318', '0', '0', 'normal');
