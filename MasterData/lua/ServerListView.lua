--服务器列表

function Awake()
    topItems={} --推荐的item组
    normalItems={} --普通的服务器item组
end

function OnEnable()
    InitView();
end

function InitView()
    for k,v in ipairs(topItems) do
        CSAPI.SetGOActive(v.gameObject,false);
    end
    for k,v in ipairs(normalItems) do
        CSAPI.SetGOActive(v.gameObject,false);
    end
    LoadInfo();
end

function LoadInfo()
    if (serverInfo==nil) then
        local dialogdata={};
        dialogdata.content=LanguageMgr:GetTips(9009)
        dialogdata.okCallBack = function()
            InitServerInfo(function()
                LoadInfo();
            end);
        end
        CSAPI.OpenView("Dialog", dialogdata)
    else
        ShowContent();
    end
end

function ShowContent()
    local lastServerInfo=GetLastServerInfo();
    local commend=GetCommendServerInfo();
    if (lastServerInfo==nil) then
        lastServerInfo={
                id=-1,
                state=-1,
                serverName="无",
                isNew=false,
                hasRole=false,
                serverId=nil,
                port=nil,
        }
    end
    CSAPI.SetGOActive(otherGrid,false);
    InitItem(serverInfo,normalItems,Content);
end

function InitItem(infos,itemList,parentObj)
    if infos then
        for i=1,#infos do
            local item=nil;
            if  i>#itemList then
                local go=ResUtil:CreateUIGO("Login/ServerItem",parentObj.transform);
                item= ComUtil.GetLuaTable(go);
                -- CSAPI.SetScale(go,0.75,0.75,0.75);
                table.insert(itemList,item);
            else
                item=itemList[i];
                CSAPI.SetGOActive(item.gameObject,true);
            end
            item.Init(infos[i]);
        end
    else
        LogError("没有获取到服务器信息！！");
    end
end

--点击最近登录的服
function OnClickLastServer()
    local lastServer=GetLastServerInfo();
    if (lastServer==nil)  then
        return;
    end
    PostEvent(lastServer);
end

--点击推荐服
function OnClickCommendServer()
    local commend=GetCommendServerInfo();
    if (commend==nil)  then
        return;
    end
    PostEvent(commend);
end

--抛出选择服务器事件
function PostEvent(data)
    EventMgr.Dispatch(EventType.Login_Select_Server,data);
end

--点击空白处
function OnClickAnyway()
    local lastServer=GetLastServerInfo();
    if (lastServer==nil)  then
        lastServer=GetCurrentServer();
    end
    PostEvent(lastServer);
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
ServiceListObj=nil;
ServerScrollView=nil;
Content=nil;
otherGrid=nil;
childGrid=nil;
view=nil;
end
----#End#----