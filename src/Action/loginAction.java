/**
 * 
 */
package Action;

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

import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author heming
 *
 */
public class loginAction extends ActionSupport implements SessionAware{
	
	private static final long serialVersionUID = 1L;
	private Map<String, Object> userSession;
	private String user_id;
	private String password;

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String execute() throws Exception {
	    System.out.println(user_id);
	    System.out.println(password);
		SessionFactory sf = new Configuration().configure().buildSessionFactory();
		Session session = sf.openSession();
        Transaction tx = session.beginTransaction();
		Query query = session.createQuery("from User where id= :id");
		query.setString("id", user_id);
		//tx.commit();
		User user = (User) query.uniqueResult();
		String pwd = null;
		if (user != null)
			pwd = user.password;
		tx.commit();
		session.close();
		if(pwd != null)
		{
			if(password.equals(pwd))
			{
	            System.out.println("success");
	            userSession.put("id", user_id);
	            Map<String, Object> se = ActionContext.getContext().getSession();
	            se.put("id", user_id);
	            return SUCCESS;
			}
			else
			{
				System.out.println("error");
	            return ERROR;
			}
		}
		else
		{
			Map<String, Object> se = ActionContext.getContext().getSession();
			String id = (String) se.get("id");
			System.out.println(id);
			HttpServletRequest request = ServletActionContext.getRequest();
			
			if(!(id != null && id != ""))
				return ERROR;
		}
		//doGet(request, response);
		return ERROR;
	}

	public void setSession(Map<String, Object> session) {
		userSession = session;
		
	}
}
