using UnityEngine;

public class DevicePlugin
{
	//public static AndroidJavaClass androidplatform;

	public static void InitAndroidPlatform()
	{
		/*if (Application.platform == RuntimePlatform.Android)
		{
			androidplatform = new AndroidJavaClass("com.trinitigame.androidplatform.AndroidPlatformActivity");
		}*/
	}

	public static void AndroidQuit()
	{
		//androidplatform.CallStatic("AndroidQuit");
	}

	public static string GetDeviceModel()
	{
		return string.Empty;
	}

	public static string GetDeviceModelDetail()
	{
		//LogMgr.Log("GetAndroidVersion : " + androidplatform.CallStatic<string>("GetAndroidVersion", new object[0]));
		LogMgr.Log("GetAndroidVersion : " + SystemInfo.operatingSystem);
		//return androidplatform.CallStatic<string>("GetAndroidVersion", new object[0]);
		return SystemInfo.operatingSystem;
	}

	public static string GetUUID()
	{
		//LogMgr.Log("GetUUID : " + androidplatform.CallStatic<string>("GetUUID", new object[0]));
		LogMgr.Log("GetUUID : " + SystemInfo.deviceUniqueIdentifier);
		//return androidplatform.CallStatic<string>("GetUUID", new object[0]);
		return SystemInfo.deviceUniqueIdentifier;
	}

	public static string GetCountryCode()
	{
		//LogMgr.Log("GetCountry : " + androidplatform.CallStatic<string>("GetCountry", new object[0]));
		LogMgr.Log("GetCountry : ");
		//return androidplatform.CallStatic<string>("GetCountry", new object[0]);
		return string.Empty;
	}

	public static string GetLanguageCode()
	{
		LogMgr.Log("GetLanguageCode : " + Application.systemLanguage);
		return Application.systemLanguage.ToString();
	}

	public static string GetSysVersion()
	{
		//LogMgr.Log("GetAndroidVersion : " + androidplatform.CallStatic<string>("GetAndroidVersion", new object[0]));
		LogMgr.Log("GetAndroidVersion : " + SystemInfo.operatingSystem);
		//return androidplatform.CallStatic<string>("GetAndroidVersion", new object[0]);
		return SystemInfo.operatingSystem;
	}

	public static string GetAppVersion()
	{
		//LogMgr.Log("GetAndroidAPPVersion : " + androidplatform.CallStatic<string>("GetAndroidAPPVersion", new object[0]));
		LogMgr.Log("GetAndroidAPPVersion : " + Application.version);
		//return androidplatform.CallStatic<string>("GetAndroidAPPVersion", new object[0]);
		return Application.version;
	}

	/*public static string GetAppBundleId()
	{
		LogMgr.Log("GetPackgeName : " + androidplatform.CallStatic<string>("GetPackgeName", new object[0]));
		return androidplatform.CallStatic<string>("GetPackgeName", new object[0]);
	}*/
}
