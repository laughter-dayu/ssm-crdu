package com.dayu.crud.dao;

import com.dayu.crud.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @Author DaYu
 * @Date 2020-01-27 15:09
 * @To_Do
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MVCTest {
    //传入SpringMVC的IOC
    @Autowired
    WebApplicationContext context;
    //虚拟MVC请求，获取到处理结果
    MockMvc mockMvc;
    @Before
    public void initMokcMvc(){
        mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
    }
    @Test
    public void testPageInfo() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();
        //请求成功以后，请求域中或有pageInfo：去除pageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码："+pageInfo.getPageNum());
        System.out.println("总页码"+pageInfo.getPages());
        System.out.println("总记录数"+pageInfo.getTotal());
        int[] nums = pageInfo.getNavigatepageNums();
        for (int i:nums) {
            System.out.print(i+"、");
        }
        System.out.println("-----------------");
        //获取员工信息
        List<Employee> list = pageInfo.getList();
        for (Employee employee:list) {
            System.out.println("ID:"+employee.getEmpId()+"||Name:"+employee.getEmpName());
        }
        System.out.println("信息总数："+list.size());
    }


}