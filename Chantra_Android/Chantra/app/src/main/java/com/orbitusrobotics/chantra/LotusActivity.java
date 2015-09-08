package com.orbitusrobotics.chantra;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.webkit.WebSettings;
import android.webkit.WebView;

import java.io.File;

public class LotusActivity extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lotus);

        WebView mWebView = (WebView) findViewById(R.id.pdf_webview);
        WebSettings settings = mWebView.getSettings();
        settings.setDefaultTextEncodingName("utf-8");
        settings.setBuiltInZoomControls(true);
        settings.setSupportZoom(true);
        mWebView.loadUrl("file:///android_res/raw/index.html");
    }


    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
