using System.Collections.Generic;
using System.Collections;
using UnityEngine;
using UnityEngine.Networking;
using System;
using System.Text;
using System.Text.RegularExpressions;

public class ServerX : MonoBehaviour
{
    public enum ServerCheckState
    {
        Valid, Invalid, Unreachable
    }

    public static ServerCheckState state;

    public static ServerX instance { get; private set; }

    public const string GameLink = "https://recompilation.net/Triniti/DinoHunter.html";

    public const string SaveEncryptionKey = "ExampleKey";
    public const string ServerEncryptionKey = "ExampleKey";

    public const string version = "0.1";
#if UNITY_STANDALONE
    public const string verUrl = "https://example.com/DinoHunter-version-win.txt";
#else
    public const string verUrl = "https://example.com/DinoHunter-version.txt";
#endif

    public const string timeUrl = "https://example.com/api/misc/getTimeMs";

#if UNITY_EDITOR
    public const string tnetConfigUrl = "https://example.net/config-1.txt";
    public const string apiUrl = "https://example.net/api/DinoHunter/";
#else
	public const string tnetConfigUrl = "https://example.com/config-1.txt";
	public const string apiUrl = "https://example.com/api/DinoHunter/";
#endif

    const string gameId = "dinohunter";

	[RuntimeInitializeOnLoadMethod]
	static void OnGameStart()
    {
#if !UNITY_STANDALONE
		Application.targetFrameRate = 120;
#endif

        DontDestroyOnLoad(new GameObject("[ServerX]", typeof(ServerX)));
	}

	void Awake()
	{
		instance = this;
	}
    // Example:
    // dinohunter 127.0.0.1 9999
    // dinohunter 127.0.0.1 10000
    public static bool Parse(string text, ref string ip, ref int port)
	{
		int portParse;

		string[] entries = text.Split('\n');

		foreach (string entry in entries)
		{
			string[] entriesItem = entry.Split(' ');

			if (entriesItem.Length < 3) continue;

			if (entriesItem[0] != gameId) continue;

			if (!int.TryParse(entriesItem[2], out portParse)) continue;

			ip = entriesItem[1];
			port = portParse;

			return true;
		}

		return false;
	}

	public static List<KeyValuePair<string, int>> Parse(string text)
	{
		List<KeyValuePair<string, int>> pairs = new List<KeyValuePair<string, int>>();

		string[] entries = text.Split('\n');

		foreach (string entry in entries)
		{
			string[] entriesItem = entry.Split(' ');

			if (entriesItem.Length < 3) continue;

			if (entriesItem[0] != gameId) continue;

			int portParse;

			if (!int.TryParse(entriesItem[2], out portParse)) continue;

			pairs.Add(new KeyValuePair<string, int>(entriesItem[1], portParse));
		}

		return pairs;
	}

	// DH Specific
	public void SendRequest(string sServerUrl, float fTimeOut, string sKey, string sAction, string sData, iServerHttp.OnSuccess onsuccess = null, iServerHttp.OnFailed onfailed = null)
	{
		Debug.Log(sAction);

		StartCoroutine(SendRequestEnumerator(sAction, sData, onsuccess, onfailed));
	}

	IEnumerator SendRequestEnumerator(string action, string data, iServerHttp.OnSuccess onsuccess, iServerHttp.OnFailed onfailed)
	{
        using (var request = new UnityWebRequest(apiUrl + action, "POST"))
		{
			request.uploadHandler = new UploadHandlerRaw(Encoding.UTF8.GetBytes(XXTEAUtils.Encrypt(data, ServerEncryptionKey)));
            request.downloadHandler = new DownloadHandlerBuffer();
            request.SetRequestHeader("Content-Type", "text/plain");

            yield return request.SendWebRequest();

			if (request.isNetworkError || request.isHttpError)
			{
				Debug.LogError("HTTP ERROR CODE: " + request.responseCode);
				Debug.LogError("HTTP ERROR: " + request.error);
				if (onfailed != null) onfailed((int)request.responseCode);
				yield break;
			}

            string result = request.downloadHandler.text;

			if (!string.IsNullOrEmpty(result))
                result = Regex.Unescape(XXTEAUtils.Decrypt(result, ServerEncryptionKey));

            if (onsuccess != null) onsuccess(result);
		}
	}

	public static IEnumerator GetServerTime()
	{
		double serverTime;

        using (var request = UnityWebRequest.Get(timeUrl))
		{
			yield return request.SendWebRequest();

			if (request.isHttpError || request.isNetworkError || 
				!double.TryParse(request.downloadHandler.text, out serverTime))
			{
				serverTime = (DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
			}
        }

        iLoginManager.GetInstance().OnGetServerTime_S(serverTime);
    }

    public static IEnumerator CheckVersion()
	{
        using (var request = UnityWebRequest.Get(verUrl))
        {
            yield return request.SendWebRequest();

            if (request.isHttpError || request.isNetworkError)
			{
				state = ServerCheckState.Unreachable;
				yield break;
			}

			string ver = request.downloadHandler.text.Trim();

            if (ver != version)
			{
				state = ServerCheckState.Invalid;
				Debug.Log("Version Mismatch: '" + ver + "' Local: '" + version + "'");
				yield break;
            }	

			state = ServerCheckState.Valid;
        }
    }
}
/*
using System.Collections.Generic;
using System.Collections;
using UnityEngine;
using UnityEngine.Networking;
using System;
using System.Text;

public class ServerX : MonoBehaviour
{
	public enum ServerCheckState
	{
		Valid, Invalid, Unreachable
	}

	public static ServerCheckState state;

	public static ServerX instance { get; private set; }

	public const string GameLink = "https://recompilation.net/Triniti/DinoHunter.html";

    public const string SaveEncryptionKey = "ExampleKey";
	public const string ServerEncryptionKey = "ExampleKey";

    public const string version = "0.1";
#if UNITY_STANDALONE
    public const string verUrl = "https://example.com/DinoHunter-version-win.txt";
#else
    public const string verUrl = "https://example.com/DinoHunter-version.txt";
#endif

    public const string timeUrl = "https://example.com/api/misc/getTimeMs";

#if UNITY_EDITOR
	public const string tnetConfigUrl = "https://example.net/config-1.txt";
	public const string apiUrl = "https://example.net/api/DinoHunter/";
#else
	public const string tnetConfigUrl = "https://example.com/config-1.txt";
	public const string apiUrl = "https://example.com/api/DinoHunter/";
#endif

    const string gameId = "dinohunter";

	[RuntimeInitializeOnLoadMethod]
	static void OnGameStart()
	{
		DontDestroyOnLoad(new GameObject("[ServerX]", typeof(ServerX)));
	}

	void Awake()
	{
		instance = this;
	}
	// Example:
	// dinohunter 127.0.0.1 9999
	// dinohunter 127.0.0.1 10000
	public static bool Parse(string text, ref string ip, ref int port)
	{
		int portParse;

		string[] entries = text.Split('\n');

		foreach (string entry in entries)
		{
			string[] entriesItem = entry.Split(' ');

			if (entriesItem.Length < 3) continue;

			if (entriesItem[0] != gameId) continue;

			if (!int.TryParse(entriesItem[2], out portParse)) continue;

			ip = entriesItem[1];
			port = portParse;

			return true;
		}

		return false;
	}

	public static List<KeyValuePair<string, int>> Parse(string text)
	{
		List<KeyValuePair<string, int>> pairs = new List<KeyValuePair<string, int>>();

		string[] entries = text.Split('\n');

		foreach (string entry in entries)
		{
			string[] entriesItem = entry.Split(' ');

			if (entriesItem.Length < 3) continue;

			if (entriesItem[0] != gameId) continue;

			int portParse;

			if (!int.TryParse(entriesItem[2], out portParse)) continue;

			pairs.Add(new KeyValuePair<string, int>(entriesItem[1], portParse));
		}

		return pairs;
	}

	// DH Specific
	public void SendRequest(string sServerUrl, float fTimeOut, string sKey, string sAction, string sData, iServerHttp.OnSuccess onsuccess = null, iServerHttp.OnFailed onfailed = null)
	{
		Debug.LogError(sAction);

		StartCoroutine(SendRequestEnumerator(sAction, sData, onsuccess, onfailed));
	}

	IEnumerator SendRequestEnumerator(string action, string data, iServerHttp.OnSuccess onsuccess, iServerHttp.OnFailed onfailed)
	{
        using (var request = new UnityWebRequest(apiUrl + action, "POST"))
		{
			request.uploadHandler = new UploadHandlerRaw(Encoding.UTF8.GetBytes(XXTEAUtils.Encrypt(data, ServerEncryptionKey)));
            request.downloadHandler = new DownloadHandlerBuffer();
            request.SetRequestHeader("Content-Type", "text/plain");

            yield return request.SendWebRequest();

			if (request.isNetworkError || request.isHttpError)
			{
				Debug.LogError("HTTP ERROR CODE: " + request.responseCode);
				Debug.LogError("HTTP ERROR: " + request.error);
				if (onfailed != null) onfailed((int)request.responseCode);
				yield break;
			}

            string result = request.downloadHandler.text;

			if (!string.IsNullOrEmpty(result))
                result = Regex.Unescape(XXTEAUtils.Decrypt(result, ServerEncryptionKey));

			if (onsuccess != null) onsuccess(result);
		}
	}

public static IEnumerator GetServerTime()
{
    double serverTime;

    using (var request = UnityWebRequest.Get(timeUrl))
    {
        yield return request.SendWebRequest();

        if (request.isHttpError || request.isNetworkError ||
            !double.TryParse(request.downloadHandler.text, out serverTime))
        {
            serverTime = (DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;
        }
    }

    iLoginManager.GetInstance().OnGetServerTime_S(serverTime);
}

public static IEnumerator CheckVersion()
{
    using (var request = UnityWebRequest.Get(verUrl))
    {
        yield return request.SendWebRequest();

        if (request.isHttpError || request.isNetworkError)
        {
            state = ServerCheckState.Unreachable;
            yield break;
        }

        string ver = request.downloadHandler.text.Trim();

        if (ver != version)
        {
            state = ServerCheckState.Invalid;
            Debug.Log("Version Mismatch: '" + ver + "' Local: '" + version + "'");
            yield break;
        }

        state = ServerCheckState.Valid;
    }
}
}
*/