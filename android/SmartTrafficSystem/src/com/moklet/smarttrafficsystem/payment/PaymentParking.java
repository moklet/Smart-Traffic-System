package com.moklet.smarttrafficsystem.payment;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.moklet.smarttrafficsystem.R;

import android.app.Activity;
import android.location.Location;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;

public class PaymentParking extends Activity {

	int kmInDec, meterInDec;
	double meter;

	static String TAG_ID_PARKIR = "id_parkir";
	static String TAG_NAMA_PARKIR = "nama_parkir";
	static String TAG_PARKIR_LAT = "parkir_lat";
	static String TAG_PARKIR_LONG = "parkir_long";
		
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		setContentView(R.layout.layout_delima);

		super.onCreate(savedInstanceState);

		Location selected_location = new Location("location	A");

		selected_location.setLatitude(-6.207082);
		selected_location.setLongitude(106.826382);

		Location near_locations = new Location("locationB");

		near_locations.setLatitude(-6.207082);
		near_locations.setLongitude(106.826382);	

		double distance = selected_location.distanceTo(near_locations);

	}

	class getparkirlist extends AsyncTask<Void, Void, Void> {

		@Override
		protected Void doInBackground(Void... params) {

			String url = "";
			
			// Creating service handler class instance
			ServiceHandler sh = new ServiceHandler();
			
			// Making a request to url and getting response
			String jsonStr = sh.makeServiceCall(url, ServiceHandler.GET);

			Log.d("Response: ", "> " + jsonStr);
				
			JSONArray ja;
			
			try {
				ja = new JSONArray(jsonStr);

				JSONObject c = ja.getJSONObject(0);
				
				String id_pengguna = c.getString(TAG_ID_PARKIR);
				String nama_pengguna = c.getString(TAG_NAMA_PARKIR);
				String idcardno = c.getString(TAG_PARKIR_LAT);
				String tgllahir = c.getString(TAG_PARKIR_LONG);
			} catch (JSONException e) {
				
				e.printStackTrace();
			}

			return null;
		}

		@Override
		protected void onPostExecute(Void result) {
			
			super.onPostExecute(result);
			
		}

	}

	private void SendDataToServer(String idposisi, String lat_terkini,
			String long_terkini, String speed_terkini) {
		
		HttpClient httpClient = new DefaultHttpClient();

		HttpPost httpPost = new HttpPost(
				"http://api.edoferiyus.com/api/insert-coordinate");
		
		// Post Data
		
		List<NameValuePair> nameValuePair = new ArrayList<NameValuePair>(2);
		nameValuePair.add(new BasicNameValuePair("idposisi", "2"));
		nameValuePair.add(new BasicNameValuePair("lat", "6.12"));
		nameValuePair.add(new BasicNameValuePair("long", "102.34"));
		nameValuePair.add(new BasicNameValuePair("speed", "21"));

		try {
			httpPost.setEntity(new UrlEncodedFormEntity(nameValuePair));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		try {
			HttpResponse response = httpClient.execute(httpPost);

			Log.d("Http Post Response:", response.toString());
		} catch (ClientProtocolException e) {

			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		}

	}

}
