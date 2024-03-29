package com.example.ajax.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.ajax.beans.ShoppingCart;

@WebServlet("/addToCart")
public class AddToCart extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String bookName = request.getParameter("id");
		int price = Integer.parseInt(request.getParameter("price"));
		
		HttpSession session = request.getSession();
		ShoppingCart sc = (ShoppingCart) session.getAttribute("sc");
		
		if(sc == null){
			sc = new ShoppingCart();
			session.setAttribute("sc", sc);
		}
		
		sc.addToCart(bookName, price);
		
		StringBuilder result = new StringBuilder();
		
		result.append("{")
			  .append("\"bookName\":\"" + bookName + "\"")
			  .append(",")
			  .append("\"totalBookNameber\":\"" + sc.getTotalBookNumber() + "\"")
			  .append(",")
			  .append("\"totalMoney\":\"" + sc.getTotalMoney() + "\"")
			  .append("}");
		
		response.setContentType("text/javascript");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().println(result.toString());
		
	}

}
