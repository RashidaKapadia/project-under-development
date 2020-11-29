package underdevelopment.db;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.neo4j.driver.Record;
import org.neo4j.driver.Result;
import org.neo4j.driver.Session;
import org.neo4j.driver.Transaction;

import static org.neo4j.driver.Values.parameters;


public class DBDebateDailyQuestion {

     
    public static Map<String, String> getDailyDebateQuestion(String tier){

        System.out.println(LocalDate.now().toString());

        try (Session session = Connect.driver.session()) {
            // NEED TO UPDATE DATE TO LOCAL DATE AFTER DEC 1
            Result result = session.run("MATCH (q:DebateQuestion {tier: $t, date: $d} ) RETURN q",
                                        parameters("t", tier, "d", "2020-12-02"));
            
            if (result.hasNext()){
                Record r = result.single();

                Map<String, String> question = new HashMap<>();
                question.put("question", r.get("q").get("question").asString());

                return question;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }

    public static int addResponse(String username, String analysis){
        try (Session session = Connect.driver.session()) {

            Result result = session.run("MERGE (r:DebateResponse {username: $u, debateAnalysis: $a} ) RETURN ID(r) as id",
                                        parameters("u", username, "a", analysis));
            
            if (result.hasNext()){
                Record r = result.next();

                int id = r.get("id").asInt();
                return id;

            }
            return -1;
        }
        catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public static boolean addResponseToQuestion(String tier, int id){
        try (Session session = Connect.driver.session()) {
            Transaction tx = session.beginTransaction();
            
            // NEED TO CHANGE DATE TO LocalDate.now().toString()
            tx.run("MATCH (q:DebateQuestion {tier: $t, date: $d}), (r:DebateResponse) " 
            + "WHERE ID(r) = $i MERGE (q)-[:hasResponse]->(r) RETURN r",
                                        parameters("t", tier, "d", "2020-12-01", "i", id));
            
            return true;
        }
        catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}