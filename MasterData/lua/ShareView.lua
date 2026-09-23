---是否截图
local IsCameraScreenshot=false;
---帧数
local  CameraScreenshotStep=0;
---脚本复制
local MJImageUtils=CS.MJImageUtils;
---沙盒路径
local PersistentMainPath=CS.MJImageUtils.SharepersistentMainPath;
---临时缓存路径
local SharetempMainPath=CS.MJImageUtils.SharetempMainPath;
---截图保存路径(完整路径)
local ScreenShotSaveAllPath="";
---截图保存项目名称
local ScreenShotSavePath="";
---截图保存项目名称
local ScreenShotSaveName="";
---分享内容
local Sharecontent="";
---调用 参考  CSAPI.OpenView("ShareView",{LocationSource=1})
--分享页面操作
function Awake()
    OnInitImagePath();
    CSAPI.AddEventListener(EventType.ShareView_NoticeTheNextFrameScreenshot,ShareView_NoticeTheNextFrameScreenshot)
    CSAPI.AddEventListener(EventType.ShareView_NoticeScreenshotCompleted,ShareView_NoticeScreenshotCompleted)
    OnInitUI();
end

function OnOpen()
    -- LocationSource=0;  ---1.抽卡分享 2.皮肤/插画 3.副本胜利分享 4.竞技场胜利分享
    if data and data.LocationSource and data.LocationSource>0 then
        if tonumber(data.LocationSource)==1 then
            Sharecontent=LanguageMgr:GetByID(1064);
            ---抽卡分享
            CSAPI.SetText(Titlecontent,LanguageMgr:GetByID(1064));
            IsCameraScreenshot=true;
        elseif tonumber(data.LocationSource)==2 then
            Sharecontent=LanguageMgr:GetByID(1065);
            ---皮肤/插画
            CSAPI.SetText(Titlecontent,LanguageMgr:GetByID(1065));
            IsCameraScreenshot=true;
        elseif tonumber(data.LocationSource)==3 then
            Sharecontent=LanguageMgr:GetByID(1066);
            ---副本胜利分享
            CSAPI.SetText(Titlecontent,LanguageMgr:GetByID(1066));
            IsCameraScreenshot=true;
        elseif tonumber(data.LocationSource)==4 then
            Sharecontent="";
            ---竞技场胜利分享
            CSAPI.SetText(Titlecontent,"");
            IsCameraScreenshot=true;
        elseif tonumber(data.LocationSource)==5 then
            CSAPI.SetText(Titlecontent,"");
            Sharecontent="";
            ---公告截图分享
            local  ImageBG_MenuADIltem= ComUtil.GetCom(ImageBGDwon, "MenuADItem")
            ImageBG_MenuADIltem:SetImage(ImageBG,data.key, data.bgName,data.url,function()
                local Scale=GetScale();
                print("Scale:"..Scale)
                CSAPI.SetScale(ImageBG.gameObject,Scale,Scale,Scale)

                CSAPI.SetGOActive(ImageBG, true);
                IsCameraScreenshot=true;
            end)
        elseif tonumber(data.LocationSource)==6 then
            Sharecontent=LanguageMgr:GetByID(1070);
            ---筑梦热土分享
            CSAPI.SetText(Titlecontent,"");
            IsCameraScreenshot=true;
        else
            Sharecontent="";
            CSAPI.SetText(Titlecontent,"");
            IsCameraScreenshot=true;
        end
    else
        Sharecontent="";
        CSAPI.SetText(Titlecontent,"");
        IsCameraScreenshot=true;
    end

end
function Start()

end


---853*467
function GetScale()
    local ScaleWidth=UnityEngine.Screen.width/853.0;
    local Scaleheight=UnityEngine.Screen.height/467.0;
    if ScaleWidth>Scaleheight then
        return ScaleWidth;
    else
        return Scaleheight;
    end
end


---初始化图片路径
function OnInitImagePath()
    MJImageUtils.CreatDirectory(PersistentMainPath);
    MJImageUtils.CreatDirectory(SharetempMainPath);

    ---路径和名称定义
    ScreenShotSavePath=PersistentMainPath; ---前缀路径
    ScreenShotSaveName=tostring(TimeUtil.GetTime())..".png"; ---根据当前时间定义截图名称
    ScreenShotSaveAllPath=ScreenShotSavePath.."/"..ScreenShotSaveName;---完整路径

end

---初始化数据
function OnInitUI()
    CSAPI.SetGOActive(ADVSavePictureBtn, false);
    CSAPI.SetGOActive(FuzzygraphBG, false);
    CSAPI.SetText(QRCodeUIDTxt,PlayerClient:GetUid());
    CSAPI.SetGOActive(AddQRCodeContent, false);
    CSAPI.SetText(SavePictureText,LanguageMgr:GetByID(1068));---分享至相册
    CSAPI.SetText(Titlecontent,"");
end
---截图前一帧通知
function ShareView_NoticeTheNextFrameScreenshot(Data)
    print("截图前一帧")
    CSAPI.SetGOActive(Tips.gameObject, false);
end
---截图完成通知
function ShareView_NoticeScreenshotCompleted(Data)
    print("截图完成")
    CSAPI.SetGOActive(Tips.gameObject, true);
end

function Update()
    if IsCameraScreenshot then
        CameraScreenshot();
    end
end
---截图
function CameraScreenshot()
    CameraScreenshotStep=CameraScreenshotStep+1;

    if CameraScreenshotStep==1 then
        ---第一步通知关闭相关UI
        CSAPI.SetGOActive(AddQRCodeContent, true);
        CSAPI.DispatchEvent(EventType.ShareView_NoticeTheNextFrameScreenshot)
    elseif CameraScreenshotStep==2 then
          ---执行截图保存数据
         Log("截图存放路径："..ScreenShotSaveAllPath)
        local goUICamera = CSAPI.GetGlobalGO("UICamera");
        local LuaTexture2D = nil
        if data and data.LocationSource and data.LocationSource>0 then
            if tonumber(data.LocationSource)==6 then
                local size = CSAPI.GetMainCanvasSize()
                LuaTexture2D=CS.MJImageUtils.SaveCameraScreenshot(goUICamera,math.floor(size[0]),math.floor(size[1]),true,ScreenShotSaveAllPath)
            else
                LuaTexture2D=CS.MJImageUtils.SaveCameraScreenshot(goUICamera,1920,1080,true,ScreenShotSaveAllPath)
            end
        else
            LuaTexture2D=CS.MJImageUtils.SaveCameraScreenshot(goUICamera,1920,1080,true,ScreenShotSaveAllPath)
        end
        if LuaTexture2D then
        else
            LogError("截图失败----:"..ScreenShotSaveAllPath)
        end
    elseif CameraScreenshotStep==3 then
        ---读取指定保存路径图片进行分享
        Log("截图成功----:"..ScreenShotSaveAllPath)
        CSAPI.SetGOActive(AddQRCodeContent, false);
        CSAPI.SetGOActive(FuzzygraphBG, false);
        CSAPI.SetGOActive(ImageBG, false);
        CS.MJImageUtils.ReadLocalimage(ShowPictures,ScreenShotSavePath,ScreenShotSaveName,function(back)
            print("ReadLocalimage："..tostring(back))
            if back then

                SDKShare(Sharecontent,"",ScreenShotSaveAllPath,ScreenShotSaveAllPath,"",tonumber(2),tonumber(8),"");
            else
                 LogError("读取资源失败："..ScreenShotSaveAllPath);
            end
        end,1280,720)
    elseif CameraScreenshotStep==4 then
        ---分享成功，进行关闭
        CSAPI.DispatchEvent(EventType.ShareView_NoticeScreenshotCompleted)
        OnClickCloseBtn();
    else
        CameraScreenshotStep=0;
        IsCameraScreenshot=false;
    end
end




---QQ按钮
function OnClickQQbtn()
    print("QQ")
end
---微信按钮
function OnClickWeChatBtn()
    print("微信")
end
---新浪按钮
function OnClickSinaBtn()
    print("新浪")
end

---朋友圈按钮
function OnClickWechatMomentsBtn()
    print("朋友圈按钮")
end

---国内保存按钮按钮
function OnClickSavePictureBtn()
    print("国内保存按钮按钮")
end
---国外保存按钮
function OnClickADVSavePictureBtn()
    print("海外保存到本地照片-----改为分享接口测试")
    CS.MJImageUtils.ReadLocalimage(ShowPictures,ScreenShotSavePath,ScreenShotSaveName,function(back)
        print("ReadLocalimage："..tostring(back))
        if back then
            SDKShare("","",ScreenShotSaveAllPath,ScreenShotSaveAllPath,"",tonumber(2),tonumber(8),"");
        else
            LogError("读取资源失败："..ScreenShotSaveAllPath);
        end
    end,1280,720)
end

---分享内容
function SDKShare(Sharecontent,ShareTitle,ShareImagePath,thumbImagePath,Url,shareType,sharePlatform,para,action)
    local ShareTable=
    {
        ["Text"]=Sharecontent,---分享的内容。29 34
        ["Title"]=ShareTitle,---分享的标题。
        ["ImagePath"]=ShareImagePath,---分享的链接。
        ["thumbImagePath"]=thumbImagePath,---分享缩略图图片的本地存储地址。要求缩略图为PNG格式大小不超过32k。
        ["Url"]=Url,---分享的链接。
        ["shareType"]=shareType,---分享类型，具体的值见下面表格。
        ["sharePlatform"]=sharePlatform,---分享平台，具体的值说明见下面表格。
        ["para"]=para,---分享参数，个别特殊分享使用。例如社区分享的GaragePainting，GaragePaintingCode
    }
    --local ShareTable=
    --{
    --    ["Text"]="分享测试内容，分享测试内容",---分享的内容。
    --    ["Title"]="分享测试标题",---分享的标题。
    --    ["ImagePath"]="Application.persistentDataPath".."/Share.jpg",---分享的链接。
    --    ["thumbImagePath"]="Application.persistentDataPath".."thumbShare.jpg",---分享缩略图图片的本地存储地址。要求缩略图为PNG格式大小不超过32k。
    --    ["Url"]="",---分享的链接。
    --    ["shareType"]=tonumber(2),---分享类型，具体的值见下面表格。
    --    ["sharePlatform"]=tonumber(8),---分享平台，具体的值说明见下面表格。
    --    ["para"]="",---分享参数，个别特殊分享使用。例如社区分享的GaragePainting，GaragePaintingCode
    --}

    local Jsonstr = Json.Encode(ShareTable)
    ShiryuSDK.Share(Jsonstr,function(Isback)
        print("SDk分享返回:"..tostring(Isback))
        if Isback then
            print("分享成功:"..ShareImagePath)
        else
           --- LogError("分享失败:"..ShareImagePath)
        end
    end)

end

---关闭页面按钮
function OnClickCloseBtn()
    ShareProto:AddShareCount({});
    view:Close()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    OnClickCloseBtn();
end
function OnDestroy()
    CSAPI.RemoveEventListener(EventType.ShareView_NoticeTheNextFrameScreenshot,ShareView_NoticeTheNextFrameScreenshot)
    CSAPI.RemoveEventListener(EventType.ShareView_NoticeScreenshotCompleted,ShareView_NoticeScreenshotCompleted)
    CameraScreenshotStep=0;
    IsCameraScreenshot=false;
end