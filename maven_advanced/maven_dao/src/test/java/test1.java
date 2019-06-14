import com.itheima.dao.UserDao;
import com.itheima.domain.User;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class test1 {



    @Test
    public void test() throws Exception {
        ApplicationContext app = new ClassPathXmlApplicationContext("applicationContext-dao.xml");
        UserDao userDao = app.getBean(UserDao.class);
        User user = userDao.findUserById(1);
        System.out.println(user);
    }
}
