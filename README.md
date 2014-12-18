yii2_blog
=========

基于YII2的一个Blog系统

###2014年12月18日
* 对前台90%的界面固定文字（链接、菜单、导航和提示文字等）使用了`YII`国际化组件进行语言切换，目前仅做了简体中文
* 对模型的提示信息也使用了了`YII`国际化组件进行语言切换，目前仅做了简体中文
* 增加了简体中文的语言翻译
* 重置密码从Site控制器改为User控制器
* 一些其他小BUG修复

###2014年12月10日
* 数据库新增留言板表
* 数据库分类表的category_name改为name，其它使用到了的地方也一并修改

###2014年12月09日
* 完成了前台分类（文章）页
* 一些逻辑和查询的优化
* 文章模型里的根据分类id获取文章、获取热门文章和获取最新文章三个方法整合到一起了！！之前怎么想的，写了三个！醉了～

###2014年12月08日
* 文章模型新增获取最新文章和热门文章的方法
* 完成了文章列表页
* 首页增加了访问文章列表页的链接
* 导航栏主页按钮增加了一个房子图标
