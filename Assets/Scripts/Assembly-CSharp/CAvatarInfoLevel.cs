using System.Collections.Generic;

public class CAvatarInfoLevel
{
    public SafeInteger m_nLevel = new SafeInteger();

    public SafeInteger[] arrFunc;
    public SafeInteger[] arrValueX;
    public SafeInteger[] arrValueY;

    public List<SafeInteger> ltMaterials;
    public List<SafeInteger> ltMaterialsCount;

    public bool isCrystalPurchase;

    public SafeInteger nPurchasePrice = new SafeInteger();

    public string sDesc = string.Empty;
    public string sLevelUpDesc = string.Empty;

    public CAvatarInfoLevel()
    {
        arrFunc = new SafeInteger[3];
        arrValueX = new SafeInteger[3];
        arrValueY = new SafeInteger[3];

        for (int i = 0; i < 3; i++)
        {
            arrFunc[i] = new SafeInteger();
            arrValueX[i] = new SafeInteger();
            arrValueY[i] = new SafeInteger();
        }

        ltMaterials = new List<SafeInteger>();
        ltMaterialsCount = new List<SafeInteger>();
    }
}
