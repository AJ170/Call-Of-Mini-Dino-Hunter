using System.Collections.Generic;

public class TUIEvent
{
	public enum SceneMainEventType
	{
		None = 0,
		TUIEvent_OptionInfo = 1,
		TUIEvent_EnterInfo = 2,
		TUIEvent_EnterLevel = 3,
		TUIEvent_ConnectResult = 4,
		TUIEvent_HidePopupWarnning = 5,
		TUIEvent_ShowPopupServer = 6,
		TUIEvent_HidePopupServer = 7,
		TUIEvent_ChangeText = 8,
		TUIEvent_ConnectAgain = 9,
		TUIEvent_GotoUpdate = 10,
		TUIEvent_FetchFailed = 11,
		TUIEvent_PopupServerOK = 12,
		TUIEvent_PopupServerCancle = 13,
		TUIEvent_ClickFullVersion = 14,
		TUIEvent_GMUsing = 15,
		TUIEvent_ServerMaintain = 16,
		TUIEvent_UnkownError = 17
	}

	public enum SceneMainMenuEventType
	{
		None = 0,
		TUIEvent_TopBar = 1,
		TUIEvent_OptionInfo = 2,
		TUIEvent_AcheviementInfo = 3,
		TUIEvent_SaleInfo = 4,
		TUIEvent_EnterInfo = 5,
		TUIEvent_TakeAchievement = 6,
		TUIEvent_ChangeMusic = 7,
		TUIEvent_ChangeSFX = 8,
		TUIEvent_Forum = 9,
		TUIEvent_EnterIAP = 10,
		TUIEvent_EnterGold = 11,
		TUIEvent_EnterEquip = 12,
		TUIEvent_EnterForge = 13,
		TUIEvent_EnterTavern = 14,
		TUIEvent_EnterSkill = 15,
		TUIEvent_EnterStash = 16,
		TUIEvent_EnterMap = 17,
		TUIEvent_ShowReview = 18,
		TUIEvent_HadAchievementReward = 19,
		TUIEvent_ShowSale = 20,
		TUIEvent_EnterSale = 21,
		TUIEvent_DailyLoginBonusInfo = 22,
		TUIEvent_ShowDailyLoginBonus = 23,
		TUIEvent_ClickDailyLoginBonus = 24,
		TUIEvent_DailyMissionsInfo = 25,
		TUIEvent_TakeDailyMissionsReward = 26,
		TUIEvent_HadDailyMissionsReward = 27,
		TUIEvent_ShowUnlockItem = 28,
		TUIEvent_OpenSupportURL = 29,
		TUIEvent_OpenReviewURL = 30,
		TUIEvent_CloseReviewURL = 31,
		TUIEvent_CloseSale = 32,
		TUIEvent_ShowUDID = 33,
		TUIEvent_SkipTutorial = 34,
		TUIEvent_EnterCoop = 35,
		TUIEvent_EnterBlackMarket = 36
	}

	public enum SceneEquipEventType
	{
		None = 0,
		TUIEvent_TopBar = 1,
		TUIEvent_OptionInfo = 2,
		TUIEvent_RoleSign = 3,
		TUIEvent_SkillSign = 4,
		TUIEvent_PropSign = 5,
		TUIEvent_WeaponSign = 6,
		TUIEvent_RoleEquip = 7,
		TUIEvent_SkillEquip = 8,
		TUIEvent_SkillUnEquip = 9,
		TUIEvent_SkillExchange = 10,
		TUIEvent_WeaponEquip = 11,
		TUIEvent_WeaponUnEquip = 12,
		TUIEvent_WeaponExchange = 13,
		TUIEvent_Back = 14,
		TUIEvent_RolesChoose = 15,
		TUIEvent_WeaponChoose = 16,
		TUIEvent_SkillChoose = 17,
		TUIEvent_EnterIAP = 18,
		TUIEvent_EnterGold = 19,
		TUIEvent_EnterGoBuyWeapon = 20,
		TUIEvent_EnterGoBuyWeaponInBlack = 21,
		TUIEvent_EnterGoBuySkill = 22,
		TUIEvent_RoleNewMarkInfo = 23,
		TUIEvent_SkillNewMarkInfo = 24,
		TUIEvent_WeaponNewMarkInfo = 25,
		TUIEvent_SkipTutorial = 26,
		TUIEvent_SetBattlePower = 27
	}

	public enum SceneStashEventType
	{
		None = 0,
		TUIEvent_TopBar = 1,
		TUIEvent_OptionInfo = 2,
		TUIEvent_StashInfo = 3,
		TUIEvent_AddCapacity = 4,
		TUIEvent_SellGoods = 5,
		TUIEvent_Back = 6,
		TUIEvent_SearchGoodsDrop = 7,
		TUIEvent_GoldToCrystal = 8,
		TUIEvent_EnterIAP = 9,
		TUIEvent_EnterGold = 10,
		TUIEvent_EnterIAPCrystalNoEnough = 11
	}

	public enum SceneSkillEventType
	{
		None = 0,
		TUIEvent_TopBar = 1,
		TUIEvent_OptionInfo = 2,
		TUIEvent_SkillInfo = 3,
		TUIEvent_SkillUnlcok = 4,
		TUIEvent_SkillBuy = 5,
		TUIEvent_SkillUpdate = 6,
		TUIEvent_Back = 7,
		TUIEvent_SkillChoose = 8,
		TUIEvent_GoldToCrystal = 9,
		TUIEvent_EnterIAP = 10,
		TUIEvent_EnterGold = 11,
		TUIEvent_EnterIAPCrystalNoEnough = 12,
		TUIEvent_EnterGoEquip = 13,
		TUIEvent_NewMarkInfo = 14,
		TUIEvent_SkipTutorial = 15
	}

	public enum SceneForgeEventType
	{
		None = 0,
		TUIEvent_TopBar = 1,
		TUIEvent_OptionInfo = 2,
		TUIEvent_WeaponInfo = 3,
		TUIEvent_WeaponGoodsBuy = 4,
		TUIEvent_Back = 5,
		TUIEvent_SearchGoodsDrop = 6,
		TUIEvent_WeaponChoose = 7,
		TUIEvent_ClickUpgrade = 8,
		TUIEvent_GetActiveWeapon = 9,
		TUIEvent_ShowSupplement = 10,
		TUIEvent_ClickSupplement = 11,
		TUIEvent_GoldToCrystal = 12,
		TUIEvent_EnterIAP = 13,
		TUIEvent_EnterGold = 14,
		TUIEvent_EnterIAPCrystalNoEnough = 15,
		TUIEvent_EnterGoEquip = 16,
		TUIEvent_NewMarkInfo = 17,
		TUIEvent_SkipTutorial = 18
	}

	public enum SceneTavernEventType
	{
		None = 0,
		TUIEvent_TopBar = 1,
		TUIEvent_OptionInfo = 2,
		TUIEvent_AllRoleInfo = 3,
		TUIEvent_RoleUnlock = 4,
		TUIEvent_RoleBuy = 5,
		TUIEvent_RoleChange = 6,
		TUIEvent_Back = 7,
		TUIEvent_RolesChoose = 8,
		TUIEvent_GoldToCrystal = 9,
		TUIEvent_EnterIAP = 10,
		TUIEvent_EnterGold = 11,
		TUIEvent_EnterIAPCrystalNoEnough = 12,
		TUIEvent_EnterGoEquip = 13,
		TUIEvent_NewMarkInfo = 14,
		TUIEvent_GetActiveRole = 15
	}

	public enum SceneMapEventType
	{
		None = 0,
		TUIEvent_TopBar = 1,
		TUIEvent_OptionInfo = 2,
		TUIEvent_MapEnterInfo = 3,
		TUIEvent_LevelInfo = 4,
		TUIEvent_EnterLevel = 5,
		TUIEvent_Back = 6,
		TUIEvent_EnterRoleBuy = 7,
		TUIEvent_EnterWeaponBuy = 8,
		TUIEvent_EnterEquip = 9,
		TUIEvent_EnterIAP = 10,
		TUIEvent_EnterGold = 11,
		TUIEvent_EnterVilliage = 12,
		TUIEvent_ClickPopularize = 13,
		TUIEvent_SkipTutorial = 14,
		TUIEvent_EnterCoop = 15
	}

	public enum SceneIAPEventType
	{
		None = 0,
		TUIEvent_TopBar = 1,
		TUIEvent_OptionInfo = 2,
		TUIEvent_IAPBuy = 3,
		TUIEvent_Back = 4,
		TUIEvent_EnterGold = 5,
		TUIEvent_IAPResult = 6,
		TUIEvent_ServerResult = 7,
		TUIEvent_IAPEnterInfo = 8,
		TUIEvent_TapJoy = 9
	}

	public enum SceneGoldEventType
	{
		None = 0,
		TUIEvent_OptionInfo = 1,
		TUIEvent_TopBar = 2,
		TUIEvent_GoldBuy = 3,
		TUIEvent_Back = 4,
		TUIEvent_EnterIAP = 5,
		TUIEvent_EnterIAPCrystalNoEnough = 6,
		TUIEvent_GoldResult = 7
	}

	public enum SceneCoopInputNameEventType
	{
		None = 0,
		TUIEvent_TopBar = 1,
		TUIEvent_HelpClick = 2,
		TUIEvent_InputName = 3,
		TUIEvent_Continue = 4,
		TUIEvent_Back = 5
	}

	public enum SceneCoopMainMenuEventType
	{
		None = 0,
		TUIEvent_TopBar = 1,
		TUIEvent_EnterInfo = 2,
		TUIEvent_Equip = 3,
		TUIEvent_Start = 4,
		TUIEvent_Friends = 5,
		TUIEvent_AddFriends = 6,
		TUIEvent_TitleList = 7,
		TUIEvent_AllRanking = 8,
		TUIEvent_FriendsRanking = 9,
		TUIEvent_AddAllRanking = 10,
		TUIEvent_AddFriendsRanking = 11,
		TUIEvent_InfoCard = 12,
		TUIEvent_Back = 13,
		TUIEvent_UpdatePlayerTexture = 14,
		TUIEvent_TitleChange = 15,
		TUIEvent_ShowUnlockItem = 16,
		TUIEvent_StatusChange = 17,
		TUIEvent_ShowLoading = 18,
		TUIEvent_EnterIAP = 19,
		TUIEvent_EnterGold = 20
	}

	public enum SceneCoopRoomEventType
	{
		None = 0,
		TUIEvent_TopBar = 1,
		TUIEvent_EnterInfo = 2,
		TUIEvent_IamEnter = 3,
		TUIEvent_PlayerEnter = 4,
		TUIEvent_PlayerExit = 5,
		TUIEvent_GameStartBtn = 6,
		TUIEvent_GameStartYes = 7,
		TUIEvent_GameStartCancel = 8,
		TUIEvent_GameStart = 9,
		TUIEvent_Back = 10,
		TUIEvent_ShowBtnStart = 11,
		TUIEvent_ShowStartWarning = 12,
		TUIEvent_LastRoleSpeedOver = 13
	}

	public enum SceneBlackMarketEventType
	{
		None = 0,
		TUIEvent_TopBar = 1,
		TUIEvent_Back = 2,
		TUIEvent_EnterIAP = 3,
		TUIEvent_EnterGold = 4,
		TUIEvent_GoodsInfo = 5,
		TUIEvent_ClickBtnBuy = 6,
		TUIEvent_EnterIAPCrystalNoEnough = 7,
		TUIEvent_GoldToCrystal = 8,
		TUIEvent_EnterGoEquip = 9
	}

	public class SendEvent_SceneMain
	{
		private SceneMainEventType name;

		private int wparam;

		private int lparam;

		public SendEvent_SceneMain(SceneMainEventType m_name, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneMainEventType GetEventName()
		{
			return name;
		}

		public int GetWParam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}
	}

	public class BackEvent_SceneMain
	{
		private SceneMainEventType name;

		private TUIGameInfo info;

		private bool control_success;

		private int wparam;

		private int lparam;

		private string str = string.Empty;

		public BackEvent_SceneMain(SceneMainEventType m_name, bool m_success, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			info = null;
			control_success = m_success;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public BackEvent_SceneMain(SceneMainEventType m_name, bool m_success, int m_wparam, string m_str)
		{
			name = m_name;
			info = null;
			control_success = m_success;
			wparam = m_wparam;
			str = m_str;
		}

		public BackEvent_SceneMain(SceneMainEventType m_name, bool m_success, TUIGameInfo m_info)
		{
			name = m_name;
			info = m_info;
			control_success = m_success;
		}

		public BackEvent_SceneMain(SceneMainEventType m_name)
		{
			name = m_name;
		}

		public BackEvent_SceneMain(SceneMainEventType m_name, string m_str)
		{
			name = m_name;
			str = m_str;
		}

		public BackEvent_SceneMain(SceneMainEventType m_name, TUIGameInfo m_info)
		{
			name = m_name;
			info = m_info;
		}

		public SceneMainEventType GetEventName()
		{
			return name;
		}

		public TUIGameInfo GetEventInfo()
		{
			return info;
		}

		public bool GetControlSuccess()
		{
			return control_success;
		}

		public int GetWparam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}

		public string GetStr()
		{
			return str;
		}
	}

	public class SendEvent_SceneMainMenu
	{
		private SceneMainMenuEventType name;

		private int wparam;

		private int lparam;

		public SendEvent_SceneMainMenu(SceneMainMenuEventType m_name, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneMainMenuEventType GetEventName()
		{
			return name;
		}

		public int GetWParam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}
	}

	public class BackEvent_SceneMainMenu
	{
		private SceneMainMenuEventType name;

		private TUIGameInfo info;

		private int wparam;

		private int lparam;

		private bool control_success;

		private string str = string.Empty;

		public BackEvent_SceneMainMenu(SceneMainMenuEventType m_name, TUIGameInfo m_info, bool m_success = false)
		{
			name = m_name;
			info = m_info;
			control_success = m_success;
		}

		public BackEvent_SceneMainMenu(SceneMainMenuEventType m_name, bool m_success = false, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			info = null;
			control_success = m_success;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public BackEvent_SceneMainMenu(SceneMainMenuEventType m_name, string m_str)
		{
			name = m_name;
			str = m_str;
		}

		public SceneMainMenuEventType GetEventName()
		{
			return name;
		}

		public TUIGameInfo GetEventInfo()
		{
			return info;
		}

		public bool GetControlSuccess()
		{
			return control_success;
		}

		public int GetWparam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}

		public string GetStr()
		{
			return str;
		}
	}

	public class SendEvent_SceneEquip
	{
		private SceneEquipEventType name;

		private int wparam;

		private int lparam;

		protected PopupType m_EquipType;

		public SendEvent_SceneEquip(SceneEquipEventType m_name, int m_wparam = 0, int m_lparam = 0, PopupType nType = PopupType.None)
		{
			name = m_name;
			wparam = m_wparam;
			lparam = m_lparam;
			m_EquipType = nType;
		}

		public SceneEquipEventType GetEventName()
		{
			return name;
		}

		public int GetWParam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}

		public new PopupType GetType()
		{
			return m_EquipType;
		}
	}

	public class BackEvent_SceneEquip
	{
		private SceneEquipEventType name;

		private TUIGameInfo info;

		private int wparam;

		private int lparam;

		private bool control_success;

		public BackEvent_SceneEquip(SceneEquipEventType m_name, TUIGameInfo m_info, bool m_success = false)
		{
			name = m_name;
			info = m_info;
			control_success = m_success;
		}

		public BackEvent_SceneEquip(SceneEquipEventType m_name, bool m_success = false, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			info = null;
			control_success = m_success;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneEquipEventType GetEventName()
		{
			return name;
		}

		public TUIGameInfo GetEventInfo()
		{
			return info;
		}

		public bool GetControlSuccess()
		{
			return control_success;
		}

		public int GetWparam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}
	}

	public class SendEvent_SceneStash
	{
		private SceneStashEventType name;

		private int wparam;

		private int lparam;

		private int rparam;

		public SendEvent_SceneStash(SceneStashEventType m_name, int m_wparam = 0, int m_lparam = 0, int m_rparam = 0)
		{
			name = m_name;
			wparam = m_wparam;
			lparam = m_lparam;
			rparam = m_rparam;
		}

		public SceneStashEventType GetEventName()
		{
			return name;
		}

		public int GetWParam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}

		public int GetRparam()
		{
			return rparam;
		}
	}

	public class BackEvent_SceneStash
	{
		private SceneStashEventType name;

		private TUIGameInfo info;

		private int wparam;

		private int lparam;

		private bool control_success;

		private BackEventFalseType false_type;

		public BackEvent_SceneStash(SceneStashEventType m_name, TUIGameInfo m_info, bool m_success = false)
		{
			name = m_name;
			info = m_info;
			control_success = m_success;
		}

		public BackEvent_SceneStash(SceneStashEventType m_name, bool m_success = false, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			info = null;
			control_success = m_success;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public BackEvent_SceneStash(SceneStashEventType m_name, bool m_success, BackEventFalseType m_false_type, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			control_success = m_success;
			false_type = m_false_type;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneStashEventType GetEventName()
		{
			return name;
		}

		public TUIGameInfo GetEventInfo()
		{
			return info;
		}

		public bool GetControlSuccess()
		{
			return control_success;
		}

		public int GetWparam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}

		public BackEventFalseType GetFalseType()
		{
			return false_type;
		}
	}

	public class SendEvent_SceneSkill
	{
		private SceneSkillEventType name;

		private int wparam;

		private int lparam;

		public SendEvent_SceneSkill(SceneSkillEventType m_name, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneSkillEventType GetEventName()
		{
			return name;
		}

		public int GetWParam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}
	}

	public class BackEvent_SceneSkill
	{
		private SceneSkillEventType name;

		private TUIGameInfo info;

		private int wparam;

		private int lparam;

		private bool control_success;

		private BackEventFalseType false_type;

		public BackEvent_SceneSkill(SceneSkillEventType m_name, TUIGameInfo m_info, bool m_success = false)
		{
			name = m_name;
			info = m_info;
			control_success = m_success;
		}

		public BackEvent_SceneSkill(SceneSkillEventType m_name, bool m_success = false, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			info = null;
			control_success = m_success;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public BackEvent_SceneSkill(SceneSkillEventType m_name, bool m_success, BackEventFalseType m_false_type, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			control_success = m_success;
			false_type = m_false_type;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneSkillEventType GetEventName()
		{
			return name;
		}

		public TUIGameInfo GetEventInfo()
		{
			return info;
		}

		public bool GetControlSuccess()
		{
			return control_success;
		}

		public int GetWparam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}

		public BackEventFalseType GetFalseType()
		{
			return false_type;
		}
	}

	public class SendEvent_SceneForge
	{
		private SceneForgeEventType name;

		private int wparam;

		private int lparam;

		private int rparam;

		private TUISupplementInfo supplement_info;

		public SendEvent_SceneForge(SceneForgeEventType m_name, int m_wparam = 0, int m_lparam = 0, int m_rparam = 0)
		{
			name = m_name;
			wparam = m_wparam;
			lparam = m_lparam;
			rparam = m_rparam;
		}

		public SendEvent_SceneForge(SceneForgeEventType m_name, TUISupplementInfo m_supplement_info)
		{
			name = m_name;
			supplement_info = m_supplement_info;
		}

		public SceneForgeEventType GetEventName()
		{
			return name;
		}

		public int GetWParam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}

		public int GetRparam()
		{
			return rparam;
		}

		public TUISupplementInfo GetSupplementInfo()
		{
			return supplement_info;
		}
	}

	public class BackEvent_SceneForge
	{
		private SceneForgeEventType name;

		private TUIGameInfo info;

		private bool control_success;

		private int wparam;

		private int lparam;

		private TUISupplementInfo m_SupplementInfo;

		private BackEventFalseType false_type;

		protected Dictionary<int, NewMarkType> m_dictMarkData;

		public BackEvent_SceneForge(SceneForgeEventType m_name, TUIGameInfo m_info, bool m_success = false)
		{
			name = m_name;
			info = m_info;
			control_success = m_success;
			wparam = 0;
			lparam = 0;
		}

		public BackEvent_SceneForge(SceneForgeEventType m_name, bool m_success = false, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			info = null;
			control_success = m_success;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public BackEvent_SceneForge(SceneForgeEventType m_name, bool m_success, BackEventFalseType m_false_type, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			control_success = m_success;
			false_type = m_false_type;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public BackEvent_SceneForge(SceneForgeEventType m_name, TUISupplementInfo supplementinfo)
		{
			name = m_name;
			m_SupplementInfo = supplementinfo;
		}

		public BackEvent_SceneForge(SceneForgeEventType m_name, Dictionary<int, NewMarkType> dictMarkData)
		{
			name = m_name;
			m_dictMarkData = dictMarkData;
		}

		public SceneForgeEventType GetEventName()
		{
			return name;
		}

		public TUIGameInfo GetEventInfo()
		{
			return info;
		}

		public bool GetControlSuccess()
		{
			return control_success;
		}

		public int GetWparam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}

		public TUISupplementInfo GetSupplementInfo()
		{
			return m_SupplementInfo;
		}

		public BackEventFalseType GetFalseType()
		{
			return false_type;
		}

		public Dictionary<int, NewMarkType> GetMarkData()
		{
			return m_dictMarkData;
		}
	}

	public class SendEvent_SceneTavern
	{
		private SceneTavernEventType name;

		private int wparam;

		private int lparam;

		public SendEvent_SceneTavern(SceneTavernEventType m_name, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneTavernEventType GetEventName()
		{
			return name;
		}

		public int GetWParam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}
	}

	public class BackEvent_SceneTavern
	{
		private SceneTavernEventType name;

		private TUIGameInfo info;

		private int wparam;

		private int lparam;

		private bool control_success;

		private BackEventFalseType false_type;

		public BackEvent_SceneTavern(SceneTavernEventType m_name, TUIGameInfo m_info, bool m_success = false)
		{
			name = m_name;
			info = m_info;
			control_success = m_success;
		}

		public BackEvent_SceneTavern(SceneTavernEventType m_name, bool m_success, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			control_success = m_success;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public BackEvent_SceneTavern(SceneTavernEventType m_name, bool m_success, BackEventFalseType m_false_type, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			control_success = m_success;
			false_type = m_false_type;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public BackEvent_SceneTavern(SceneTavernEventType m_name, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneTavernEventType GetEventName()
		{
			return name;
		}

		public TUIGameInfo GetEventInfo()
		{
			return info;
		}

		public bool GetControlSuccess()
		{
			return control_success;
		}

		public int GetWparam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}

		public BackEventFalseType GetFalseType()
		{
			return false_type;
		}
	}

	public class SendEvent_SceneMap
	{
		private SceneMapEventType name;

		private int wparam;

		private int lparam;

		public SendEvent_SceneMap(SceneMapEventType m_name, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneMapEventType GetEventName()
		{
			return name;
		}

		public int GetWParam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}
	}

	public class BackEvent_SceneMap
	{
		private SceneMapEventType name;

		private TUIGameInfo info;

		private int wparam;

		private int lparam;

		private bool control_success;

		private string str = string.Empty;

		public BackEvent_SceneMap(SceneMapEventType m_name, TUIGameInfo m_info, bool m_success = false)
		{
			name = m_name;
			info = m_info;
			control_success = m_success;
		}

		public BackEvent_SceneMap(SceneMapEventType m_name, bool m_success = false, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			info = null;
			control_success = m_success;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public BackEvent_SceneMap(SceneMapEventType m_name, string m_str)
		{
			name = m_name;
			str = m_str;
		}

		public SceneMapEventType GetEventName()
		{
			return name;
		}

		public TUIGameInfo GetEventInfo()
		{
			return info;
		}

		public bool GetControlSuccess()
		{
			return control_success;
		}

		public int GetWparam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}

		public string GetStr()
		{
			return str;
		}
	}

	public class SendEvent_SceneIAP
	{
		private SceneIAPEventType name;

		private int wparam;

		private int lparam;

		public SendEvent_SceneIAP(SceneIAPEventType m_name, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneIAPEventType GetEventName()
		{
			return name;
		}

		public int GetWParam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}
	}

	public class BackEvent_SceneIAP
	{
		private SceneIAPEventType name;

		private TUIGameInfo info;

		private int wparam;

		private int lparam;

		private bool control_success;

		public BackEvent_SceneIAP(SceneIAPEventType m_name, TUIGameInfo m_info, bool m_success = false, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			info = m_info;
			control_success = m_success;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public BackEvent_SceneIAP(SceneIAPEventType m_name, bool m_success = false, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			info = null;
			control_success = m_success;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneIAPEventType GetEventName()
		{
			return name;
		}

		public TUIGameInfo GetEventInfo()
		{
			return info;
		}

		public bool GetControlSuccess()
		{
			return control_success;
		}

		public int GetWparam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}
	}

	public class SendEvent_SceneGold
	{
		private SceneGoldEventType name;

		private int wparam;

		private int lparam;

		public SendEvent_SceneGold(SceneGoldEventType m_name, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneGoldEventType GetEventName()
		{
			return name;
		}

		public int GetWParam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}
	}

	public class BackEvent_SceneGold
	{
		private SceneGoldEventType name;

		private TUIGameInfo info;

		private int wparam;

		private int lparam;

		private bool control_success;

		private BackEventFalseType false_type;

		public BackEvent_SceneGold(SceneGoldEventType m_name, TUIGameInfo m_info, bool m_success = false)
		{
			name = m_name;
			info = m_info;
			control_success = m_success;
		}

		public BackEvent_SceneGold(SceneGoldEventType m_name, bool m_success = false, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			info = null;
			control_success = m_success;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public BackEvent_SceneGold(SceneGoldEventType m_name, bool m_success, BackEventFalseType m_false_type, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			control_success = m_success;
			false_type = m_false_type;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneGoldEventType GetEventName()
		{
			return name;
		}

		public TUIGameInfo GetEventInfo()
		{
			return info;
		}

		public bool GetControlSuccess()
		{
			return control_success;
		}

		public int GetWparam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}

		public BackEventFalseType GetFalseType()
		{
			return false_type;
		}
	}

	public class SendEvent_SceneCoopInputName
	{
		private SceneCoopInputNameEventType name;

		private int wparam;

		private int lparam;

		private string str = string.Empty;

		public SendEvent_SceneCoopInputName(SceneCoopInputNameEventType m_name, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SendEvent_SceneCoopInputName(SceneCoopInputNameEventType m_name, string m_str)
		{
			name = m_name;
			str = m_str;
		}

		public SceneCoopInputNameEventType GetEventName()
		{
			return name;
		}

		public int GetWParam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}

		public string GetStr()
		{
			return str;
		}
	}

	public class BackEvent_SceneCoopInputName
	{
		private SceneCoopInputNameEventType name;

		private int wparam;

		private int lparam;

		private TUIGameInfo info;

		private bool control_success;

		public BackEvent_SceneCoopInputName(SceneCoopInputNameEventType m_name, TUIGameInfo m_info, bool m_success = false)
		{
			name = m_name;
			info = m_info;
			control_success = m_success;
		}

		public BackEvent_SceneCoopInputName(SceneCoopInputNameEventType m_name, bool m_success = false, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			info = null;
			control_success = m_success;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneCoopInputNameEventType GetEventName()
		{
			return name;
		}

		public TUIGameInfo GetEventInfo()
		{
			return info;
		}

		public bool GetControlSuccess()
		{
			return control_success;
		}

		public int GetWparam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}
	}

	public class SendEvent_SceneCoopMainMenu
	{
		private SceneCoopMainMenuEventType name;

		private int wparam;

		private int lparam;

		private string str = string.Empty;

		public SendEvent_SceneCoopMainMenu(SceneCoopMainMenuEventType m_name, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SendEvent_SceneCoopMainMenu(SceneCoopMainMenuEventType m_name, string m_str)
		{
			name = m_name;
			str = m_str;
		}

		public string GetStr()
		{
			return str;
		}

		public SceneCoopMainMenuEventType GetEventName()
		{
			return name;
		}

		public int GetWParam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}
	}

	public class BackEvent_SceneCoopMainMenu
	{
		private SceneCoopMainMenuEventType name;

		private int wparam;

		private int lparam;

		private TUIGameInfo info;

		private bool control_success;

		private string str = string.Empty;

		public BackEvent_SceneCoopMainMenu(SceneCoopMainMenuEventType m_name, TUIGameInfo m_info, bool m_success = false)
		{
			name = m_name;
			info = m_info;
			control_success = m_success;
		}

		public BackEvent_SceneCoopMainMenu(SceneCoopMainMenuEventType m_name, bool m_success = false, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			info = null;
			control_success = m_success;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public BackEvent_SceneCoopMainMenu(SceneCoopMainMenuEventType m_name, bool m_success, string m_str)
		{
			name = m_name;
			control_success = m_success;
			str = m_str;
		}

		public SceneCoopMainMenuEventType GetEventName()
		{
			return name;
		}

		public TUIGameInfo GetEventInfo()
		{
			return info;
		}

		public bool GetControlSuccess()
		{
			return control_success;
		}

		public int GetWparam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}

		public string GetStr()
		{
			return str;
		}
	}

	public class SendEvent_SceneCoopRoom
	{
		private SceneCoopRoomEventType name;

		private int wparam;

		private int lparam;

		public SendEvent_SceneCoopRoom(SceneCoopRoomEventType m_name, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneCoopRoomEventType GetEventName()
		{
			return name;
		}

		public int GetWParam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}
	}

	public class BackEvent_SceneCoopRoom
	{
		private SceneCoopRoomEventType name;

		private int wparam;

		private int lparam;

		private TUIGameInfo info;

		private bool control_success;

		private string str = string.Empty;

		public BackEvent_SceneCoopRoom(SceneCoopRoomEventType m_name, TUIGameInfo m_info, bool m_success = false)
		{
			name = m_name;
			info = m_info;
			control_success = m_success;
		}

		public BackEvent_SceneCoopRoom(SceneCoopRoomEventType m_name, bool m_success = false, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			info = null;
			control_success = m_success;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public BackEvent_SceneCoopRoom(SceneCoopRoomEventType m_name, string m_str)
		{
			name = m_name;
			str = m_str;
		}

		public SceneCoopRoomEventType GetEventName()
		{
			return name;
		}

		public TUIGameInfo GetEventInfo()
		{
			return info;
		}

		public bool GetControlSuccess()
		{
			return control_success;
		}

		public int GetWparam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}

		public string GetStr()
		{
			return str;
		}
	}

	public class SendEvent_SceneBlackMarket
	{
		private SceneBlackMarketEventType name;

		private int wparam;

		private int lparam;

		public SendEvent_SceneBlackMarket(SceneBlackMarketEventType m_name, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public SceneBlackMarketEventType GetEventName()
		{
			return name;
		}

		public int GetWParam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}
	}

	public class BackEvent_SceneBlackMarket
	{
		private SceneBlackMarketEventType name;

		private int wparam;

		private int lparam;

		private TUIGameInfo info;

		private bool control_success;

		private BackEventFalseType false_type;

		public BackEvent_SceneBlackMarket(SceneBlackMarketEventType m_name, TUIGameInfo m_info, bool m_success = false)
		{
			name = m_name;
			info = m_info;
			control_success = m_success;
		}

		public BackEvent_SceneBlackMarket(SceneBlackMarketEventType m_name, bool m_success = false, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			control_success = m_success;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public BackEvent_SceneBlackMarket(SceneBlackMarketEventType m_name, bool m_success, BackEventFalseType m_false_type, int m_wparam = 0, int m_lparam = 0)
		{
			name = m_name;
			control_success = m_success;
			false_type = m_false_type;
			wparam = m_wparam;
			lparam = m_lparam;
		}

		public bool GetControlSuccess()
		{
			return control_success;
		}

		public TUIGameInfo GetEventInfo()
		{
			return info;
		}

		public SceneBlackMarketEventType GetEventName()
		{
			return name;
		}

		public int GetWparam()
		{
			return wparam;
		}

		public int GetLparam()
		{
			return lparam;
		}

		public BackEventFalseType GetFalseType()
		{
			return false_type;
		}
	}
}
