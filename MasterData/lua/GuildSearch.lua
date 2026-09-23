--公会搜索界面
local searchItems={};
local fInpID=nil;
local isList=false;
local recomentList={};
function Awake()
    UIUtil:AddTop2("GuildSearch", gameObject, OnClickReturn)
    --UIUtil:AddTop(gameObject, OnClickReturn)
    fInpID=ComUtil.GetCom(inpID,"InputField");
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Guild_Recoment_Update, OnRecomentUpdate);
    eventMgr:AddListener(EventType.Guild_Apply_Cancel, Refresh);
    eventMgr:AddListener(EventType.Guild_ApplyLog_Update, Refresh);
end

function OnDestroy()
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end

function OnOpen()
    --获取系统推荐的公会信息
    GuildProto:LookPlrApplyLog();
    GuildProto:Recoment();
end

function Refresh()
    if isList==false then
        ShowSearchInfo(recomentList)
    else
        ShowSearchInfo(GuildMgr:GetMineApplyLog())
    end
end

function OnRecomentUpdate(data)
    if data then
        recomentList=data.list;
        ShowSearchInfo(recomentList)
        -- if data.isRecoment then
        --     recomentList=data.list;
        --     ShowSearchInfo(recomentList)
        -- else
        --     ShowSearchInfo(data)
        -- end
    end
end

--显示公会列表
function ShowSearchInfo(data)
    for k,v in ipairs(searchItems) do
        CSAPI.SetGOActive(v.gameObject,false);
    end
    if data then
        table.sort(data,function(a,b)
            if a.apply_lv==b.apply_lv then
                return a.id>b.id;
            else
                return a.apply_lv>b.apply_lv;
            end
        end);
        for k,v in ipairs(data) do
            if k<=#searchItems then
                searchItems[k].Refresh(v,{isList=isList});
                CSAPI.SetGOActive(searchItems[k].gameObject,true);
            else
                ResUtil:CreateUIGOAsync("Guild/GuildSearchItem",Content,function(go)
                    local tab=ComUtil.GetLuaTable(go)
                    tab.Refresh(v,{isList=isList});
                    table.insert(searchItems,tab);
                end)
            end
        end
    end
end

--点击搜索
function OnClickSearch()
    --获取搜索到的公会信息并显示
    local id=fInpID.text;
    if id~=nil and id~="" then
        GuildProto:Search(tonumber(id));
    end
end

--点击申请列表
function OnClickList()
    isList=not isList;
    CSAPI.SetText(txt_list,isList and LanguageMgr:GetByID(27011) or LanguageMgr:GetByID(27012));
    CSAPI.SetGOActive(inpID,not isList);
    CSAPI.SetGOActive(btn_search,not isList);
    CSAPI.SetGOActive(btn_refresh,not isList);
    --显示自己的申请记录
    if isList==true then
        ShowSearchInfo(GuildMgr:GetMineApplyLog());
    else
        ShowSearchInfo(recomentList);
    end
end

function OnClickCreate()
    CSAPI.OpenView("GuildCreate",nil,nil,function()
        Close();
    end);
end

function OnClickReturn()
    Close();
end

function Close()
    view:Close();
end

function OnClickRefresh()
    if GuildMgr:GetRecomentTime()==nil or (CSAPI.GetServerTime()-GuildMgr:GetRecomentTime()>=g_GuildRecomentFlushDiff) then
        GuildProto:Recoment(true);
    else
        Tips.ShowTips(LanguageMgr:GetTips(17009));
    end
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
root=nil;
searchObj=nil;
inpID=nil;
btn_search=nil;
txt_list=nil;
btn_refresh=nil;
sv=nil;
Content=nil;
view=nil;
end
----#End#----