// convenient JDBC result set to JSON array mapper

import org.json.JSONObject;
import org.json.JSONArray;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
//import org.springframework.jdbc.support.JdbcUtils;

public class ResultSetToJsonMapper
{
	public static JSONArray convertToJSON(ResultSet resultSet) throws Exception {
        JSONArray jsonArray = new JSONArray();
        if (resultSet != null) {
            while (resultSet.next()) {
                ResultSetMetaData metaData = resultSet.getMetaData();
                int total_rows = metaData.getColumnCount();
                JSONObject obj = new JSONObject();
                for (int i = 0; i < total_rows; i++) {
                    String rKey = metaData.getColumnLabel(i + 1).toLowerCase();
                    Object rVal = resultSet.getObject(i + 1);
                    obj.put(rKey, rVal);
                }
                jsonArray.put(obj);
            }
        }
        return jsonArray;
    }
}