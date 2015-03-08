package com.moklet.smarttrafficsystem.login;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
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

import com.moklet.smarttrafficsystem.MainActivity;
import com.moklet.smarttrafficsystem.R;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class LoginActivity extends Activity {

	EditText etPengguna, etBirthdate, etLicenseNumber;
	Button btnLogin;
	String responeLogin;
	String id_pengguna;
	String id_posisi;

	private static final String TAG_ID_PENGGUNA = "id_pengguna";
	private static final String TAG_NAMA_PENGGUNA = "nama_pengguna";
	private static final String TAG_KATA_SANDI = "kata_sandi";
	private static final String TAG_IDCARDNO = "idcardno";
	private static final String TAG_TGL_LAHIR = "tgl_lahir";
	private static final String TAG_NAMA_LENGKAP = "nama_lengkap";
	private static final String TAG_JENIS_KELAMIN = "jenis_kelamin";
	private static final String TAG_ID_JENIS_KENDARAAN = "id_jenis_kendaraan";
	private static final String TAG_ID_MEREK = "id_merek";
	private static final String TAG_ID_TIPE_MEREK = "id_tipe_merek";
	private static final String TAG_WARNA_KENDARAAN = "warna_kendaraan";
	private static final String TAG_NO_PLAT = "no_plat";
	private static final String TAG_ACTIVE = "active";
	private static final String TAG_ID_POSISI = "id_posisi";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		setContentView(R.layout.layout_login);
		super.onCreate(savedInstanceState);

		etPengguna = (EditText) findViewById(R.id.etPengguna);
		etBirthdate = (EditText) findViewById(R.id.etBirthdate);
		etLicenseNumber = (EditText) findViewById(R.id.etLicenseNumber);

		btnLogin = (Button) findViewById(R.id.btnLogin);

		btnLogin.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View arg0) {
				new logintask().execute();
			}
		});

	}

	class logintask extends AsyncTask<Void, Void, Void> {

		@Override
		protected Void doInBackground(Void... arg0) {

			postLoginData();

			return null;
		}

		@Override
		protected void onPostExecute(Void result) {

			if (!responeLogin.toString().equals("0")) {

				JSONArray ja;
				try {
					ja = new JSONArray(responeLogin);

					JSONObject c = ja.getJSONObject(0);

					id_pengguna = c.getString(TAG_ID_PENGGUNA);
					String nama_pengguna = c.getString(TAG_NAMA_PENGGUNA);
					String idcardno = c.getString(TAG_IDCARDNO);
					String tgllahir = c.getString(TAG_TGL_LAHIR);
					String nama_lengkap = c.getString(TAG_NAMA_LENGKAP);
					String jenis_kelamin = c.getString(TAG_JENIS_KELAMIN);
					String id_jenis_kendaraan = c
							.getString(TAG_ID_JENIS_KENDARAAN);
					String id_merek = c.getString(TAG_ID_MEREK);
					String id_tipe_merek = c.getString(TAG_ID_TIPE_MEREK);
					String warna_kendaraan = c.getString(TAG_WARNA_KENDARAAN);
					String no_plat = c.getString(TAG_NO_PLAT);
					String active = c.getString(TAG_ACTIVE);
					id_posisi = c.getString(TAG_ID_POSISI);
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				Log.d("id_posisi", id_posisi + "");

				Intent intent = new Intent(LoginActivity.this,
						MainActivity.class);

				intent.putExtra(TAG_ID_POSISI, id_posisi + "");

				startActivity(intent);

				finish();

			} else {
				Toast.makeText(getApplicationContext(),
						"Username & Password Salah", Toast.LENGTH_SHORT).show();
			}

			super.onPostExecute(result);
		}

	}

	public void postLoginData() {
		// Create a new HttpClient and Post Header
		HttpClient httpclient = new DefaultHttpClient();

		/* login.php returns true if username and password is equal to saranga */
		HttpPost httppost = new HttpPost("http://api.edoferiyus.com/api/login");

		try {

			// Add user name and password

			List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(2);
			nameValuePairs.add(new BasicNameValuePair("username", etPengguna
					.getText().toString()));
			nameValuePairs.add(new BasicNameValuePair("birthdate", etBirthdate
					.getText().toString()));
			nameValuePairs.add(new BasicNameValuePair("licensenumber",
					etLicenseNumber.getText().toString()));
			httppost.setEntity(new UrlEncodedFormEntity(nameValuePairs));

			// Execute HTTP Post Request
			Log.w("SENCIDE", "Execute HTTP Post Request");
			HttpResponse response = httpclient.execute(httppost);

			responeLogin = inputStreamToString(
					response.getEntity().getContent()).toString();
			Log.w("SENCIDE", responeLogin);

		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private StringBuilder inputStreamToString(InputStream is) {
		String line = "";
		StringBuilder total = new StringBuilder();
		// Wrap a BufferedReader around the InputStream
		BufferedReader rd = new BufferedReader(new InputStreamReader(is));
		// Read response until the end
		try {
			while ((line = rd.readLine()) != null) {
				total.append(line);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		// Return full string
		return total;
	}

}
