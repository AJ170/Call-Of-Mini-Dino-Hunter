using UnityEngine;

public class LogMgr
{
	public const bool ShowLog = false;

	private static LogMgr sInstance;

	public static LogMgr Instance()
	{
		return sInstance;
	}

	public static void Log(object message)
	{
		Debug.Log(message);
	}

	public static void Log(object message, Object context)
	{
	}

	public static void LogError(object message)
    {
        Debug.LogError(message);
    }

	public static void LogError(object message, Object context)
	{
	}

	public static void LogWarning(object message)
	{
	}

	public static void LogWarning(object message, Object context)
	{
	}
}
