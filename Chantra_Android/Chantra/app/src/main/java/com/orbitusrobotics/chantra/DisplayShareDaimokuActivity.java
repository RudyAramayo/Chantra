package com.orbitusrobotics.chantra;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.telephony.SmsManager;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;

import com.facebook.FacebookSdk;
import com.facebook.share.widget.ShareDialog;

import org.apache.http.protocol.HTTP;

import java.io.File;

import static com.orbitusrobotics.chantra.ChantHomeActivity.ACCUMULATED_DAIMOKU;
import static com.orbitusrobotics.chantra.ChantHomeActivity.ACCUMULATED_DAIMOKU_TIME;
import static com.orbitusrobotics.chantra.ChantHomeActivity.MY_PREFS_NAME;


public class DisplayShareDaimokuActivity extends AppCompatActivity {

    private int accumulated_daimoku;
    private String accumulated_daimoku_string;
    private String accumulated_daimoku_time_string;

    private Menu menu;
    private int selected_daimoku_icon;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        FacebookSdk.sdkInitialize(getApplicationContext());

        setContentView(R.layout.activity_display_share_daimoku);
        Intent intent = getIntent();

        //facebook = new Facebook(APP_ID);

        accumulated_daimoku_time_string = intent.getStringExtra(ACCUMULATED_DAIMOKU_TIME);
        accumulated_daimoku_string = intent.getStringExtra(ACCUMULATED_DAIMOKU);
        accumulated_daimoku = Integer.parseInt(accumulated_daimoku_string);

        ((TextView) findViewById(R.id.daimoku_text)).setText(accumulated_daimoku_string);

        SharedPreferences prefs = getSharedPreferences(MY_PREFS_NAME, MODE_PRIVATE);
        selected_daimoku_icon = prefs.getInt("selected daimoku icon", 0);




        Log.d("chantra", "Accumulated Daimoku - " + accumulated_daimoku_string);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        this.menu = menu;
        getMenuInflater().inflate(R.menu.menu_lotus, menu);



        int cherry_blossom = 0x1F338;
        String cherry_blossom_string= new String(Character.toChars(cherry_blossom)) + " Cherry Blossom";
        MenuItem item = menu.findItem(R.id.item1);
        item.setTitle(cherry_blossom_string);
        if (selected_daimoku_icon == 0)
            item.setChecked(true);

        int tulip = 0x1F337;
        String tulip_string = new String(Character.toChars(tulip)) + " Tulip";
        item = menu.findItem(R.id.item2);
        item.setTitle(tulip_string);
        if (selected_daimoku_icon == 1)
            item.setChecked(true);

        int seedling = 0x1F331;
        String seedling_string = new String(Character.toChars(seedling)) + " Seedling";
        item = menu.findItem(R.id.item3);
        item.setTitle(seedling_string);
        if (selected_daimoku_icon == 2)
            item.setChecked(true);

        int hibiscus = 0x1F33A;
        String hibiscus_string = new String(Character.toChars(hibiscus)) + " Hibiscus";
        item = menu.findItem(R.id.item4);
        item.setTitle(hibiscus_string);
        if (selected_daimoku_icon == 3)
            item.setChecked(true);

        int rose= 0x1F339;
        String rose_string = new String(Character.toChars(rose)) + " Rose";
        item = menu.findItem(R.id.item5);
        item.setTitle(rose_string);
        if (selected_daimoku_icon == 4)
            item.setChecked(true);

        int clover = 0x1F340;
        String clover_string = new String(Character.toChars(clover)) + " Clover";
        item = menu.findItem(R.id.item6);
        item.setTitle(clover_string);
        if (selected_daimoku_icon == 5)
            item.setChecked(true);

        int prayer= 0x1F64F;
        String prayer_string = new String(Character.toChars(prayer)) + " Prayer";
        item = menu.findItem(R.id.item7);
        item.setTitle(prayer_string);
        if (selected_daimoku_icon == 6)
            item.setChecked(true);

        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem selected_item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.

        int id = selected_item.getItemId();
        menu.findItem(selected_item.getItemId());

        MenuItem item = menu.findItem(R.id.item1);
        if (selected_item == item)
        {
            selected_daimoku_icon = 1;
            item.setChecked(true);
        }
        else
        {
            item.setChecked(false);
        }

        item = menu.findItem(R.id.item2);
        if (selected_item == item)
        {
            selected_daimoku_icon = 2;
            item.setChecked(true);
        }
        else
        {
            item.setChecked(false);
        }

        item = menu.findItem(R.id.item3);
        if (selected_item == item)
        {
            selected_daimoku_icon = 3;
            item.setChecked(true);
        }
        else
        {
            item.setChecked(false);
        }

        item = menu.findItem(R.id.item4);
        if (selected_item == item)
        {
            selected_daimoku_icon = 4;
            item.setChecked(true);
        }
        else
        {
            item.setChecked(false);
        }

        item = menu.findItem(R.id.item5);
        if (selected_item == item)
        {
            selected_daimoku_icon = 5;
            item.setChecked(true);
        }
        else
        {
            item.setChecked(false);
        }

        item = menu.findItem(R.id.item6);
        if (selected_item == item)
        {
            selected_daimoku_icon = 6;
            item.setChecked(true);
        }
        else
        {
            item.setChecked(false);
        }

        item = menu.findItem(R.id.item7);
        if (selected_item == item)
        {
            selected_daimoku_icon = 7;
            item.setChecked(true);
        }
        else
        {
            item.setChecked(false);
        }

        return true;
    }

    public String daimoku_share_message()
    {

        int unicode = 0x1F338;

        switch (selected_daimoku_icon)
        {
            case 1:
                //Cherry Blossom
                unicode = 0x1F338;
                break;
            case 2:
                //Tulip
                unicode = 0x1F337;
                break;
            case 3:
                //Seedling
                unicode = 0x1F331;
                break;
            case 4:
                //Hibiscus
                unicode = 0x1F33A;
                break;
            case 5:
                //Rose
                unicode = 0x1F339;
                break;
            case 6:
                //Clover
                unicode = 0x1F340;
                break;
            case 7:
                //Prayer
                unicode = 0x1F64F;
                break;
        }
        String daimoku_icon = new String(Character.toChars(unicode));
        String daimoku_text = String.format("I'm sending you these Daimoku (time:%s) today!\n%s", accumulated_daimoku_time_string, daimoku_icon);
        int daimoku_flower_count = accumulated_daimoku / 900;

        for (int i=0; i < daimoku_flower_count; i++)
        {
            daimoku_text = daimoku_text + daimoku_icon;
        }

        return daimoku_text;
    }

    public void messagesAction(View view) {

        //Works!

        Uri uri = Uri.parse("smsto:");
        Intent it = new Intent(Intent.ACTION_SENDTO, uri);

        it.putExtra("sms_body", daimoku_share_message());
        startActivity(it);


    }

    public String getEmijoByUnicode(int unicode) {
        return new String(Character.toChars(unicode));
    }

    public void mailAction(View view) {
        Log.d("chantra", "Mail Action");
        Intent emailIntent = new Intent(Intent.ACTION_SEND);
// The intent does not have a URI, so declare the "text/plain" MIME type
        emailIntent.setType(HTTP.PLAIN_TEXT_TYPE);
        //emailIntent.putExtra(Intent.EXTRA_EMAIL, new String[]{"jon@example.com"}); // recipients
        emailIntent.putExtra(Intent.EXTRA_SUBJECT, "Chanted for you");
        emailIntent.putExtra(Intent.EXTRA_TEXT, daimoku_share_message());
        //emailIntent.putExtra(Intent.EXTRA_STREAM, Uri.parse("content://path/to/email/attachment"));
// You can also attach multiple items by passing an ArrayList of Uris
        startActivity(emailIntent);
    }

    public void facebookAction(View view) {
        Log.d("chantra", "Facebook Action");

        //Activity activityOrFragment;
        //ShareDialog.show(activityOrFragment, content);


    }

    public void twitterAction(View view) {
        Log.d("chantra", "Twitter Action");

    }
}
