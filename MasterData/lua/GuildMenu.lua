--公会菜单
function Awake()
    UIUtil:AddTop2("GuildMenu", gameObject, OnClickReturn)
    --UIUtil:AddTop(gameObject, OnClickReturn)
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Guild_ApplyRet_Notice, OnJoinNotice);
end

function OnDestroy()
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end


function OnOpen()
    if GuildMgr:CanJoinGuild()~=true then
        CSAPI.OpenView("GuildMain");
        view:Close();
	end
end

function OnClickCreate()
    CSAPI.OpenView("GuildCreate");
end

function OnClickJoin()
    CSAPI.OpenView("GuildSearch");
end

function OnClickReturn()
    view:Close();
end

function OnJoinNotice()
    CSAPI.CloseAllOpenned()
    --刷新界面，进入主界面
    JumpMgr:Jump(170001);
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
bg=nil;
root=nil;
view=nil;
end
----#End#----