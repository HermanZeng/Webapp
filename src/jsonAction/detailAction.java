package jsonAction;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import Entity.User;
import Entity.Book;

import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class detailAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Book book;
	public Map responsejson;
	public Book getBook() {
		
		return book;
	}
	public void setBook(Book book) {
		this.book = book;
	}
	public String execute() throws Exception {
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		Query query = sess.createQuery("from Book where item_id = :item_id");
		query.setParameter("item_id", "000001");
		Book bk = (Book)query.uniqueResult();
		tx.commit();
		sess.close();
		this.book = bk;
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("bookname", bk.getBookname());
		map.put("price", bk.getPrice());
		this.setResponsejson(map);
		System.out.println(bk.getBookname());
		return null;
	}
	public Map getResponsejson() {
		return responsejson;
	}
	public void setResponsejson(Map responsejson) {
		this.responsejson = responsejson;
	}
}
