--弱引导界面

function Awake()
    SetHint();

    AddListener();
end

function AddListener()
    EventMgr.AddListener(EventType.Guide_Hint,OnShowHint);
    EventMgr.AddListener(EventType.View_Lua_Opened,OnViewOpened);
end

function OnViewOpened(viewKey)
    --OnShowHint();   
    --LogError(viewKey);

    if(not homeNodeData)then       
        local x,y,z = CSAPI.GetPos(homeBtnNode);
        homeNodeData = {x=x,y=y + 3,z=z};
    end

    homeNodeData.time = nil;

    if(not hintViews)then
        hintViews = {};
         
        hintViews.CoolView = 1;--冷却
        hintViews.SettingView = 1;--设置
        --hintViews.SignInView = 1;--签到
        hintViews.ArchiveView = 1;--图鉴
        hintViews.TeamView = 1;--编队
        hintViews.ShopView = 1;--商店
        hintViews.RoleListNormal = 1;--角色
        hintViews.MissionView = 1;--任务
        hintViews.CreateView = 1;--抽卡
        hintViews.GuildMenu = 1;--公会
        hintViews.Matrix = 1;--基地
        hintViews.Bag = 1;--背包
--        hintViews.Section = 1;--章节
--        hintViews.Dungeon = 1;--副本
        hintViews.GuildMenu = 1;--公会        
    end

    OnShowHint(hintViews[viewKey] and homeNodeData);
end

function OnShowHint(data)   
    SetHint();--先清空

    showData = data;    
    if(not data)then
        SetHint(data)
        return;
    end
    if(not CheckLv())then        
        return;
    end
    if(not data.time)then
        data.time = (g_Guide_Hint_Time or 10) + CSAPI.GetTime();
    end
    --data.time = 2 + CSAPI.GetTime()
    if(data.time == 0)then
        SetHint(data);
        return;
    end

    if(isCalling)then
        return;
    end
    isCalling = 1;
    FuncUtil:Call(ShowHint,nil,2000);
end

function ShowHint()
    isCalling = nil;

    if(not showData)then
        return;      
    end

    local time = CSAPI.GetTime();

    if(time < showData.time)then
        OnShowHint(showData);
        return;
    end
    
    SetHint(showData);
end

function SetHint(data)
    local hasGuide = CSAPI.IsViewOpen("Guide");  

    CSAPI.SetGOActive(node,data and (not hasGuide) and true or false);
    if(data)then
        if(data.ui_pos)then
            CSAPI.SetAnchor(node,data.x,data.y,data.z);
        else
            CSAPI.SetPos(node,data.x,data.y,data.z);
        end
    end    

    showData = nil;
end

function CheckLv()
    return PlayerClient:GetLv() < (g_Guide_Hint_Close_Lv or 100);
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
node=nil;
homeBtnNode=nil;
view=nil;
end
----#End#----