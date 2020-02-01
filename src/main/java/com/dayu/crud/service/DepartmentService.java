package com.dayu.crud.service;

import com.dayu.crud.bean.Department;
import com.dayu.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author DaYu
 * @Date 2020-01-30 16:34
 * @To_Do
 */
@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    /**
     * 获取部门列表
     * @return
     */
    public List<Department> getDepts() {
        return departmentMapper.selectByExample(null);
    }
}
