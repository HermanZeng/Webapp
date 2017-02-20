package Interceptor;

import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class loginInterceptor extends AbstractInterceptor{

	private static final long serialVersionUID = 1L;
	private Map<String, Object> userSession;
	
	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		userSession = ActionContext.getContext().getSession();
		String user_id = (String)userSession.get("user_id");
		if(user_id != null && user_id != "")
		{
			return invocation.invoke();
		}
		else
		{
			return "fail";
		}
	}

}
