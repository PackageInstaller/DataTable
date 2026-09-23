--战场列表
local listType=1;--战场列表类型
local layout=nil;
local eventMgr=nil;
local protoInfo={};
local lastY=0;
local disResetPos=false;
local scorll=nil;
function Awake()
    scroll=ComUtil.GetCom(sv,"ScrollRect");
    layout = ComUtil.GetCom(sv, "UICircularScrollView")
    layout:Init(LayoutCallBack)
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Guild_LogInfo_Ret,SetData);
end

function OnDestroy()
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end

function OnOpen()
    listType=openSetting;
    Refresh()
end

function SetData(eventData)
    if eventData then
        if protoInfo[listType]~=nil then
            protoInfo[listType].ix=eventData.ix;
            for k,v in ipairs(eventData.infos) do
                table.insert(protoInfo[listType].infos,v);
            end
        elseif eventData.infos~=nil and next(eventData.infos)~=nil then
            protoInfo[listType]=eventData;
        end
    end
    if protoInfo[listType] and protoInfo[listType].infos and next(protoInfo[listType].infos) then
        curDatas=protoInfo[listType].infos;
    else
        curDatas={};
    end
    layout:IEShowList(#curDatas,nil,disResetPos)
end

function Refresh()
    SetBtnState(listType);
    SendProto();
end

function LayoutCallBack(element)
    local index = tonumber(element.name) + 1
	local _data = curDatas[index]
	ItemUtil.AddCircularItems(element, "GuildFight/GuildBattleResultItem", _data, {listType=listType}, nil, 1)
end

function SetBtnState(type)
    CSAPI.SetGOActive(guildResultSB,type==1);
    CSAPI.SetGOActive(mineResultSB,type~=1);
end

function OnClickTab(go)
    if go==btnMineResult then
        listType=2;
    else
        listType=1;
    end
    disResetPos=false;
    Log(listType);
    Refresh();
end

function OnClickAnyway()
    view:Close();
end

function OnBeginDragXY(x,y)
    lastY=y;
end

function OnEndDragXY(x,y)
    if y>lastY then
        if y-lastY>=200 and scroll.normalizedPosition.y<=0 then
            Log("获取新数据");
            disResetPos=true;
            SendProto();
        end
    else
        if math.abs(y-lastY)>=200 and scroll.normalizedPosition.y>=1  then
            Log("刷新----------");
            protoInfo={};
            Refresh();
        end
    end
    lastY=0;
end

function SendProto()
    local isMax=true;
    local index=-1;
    if protoInfo[listType]~=nil then--判断是否到了最后一页
        if protoInfo[listType].ix>1 then 
            index=protoInfo[listType].ix;
            isMax=false;
        else
            isMax=true;
            index=1;
        end
    else
        isMax=false;
    end
    if isMax==false then
        if listType==1 then --公会记录
            GuildProto:GFGuildFightLog(index);
        elseif listType==2 then  --个人记录
            GuildProto:GFSelfFightLog(index);
        end
    else
        SetData();
    end
    return isMax
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
btnGuildResult=nil;
guildResultSB=nil;
btnMineResult=nil;
mineResultSB=nil;
sv=nil;
view=nil;
end
----#End#----