--公会成员信息
local eventMgr=nil;
local otherData=nil;--扩展信息：参考协议sGuildMemB类型
local supportList=nil;
local supportData=nil;--助战数据
local cb=nil;
function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Guild_GuildMem_Info, OnInfoUpdate);
    eventMgr:AddListener(EventType.Guild_MemTitle_Change, OnTitleChange);
    eventMgr:AddListener(EventType.Guild_GuildMem_Change, OnMemChange);
    eventMgr:AddListener(EventType.Guild_MemTeam_Info,OnTeamInfo);
end

function OnDestroy()
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end

function OnOpen()
    if data then
        GuildProto:MemberInfo(data.uid)
    end
    Refresh();
end

function OnInfoUpdate(eventData)
    otherData=eventData.info
    Refresh();
end

--权限变更
function OnTitleChange(eventData)
    if eventData and data then
        for k,v in ipairs(eventData)do
            if v.uid==data.uid then
                data.title=eventData.title==nil and data.title or eventData.title;
            end
        end
    end
    Refresh();
end

--会员列表变更
function OnMemChange(eventData)
    if eventData.isRemove and eventData.uid==data.uid then
        Close();
    end
end

function Refresh()
    if GuildMgr:GetTitle()==GuildMemberType.Boss then
        if data.uid==PlayerClient:GetUid() then
            CSAPI.SetGOActive(btnExit,false);
            CSAPI.SetGOActive(btnSub,false);
            CSAPI.SetGOActive(btnUnSub,false);
            CSAPI.SetGOActive(btnMaster,false);
        else
            CSAPI.SetGOActive(btnExit,true);
            CSAPI.SetGOActive(btnMaster,true);
            if data and data.title==GuildMemberType.SubBoss then--已经是副会长
                CSAPI.SetGOActive(btnSub,false);
                CSAPI.SetGOActive(btnUnSub,true);
            else
                CSAPI.SetGOActive(btnSub,true);
                CSAPI.SetGOActive(btnUnSub,false);
            end
        end
    elseif GuildMgr:GetTitle()==GuildMemberType.SubBoss then
        CSAPI.SetGOActive(btnSub,false);
        CSAPI.SetGOActive(btnUnSub,false);
        CSAPI.SetGOActive(btnMaster,false);
        if data and data.title==GuildMemberType.Normal and data.uid~=PlayerClient:GetUid() then
            CSAPI.SetGOActive(btnExit,true);
        else
            CSAPI.SetGOActive(btnExit,false);
        end
    else
        CSAPI.SetGOActive(btnSub,false);
        CSAPI.SetGOActive(btnUnSub,false);
        CSAPI.SetGOActive(btnMaster,false);
        CSAPI.SetGOActive(btnExit,false);
    end
    local info=FriendMgr:GetData(data.uid);
    if (info and info:IsFriend()) or data.uid==PlayerClient:GetUid() then--已经是好友或者是自身
        CSAPI.SetGOActive(btnApply,false);
    else
        CSAPI.SetGOActive(btnApply,true);
    end
    if data then
        CSAPI.SetText(txt_name,data.name);
        CSAPI.SetText(txt_lv,tostring(data.lv));
        local title=LanguageMgr:GetByID(27009);
        if data.title==GuildMemberType.Boss then
            title=LanguageMgr:GetByID(27007);
        elseif data.title==GuildMemberType.SubBoss then
            title=LanguageMgr:GetByID(27008);
        end
        CSAPI.SetText(txt_type,title);
        if data.icon_id then
            local cfg=Cfgs.character:GetByID(data.icon_id)
            if cfg then
                ResUtil.RoleCard:Load(icon, cfg.icon)
            end
        else
            CSAPI.SetRectSize(icon,0,0,0);
        end
    end
    if otherData then
        CSAPI.SetText(txt_num,otherData.f_num.."/"..FriendMgr:GetMaxCount());
        local desc=LanguageMgr:GetByID(27005);
        if otherData.desc then
            desc=desc..otherData.desc
        else
            desc=desc..LanguageMgr:GetByID(27010)
        end
        CSAPI.SetText(txt_desc,desc);
        --加载支援队员信息
        local typeList = {eCardMainType.QN, eCardMainType.TH, eCardMainType.TT, eCardMainType.TS};
        supportList = supportList or {};
        for i = 1, #typeList do
            local type = typeList[i];
            local card = nil;
            if otherData.team then
                for k, v in ipairs(otherData.team) do
                    -- local c = RoleMgr:GetData(v.cid);
                    local c=CharacterCardsData(v.card_info);
                    if c:GetMainType() == type then
                        card = c;
                        break;
                    end
                end
            end
            if(supportList[type]) then
                supportList[type].Refresh({cardData = card, type = type})
            else		
                ResUtil:CreateUIGOAsync("Guild/GuildSupportItem", supportNode, function(go)
                    CSAPI.SetScale(go,0.6, 0.6, 0.6)
                    supportItem = ComUtil.GetLuaTable(go)
                    local type = typeList[i];	
                    supportItem.Refresh({cardData = card, type = type})
                    supportItem.SetClickCB(OnClickSupport);
                    supportList[type] = supportItem;
                end)
            end
        end
    end
end

--任命副会长
function OnClickSub()
    local dialogdata = {};
    local content = string.format(LanguageMgr:GetByID(17003), data.name);
    dialogdata.content = content;
    dialogdata.okCallBack = function()
       GuildProto:SetSubBoss(data.uid);
    end
    CSAPI.OpenView("Dialog", dialogdata)
end

--取消副会长
function OnClickUnSub()
    local dialogdata = {};
    local content = string.format(LanguageMgr:GetByID(17004), data.name);
    dialogdata.content = content;
    dialogdata.okCallBack = function()
        GuildProto:UnSetSubBoss(data.uid);
    end
    CSAPI.OpenView("Dialog", dialogdata)
end

--任命会长
function OnClickMaster()
    local dialogdata = {};
    local content = string.format(LanguageMgr:GetByID(17005), data.name);
    dialogdata.content = content;
    dialogdata.okCallBack = function()
       GuildProto:SetBoss(data.uid);
    end
    CSAPI.OpenView("Dialog", dialogdata)
end

--添加好友
function OnClickApply()
    local info=FriendMgr:GetData(data.uid);
    if info and info:IsFriend() then
        Tips.ShowTips(LanguageMgr:GetTips(17007));
    elseif FriendMgr:CanAdd() then
        local test = string.format(LanguageMgr:GetTips(17008), PlayerClient:GetName())
		local datas = {{uid = data.uid, state = eFriendState.Apply, apply_msg = test}}
        FriendMgr:Op(datas)
    else
        Tips.ShowTips(StringTips.friend_tips2);
    end
end

--踢出公会
function OnClickExit()
    local dialogdata = {};
    local content = string.format(LanguageMgr:GetTips(17006), data.name);
    dialogdata.content = content;
    dialogdata.okCallBack = function()
       GuildProto:DelMem(data.uid);
       Close();
    end
    CSAPI.OpenView("Dialog", dialogdata)
end

function Close()
    view:Close();
end

function OnClickAnyway()
    Close();
end

function OnTeamInfo(eventData)
    supportData=eventData;
    if cb then
        cb();
    end
end

function OnClickSupport(id)
    if supportData==nil or (supportData and supportData.uid~=data.uid) then
        GuildProto:LookTeam(data.uid);
        cb=function()
            Log( id);
            OnClickSupport(id)
        end;
        return
    end
    if id then
        for k,v in ipairs(supportData.team) do
            if v.cid==id then
                local cardData=CharacterCardsData(v)
                --CSAPI.OpenView("RoleInfo", cardData,RoleInfoOpenType.LookOther)
                CSAPI.OpenView("RoleInfo", cardData)
            end
        end
    end
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
root=nil;
icon=nil;
txt_name=nil;
txt_lv=nil;
txt_type=nil;
txt_num=nil;
txt_desc=nil;
txt_support=nil;
supportNode=nil;
btnSub=nil;
btnUnSub=nil;
btnMaster=nil;
btnApply=nil;
btnExit=nil;
view=nil;
end
----#End#----