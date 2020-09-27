package Fragments;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.leaderboard.Hero;
import com.example.leaderboard.LearningAdapter;
import com.example.leaderboard.R;
import com.example.leaderboard.data.network.ApiClient;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class FragmentLearningLeaders extends Fragment {

    private RecyclerView mRecyclerView;
    private TextView mTextView;
    private TextView mTextView1;
    private ImageView mImageView;
    private ProgressBar mProgressBar;
    private LinearLayoutManager mLayoutManager;

    public FragmentLearningLeaders() {
        // Required empty public constructor
    }
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_top_learners,container,false);
        mRecyclerView = view.findViewById(R.id.recycler_view_learner_leaders);

        mLayoutManager = new LinearLayoutManager(getContext());
        mRecyclerView.setLayoutManager(mLayoutManager);

        mTextView = view.findViewById(R.id.img_badge);
        mTextView1 = view.findViewById(R.id.txt_name);
        mImageView = view.findViewById(R.id.imageView_top_learner);
        mProgressBar = new ProgressBar(getContext());

        getLearners();
        return view;
    }

    private void getLearners() {
        ApiClient.getClient().getLearningLeaders().enqueue(new Callback<List<Hero>>() {

            private List<Hero> mLearningHeroList;
            private TopLearnersAdapter mTopLearnersAdapter;

            @Override
            public void onResponse(Call<List<Hero>> call, Response<List<Hero>> response) {
                if (response.isSuccessful()){
                    mLearningHeroList = response.body();
                   