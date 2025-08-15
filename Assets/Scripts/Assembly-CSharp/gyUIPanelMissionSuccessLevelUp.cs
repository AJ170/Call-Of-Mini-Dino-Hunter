using UnityEngine;

public class gyUIPanelMissionSuccessLevelUp : MonoBehaviour
{
	public GameObject mLightBase;

	public GameObject mLightAnim;

	public GameObject mTitleText;

	public GameObject mTitleIcon;

	public GameObject mStatisticsBackground;

	public UILabel mLabel1_1;

	public UILabel mLabel1_2;

	public UISprite mLabel1_3;

	public UILabel mLabel1_4;

	public UILabel mLabel2_1;

	public UILabel mLabel2_2;

	public UISprite mLabel2_3;

	public UILabel mLabel2_4;

	protected bool m_bShow;

	protected int m_nStep;

	protected float m_fStepCount;

	private void Awake()
	{
		m_bShow = false;
		base.gameObject.SetActiveRecursively(false);
	}

	private void Start()
	{
	}

	private void Update()
	{
		if (!m_bShow)
		{
			return;
		}
        float deltaTime = Time.deltaTime;
		switch (m_nStep)
		{
		case 0:
			m_fStepCount -= deltaTime;
			if (m_fStepCount <= 0f)
			{
				CUISound.GetInstance().Play("UI_Bump");
				mLabel1_2.gameObject.SetActiveRecursively(true);
				m_nStep = 1;
				m_fStepCount = 0.2f;
			}
			break;
		case 1:
			m_fStepCount -= deltaTime;
			if (m_fStepCount <= 0f)
			{
				CUISound.GetInstance().Play("UI_Bump");
				mLabel1_3.gameObject.SetActiveRecursively(true);
				m_nStep = 2;
				m_fStepCount = 0.2f;
			}
			break;
		case 2:
			m_fStepCount -= deltaTime;
			if (m_fStepCount <= 0f)
			{
				CUISound.GetInstance().Play("UI_Bump");
				mLabel1_4.gameObject.SetActiveRecursively(true);
				m_nStep = 3;
				m_fStepCount = 0.2f;
			}
			break;
		case 3:
			m_fStepCount -= deltaTime;
			if (m_fStepCount <= 0f)
			{
				CUISound.GetInstance().Play("UI_Bump");
				mLabel2_2.gameObject.SetActiveRecursively(true);
				m_nStep = 4;
				m_fStepCount = 0.2f;
			}
			break;
		case 4:
			m_fStepCount -= deltaTime;
			if (m_fStepCount <= 0f)
			{
				CUISound.GetInstance().Play("UI_Bump");
				mLabel2_3.gameObject.SetActiveRecursively(true);
				m_nStep = 5;
				m_fStepCount = 0.2f;
			}
			break;
		case 5:
			m_fStepCount -= deltaTime;
			if (m_fStepCount <= 0f)
			{
				CUISound.GetInstance().Play("UI_Bump");
				mLabel2_4.gameObject.SetActiveRecursively(true);
				m_nStep = 6;
				m_fStepCount = 0.2f;
			}
			break;
		}
	}

    public void Show(bool bShow)
    {
        m_bShow = bShow;
        base.gameObject.SetActive(bShow);

        if (mLightBase != null) mLightBase.SetActive(bShow);
        if (mLightAnim != null) mLightAnim.SetActive(bShow);
        if (mTitleText != null) mTitleText.SetActive(bShow);
        if (mTitleIcon != null) mTitleIcon.SetActive(bShow);
        if (mStatisticsBackground != null) mStatisticsBackground.SetActive(bShow);

        GameObject statistics = FindDeepChild(gameObject, "Statistics");
        GameObject context1 = FindDeepChild(gameObject, "context1");
        GameObject context2 = FindDeepChild(gameObject, "context2");

        if (statistics != null) statistics.SetActive(bShow);
        if (context1 != null) context1.SetActive(bShow);
        if (context2 != null) context2.SetActive(bShow);

        if (statistics != null)
        {
            Transform background = statistics.transform.Find("background");
            if (background != null)
            {
                foreach (Transform child in background)
                {
                    if (child.name.ToLower().Contains("title"))
                        child.gameObject.SetActive(bShow);
                }
            }
        }

        if (bShow)
        {
            Transform lightAnim = transform.Find("LightAnim");
            if (lightAnim != null)
            {
                Transform direction = lightAnim.Find("direction");
                if (direction != null)
                {
                    direction.gameObject.SetActive(true);
                    foreach (Transform child in direction)
                    {
                        if (child.name == "LightPencil")
                        {
                            child.gameObject.SetActive(true);
                            Transform sprite = child.Find("sprite");
                            if (sprite != null) sprite.gameObject.SetActive(true);
                        }
                    }
                }
            }

            if (mLightBase != null)
            {
                Transform point = mLightBase.transform.Find("point");
                if (point != null) point.gameObject.SetActive(true);
            }

            base.transform.localPosition = new Vector3(0f, 0f, base.transform.localPosition.z);
        }
        else
        {
            base.transform.localPosition = new Vector3(10000f, 10000f, base.transform.localPosition.z);
        }
    }

    private GameObject FindDeepChild(GameObject parent, string name)
    {
        Transform[] children = parent.GetComponentsInChildren<Transform>(true);
        foreach (Transform child in children)
        {
            if (child.name == name)
                return child.gameObject;
        }
        return null;
    }

    private void EnableChildByName(GameObject parent, string name)
    {
        foreach (Transform child in parent.GetComponentsInChildren<Transform>(true))
        {
            if (child.name == name)
                child.gameObject.SetActive(true);
        }
    }

    private void EnableChildContains(GameObject parent, string substring)
    {
        foreach (Transform child in parent.GetComponentsInChildren<Transform>(true))
        {
            if (child.name.ToLower().Contains(substring.ToLower()))
                child.gameObject.SetActive(true);
        }
    }

    private void SetActiveAllChildren(GameObject parent, bool active)
    {
        foreach (Transform t in parent.GetComponentsInChildren<Transform>(true))
        {
            if (t != parent.transform)
                t.gameObject.SetActive(active);
        }
    }

    public bool IsAnim()
	{
		return m_nStep < 6;
	}

	public void Go()
	{
		mLabel1_1.gameObject.SetActiveRecursively(false);
		mLabel1_2.gameObject.SetActiveRecursively(false);
		mLabel1_3.gameObject.SetActiveRecursively(false);
		mLabel1_4.gameObject.SetActiveRecursively(false);
		mLabel2_1.gameObject.SetActiveRecursively(false);
		mLabel2_2.gameObject.SetActiveRecursively(false);
		mLabel2_3.gameObject.SetActiveRecursively(false);
		mLabel2_4.gameObject.SetActiveRecursively(false);
		CUISound.GetInstance().Play("UI_Bump");
		mLabel1_1.gameObject.SetActiveRecursively(true);
		mLabel2_1.gameObject.SetActiveRecursively(true);
		m_nStep = 0;
		m_fStepCount = 0.5f;
	}

	public void Stop()
	{
		CUISound.GetInstance().Play("UI_Bump");
		mLabel1_1.gameObject.SetActiveRecursively(true);
		mLabel1_2.gameObject.SetActiveRecursively(true);
		mLabel1_3.gameObject.SetActiveRecursively(true);
		mLabel1_4.gameObject.SetActiveRecursively(true);
		mLabel2_1.gameObject.SetActiveRecursively(true);
		mLabel2_2.gameObject.SetActiveRecursively(true);
		mLabel2_3.gameObject.SetActiveRecursively(true);
		mLabel2_4.gameObject.SetActiveRecursively(true);
		m_nStep = 6;
	}

	public void SetLevelContext(int from, int to)
	{
		if (!(mLabel1_2 == null) && !(mLabel1_4 == null))
		{
			mLabel1_2.text = from.ToString();
			mLabel1_4.text = "[11FF00]" + to;
		}
	}

	public void SetHPContext(int from, int to)
	{
		if (!(mLabel2_2 == null) && !(mLabel2_4 == null))
		{
			mLabel2_2.text = from.ToString();
			mLabel2_4.text = "[11FF00]" + to;
		}
	}
}
