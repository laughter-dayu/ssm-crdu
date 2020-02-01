package com.dayu.crud.controller;

import com.dayu.crud.bean.Employee;
import com.dayu.crud.service.EmployeeService;
import com.dayu.crud.untils.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author DaYu
 * @Date 2020-01-27 17:50
 * @To_Do
 */
@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    /**
     * 非json数据返回格式查询员工数据
     *
     * @param pn
     * @param model
     * @return
     */
    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //初始页码、页面显示数据条数
        PageHelper.startPage(pn, 7);
        List<Employee> emps = employeeService.getAllEmps();
        //pageInfo封装emps的详细信息，包括查询出来的数据、传入连续显示页数范围
        PageInfo pageInfo = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "list";
    }

    /***
     * 查询员工的数据（分页查询）
     * @param pageNumber
     * @return
     */
    @RequestMapping(value = "/empsx", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber) {
        //初始页码、页面显示数据条数
        PageHelper.startPage(pageNumber, 7);
        List<Employee> emps = employeeService.getAllEmps();
        //pageInfo封装emps的详细信息，包括查询出来的数据、传入连续显示页数范围
        PageInfo<Employee> pageInfo = new PageInfo<Employee>(emps, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }

    /**
     * 保存员工
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        //校验失败，返回失败，在模态框显示失败的错误信息
        if (result.hasErrors()) {
            List<FieldError> errors = result.getFieldErrors();
            Map<String, Object> map = new HashMap<>();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名:"+fieldError.getField());
                System.out.println("错误信息:"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName) {
        //判断用户名是否合法规定表达式
        String regx = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        Boolean b = employeeService.checkUser(empName);
        if (!empName.matches(regx)) {
            return Msg.fail().add("va_msg", "用户名且为2-5中文或3-16英文数字组合");
        }
        if (b == true) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名已存在");
        }
    }

    /**
     * 根据id查询员工
     * @param id
     * @return
     */
    @GetMapping("/emp/{id}")
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee= employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }
    /*
     * @ResponseBody
     *
     * @DeleteMapping("/emp/{id}") public Msg deleteEmpById(@PathVariable("id")
     * Integer id) { employeeService.deleteEmp(id); return Msg.success(); }
     */

    /**
     * 解决方案 要能支持直接发送PUT之类的请求，还要封装请求体中的数据
     * 1、配置上HttpputFormContentFilter；
     * 2、作用：将请求体中的数据解析包装成一个map。
     * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据 员工更新方法
     *
     * @param employee
     * @return
     */
    @PutMapping("/emp/{empId}")
    @ResponseBody
    public Msg saveEmp(Employee employee, HttpServletRequest request) {
        System.out.println("requestScope中的值：" + request.getParameter("email"));
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }
    /**
     * 单个批量二合一 批量删除：1-2-3 单个删除：1
     * @param ids
     * @return
     */
    @ResponseBody
    @DeleteMapping("/emp/{ids}")
    public Msg deleteEmpById(@PathVariable("ids") String ids) {
        if (ids.contains("-")) {
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            // 组装id的集合
            for (String string : str_ids) {
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        } else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }


}
