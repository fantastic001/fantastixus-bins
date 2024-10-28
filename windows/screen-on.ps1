Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class InputSimulator
{
    [DllImport("user32.dll", SetLastError = true)]
    public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, UIntPtr dwExtraInfo);

    [DllImport("user32.dll")]
    public static extern bool SetCursorPos(int X, int Y);

    [DllImport("user32.dll")]
    public static extern bool GetCursorPos(out POINT lpPoint);

    [StructLayout(LayoutKind.Sequential)]
    public struct POINT
    {
        public int X;
        public int Y;
    }

    public const int KEYEVENTF_KEYDOWN = 0x0000; // Key down flag
    public const int KEYEVENTF_KEYUP = 0x0002; // Key up flag
    public const byte VK_CONTROL = 0x11; // Ctrl key code

    public static void PressCtrl()
    {
        keybd_event(VK_CONTROL, 0, KEYEVENTF_KEYDOWN, UIntPtr.Zero);
    }

    public static void ReleaseCtrl()
    {
        keybd_event(VK_CONTROL, 0, KEYEVENTF_KEYUP, UIntPtr.Zero);
    }

    public static void MoveMouseRandomly()
    {
        Random rand = new Random();
        int offset = rand.Next(2) == 0 ? -5 : 5;

        POINT currentPos;
        GetCursorPos(out currentPos);
        SetCursorPos(currentPos.X + offset, currentPos.Y);
    }
}
"@

# Infinite loop to simulate Ctrl press and random mouse movement
while ($true) {
    # Press the Control key
    [InputSimulator]::PressCtrl()

    # Move the mouse slightly left or right
    [InputSimulator]::MoveMouseRandomly()

    # Release the Control key
    Start-Sleep -Milliseconds 100 # Optional delay between iterations
    [InputSimulator]::ReleaseCtrl()

    Start-Sleep -Milliseconds 500 # Adjust delay as needed
}