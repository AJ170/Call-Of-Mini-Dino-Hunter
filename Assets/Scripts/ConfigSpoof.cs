using UnityEngine;

public static class ConfigSpoof
{
    public static string GetConfig(string name)
    {
        TextAsset asset = Resources.Load<TextAsset>("configspoof/" + name);

        return asset.text;
    }
}
