package com.CamperX.productList.controller;

import com.CamperX.productList.service.ProductListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
public class ProductListController {

    @Autowired
    private ProductListService service;

    @RequestMapping("/camperX_productList")
    public String camperX_productList(@RequestParam(defaultValue = "tent_all") String category, Model model) throws Exception {
        model.addAttribute("category", category);
        model.addAttribute("sidebarData", service.getSidebarData(category));
        
        // 초기 상품 목록은 필터 없이 로드
        model.addAttribute("productList", service.getProductList(Map.of("category", category)));
        return "productList/productList";
    }

    @PostMapping("/camperX/getProductList")
    @ResponseBody
    public List<Map<String, Object>> getProductList(@RequestBody Map<String, Object> filterData) throws Exception {
        List<Map<String, Object>> products = service.getProductList(filterData);
        if (products != null && !products.isEmpty()) {
        }
        return products;
    }

    @RequestMapping("/camperX/getSubCategories")
    @ResponseBody
    public List<Map<String, Object>> getSubCategories(@RequestParam String category) throws Exception {
        List<Map<String, Object>> subCategories = service.getSubCategories(category);
        if (subCategories != null && !subCategories.isEmpty()) {
        }
        return subCategories;
    }
}
