package com.dayu.crud.service;

import com.dayu.crud.bean.Employee;
import com.dayu.crud.bean.EmployeeExample;
import com.dayu.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author DaYu
 * @Date 2020-01-27 17:57
 * @To_Do
 */
@Service
public class EmployeeService {
    /**
     * 获取所有员工信息
     */
    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAllEmps() {
        EmployeeExample example = new EmployeeExample();
        //升序查询
        example.setOrderByClause("emp_id asc");
        //return employeeMapper.selectByExampleWithDept(null);
        return employeeMapper.selectByExampleWithDept(example);
    }

    /**
     * 保存员工
     *
     * @param employee
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * 检查用户名是否可用
     *
     * @param empName
     */
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    /**
     * 根据id获取员工数据
     *
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    /**
     * 员工更新
     *
     * @param employee
     */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 单个删除
     *
     * @param id
     */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 批量删除
     *
     * @param del_ids
     */
    public void deleteBatch(List<Integer> del_ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        // delete from xxx where emp_id in(1,2,3)In可批量删除
        criteria.andEmpIdIn(del_ids);
        employeeMapper.deleteByExample(example);
    }
}
