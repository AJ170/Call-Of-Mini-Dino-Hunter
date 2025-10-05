using UnityEngine;
using System;
using Random = UnityEngine.Random;

public class SafeFloat
{
    private int key;          // Per-instance key for XOR encryption
    private int encryptedBits; // Encrypted float stored as int
    private int checksum;      // Simple checksum for tamper detection

    private const int checksumConst = 0x5A5A5A5A; // arbitrary constant for checksum

    public SafeFloat()
    {
        key = Random.Range(1000, 999999);
        Set(0f);
    }

    public SafeFloat(float value) : this()
    {
        Set(value);
    }

    private int FloatToBits(float f)
    {
        return BitConverter.ToInt32(BitConverter.GetBytes(f), 0);
    }

    private float BitsToFloat(int bits)
    {
        return BitConverter.ToSingle(BitConverter.GetBytes(bits), 0);
    }

    private void UpdateChecksum()
    {
        checksum = encryptedBits ^ key ^ checksumConst;
    }

    public float Get()
    {
        // Decrypt
        int bits = encryptedBits ^ key;

        // Check for tampering
        if ((encryptedBits ^ key ^ checksumConst) != checksum)
        {
            // Detected tampering: reset key and encryptedBits
            key = Random.Range(1000, 999999);
            bits = FloatToBits(BitsToFloat(bits)); // preserve the real value
            encryptedBits = bits ^ key;
            UpdateChecksum();
        }

        // Rotate key slightly to break CE freezes
        key ^= Random.Range(1, 255);
        UpdateChecksum();

        return BitsToFloat(bits);
    }

    public void Set(float value)
    {
        int bits = FloatToBits(value);
        encryptedBits = bits ^ key;
        UpdateChecksum();
    }

    // Implicit conversions
    public static implicit operator SafeFloat(float value)
    {
        return new SafeFloat(value);
    }

    public static implicit operator float(SafeFloat s)
    {
        return s.Get();
    }

    // Operators
    public static SafeFloat operator +(SafeFloat a, SafeFloat b)
    {
        return new SafeFloat(a.Get() + b.Get());
    }

    public static SafeFloat operator -(SafeFloat a, SafeFloat b)
    {
        return new SafeFloat(a.Get() - b.Get());
    }

    public static SafeFloat operator *(SafeFloat a, SafeFloat b)
    {
        return new SafeFloat(a.Get() * b.Get());
    }

    public static SafeFloat operator /(SafeFloat a, SafeFloat b)
    {
        return new SafeFloat(a.Get() / b.Get());
    }

    public override bool Equals(object obj)
    {
        if (obj == null) return false;

        if (obj.GetType() == typeof(SafeFloat))
            return Get() == ((SafeFloat)obj).Get();

        if (obj.GetType() == typeof(float))
            return Get() == (float)obj;

        return false;
    }

    public override int GetHashCode()
    {
        return Get().GetHashCode();
    }

    public override string ToString()
    {
        return Get().ToString();
    }
}
