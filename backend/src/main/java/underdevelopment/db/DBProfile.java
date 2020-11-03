package underdevelopment.db;

import static org.neo4j.driver.Values.parameters;

import org.neo4j.driver.Record;
import org.neo4j.driver.Result;
import org.neo4j.driver.Session;
import org.neo4j.driver.Transaction;

public class DBProfile{
	
	
	public static boolean checkPassword(String username, String password) {
		boolean correctPassword = false;

		 try (Session session = Connect.driver.session()){
	        	try (Transaction tx = session.beginTransaction()) {
	        		
	    	        System.out.println("returnindfdf");
					Result result = tx.run(String.format("MATCH (u:user) WHERE u.username = '%s' RETURN u.password = '%s' as correct", username, password));
					// We know username exists, so password exists
					Record record = result.next();
					correctPassword = record.get("correct").asBoolean();
			        System.out.println("returning: " + correctPassword);

					tx.close();
					session.close();
	        	}catch(Exception e) {
	        		e.printStackTrace();
	        	}
	        }catch(Exception e) {
        		e.printStackTrace();
        	}
	        System.out.println("returning: " + correctPassword);
	        return correctPassword;
	}
    // DB command for upadting user password
    public static void updateUserPassword(String username, String newPassword) {
        System.out.println("updating password");
              
        try (Session session = Connect.driver.session()) {
              session.writeTransaction(tx -> tx.run(
                "MATCH (u:user) WHERE u.username = $username SET u.password = '$password'",
                parameters("username", username, "password", newPassword)));
            session.close();
        }
        catch (Exception e){
            // FOR DEBUG
            e.printStackTrace();
        }
    }
    
    // DB command for upadting user status
    public static void updateUserEmail(String username, String email){
        System.out.println("updating email");

        try (Session session = Connect.driver.session()) {
            session.writeTransaction(tx -> tx.run(
                "MATCH (u:user) WHERE u.username = $username SET u.email = '$email'",
                parameters("username", username, "email", email)));
            
            session.close();
        }
        catch (Exception e){
            // FOR DEBUG
            e.printStackTrace();
        }
    }

    // DB command for upadting user status
    public static void updateUserInfo(String username, String status, String email, 
                                    String about, String dob, String acs){
        
        try (Session session = Connect.driver.session()) {
            session.writeTransaction(tx -> tx.run(
                "MATCH (u:user) WHERE u.username = $username SET u.status = $status, u.email = $email, u.about = $about, u.dob = $dob, u.acs = $acs",
                parameters("username", username, "status", status, "email", email, "about", about, "dob", dob, "acs", acs)));
            
            session.close();
        }
        catch (Exception e){
            // FOR DEBUG
            e.printStackTrace();
        }
    }
    
    // DB command for getting user status
    public static Record getUserInfo(String username){
        try (Session session = Connect.driver.session()) {
            try (Transaction tx = session.beginTransaction()) {
              Result node_result = tx.run("MATCH (u:user) WHERE u.username = $username WITH u RETURN u.username as username, u.email as email, u.dob as dob, u.about as about, u.status as status, toInteger(u.acs) as acs ",
              parameters("username", username));
      
              // If any results have been returned, return the record
              if (node_result.hasNext()) {
                return node_result.next();
              }
            }
        }
        return null;
    }
}