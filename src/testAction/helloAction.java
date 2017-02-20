/**
 * 
 */
package testAction;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import testModel.entity;;
/**
 * @author heming
 *
 */
public class helloAction extends ActionSupport implements SessionAware{
	
	private static final long serialVersionUID = 1L;
	private Map<String, Object> userSession;
	private int date;
	
	public int getDate() {
		return date;
	}

	public void setDate(int date) {
		this.date = date;
	}

	public String execute() throws Exception {
		ApplicationContext context =
				  new ClassPathXmlApplicationContext(new String[] {"TestContext.xml"});
	      entity bean = context.getBean(entity.class);
	      this.date = bean.getDate();
	      System.out.println(bean.getDate());
	      System.out.println("success");
	      System.out.println("hello");
		return SUCCESS;
	}

	public void setSession(Map<String, Object> session) {
		userSession = session;
		
	}
}
