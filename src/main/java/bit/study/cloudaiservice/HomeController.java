package bit.study.cloudaiservice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import java.io.File;

@Controller
public class HomeController {
    @GetMapping("/")
    public String home(HttpServletRequest request) {
        delete(request);
        return "home";
    }

    public void delete(HttpServletRequest request) {
        String uploadPath = request.getSession().getServletContext().getRealPath("/");

        File file = new File(uploadPath+"/");
        String[] list = file.list();
        System.out.println(list.length);
        for(String fn:list) {
            System.out.println(fn);
            File f = new File(uploadPath+"/"+fn);
            if(f.exists()) {
                System.out.println(fn+" 파일 삭제");
                f.delete();
            }
        }
    }
}
