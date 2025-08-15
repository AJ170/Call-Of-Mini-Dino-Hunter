using UnityEngine;

public class UICursorFollow : MonoBehaviour
{
    public Texture2D normalCursor;
    public Texture2D clickCursor;

    public Rect normalRect;
    public Rect clickRect;

    private Texture2D currentCursor;
    private Rect currentRect;

    bool active;

    void Start()
    {
        DontDestroyOnLoad(gameObject);

        currentCursor = normalCursor;
        currentRect = normalRect;

        Toggle();
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.F2)) Toggle();

        if (!active) return;

        Cursor.visible = false; // not doing it causes the cursor to be vissible when focusing back.

        if (Input.GetMouseButton(0))
        {
            currentCursor = clickCursor;
            currentRect = clickRect;
        }
        else
        {
            currentCursor = normalCursor;
            currentRect = normalRect;
        }
    }

    public void Toggle()
    {
        active = !active;
        Cursor.visible = true;
    }

    void OnGUI()
    {
        if (!active) return;

        Vector2 mousePos = Event.current.mousePosition;

        // Offset the position so it's centered
        float x = (mousePos.x - currentRect.x / 2) + currentRect.x;
        float y = (mousePos.y - currentRect.y / 2) + currentRect.y;

        GUI.DrawTexture(new Rect(x, y, currentRect.width, currentRect.height), currentCursor);
    }
}
