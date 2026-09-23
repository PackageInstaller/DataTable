--公会会员面板
local sortType=1; --升序
local memItems={};

function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Guild_GuildMem_Update, OnInfoUpdate);
    eventMgr:AddListener(EventType.Guild_MemTitle_Change, OnTitleChange);
    eventMgr:AddListener(EventType.Guild_GuildMem_Change, OnMemChange);
end

function OnDestroy()
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end

--队员列表变更
function OnMemChange(eventData)
    if eventData and eventData.isRemove and data then
        --有成员离开，直接删除该数据刷新面板
        for k,v in ipairs(data) do
            if v.uid==eventData.uid then
                table.remove(data,k);
                break
            end
        end
        Init();
    else--有新成员进来，请求数据列表
        Refresh();
    end
end

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

--权限变更
function OnTitleChange(eventData)
    if data and eventData then
        for k,v in ipairs(eventData) do
            for key,val in ipairs(data) do
                if v.uid==val.uid then
                    val.title=v.title==nil and val.title or v.title;
                end
            end
        end
    end
    Init();
end

function Refresh()
    GuildProto:MemberList();
end

function Init()
    CSAPI.SetText(txt_sort,sortType==1 and LanguageMgr:GetByID(27001) or LanguageMgr:GetByID(27000));
    if  GuildMgr:GetTitle()==GuildMemberType.Boss then--会长无法退出公会
        CSAPI.SetGOActive(btn_exit,false);
    else
        CSAPI.SetGOActive(btn_exit,true);
    end
    local num=1;
    if memItems then
        for k,v in ipairs(memItems) do
            CSAPI.SetGOActive(v.gameObject,false)
        end
    end
    if data then
        table.sort( data, function(a,b)
            if a.title==b.title then
                if a.pre_online==b.pre_online then
                    return a.uid>b.uid;
                else
                    return a.pre_online<b.pre_online
                end
            else
                return a.title<b.title;
            end
        end )
        local list=data
        if sortType~=1 then
            list={};
            for i=#data,1,-1 do
                table.insert(list,data[i]);
            end
        end
        for k,v in ipairs(list) do
            if num<=#memItems then
                memItems[num].Refresh(v);
                CSAPI.SetGOActive(memItems[num].gameObject,true);
            else
                ResUtil:CreateUIGOAsync("Guild/GuildMemItem",Content,function(go)
                    local tab=ComUtil.GetLuaTable(go)
                    tab.Refresh(v);
                    table.insert(memItems,tab);
                end)
            end
            num=num+1;
        end
    end
end

function OnClickSort()
    sortType=sortType==1 and 2 or 1;
    Init();
end

--退出公会
function OnClickExit()
    local dialogdata = {};
    dialogdata.content = LanguageMgr:GetTips(17002);
    dialogdata.okCallBack = function()
        GuildProto:Quit()
    end
    CSAPI.OpenView("Dialog", dialogdata)
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
btn_exit=nil;
view=nil;
end
----#End#----