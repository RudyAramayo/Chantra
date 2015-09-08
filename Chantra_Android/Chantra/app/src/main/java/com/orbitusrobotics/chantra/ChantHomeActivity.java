package com.orbitusrobotics.chantra;

import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.net.Uri;
import android.os.CountDownTimer;
import android.os.SystemClock;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.util.Log;
import android.content.Intent;
import android.media.MediaPlayer;
import android.widget.Chronometer;
import android.widget.TextView;
import android.widget.Toast;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.TimeZone;


public class ChantHomeActivity extends ActionBarActivity {


    private boolean timerHasStarted = false;
    private long timeElapsed;
    private long daimoku;
    private long total_daimoku;

    private CountDownTimer daimokuCounter;

    private final long startTime = 0000;
    private final long interval = 1000;

    public final static String MY_PREFS_NAME = "Chantra";
    public final static String ACCUMULATED_DAIMOKU_TIME = "com.orbitusrobotics.chantra.DAIMOKUTIME";
    public final static String ACCUMULATED_DAIMOKU = "com.orbitusrobotics.chantra.DAIMOKU";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_chant_home);

        //text = (TextView) this.findViewById(R.id.timer);
        //timeElapsedView = (TextView) this.findViewById(R.id.timeElapsed);
        //countDownTimer = new MalibuCountDownTimer(startTime, interval);
        //text.setText(text.getText() + String.valueOf(startTime));
        //countDownTimer.start();



        //Recall Accumulated Daimoku
        SharedPreferences prefs = getSharedPreferences(MY_PREFS_NAME, MODE_PRIVATE);
        daimoku = prefs.getLong("daimoku", 0);
        total_daimoku = prefs.getLong("total_daimoku", 0);
        timerHasStarted = prefs.getBoolean("timerHasStarted", true);
        ((Chronometer) findViewById(R.id.chronometer1)).setBase(SystemClock.elapsedRealtime() - daimoku*1000);

        //Start timer if it was running before
        if (timerHasStarted)
        {
            Log.d("chantra", "Starting timer");
            ((Chronometer) findViewById(R.id.chronometer1)).start();
        }

        Log.d("chantra", "total daimoku " + total_daimoku);
        Log.d("chantra", "daimoku " + daimoku);


    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_chant_home, menu);
        return true;
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

    public void goalsAction(View view)
    {
        Log.d("chantra", "Goals Action");
        //Intent intent = new Intent(this, DisplayGoalsActivity.class);
        //startActivity(intent);
    }

    public void communityAction(View view)
    {
        Log.d("chantra", "Community Action");
        Intent intent = new Intent(this, DisplayCommunityActivity.class);
        startActivity(intent);
    }

    public void shareAction(View view)
    {
        //Log.d("chantra", "Share Action");
        Intent intent = new Intent(this, DisplayShareDaimokuActivity.class);

        long elapsedMillis = ((Chronometer) findViewById(R.id.chronometer1)).getBase();
        long durationSeconds = elapsedMillis / 1000;

        //send accumulated daimoku amount to the share daimoku activity

        if (timerHasStarted)
        {
            long unfinished_daimoku = (SystemClock.elapsedRealtime() - ((Chronometer) findViewById(R.id.chronometer1)).getBase()) / 1000;
            intent.putExtra(ACCUMULATED_DAIMOKU, Long.toString(total_daimoku + unfinished_daimoku));
            String daimokuStringTime = String.format("%02d:%02d:%02d", (total_daimoku + unfinished_daimoku) / 3600,
                    ((total_daimoku + unfinished_daimoku) % 3600) / 60, ((total_daimoku + unfinished_daimoku) % 60));
            intent.putExtra(ACCUMULATED_DAIMOKU_TIME, daimokuStringTime);
        }
        else
        {
            intent.putExtra(ACCUMULATED_DAIMOKU, Long.toString(total_daimoku + daimoku));
            String daimokuStringTime = String.format("%02d:%02d:%02d", (total_daimoku + daimoku) / 3600,
                    ((total_daimoku + daimoku) % 3600) / 60, ((total_daimoku + daimoku) % 60));
            intent.putExtra(ACCUMULATED_DAIMOKU_TIME, daimokuStringTime);
        }
        startActivity(intent);
    }


    public void lotusAction(View view)
    {

        Log.d("chantra", "Lotus Action");
        Intent intent = new Intent(this, LotusActivity.class);
        startActivity(intent);



        /*
        File pdfFile = new File(
                "android.resource://com.orbitusrobotics.chantra/"
                        + R.raw.prayerbook_large);
        Uri path = Uri.fromFile(pdfFile);
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        intent.setDataAndType(path, "application/pdf");

        startActivity(intent);
        */

        /*
        Log.d("chantra", "Lotus Action");
        Intent intent = new Intent(Intent.ACTION_VIEW,
                Uri.parse("@res/raw/prayerbook_large.pdf"));
        intent.setType("application/pdf");
        PackageManager pm = getPackageManager();
        List<ResolveInfo> activities = pm.queryIntentActivities(intent, 0);
        //if (activities.size() > 0) {
            startActivity(intent);
        //} else {
            // Do something else here. Maybe pop up a Dialog or Toast
        //}
        */

    }

    public void resetTimerAction(View view)
    {
        Log.d("chantra", "Reset Timer Action");

        ((Chronometer) findViewById(R.id.chronometer1)).stop();

        //if timer is running ... stop timer...
        // add daimoku

        //Store Daimoku
        SharedPreferences.Editor editor = getSharedPreferences(MY_PREFS_NAME, MODE_PRIVATE).edit();
        editor.putLong("total_daimoku", total_daimoku + daimoku);
        editor.putLong("daimoku", 0);
        editor.commit();
        daimoku = 0;

        SharedPreferences prefs = getSharedPreferences(MY_PREFS_NAME, MODE_PRIVATE);
        total_daimoku = prefs.getLong("total_daimoku", 0);
        editor.commit();

        ((Chronometer) findViewById(R.id.chronometer1)).setBase(SystemClock.elapsedRealtime());

        Log.d("chantra", "total daimoku " + total_daimoku);
        Log.d("chantra", "daimoku " + daimoku);

    }

    public void timerAction(View view)
    {
        Log.d("chantra", "toggle timer");
        if (timerHasStarted)
        {
            //store time
            long elapsedMillis = SystemClock.elapsedRealtime() - ((Chronometer) findViewById(R.id.chronometer1)).getBase();
            daimoku = elapsedMillis/1000;

            Log.d("chantra", "total_daimoku " + total_daimoku);
            Log.d("chantra", "accumulated daimoku " + daimoku);

            //Store Daimoku
            SharedPreferences.Editor editor = getSharedPreferences(MY_PREFS_NAME, MODE_PRIVATE).edit();
            editor.putLong("daimoku", daimoku);
            editor.commit();



            ((Chronometer) findViewById(R.id.chronometer1)).stop();

            timerHasStarted = false;
            //Store timerHasStarted
            editor = getSharedPreferences(MY_PREFS_NAME, MODE_PRIVATE).edit();
            editor.putBoolean("timerHasStarted", timerHasStarted);
            editor.commit();
        }
        else
        {
            ((Chronometer) findViewById(R.id.chronometer1)).setBase((long) (SystemClock.elapsedRealtime() - 1000*daimoku));
            ((Chronometer) findViewById(R.id.chronometer1)).start();

            timerHasStarted = true;
            //Store timerHasStarted
            SharedPreferences.Editor editor = getSharedPreferences(MY_PREFS_NAME, MODE_PRIVATE).edit();
            editor.putBoolean("timerHasStarted", timerHasStarted);
            editor.commit();

        }
    }


    public void bellAction(View view) {

        Random rnd = new Random();
        int randomAudioIndex = rnd.nextInt(5);
        switch (randomAudioIndex) {
            case 0:
                Log.d("chantra", "Bell Action -- 0");
                MediaPlayer mediaPlayer1 = MediaPlayer.create(this, R.raw.bell1);
                mediaPlayer1.start();
                break;
            case 1:
                Log.d("chantra", "Bell Action -- 1");
                MediaPlayer mediaPlayer2 = MediaPlayer.create(this, R.raw.bell2);
                mediaPlayer2.start();
                break;
            case 2:
                Log.d("chantra", "Bell Action -- 2");
                MediaPlayer mediaPlayer3 = MediaPlayer.create(this, R.raw.bell3);
                mediaPlayer3.start();
                break;
            case 3:
                Log.d("chantra", "Bell Action -- 3");
                MediaPlayer mediaPlayer4 = MediaPlayer.create(this, R.raw.bell4);
                mediaPlayer4.start();
                break;
            case 4:
                Log.d("chantra", "Bell Action -- 4");
                MediaPlayer mediaPlayer5 = MediaPlayer.create(this, R.raw.bell5);
                mediaPlayer5.start();
                break;
        }
    }

}
