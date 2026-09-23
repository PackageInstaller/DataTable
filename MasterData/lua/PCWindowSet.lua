
---PC版本 窗口设置
---全屏设置和1280*720切换
---可以调的模式有  1.全屏设置  2.1920*1080  3.1280*720  4.640*480
---目前仅仅配置到 设置页面 仅仅Windos 版本情况下 可见 开配置 ，默认配置1280*720
---
---
---  弃用 弃用 弃用  原因是 真机  读取 CS.UnityEngine.Screen.fullScreenMode   居然是nil      C# 正常
---
PCWindowSet={}
local this=PCWindowSet;

---状态
this.PCmodeState=0;
---是否可执行
this.Isitexecutable=false;

--local Screen=UnityEngine.Screen;
local FullScreenMode=UnityEngine.FullScreenMode;
local Input=UnityEngine.Input;
local KeyCode=UnityEngine.KeyCode;

---初始化状态
function this.OnInit()

     print("Screen.fullScreenMode:--onintt---"..tostring(CS.UnityEngine.Screen.fullScreenMode))
    if UnityEngine.Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer then
        this.Isitexecutable=true;
        this.SetResolution(1280,720,false,3)
    else
        this.Isitexecutable=false;
    end
end

---模仿Updata
function this.ImitateUpdata()
    if this.Isitexecutable==false then
        return
    end
    if(Input.GetKeyDown(KeyCode.F1))then
          print("全屏适配")
        this.SetResolution(1920,1080,true,1)
    elseif (Input.GetKeyDown(KeyCode.F3)) then
        print("1920*1080适配")
        this.SetResolution(1920,1080,false,2)
    elseif (Input.GetKeyDown(KeyCode.F4)) then
        print("1280*720适配")
        this.SetResolution(1280,720,false,3)
    elseif (Input.GetKeyDown(KeyCode.F5)) then
        print("640*480适配")
        this.SetResolution(640,480,false,4)
    elseif (Input.GetKeyDown(KeyCode.F6)) then
        print("640*480适配")
        --local dialogData = {}
        --dialogData.content = LanguageMgr:GetTips(7001)
        --dialogData.okText =LanguageMgr:GetByID(1001)
        --dialogData.cancelText =LanguageMgr:GetByID(1002)
        --dialogData.okCallBack = function()  end
        --dialogData.cancelCallBack = function() end
        --CSAPI.OpenView("Dialog", dialogData)
        ShiryuSDK.ExitGame();
    end
end



---width  宽度
---height 高度
---IsFullScreen bool 是否全屏
---模式状态 modeState 0：默认  1：全屏设置 2:1920*1080 3:1280*720  4:640*480
function this.SetResolution(width,height,IsFullScreen,modeState)
    if modeState==1 then
       if this.PCmodeState==modeState then     print("拒绝"..modeState)  return; end
        this.PCmodeState=modeState
        print("   this.PCmodeState:"..  this.PCmodeState)
        this.SetResolutionMode(1,function()  CS.UnityEngine.Screen.SetResolution(width, height, IsFullScreen); end);
    elseif modeState==2 then
        if this.PCmodeState==modeState then  print("拒绝"..modeState)  return; end
        this.PCmodeState=modeState
        print("   this.PCmodeState:"..  this.PCmodeState)
        this.SetResolutionMode(2,function() CS.UnityEngine.Screen.SetResolution(width, height, IsFullScreen);  end);
    elseif modeState==3 then
        if this.PCmodeState==modeState then  print("拒绝"..modeState)  return; end
        this.PCmodeState=modeState
        print("   this.PCmodeState:"..  this.PCmodeState)
        this.SetResolutionMode(2,function()      CS.UnityEngine.Screen.SetResolution(width, height, IsFullScreen); end);
    elseif modeState==4 then
        if this.PCmodeState==modeState then  print("拒绝"..modeState)  return; end
        this.PCmodeState=modeState
        print("   this.PCmodeState:"..  this.PCmodeState)
        this.SetResolutionMode(2,function()       CS.UnityEngine.Screen.SetResolution(width, height, IsFullScreen); end);
    else
        if this.PCmodeState==modeState then   print("拒绝"..modeState)  return; end
        this.PCmodeState=modeState
        this.SetResolutionMode(2,function()   CS.UnityEngine.Screen.SetResolution(width, height, IsFullScreen); end);

    end
end
---设置状态
function this.SetResolutionMode(modeState,action)

    print("modeState---"..modeState.."当前状态"..tostring(CS.UnityEngine.Screen.fullScreenMode))
    if modeState==1 then
        if CS.UnityEngine.Screen.fullScreenMode == FullScreenMode.Windowed then
            print("进入了设置----------FullScreenMode.FullScreenWindow")
            CS.UnityEngine.Screen.fullScreenMode = FullScreenMode.FullScreenWindow;
            print("设置后输出---  Screen.fullScreenMode: "..tostring(CS.UnityEngine.Screen.fullScreenMode))
        end
        if action then action(); end
    elseif  modeState==2 then
        if CS.UnityEngine.Screen.fullScreenMode == FullScreenMode.FullScreenWindow then
            print("进入了设置----------FullScreenMode.Windowed")
            CS.UnityEngine.Screen.fullScreenMode = FullScreenMode.Windowed;
            print("设置后输出---  Screen.fullScreenMode: "..tostring(CS.UnityEngine.Screen.fullScreenMode))
        end
        if action then action(); end
    end
end