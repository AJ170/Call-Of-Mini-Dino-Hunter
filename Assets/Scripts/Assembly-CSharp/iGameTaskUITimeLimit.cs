using UnityEngine;

public class iGameTaskUITimeLimit : iGameTaskUIBase
{
    protected UILabel m_LeftTime;

    private void Awake()
    {
        Transform transform = base.transform.Find("txtTime");
        if (transform != null)
        {
            m_LeftTime = transform.GetComponent<UILabel>();
        }
    }

    public void SetTime(float fLeftTime)
    {
        if (m_LeftTime != null)
        {
            fLeftTime = Mathf.Max(fLeftTime, 0f);

            m_LeftTime.text = MyUtils.TimeToString(fLeftTime);
        }
    }

    public override void UpdateTask(float deltaTime)
    {
        if (m_curTaskBase != null)
        {
            SetTime(m_curTaskBase.TaskTime);
        }
    }
}