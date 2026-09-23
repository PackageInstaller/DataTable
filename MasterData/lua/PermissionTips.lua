--用户协议
require "LoginCommFuns"
local scroll=nil;
local index=1;
local agreeTexts=nil;
function Awake()
    scroll=ComUtil.GetCom(sv,"ScrollRect");
end

function OnOpen()
    EventMgr.Dispatch(EventType.Login_Hide_Mask);
    agreeTexts=Cfgs.CfgExplanatoryText:GetGroup(7);
    UIUtil:ShowAction(root,function()
        Refresh();
    end);
end

function Refresh()
    local content="";
    if agreeTexts then
        CSAPI.SetText(txt_content,agreeTexts[index].desc);
    end
end

--取消
function OnClickCancel()
    EventMgr.Dispatch(EventType.Login_State_Agree,false)
    view:Close();
end

--同意
function OnClickAgree()
    SetPermission(true);
    UIUtil:HideAction(root,function()
        view:Close();
    end);
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