package testInstance;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import testModel.entity;;

public class testApp {
	
	public static void main(String[] args) {
		  ApplicationContext context =
				  new ClassPathXmlApplicationContext(new String[] {"TestContext.xml"});
	      entity bean = context.getBean(entity.class);
	      bean.printDate();
	  }
}
