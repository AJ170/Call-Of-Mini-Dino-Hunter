using System.Collections.Generic;
using UnityEngine;

public class CWeaponInfoLevel
{
    public int nLevel;
    public int nType;
    public int nElementType;
    public int nActionType;
    public int nModel;
    public int nFire;
    public int nBullet;
    public int nHit;
    public string sAudioFire = string.Empty;

    public int nAttackMode;

    public List<SafeFloat> ltAttackModeValue;

    public string sName = string.Empty;
    public string sDesc = string.Empty;
    public string sIcon = string.Empty;

    public float fShootSpeed = new float();
    public float fMSDownRateShoot;
    public float fMSDownRateEquip;
    public float fPrecise = 1f;

    public int nCapacity = new int();

    public int[] arrFunc = new int[3];
    public int[] arrValueX = new int[3];
    public int[] arrValueY = new int[3];

    public SafeFloat fDamage = new SafeFloat();
    public SafeFloat fCritical = new SafeFloat();
    public SafeFloat fCriticalDmg = new SafeFloat();

    public float fElementUp;
    public List<int> ltElementUpMonster = new List<int>();
    public float fElementDown;
    public List<int> ltElementDownMonster = new List<int>();

    public List<SafeInteger> ltMaterials;
    public List<SafeInteger> ltMaterialsCount;

    public bool isCrystalPurchase;
    public SafeInteger nPurchasePrice = new SafeInteger();

    public string sLevelUpDesc = string.Empty;

    public CWeaponInfoLevel()
    {
        ltAttackModeValue = new List<SafeFloat>();

        nBullet = -1;
        nFire = -1;
        nHit = -1;

        ltMaterials = new List<SafeInteger>();
        ltMaterialsCount = new List<SafeInteger>();
    }

    public bool GetAtkModeValue(int nIndex, ref float fValue)
    {
        fValue = 0f;
        if (ltAttackModeValue == null || nIndex < 0 || nIndex >= ltAttackModeValue.Count)
            return false;

        if (ltAttackModeValue[nIndex] == null)
            ltAttackModeValue[nIndex] = new SafeFloat();

        fValue = ltAttackModeValue[nIndex].Get();
        return true;
    }

    public bool GetAtkModeValue(int nIndex, ref int nValue)
    {
        nValue = 0;
        if (ltAttackModeValue == null || nIndex < 0 || nIndex >= ltAttackModeValue.Count)
            return false;

        if (ltAttackModeValue[nIndex] == null)
            ltAttackModeValue[nIndex] = new SafeFloat();

        nValue = (int)ltAttackModeValue[nIndex].Get();
        return true;
    }

    public float GetElementValue(int nMobID)
    {
        if (ltElementUpMonster != null)
        {
            for (int i = 0; i < ltElementUpMonster.Count; i++)
            {
                if (nMobID == ltElementUpMonster[i])
                    return fElementUp;
            }
        }

        if (ltElementDownMonster != null)
        {
            for (int i = 0; i < ltElementDownMonster.Count; i++)
            {
                if (nMobID == ltElementDownMonster[i])
                    return fElementDown;
            }
        }

        return 0f;
    }

    public float CalcDPS()
    {
        float fValue = 0f;

        if (nAttackMode == 5)
        {
            GetAtkModeValue(2, ref fValue);
        }
        else
        {
            fValue = fShootSpeed;
        }

        return (fValue != 0f) ? (fDamage.Get() / fValue) : fDamage.Get();
    }

    public void InitializeMaterials(int count)
    {
        if (ltMaterials == null) ltMaterials = new List<SafeInteger>();
        if (ltMaterialsCount == null) ltMaterialsCount = new List<SafeInteger>();

        while (ltMaterials.Count < count)
            ltMaterials.Add(new SafeInteger());

        while (ltMaterialsCount.Count < count)
            ltMaterialsCount.Add(new SafeInteger());
    }
}
