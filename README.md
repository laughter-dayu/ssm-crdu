SSM-CRUD/bilibili雷丰阳雷大神视屏讲解ssm_crud/IDEA版
==
基于ssm+bootstrap的简单员工管理系统，观看尚硅谷SSM整合视频教程所写。<br>视屏网址：https://www.bilibili.com/video/av35988777
#
技术：
<br>Spring+SpringMVC+Mybatis+Bootstrap
#

开发工具：

<br>apache-tomcat7及以上、
<br>mysql
<br>IntelliJ IDEA 2019.2
<br>maven-3.6.1
#

操作中遇到的问题：

<br>1）IDEA测试和eclipse测试不同，关于IDEA如何测试，自行百度
<br>2）Pagehelper插件5.0及以上去掉了不适合出现在分页插件中的 orderby 功能，官方申明以后会提供单独的排序
<br>解决方法：mybatis条件查询可设置查询规则
<br>3）前端jsp文件中的{APP_PATH}即以服务器为标准的相对路径时不时报错，建议pom文件添加jstl、javax.servlet-api引用（提示:<scope>provided</scope>告知替换）
#
