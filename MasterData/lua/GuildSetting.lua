--公会设置面板

local lv=1;
local desc="";
local inpName;
local inpDesc;
local inpLv;
local iconId=nil;
local typeToggleA;
local typeToggleB;
local joinToggleA;
local joinToggleB;
local moneyId=nil;
local moneyNum=0;
local iconClick=nil;
local title=nil;
local eventMgr=nil;
function Awake()
    inpName=ComUtil.GetCom(inp_name,"InputField");
    inpDesc=ComUtil.GetCom(inp_desc,"InputField");
    inpLv=ComUtil.GetCom(inp_lv,"InputField");
    typeToggleA=ComUtil.GetCom(typeToggle1,"Toggle");
    typeToggleB=ComUtil.GetCom(typeToggle2,"Toggle");
    joinToggleA=ComUtil.GetCom(joinToggle1,"Toggle");
    joinToggleB=ComUtil.GetCom(joinToggle2,"Toggle");
    iconClick=ComUtil.GetCom(iconObj,"Image");
    CSAPI.AddInputFieldCallBack(inp_lv,OnLvChange);
    CSAPI.AddInputFieldChange(inp_desc,OnDescChange);
    CSAPI.AddInputFieldChange(inp_name,OnNameChange);
    CSAPI.AddInputFieldCallBack(inp_name,OnNameEnd);
    CSAPI.AddInputFieldCallBack(inp_desc,OnDescEnd);
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Guild_Icon_Change, OnIconChange);
    eventMgr:AddListener(EventType.Guild_Info_Refresh, OnInfoChange);
end

function OnDestroy()
    CSAPI.RemoveInputFieldChange(inp_name,OnNameChange);
    CSAPI.RemoveInputFieldChange(inp_desc,OnDescChange);
    CSAPI.RemoveInputFieldCallBack(inp_lv,OnLvChange);
    CSAPI.RemoveInputFieldCallBack(inp_name,OnNameEnd);
    CSAPI.RemoveInputFieldCallBack(inp_desc,OnDescEnd);
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end

function OnOpen()
    title=GuildMgr:GetTitle();
    CSAPI.SetGOActive(btn_del,false);
    if title==GuildMemberType.Boss then-- 会长
        iconClick.raycastTarget=true;
        inpName.interactable=true;
        CSAPI.SetGOActive(btn_del,true);
    elseif title==GuildMemberType.SubBoss then-- 副会长
        iconClick.raycastTarget=false;
        inpName.interactable=false;
    end
    --初始化当前信息
    local guildInfo=GuildMgr:GetGuildInfo();
    inpName.text=guildInfo.name
    --读取头像
    iconId=guildInfo.icon;
    if iconId then
        local cfg=Cfgs.character:GetByID(iconId)
        if cfg then
            ResUtil.RoleCard:Load(icon, cfg.icon)
        end
    else
        CSAPI.SetRectSize(icon,0,0,0);
    end
    local isType1=guildInfo.activity_type==GuildActivityType.Lazy;
    typeToggleA.isOn=isType1;
    typeToggleB.isOn=not isType1;
    local isJoin1=guildInfo.ratify_type==GuildRatifyType.Auto;
    joinToggleA.isOn=isJoin1;
    joinToggleB.isOn=not isJoin1;
    inpLv.text=tostring(guildInfo.apply_lv);
    lv=guildInfo.apply_lv;
    inpDesc.text=guildInfo.desc;
end

-----------------------------Root1的逻辑-------------------------

function OnNameChange(text)
    local name=StringUtil:FilterChar2(text);
    inpName.text=name;
end

--名字输入完毕时
function OnNameEnd(text)
    if MsgParser:CheckContain(text) then
        Tips.ShowTips(StringTips.common4)
        inpName.text="";
    end
end

function OnLvChange(str)   
    if str==nil or str=="" then
        lv=1;
        inpLv.text=tostring(lv);
        return
    end
    lv=tonumber(str);
    if lv>g_PlayerLvMax then
        lv=g_PlayerLvMax;
        inpLv.text=tostring(lv);
    elseif lv<=0 then
        lv=1;
        inpLv.text=tostring(lv);
    end
end

function OnClickLevel(go)
    local add=go==btnAdd and 1 or -1;
    lv=lv+add;
    if lv>g_PlayerLvMax then
        lv=g_PlayerLvMax;
    elseif lv<0 then
        lv=1;
    end
    inpLv.text=tostring(lv);
end

function OnDescChange(text)
    if GLogicCheck:GetStringLen(text)>100 then
        desc=StringUtil:SetStringByLen(text, 100, "");
        inpDesc.text=desc;
    end
end

function OnDescEnd(text)
    if MsgParser:CheckContain(text) then --不得含有屏蔽词
        Tips.ShowTips(StringTips.common4)
        inpDesc.text="";
    end
end

function OnClickOk()
    local name=inpName.text
    if name==nil or name=="" then
        Tips.ShowTips(LanguageMgr:GetTips(17000));
        return;
    end
    if iconId==nil or iconId=="" then
        Tips.ShowTips(LanguageMgr:GetTips(17001));
        return;
    end
    local guildInfo=GuildMgr:GetGuildInfo();
    local activity_type=typeToggleA.isOn and GuildActivityType.Lazy or GuildActivityType.Active;
    if activity_type==guildInfo.activity_type then
        activity_type=nil;
    end
    local ratify_type=joinToggleA.isOn and GuildRatifyType.Auto or GuildRatifyType.Apply;
    if ratify_type==guildInfo.ratify_type then
        ratify_type=nil;
    end
    if name==guildInfo.name then
        name=nil;
    end
    local iconID=iconId;
    if iconID==guildInfo.icon then
        iconID=nil;
    end
    local currLv=lv;
    if guildInfo.apply_lv==tonumber(inpLv.text) then
        currLv=nil;
    end
    local desc=inpDesc.text or "";
    if desc==guildInfo.desc then
        desc=nil;
    end
    local info={
        name=name, 
        icon=iconID,
        activity_type=activity_type,
        apply_lv=currLv,
        ratify_type=ratify_type,
        desc=desc,
    };
    if (title==GuildMemberType.Boss or title==GuildMemberType.SubBoss) and next(info)~=nil then
        GuildProto:ModInfo(info);
    else
        Close();
    end
end

--解散公会
function OnClickDel()
    if title==GuildMemberType.Boss then
        local dialogdata = {};
        dialogdata.content =LanguageMgr:GetTips(17013);
        dialogdata.okCallBack = function()
            GuildProto:DelGuild();
        end
        CSAPI.OpenView("Dialog", dialogdata)
    else
        Tips.ShowTips(LanguageMgr:GetTips(17014));
    end
end

function Close()
    view:Close();
end

function OnClickClose()
    Close();
end

function OnClickIcon()
    CSAPI.OpenView("GuildIcon",{iconID=iconId});
end

function OnIconChange(id)
    iconId=id;
    if id then
        local cfg=Cfgs.character:GetByID(id)
        if cfg then
            ResUtil.RoleCard:Load(icon, cfg.icon)
        end
    end
end

function OnInfoChange()
    Close();
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
root=nil;
btn_del=nil;
inp_name=nil;
txt_tips=nil;
iconObj=nil;
icon=nil;
typeToggle1=nil;
typeToggle2=nil;
inp_lv=nil;
btnAdd=nil;
btnRemove=nil;
joinToggle1=nil;
joinToggle2=nil;
inp_desc=nil;
btn_ok=nil;
btn_close=nil;
view=nil;
end
----#End#----