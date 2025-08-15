/*using System.Collections;
using Boomlagoon.JSON;
using UnityEngine;

public class TrinitiAdAndroidPlugin : MonoBehaviour
{
	private static TrinitiAdAndroidPlugin sInstance;

	private bool isready;

	private bool admob;

	private bool chartboost;

	private bool openclik;

	private string id = string.Empty;

	private string key = string.Empty;

	public static TrinitiAdAndroidPlugin Instance()
	{
		return sInstance;
	}

	public bool IsReady()
	{
		return isready;
	}

	public bool CanAdmob()
	{
		return admob;
	}

	public bool CanChartboost()
	{
		return chartboost;
	}

	public bool CanOpenclik()
	{
		return openclik;
	}

	public string GetID()
	{
		return id;
	}

	public string GetKey()
	{
		return key;
	}

	private void Start()
	{
		sInstance = this;
		StartCoroutine(init());
	}

	public void InitAdd()
	{
		Debug.Log("-----------------------InitAdd----------------------------------");
		Debug.Log(Instance().IsReady());
		if (Instance().IsReady())
		{
			if (Instance().CanAdmob())
			{
				LogMgr.Log("admob " + Instance().GetKey());
				OpenClikPlugin.Initialize(Instance().GetKey());
			}
			else if (Instance().CanChartboost())
			{
				LogMgr.Log("chartboost id:" + Instance().GetID() + " key:" + Instance().GetKey());
				ChartBoostAndroid.init(Instance().GetID(), Instance().GetKey());
				ChartBoostAndroid.onStart();
			}
			else if (Instance().CanOpenclik())
			{
				LogMgr.Log("openclik key:" + Instance().GetKey());
			}
		}
	}

	private IEnumerator init()
	{
		string url = "http://184.168.67.133/trinitiadconfig_android.txt";
		WWW www = new WWW(url);
		yield return www;
		LogMgr.Log(www.text);
		JSONObject jsonData = JSONObject.Parse(www.text);
		try
		{
			JSONObject data = jsonData.GetObject("CoMDH");
			switch (data.GetString("type"))
			{
			case "admob":
				LogMgr.Log("TrinitiAdAndroidPlugin admob");
				admob = true;
				id = string.Empty;
				key = data.GetString("admobkey");
				break;
			case "chartboost":
				LogMgr.Log("TrinitiAdAndroidPlugin chartboost");
				chartboost = true;
				id = data.GetString("chartboostid");
				key = data.GetString("chartboostkey");
				break;
			case "openclik":
				LogMgr.Log("TrinitiAdAndroidPlugin openclik");
				openclik = true;
				id = string.Empty;
				key = data.GetString("openclikkey");
				break;
			}
		}
		catch
		{
		}
		isready = true;
		LogMgr.Log("TrinitiAdAndroidPlugin isready:" + isready);
		InitAdd();
	}
}
*/