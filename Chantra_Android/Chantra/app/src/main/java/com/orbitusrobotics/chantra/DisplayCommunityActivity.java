package com.orbitusrobotics.chantra;

import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.content.Intent;
import android.view.View;

public class DisplayCommunityActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_display_community);
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

    public void rowClick(View view)
    {
        switch(view.getId()) {
            case R.id.daily_encouragement:

                Log.d("chantra", "Row Click Encouragement");
                Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.sgi.org/sgi-president/daily-encouragement/"));
                startActivity(browserIntent);

                break;
            case R.id.sgi_usa:

                Log.d("chantra", "Row Click SGI_USA");
                browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.sgi-usa.org/"));
                startActivity(browserIntent);

                break;
            case R.id.sgi_intl:

                Log.d("chantra", "Row Click SGI_INTL");
                browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.sgi.org/"));
                startActivity(browserIntent);

                break;
            case R.id.words_of_wisdom:

                Log.d("chantra", "Row Click Words of Wisdom");
                browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.ikedaquotes.org/"));
                startActivity(browserIntent);

                break;
            case R.id.sgi_quarterly:

                Log.d("chantra", "Row Click SGI Quarterly");
                browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.sgiquarterly.org/"));
                startActivity(browserIntent);

                break;
            case R.id.tsunesaburo_makiguchi:

                Log.d("chantra", "Row Click Tsunesaburo Makiguchi");
                browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.tmakiguchi.org/"));
                startActivity(browserIntent);

                break;
            case R.id.josei_toda:

                Log.d("chantra", "Row Click Josei Toda");
                browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.joseitoda.org/"));
                startActivity(browserIntent);

                break;
            case R.id.daisaku_ikeda:

                Log.d("chantra", "Row Click Daisaku Ikeda");
                browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.daisakuikeda.org/"));
                startActivity(browserIntent);

                break;
            case R.id.writings_of_nichiren_daishonin:

                Log.d("chantra", "Row Click Writings of nichiren Daishonin");
                browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.nichirenlibrary.org/"));
                startActivity(browserIntent);

                break;
            case R.id.sgi_youtube:

                Log.d("chantra", "Row Click SGI Youtube");
                browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.youtube.com/user/SGIVideosOnline"));
                startActivity(browserIntent);

                break;
            case R.id.sgi_buddhism:

                Log.d("chantra", "Row Click SGI Buddhism");
                browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.nichirenlibrary.org/en/dic/toc/"));
                startActivity(browserIntent);

                break;
            case R.id.sgi_video_for_youth:

                Log.d("chantra", "Row Click SGI Video for youth campaign");
                browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.youtube.com/watch?v=3VEMHWnewuc"));
                startActivity(browserIntent);

                break;
        }

    }

}
