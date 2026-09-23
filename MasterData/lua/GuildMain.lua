--公会主界面
local title=nil;--当前的权限
local rightView=nil;
local rightList={};
function Awake()
    UIUtil:AddTop2("GuildMain", gameObject, OnClickReturn)
    --UIUtil:AddTop(gameObject, OnClickReturn)
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Guild_Info_Refresh, OnInfoRefresh);
    eventMgr:AddListener(EventType.Guild_GuildMem_Change, OnMemChange);
    eventMgr:AddListener(EventType.Guild_MemTitle_Change,OnTitleChange);
end

function OnDestroy()
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end

function OnOpen()
    Refresh()
end

function Refresh()
    ShowLeftView();
    title=GuildMgr:GetTitle();
    if title==GuildMemberType.Normal then
        --普通会员只有公会商店和成员情报按钮
        CSAPI.SetGOActive(btn_request,false);
        CSAPI.SetGOActive(btn_setting,false);
    end
end

--显示左边的信息
function ShowLeftView()
    local data=GuildMgr:GetGuildInfo();
    if data then
        CSAPI.SetText(txt_guildName,tostring(data.name));
        local type=data.activity_type==GuildActivityType.Active and LanguageMgr:GetByID(27003) or LanguageMgr:GetByID(27004)
        CSAPI.SetText(txt_guildType,type);
        CSAPI.SetText(txt_master,data.n_name);
        CSAPI.SetText(txt_guildID,tostring(data.id));
        CSAPI.SetText(txt_num,data.mem_cnt.."/"..g_GuildMaxMenCnt);
        CSAPI.SetText(txt_rank,tostring(data.rank or 0));
        CSAPI.SetText(txt_desc,data.desc or "");
    end
end

--显示右边的界面
function ShowRightView(data)
    if rightView then
        CSAPI.SetGOActive(rightView.gameObject,false);
    end
    if data then
        if rightList[data.view]==nil then
            local go=ResUtil:CreateUIGO("Guild/"..data.view,rightObj.transform);
            rightView=ComUtil.GetLuaTable(go);
            rightList[data.view]=tab;
        else
            CSAPI.SetGOActive(rightList[data.view].gameObject,true);
            rightView=rightList[data.view];
        end
        rightView.Refresh();
    end
end

function OnInfoRefresh(eventData)
    Refresh()
end

function OnMemChange(eventData)
    if eventData.isRemove and eventData.uid~=PlayerClient:GetUid() then
        Refresh()
    elseif eventData.isRemove and eventData.uid==PlayerClient:GetUid() then
        CSAPI.CloseAllOpenned();
    end
end

--职位变更
function OnTitleChange()
    title=GuildMgr:GetTitle();
    if title==GuildMemberType.Normal then
        --普通会员只有公会商店和成员情报按钮
        CSAPI.SetGOActive(btn_request,false);
        CSAPI.SetGOActive(btn_setting,false);
    else
        CSAPI.SetGOActive(btn_request,true);
        CSAPI.SetGOActive(btn_setting,true);
    end
    ShowLeftView();
end

function OnClickStore()

end

function OnClickMember()
    ShowRightView({view="GuildMem"});
end

function OnClickRequest()
    ShowRightView({view="GuildApply"});
end

function OnClickSetting()
    CSAPI.OpenView("GuildSetting");
end

function OnClickReturn()
    Close()
end

function Close()
    view:Close();
end

--公会战
function OnClickFight()
    GuildProto:GFinfo(function()
        local cfg=GuildFightMgr:GetGroupCfg(1,1);
        GuildFightMgr:EnterGFMain();
    end);
end

function OnClickFight2()
    Tips.ShowTips("功能开发中...")
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
root=nil;
txt_guildName=nil;
txt_guildType=nil;
txt_master=nil;
txt_guildID=nil;
txt_num=nil;
txt_rank=nil;
txt_desc=nil;
rightObj=nil;
btns=nil;
btn_store=nil;
btn_member=nil;
btn_request=nil;
btn_setting=nil;
btnFight=nil;
btnFight2=nil;
view=nil;
end
----#End#----