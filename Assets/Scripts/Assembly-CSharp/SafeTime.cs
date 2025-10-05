using UnityEngine;

public static class SafeTime
{
    private static double lastTime = -1;
    private static float safeDeltaTime = 0f;

    public static float DeltaTime
    {
        get { return safeDeltaTime; }
    }

    public static void Update()
    {
        double now = System.DateTime.UtcNow.Ticks / (double)System.TimeSpan.TicksPerSecond;
        if (lastTime > 0)
        {
            double delta = now - lastTime;

            // clamp between 1ms and 100ms
            if (delta < 0.001) delta = 0.001;
            if (delta > 0.1) delta = 0.1;

            safeDeltaTime = (float)delta;
        }
        lastTime = now;
    }
}