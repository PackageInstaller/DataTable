--公会申请面板
local sortType=1; --升序
local applyItems={};
local data=nil;
function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Guild_GuildApply_Update, OnInfoUpdate);
    eventMgr:AddListener(EventType.Guild_GuildApply_Return, OnApplyReturn);
    eventMgr:AddListener(EventType.Guild_GuildApply_Add, OnInfoAdd);
end

function OnDestroy()
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end

--显示申请记录
function OnInfoUpdate(eventData)
    local list={};
    if eventData then
        for k,v in pairs(eventData) do
            table.insert(list,v);
        end
    end
   data=list
   Init();
end

function OnInfoAdd()
    Refresh();
end

--申请结果
function OnApplyReturn(eventData)
    if eventData and data then
        for k,v in ipairs(data) do
            if v.uid==eventData.uid then
                table.remove(data,k);
                break;
            end
        end
        if eventData.is_allow then --刷新界面信息
            GuildProto:GuildInfo();
        end

        Init();
    end
end

function Refresh()
    GuildProto:LookGuildApplyLog();
end

function Init()
    local num=1;
    CSAPI.SetText(txt_sort,sortType==1 and LanguageMgr:GetByID(27001) or LanguageMgr:GetByID(27000));
    if applyItems then
        for k,v in ipairs(applyItems) do
            CSAPI.SetGOActive(v.gameObject,false);
        end
    end
    if data then
        table.sort( data, function(a,b)
            if sortType==1 then
                return a.t_apply>b.t_apply;
            else
                return a.t_apply<b.t_apply;
            end
        end )
        for k,v in ipairs(data) do
            if num<=#applyItems then
                applyItems[num].Refresh(v);
                CSAPI.SetGOActive(applyItems[num].gameObject,true);
            else
                ResUtil:CreateUIGOAsync("Guild/GuildApplyItem",Content,function(go)
                    local tab=ComUtil.GetLuaTable(go)
                    tab.Refresh(v);
                    table.insert(applyItems,tab);
                end)
            end
            num=num+1;
        end
    end
end

function OnClickSort()
    sortType=sortType==1 and 2 or 1;
    OnInfoUpdate();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
root=nil;
topObj=nil;
txt_sort=nil;
sv=nil;
Content=nil;
view=nil;
end
----#End#----