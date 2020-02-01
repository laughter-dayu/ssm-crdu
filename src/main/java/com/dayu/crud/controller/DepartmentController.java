package com.dayu.crud.controller;

import com.dayu.crud.bean.Department;
import com.dayu.crud.bean.Employee;
import com.dayu.crud.dao.DepartmentMapper;
import com.dayu.crud.service.DepartmentService;
import com.dayu.crud.service.EmployeeService;
import com.dayu.crud.untils.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Author DaYu
 * @Date 2020-01-27 17:50
 * @To_Do
 */
@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;

    /**
     * 获取部门列表
     * @return
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> depts = departmentService.getDepts();
        return Msg.success().add("depts",depts);
    }


}
