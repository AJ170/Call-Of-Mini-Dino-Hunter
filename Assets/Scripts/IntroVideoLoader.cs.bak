using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Video;
using UnityEngine.UI;

public class IntroVideoLoader : MonoBehaviour
{
    [Header("Video Setup")]
    public VideoPlayer videoPlayer;
    public RawImage videoImage;
    public RenderTexture renderTexture;
    public VideoClip introClip;

    private bool videoSkipped = false;

    private void Start()
    {
        if (videoPlayer == null || videoImage == null || renderTexture == null || introClip == null)
        {
            Debug.LogWarning("Intro video setup incomplete, loading main scene directly.");
            SceneManager.LoadScene("Scene_Main");
            return;
        }

        StartCoroutine(PlayIntroVideo());
    }

    private void Update()
    {
        if (videoSkipped) return;

#if UNITY_EDITOR || UNITY_STANDALONE
        if (Input.GetMouseButtonDown(0))
        {
            SkipVideo("Mouse Click");
        }
#elif UNITY_ANDROID || UNITY_IOS
        if (Input.touchCount > 0)
        {
            SkipVideo("Touch Input");
        }
#endif
    }

    private System.Collections.IEnumerator PlayIntroVideo()
    {
        videoSkipped = false;

        videoPlayer.targetTexture = renderTexture;
        videoImage.texture = renderTexture;

        videoPlayer.Stop();
        videoPlayer.clip = introClip;
        videoPlayer.Prepare();

        while (!videoPlayer.isPrepared)
            yield return null;

        videoPlayer.Play();

        // Wait until finished or skipped
        while (videoPlayer.isPlaying && !videoSkipped)
            yield return null;

        LoadMainScene();
    }

    private void SkipVideo(string reason)
    {
        if (videoSkipped) return;

        Debug.Log("Video skipped: " + reason);
        videoSkipped = true;

        if (videoPlayer != null && videoPlayer.isPlaying)
            videoPlayer.Stop();

        LoadMainScene();
    }

    private void LoadMainScene()
    {
        SceneManager.LoadScene("Scene_Main");
    }
}
