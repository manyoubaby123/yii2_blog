-- MySQL Script generated by MySQL Workbench
-- 2014年11月29日 星期六 18时39分21秒
-- Model: New Model    Version: 1.0
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema blog
-- -----------------------------------------------------
-- 博客
DROP SCHEMA IF EXISTS `blog` ;
CREATE SCHEMA IF NOT EXISTS `blog` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `blog` ;

-- -----------------------------------------------------
-- Table `blog`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blog`.`user` ;

CREATE TABLE IF NOT EXISTS `blog`.`user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '昵称',
  `email` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '邮箱',
  `gender` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '性别，0代表女，1代表男',
  `phone` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '手机号码',
  `password_hash` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '密码HASH值',
  `profile` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '个人简介',
  `avatar` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '头像',
  `create_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
  `update_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
  `active_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '上次活动时间',
  `status` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户状态',
  `auth_key` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '用户验证密钥',
  `password_reset_token` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '重置密码的密钥',
  `site` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '个人网站网址',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `nickname_UNIQUE` (`nickname` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB
COMMENT = '用户表';


-- -----------------------------------------------------
-- Table `blog`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blog`.`category` ;

CREATE TABLE IF NOT EXISTS `blog`.`category` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '分类名称',
  `slug` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '分类路由',
  `sort` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `parent_id` SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '父级ID，为0是为一级分类',
  `description` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '分类介绍',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `category_name_UNIQUE` (`category_name` ASC),
  UNIQUE INDEX `slug_UNIQUE` (`slug` ASC))
ENGINE = InnoDB
COMMENT = '文章分类表';


-- -----------------------------------------------------
-- Table `blog`.`article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blog`.`article` ;

CREATE TABLE IF NOT EXISTS `blog`.`article` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `title` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '文章标题',
  `content` LONGTEXT NOT NULL COMMENT '文章内容',
  `create_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '发布时间',
  `update_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
  `type` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '文章类型，默认为0。0代表文章，1代表说说，2代表独立页面',
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '状态',
  `top` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否置顶',
  `view` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览量',
  `sort` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `slug` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '文章路由名',
  `excerpt` TEXT NOT NULL COMMENT '文章摘要',
  `password` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '文章查看密码',
  `allow_comment` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '允许评论',
  `comments_total` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论统计',
  `user_id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '发布文章的用户ID',
  `category_id` SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章所属分类ID',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC),
  INDEX `fk_article_user_idx` (`user_id` ASC),
  INDEX `fk_article_category1_idx` (`category_id` ASC),
  UNIQUE INDEX `slug_UNIQUE` (`slug` ASC),
  INDEX `create_time` (`create_time` ASC),
  CONSTRAINT `fk_article_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `blog`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_article_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `blog`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '文章表';


-- -----------------------------------------------------
-- Table `blog`.`album`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blog`.`album` ;

CREATE TABLE IF NOT EXISTS `blog`.`album` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '相册ID',
  `name` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '相册名称',
  `description` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '相册描述',
  `cover` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '封面图',
  `create_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_album_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_album_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `blog`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '相册表';


-- -----------------------------------------------------
-- Table `blog`.`album_photos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blog`.`album_photos` ;

CREATE TABLE IF NOT EXISTS `blog`.`album_photos` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '图片ID',
  `name` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '图片名称',
  `description` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '图片描述',
  `path` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '图片路径',
  `create_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '上传时间',
  `album_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_album_photos_album1_idx` (`album_id` ASC),
  CONSTRAINT `fk_album_photos_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `blog`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blog`.`article_comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blog`.`article_comments` ;

CREATE TABLE IF NOT EXISTS `blog`.`article_comments` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `content` TEXT NOT NULL COMMENT '评论内容',
  `create_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论时间',
  `ip` VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'IP',
  `agent` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '浏览器信息',
  `reply_to` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '给谁的回复',
  `parent_id` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '父级ID',
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '评论状态',
  `article_id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论的文章ID',
  `user_id` INT UNSIGNED NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`),
  INDEX `fk_article_comments_article1_idx` (`article_id` ASC),
  INDEX `fk_article_comments_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_article_comments_article1`
    FOREIGN KEY (`article_id`)
    REFERENCES `blog`.`article` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_article_comments_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `blog`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '文章评论表';


-- -----------------------------------------------------
-- Table `blog`.`options`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blog`.`options` ;

CREATE TABLE IF NOT EXISTS `blog`.`options` (
  `name` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '配置项名称',
  `value` TEXT NOT NULL COMMENT '配置项值',
  `remark` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '设置项备注(中文名)',
  PRIMARY KEY (`name`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
COMMENT = '系统设置表';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
