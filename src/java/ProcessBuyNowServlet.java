import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ProcessBuyNowServlet")
public class ProcessBuyNowServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get medicine details from request
        int medicineId = Integer.parseInt(request.getParameter("medicineId"));
        String medicineName = request.getParameter("medicineName");
        double medicinePrice = Double.parseDouble(request.getParameter("medicinePrice"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        // Create a cart item
        Map<String, Object> cartItem = new HashMap<>();
        cartItem.put("medicineId", medicineId);
        cartItem.put("medicineName", medicineName);
        cartItem.put("medicinePrice", medicinePrice);
        cartItem.put("quantity", quantity);
        
        // Create a new cart with just this item
        ArrayList<Map<String, Object>> cart = new ArrayList<>();
        cart.add(cartItem);
        
        // Store cart in session
        HttpSession session = request.getSession();
        session.setAttribute("cart", cart);
        
        // Redirect to checkout page
        response.sendRedirect("checkout.jsp");
    }
}