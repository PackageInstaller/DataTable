--用户协议
require "LoginCommFuns"
local scroll=nil;
local agreeImg=nil;
local index=1;
local agreeTexts=nil;
local canvasGroup=nil;
local items=nil;
function Awake()
    scroll=ComUtil.GetCom(sv,"ScrollRect");
    canvasGroup=ComUtil.GetCom(btn_agree,"CanvasGroup");
    agreeImg=ComUtil.GetCom(btn_agree,"Image");
end

function OnOpen()
    if data and data ~= "" then
        CSAPI.SetText(txt_desc,data)
    end
    SetAgreeEnable(false);
    EventMgr.Dispatch(EventType.Login_Hide_Mask);
    agreeTexts=Cfgs.CfgExplanatoryText:GetGroup(4);
    index=openSetting
    UIUtil:ShowAction(root,function()
        Refresh();
    end);
end

function Refresh()
    local content="";
    if agreeTexts then
        CSAPI.SetText(txt_title,agreeTexts[index].title)
        local datas=StringUtil:split(agreeTexts[index].desc, "\n");
        -- LogError(datas)
        ItemUtil.AddItems("Login/AgreementItem", items, datas, txt_content, nil, 1)
        -- CSAPI.SetText(txt_content,agreeTexts[index].desc);
    end
    scroll.normalizedPosition=UnityEngine.Vector2.one;
end

function Update()
    SetAgreeEnable(scroll.verticalScrollbar.value<=0)
end

function SetAgreeEnable(enable)
    local color=enable==true and 1 or 0.5;
    canvasGroup.alpha=color;
    agreeImg.raycastTarget=enable==true;
end

--取消
function OnClickCancel()
    view:Close();
    CSAPI.Quit();
end

--同意
function OnClickAgree()
    if  agreeTexts==nil then
        LogError("获取用户协议信息失败...");
        return
    end
    EventMgr.Dispatch(EventType.Setting_Window_Logout_Agree)
    UIUtil:HideAction(root,function()
        view:Close();
    end);
end

function OnClickClose()
    if isClose then
        view:Close();
    end
end

function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
root=nil;
sv=nil;
txt_content=nil;
btn_agree=nil;
view=nil;
end
----#End#----