using EventCenter;
using UnityEngine;

public class Scene_Main : MonoBehaviour
{
	public TUIFade m_fade;

	private float m_fade_in_time;

	private float m_fade_out_time;

	private bool do_fade_in;

	private bool is_fade_out;

	private bool do_fade_out;

	private string next_scene = "Scene_MainMenu";

	private int next_scene_id;

	private bool is_enter_level_scene;

	private bool sfx_open_now = true;

	private bool music_open_now = true;

	public TUILabel label_text;

	public PopupIAP popup_warning;

	private bool connect_success;

	private ServerConnectFailType server_connect_fail;

	public GameObject prefab_popup_server;

	private PopupServer popup_server;

	public Transform tui_control;

	private void Awake()
	{
		TUIDataServer.Instance().Initialize();
		global::EventCenter.EventCenter.Instance.Register<TUIEvent.BackEvent_SceneMain>(TUIEvent_SetUIInfo);
	}

	private void Start()
	{
		global::EventCenter.EventCenter.Instance.Publish(this, new TUIEvent.SendEvent_SceneMain(TUIEvent.SceneMainEventType.TUIEvent_EnterInfo));
		if (music_open_now)
		{
			CUISound.GetInstance().Play("BGM_theme");
		}
	}

	private void Update()
	{
		if (m_fade == null)
		{
			Debug.Log("error!no found m_fade!");
		}
		m_fade_in_time += Time.deltaTime;
		if (m_fade_in_time >= m_fade.fadeInTime && !do_fade_in)
		{
			do_fade_in = true;
		}
		if (!is_fade_out)
		{
			return;
		}
		m_fade_out_time += Time.deltaTime;
		if (!(m_fade_out_time >= m_fade.fadeOutTime) || do_fade_out)
		{
			return;
		}
		do_fade_out = true;
		m_fade.SetFadeOutEnd();
		if (is_enter_level_scene)
		{
			CUISound.GetInstance().Stop("BGM_theme");
		}
		if (is_enter_level_scene)
		{
			TUIMappingInfo.SwitchSceneInt switchSceneInt = TUIMappingInfo.Instance().GetSwitchSceneInt();
			if (switchSceneInt != null)
			{
				switchSceneInt(next_scene_id);
			}
		}
		else
		{
			TUIMappingInfo.SwitchSceneStr switchSceneStr = TUIMappingInfo.Instance().GetSwitchSceneStr();
			if (switchSceneStr != null)
			{
				switchSceneStr(next_scene);
			}
		}
	}

	private void OnDestroy()
	{
		global::EventCenter.EventCenter.Instance.Unregister<TUIEvent.BackEvent_SceneMain>(TUIEvent_SetUIInfo);
	}

	public void TUIEvent_SetUIInfo(object sender, TUIEvent.BackEvent_SceneMain m_event)
	{
		if (m_event.GetEventName() == TUIEvent.SceneMainEventType.TUIEvent_EnterInfo)
		{
			return;
		}
		if (m_event.GetEventName() == TUIEvent.SceneMainEventType.TUIEvent_EnterLevel)
		{
			is_enter_level_scene = m_event.GetControlSuccess();
			if (m_event.GetControlSuccess())
			{
				int wparam = m_event.GetWparam();
				next_scene_id = wparam;
				if (!is_fade_out)
				{
					is_fade_out = true;
					m_fade.FadeOut();
				}
				return;
			}
			int wparam2 = m_event.GetWparam();
			string sceneName = TUIMappingInfo.Instance().GetSceneName(wparam2);
			if (sceneName != string.Empty)
			{
				next_scene = sceneName;
			}
			else
			{
				next_scene = "Scene_MainMenu";
			}
			if (!is_fade_out)
			{
				is_fade_out = true;
				m_fade.FadeOut();
			}
		}
		else if (m_event.GetEventName() == TUIEvent.SceneMainEventType.TUIEvent_ConnectResult)
		{
			if (m_event.GetControlSuccess())
			{
				connect_success = true;
				return;
			}
			connect_success = false;
			server_connect_fail = (ServerConnectFailType)m_event.GetWparam();
			string str = m_event.GetStr();
			if (str != null && str.Length > 0)
			{
				if (popup_warning != null)
				{
					popup_warning.ShowPopupYes(str);
				}
			}
			else if (server_connect_fail == ServerConnectFailType.NeedNet)
			{
				if (popup_warning != null)
				{
					popup_warning.ShowPopupYes("Unable to connect to the server! Please try again later.");
				}
			}
			else if (server_connect_fail == ServerConnectFailType.NeedUpdate)
			{
				if (popup_warning != null)
				{
					popup_warning.ShowPopupYes("A new update is available! Please download to continue playing.");
				}
			}
			else if (server_connect_fail == ServerConnectFailType.FetchFailed)
			{
				if (popup_warning != null)
				{
					popup_warning.ShowPopupYes("Disconnected! Reconnect now?");
				}
			}
			else if (server_connect_fail == ServerConnectFailType.GMUsing)
			{
				if (popup_warning != null)
				{
					popup_warning.ShowPopupYes("Your account is under maintenance. Please try again later.");
				}
			}
			else if (server_connect_fail == ServerConnectFailType.ServerMaintain)
			{
				if (popup_warning != null)
				{
					popup_warning.ShowPopupYes("Our server is down for maintenance. Please retry later!");
				}
			}
			else
			{
				Debug.Log("error!");
			}
			AndroidReturnPlugin.instance.SetCurFunc(TUIEvent_CloseWarnning);
		}
		else if (m_event.GetEventName() == TUIEvent.SceneMainEventType.TUIEvent_HidePopupWarnning)
		{
			if (popup_warning != null)
			{
				popup_warning.Hide();
			}
			AndroidReturnPlugin.instance.ClearFunc(TUIEvent_CloseWarnning);
		}
		else if (m_event.GetEventName() == TUIEvent.SceneMainEventType.TUIEvent_ShowPopupServer)
		{
			if (popup_server != null)
			{
				popup_server.DoDestroy();
				popup_server = null;
			}
			if (prefab_popup_server != null && tui_control != null)
			{
				GameObject gameObject = (GameObject)Object.Instantiate(prefab_popup_server);
				gameObject.transform.parent = tui_control;
				gameObject.transform.localPosition = new Vector3(0f, 0f, gameObject.transform.localPosition.z);
				popup_server = gameObject.GetComponent<PopupServer>();
				if (popup_server != null)
				{
					popup_server.DoCreate(m_event.GetStr(), base.gameObject, base.name, "TUIEvent_PopupServerOK", "TUIEvent_PopupServerCancle");
				}
			}
		}
		else if (m_event.GetEventName() == TUIEvent.SceneMainEventType.TUIEvent_HidePopupServer)
		{
			if (popup_server != null)
			{
				popup_server.DoDestroy();
				popup_server = null;
			}
		}
		else if (m_event.GetEventName() == TUIEvent.SceneMainEventType.TUIEvent_ChangeText)
		{
			string str2 = m_event.GetStr();
			if (label_text != null)
			{
				label_text.Text = str2;
			}
		}
	}

	public void TUIEvent_Enter(TUIControl control, int event_type, float wparam, float lparam, object data)
	{
		if (event_type == 3 && connect_success)
		{
			if (sfx_open_now)
			{
				CUISound.GetInstance().Play("UI_Entergame");
			}
			global::EventCenter.EventCenter.Instance.Publish(this, new TUIEvent.SendEvent_SceneMain(TUIEvent.SceneMainEventType.TUIEvent_EnterLevel));
		}
	}

	public void TUIEvent_CloseWarnning(TUIControl control, int event_type, float wparam, float lparam, object data)
	{
		if (event_type == 3)
		{
			if (sfx_open_now)
			{
				CUISound.GetInstance().Play("UI_Button");
			}
			if (popup_warning != null)
			{
				popup_warning.Hide();
			}
			AndroidReturnPlugin.instance.ClearFunc(TUIEvent_CloseWarnning);
			if (server_connect_fail == ServerConnectFailType.NeedNet)
			{
				global::EventCenter.EventCenter.Instance.Publish(this, new TUIEvent.SendEvent_SceneMain(TUIEvent.SceneMainEventType.TUIEvent_ConnectAgain));
			}
			else if (server_connect_fail == ServerConnectFailType.NeedUpdate)
			{
				global::EventCenter.EventCenter.Instance.Publish(this, new TUIEvent.SendEvent_SceneMain(TUIEvent.SceneMainEventType.TUIEvent_GotoUpdate));
			}
			else if (server_connect_fail == ServerConnectFailType.FetchFailed)
			{
				global::EventCenter.EventCenter.Instance.Publish(this, new TUIEvent.SendEvent_SceneMain(TUIEvent.SceneMainEventType.TUIEvent_FetchFailed));
			}
			else if (server_connect_fail == ServerConnectFailType.GMUsing)
			{
				global::EventCenter.EventCenter.Instance.Publish(this, new TUIEvent.SendEvent_SceneMain(TUIEvent.SceneMainEventType.TUIEvent_GMUsing));
			}
			else if (server_connect_fail == ServerConnectFailType.ServerMaintain)
			{
				global::EventCenter.EventCenter.Instance.Publish(this, new TUIEvent.SendEvent_SceneMain(TUIEvent.SceneMainEventType.TUIEvent_ServerMaintain));
			}
			else
			{
				Debug.Log("error!");
			}
		}
	}

	public void TUIEvent_PopupServerOK(TUIControl control, int event_type, float wparam, float lparam, object data)
	{
		if (event_type == 3)
		{
			if (sfx_open_now)
			{
				CUISound.GetInstance().Play("UI_Button");
			}
			global::EventCenter.EventCenter.Instance.Publish(this, new TUIEvent.SendEvent_SceneMain(TUIEvent.SceneMainEventType.TUIEvent_PopupServerOK));
		}
	}

	public void TUIEvent_PopupServerCancle(TUIControl control, int event_type, float wparam, float lparam, object data)
	{
		if (event_type == 3)
		{
			if (sfx_open_now)
			{
				CUISound.GetInstance().Play("UI_Cancle");
			}
			global::EventCenter.EventCenter.Instance.Publish(this, new TUIEvent.SendEvent_SceneMain(TUIEvent.SceneMainEventType.TUIEvent_PopupServerCancle));
		}
	}
}
