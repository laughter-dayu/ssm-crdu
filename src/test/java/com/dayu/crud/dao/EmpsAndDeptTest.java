package com.dayu.crud.dao;

import com.dayu.crud.bean.Department;
import com.dayu.crud.bean.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

import static org.junit.Assert.*;

/**
 * @Author DaYu
 * @Date 2020-01-27 15:09
 * @To_Do
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class EmpsAndDeptTest {

    /**
     * 测试DepartmentMapper
     */
    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private EmployeeMapper employeeMapper;
    @Autowired
    private SqlSession sqlSession;

    //@Test
    public void testCRDU() {
        departmentMapper.insertSelective(new Department(null,"开发部"));
        departmentMapper.insertSelective(new Department(null,"测试部"));
        System.out.println("测试完成 ");

    }
    @Test
    public void testInsertEmp(){
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        String uuid = UUID.randomUUID().toString().substring(0, 5);
        for (int i = 0; i <250; i++) {
            //交替插入
            mapper.insertSelective(new Employee(null, uuid+i,"F",uuid+"@163.com", 1));
            mapper.insertSelective(new Employee(null, uuid+i,"M",uuid+"@163.com", 2));
        }
        System.out.println("测试:插入用户数据完成");
    }
}