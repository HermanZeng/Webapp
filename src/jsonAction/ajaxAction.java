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
import testModel.entity;
import Entity.Bookdetail;

import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import testModel.sqlCommand;
/**
 * Servlet implementation class ajaxAction
 */
@WebServlet("/ajaxAction")
public class ajaxAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ajaxAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/*ApplicationContext context =
				  new ClassPathXmlApplicationContext(new String[] {"TestContext.xml"});
	    sqlCommand bean = context.getBean(sqlCommand.class);
	    System.out.println(bean.getSqlcmd());*/
		String item_id = (String) request.getParameter("item_id");
		System.out.println(item_id);
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session sess = sf.openSession();
		Transaction tx = sess.beginTransaction();
		Query query = sess.createQuery("from Bookdetail where item_id = :item_id");
		query.setParameter("item_id", item_id);
		Bookdetail detail = (Bookdetail)query.uniqueResult();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=utf-8");
		String jsonStr = "{\"bookname\":\""+detail.getBookname()+"\",\"price\":\""+detail.getPrice()+"\",\"category\":\""+detail.getCategory()+"\",\"detail\":\""+detail.getDetail()+"\"}";
		PrintWriter out = null;
		out = response.getWriter();
	    out.write(jsonStr);
	    if(out != null)
	    	out.close();
	}

}
