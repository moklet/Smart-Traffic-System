package com.moklet.smarttrafficsystem;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

import com.moklet.smarttrafficsystem.showmap.ShowMapActivity;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.location.Location;
import android.location.LocationManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.StrictMode;
import android.preference.PreferenceManager;
import android.provider.Settings.Secure;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends Activity implements GPSCallback {
	private GPSManager gpsManager = null;
	private double speed = 0.0;
	Boolean isGPSEnabled = false;
	LocationManager locationManager;
	double currentSpeed, kmphSpeed;
	TextView txtview;
	String android_id;
	Button btnCheckinHome, btnCheckinOffice, btnShowMaps;

	String id_pengguna, id_posisi;

	TextView tvPengguna, tvLat, tvLong, tvSpeed;

	double latitude, longitude;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();

		StrictMode.setThreadPolicy(policy); 

		Intent intent = getIntent();
		id_posisi = intent.getStringExtra("id_posisi");

		btnCheckinHome = (Button) findViewById(R.id.btnCheckinHome);
		btnCheckinOffice = (Button) findViewById(R.id.btnCheckinOffice);
		btnShowMaps = (Button)findViewById(R.id.btnShowMaps);

		android_id = Secure.getString(getApplicationContext()
				.getContentResolver(), Secure.ANDROID_ID);

		tvPengguna = (TextView) findViewById(R.id.idPengguna);
		tvLat = (TextView) findViewById(R.id.tvlat);
		tvLong = (TextView) findViewById(R.id.tvlong);
		tvSpeed = (TextView) findViewById(R.id.tvSpeed);

		locationManager = (LocationManager) getSystemService(LOCATION_SERVICE);
		gpsManager = new GPSManager(MainActivity.this);
		isGPSEnabled = locationManager
				.isProviderEnabled(LocationManager.GPS_PROVIDER);
		if (isGPSEnabled) {
			gpsManager.startListening(getApplicationContext());
			gpsManager.setGPSCallback(this);
		} else {
			gpsManager.showSettingsAlert();
		}

		btnCheckinHome.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				new cinhome().execute();
			}
		});

		btnCheckinOffice.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				new cinoffice().execute();

			}
		});
		
		btnShowMaps.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View arg0) {
				Intent intent = new Intent(MainActivity.this, ShowMapActivity.class);
				startActivity(intent);
				
			}
		});

		

	}

	@Override
	public void onGPSUpdate(Location location) {
		speed = location.getSpeed();

		currentSpeed = round(speed, 3, BigDecimal.ROUND_HALF_UP);
		kmphSpeed = round((currentSpeed * 3.6), 3, BigDecimal.ROUND_HALF_UP);

		latitude = location.getLatitude();
		longitude = location.getLongitude();

		tvLat.setText(latitude + "");
		tvLong.setText(longitude + "");

		tvSpeed.setText(kmphSpeed + "");

		(new Thread(new Runnable() {

			@Override
			public void run() {
				while (!Thread.interrupted())
					try {
						Thread.sleep(30000);
						runOnUiThread(new Runnable() {

							@Override
							public void run() {
								SendDataToServer(id_posisi, latitude + "",
										longitude + "", kmphSpeed + "");
							}
						});
					} catch (InterruptedException e) {
						// ooops
					}
			}
		})).start();
		
		Location selected_location = new Location("location	A");

		selected_location.setLatitude(latitude);
		selected_location.setLongitude(longitude);

		Location near_locations = new Location("locationB");

		near_locations.setLatitude(-6.223766);
		near_locations.setLongitude(106.826793);	

		double distance = selected_location.distanceTo(near_locations);
		
		if (distance < 3){
			Log.d("distance", "Jarak Dengan Lokasi Parikr Sudah Dekat");
			
			// do pembayaran
		} else {
			Log.d("distance", "Jarak Dengan Lokasi Parkir Masih Jauh");
			
			// no action
		}

	}

	@Override
	protected void onDestroy() {
		gpsManager.stopListening();
		gpsManager.setGPSCallback(null);
		gpsManager = null;
		super.onDestroy();
	}

	class postserver extends AsyncTask<Void, Void, Void> {

		@Override
		protected Void doInBackground(Void... arg0) {
			
			return null;
		}
		
	}

	public static double round(double unrounded, int precision, int roundingMode) {
		BigDecimal bd = new BigDecimal(unrounded);
		BigDecimal rounded = bd.setScale(precision, roundingMode);
		return rounded.doubleValue();
	}

	class cinhome extends AsyncTask<Void, Void, Void> {

		@Override
		protected Void doInBackground(Void... params) {
			checkinhome("-6.236559", "106.827414");
			return null;
		}
	}

	class cinoffice extends AsyncTask<Void, Void, Void> {

		@Override
		protected Void doInBackground(Void... params) {
			checkinoffice("-6.206887", "106.829324");
			return null;
		}
	}

	private void checkinhome(String lat, String longs) {

		HttpClient httpClient = new DefaultHttpClient();

		HttpPost httpPost = new HttpPost(
				"http://api.edoferiyus.com/api/insert-coordinate/home");

		// Post Data
		List<NameValuePair> nameValuePair = new ArrayList<NameValuePair>(2);

		nameValuePair.add(new BasicNameValuePair("idposisi", id_posisi));
		nameValuePair.add(new BasicNameValuePair("rumah_lat", lat));
		nameValuePair.add(new BasicNameValuePair("rumah_long", longs));

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

	private void checkinoffice(String lat, String longs) {

		HttpClient httpClient = new DefaultHttpClient();

		HttpPost httpPost = new HttpPost(
				"http://api.edoferiyus.com/api/insert-coordinate/office");

		// Post Data
		List<NameValuePair> nameValuePair = new ArrayList<NameValuePair>(2);

		nameValuePair.add(new BasicNameValuePair("idposisi", id_posisi));
		nameValuePair.add(new BasicNameValuePair("kantor_lat", lat));
		nameValuePair.add(new BasicNameValuePair("kantor_long", longs));

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

	private void SendDataToServer(String idposisi, String lat_terkini,
			String long_terkini, String speed_terkini) {

		HttpClient httpClient = new DefaultHttpClient();

		HttpPost httpPost = new HttpPost(
				"http://api.edoferiyus.com/api/insert-coordinate");

		// Post Data
		List<NameValuePair> nameValuePair = new ArrayList<NameValuePair>(2);
		nameValuePair.add(new BasicNameValuePair("idposisi", idposisi));
		nameValuePair.add(new BasicNameValuePair("lat", lat_terkini));
		nameValuePair.add(new BasicNameValuePair("long", long_terkini));
		nameValuePair.add(new BasicNameValuePair("speed", speed_terkini));

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

	private void savePreferences(String key, String value) {
		SharedPreferences sharedPreferences = PreferenceManager
				.getDefaultSharedPreferences(this);
		Editor editor = sharedPreferences.edit();
		editor.putString(key, value);
		editor.commit();
	}
}