package jdbcconnection;

import java.sql.*;

/**
 *
 * @author Luana Kimley
 */
public class ZooProjectJDBC
{

    public static void main(String[] args)
    {
  
        Connection connection = null;
        try
        {
            // use the DriverManager to create a Connection object
            String dbUrl = "jdbc:mysql://localhost:3306/zoo";
            String username = "root";
            String password = "";
            connection = DriverManager.getConnection(dbUrl, username, password);
            System.out.println("Connected!");
            Statement stmt = (Statement) connection.createStatement();
	
			// Show animal with its breed which are 10 years and older
            System.out.println("Show animal with its breed which are 10 years and older");
            ResultSet rs1 = stmt.executeQuery("SELECT a.animal_name, b.breed_name, TIMESTAMPDIFF(YEAR, animal_dob, CURDATE()) AS animal_age \n"
                    + "FROM animal a JOIN animal_breed b USING(breed_id)\n"
                    + "WHERE TIMESTAMPDIFF(YEAR, animal_dob, CURDATE()) > 10\n"
                    + "ORDER BY TIMESTAMPDIFF(YEAR, animal_dob, CURDATE());");

            System.out.printf("%-20s%20s%20s\n", "animal_name", "breed_name", "animal_age");
            while (rs1.next())
            {
                System.out.printf("%-20s%20s%20s\n", rs1.getString(1), rs1.getString(2), rs1.getString(3));
            }

			// Show all animal name, food name, and zookeeper name for all feeding schedule on Monday
            System.out.println("\nShow all animal name, food name, and zookeeper name for all feeding schedule on Monday");
            ResultSet rs2 = stmt.executeQuery("SELECT fs.feeding_day, fs.feeding_time, a.animal_name, f.food_name, z.zookeeper_name \n"
                    + "FROM animal a, food f, zookeeper z, feeding_schedule fs, feeding_schedule_animal_food saf, zookeeper_allocation za\n"
                    + "WHERE saf.feeding_id = fs.feeding_id AND a.animal_id = saf.animal_id AND saf.food_id = f.food_id \n"
                    + "AND za.schedule_animal_food_id = saf.schedule_animal_food_id AND za.zookeeper_id = z.zookeeper_id \n"
                    + "AND fs.feeding_day = 'Monday'");
            System.out.printf("%-20s%10s%20s%20s%20s\n", "feeding_day", "feeding_time", "animal_name", "food_name", "zookeeper_name");
            while (rs2.next())
            {
                System.out.printf("%-20s%12s%20s%20s%20s\n", rs2.getString(1), rs2.getString(2), rs2.getString(3), rs2.getString(4), rs2.getString(5));
            }

			// Show the average age of each animal breed (rounded to 2 decimal places) in the zoo, in order
            System.out.println("\nShow the average age of each animal breed (rounded to 2 decimal places) in the zoo, in order");
            ResultSet rs3 = stmt.executeQuery("SELECT b.breed_name, FORMAT(AVG(TIMESTAMPDIFF(YEAR, animal_dob, CURDATE())), 2) AS average_animal_breed_age \n"
                    + "FROM animal a JOIN animal_breed b USING(breed_id)\n"
                    + "GROUP BY b.breed_id\n"
                    + "ORDER BY AVG(TIMESTAMPDIFF(YEAR, animal_dob, CURDATE()))");
            System.out.printf("%-20s%20s\n", "breed_name", "average_animal_breed_age");
            while (rs3.next())
            {
                System.out.printf("%-20s%24s\n", rs3.getString(1), rs3.getString(2));
            }
			
			// Insert new feeding schedule for Ori the orangutan and show that it has been inserted
            System.out.println("\nInsert new feeding schedule for Ori the orangutan");
            String insert_command = "INSERT INTO feeding_schedule_animal_food VALUES ('SAF-49', \n"
                    + "(SELECT feeding_id FROM feeding_schedule WHERE feeding_day='Monday' AND feeding_time='09:15'), \n"
                    + "(SELECT animal_id FROM animal WHERE animal_name='Ori'), \n"
                    + "(SELECT food_id FROM food WHERE food_name='Bananas'));";
            stmt.executeUpdate(insert_command);
            String command_test = "SELECT * FROM feeding_schedule_animal_food WHERE schedule_animal_food_id = 'SAF-49'";
            System.out.printf("%-20s%20s%20s%20s\n", "schedule_animal_food_id", "feeding_id", "animal_id", "food_id");
            ResultSet rs4 = stmt.executeQuery(command_test);
            while (rs4.next())
            {
                System.out.printf("%-20s%23s%20s%20s\n", rs4.getString(1), rs4.getString(2), rs4.getString(3), rs4.getString(4));
            }
			
			// Delete new feeding schedule for Ori the orangutan and show that it has been deleted
            System.out.println("\nDelete Ori the orangutan's feeding schedule");
            String delete_command = "DELETE FROM feeding_schedule_animal_food \n"
                    + "WHERE animal_id=(SELECT animal_id FROM animal WHERE animal_name='Ori')\n"
                    + "AND feeding_id=(SELECT feeding_id FROM feeding_schedule WHERE feeding_day='Monday' AND feeding_time='09:15') AND food_id=(SELECT food_id FROM food WHERE food_name='Bananas')";
            stmt.executeUpdate(delete_command);
            System.out.printf("%-20s%20s%20s%20s\n", "schedule_animal_food_id", "feeding_id", "animal_id", "food_id");
            ResultSet rs5 = stmt.executeQuery(command_test);
            while (rs5.next())
            {
                System.out.printf("%-20s%23s%20s%20s\n", rs4.getString(1), rs4.getString(2), rs4.getString(3), rs4.getString(4));
            }
        } 
        catch (SQLException e)
        {
            for (Throwable t : e)
            {
                t.printStackTrace();
            }
        }
    }

}
