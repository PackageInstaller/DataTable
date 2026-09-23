--公会战排名界面
local listType=GuildRankType.GuildGobalRank;--排名类型
local protoInfo={};
local layout=nil;
local lastY=0;
local scroll=nil;
local disResetPos=false;
local currItem=nil;--玩家相关的rank列
function Awake()
    UIUtil:AddTop2("GuildRankList", gameObject, OnClickReturn)
    --UIUtil:AddTop(gameObject, OnClickReturn)
    layout = ComUtil.GetCom(sv, "UICircularScrollView")
    layout:Init(LayoutCallBack)
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Guild_RankInfo_Ret,SetData);
    SetBtnState(listType)
    scroll=ComUtil.GetCom(sv,"ScrollRect");
    ResUtil:CreateUIGOAsync("GuildFight/GuildRankItem",currNode,function(go)
        currItem=ComUtil.GetLuaTable(go);
    end)
end

function OnDestroy()
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end

function LayoutCallBack(element)
    local index = tonumber(element.name) + 1
	local _data = curDatas[index]
	ItemUtil.AddCircularItems(element, "GuildFight/GuildRankItem", _data, {type=listType}, nil, 1)
end

function OnOpen()
    Refresh();
end

function Refresh()
    SendProto();
    if currItem then
        local icon;
        local name;
        local rank;
        local score;
        local group
        local guildInfo=GuildMgr:GetGuildInfo();
        if listType==GuildRankType.GuildGobalRank then
            local rankInfo=GuildFightMgr:GetGFRankData()
            icon=rankInfo.icon;
            name=rankInfo.name;
            rank=rankInfo.rank;
            score=rankInfo.score;
            group=rankInfo.group_id
            CSAPI.SetGOActive(currItem.txt_group,true);
        elseif listType==GuildRankType.MemberGobalRank then 
            icon=PlayerClient:GetIconId();
            name=PlayerClient:GetName();
            rank=guildInfo.sum_rank;
            score=guildInfo.today_score;
            CSAPI.SetGOActive(currItem.txt_group,false);
        elseif listType==GuildRankType.MemberGuildRank then
            icon=PlayerClient:GetIconId();
            name=PlayerClient:GetName();
            rank=0;
            score=0;
            CSAPI.SetGOActive(currItemtxt_group,false);
        end
        currItem.SetIcon(icon);
        currItem.SetName(name);
        currItem.SetRank(rank);
        currItem.SetScore(score);
        currItem.SetGroup();
    end
end

--获取到的排名数据
function SetData(eventData)
    if protoInfo[listType]~=nil then
        protoInfo[listType].ix=eventData.ix;
        protoInfo[listType].max_ix=eventData.max_ix;
        for k,v in ipairs(eventData.infos) do
            table.insert(protoInfo[listType].infos,v);
        end
    elseif eventData.infos~=nil and next(eventData.infos)~=nil then
        protoInfo[listType]=eventData;
    end
    if protoInfo[listType] and protoInfo[listType].infos and next(eventData.infos) then
        curDatas=protoInfo[listType].infos;
    else
        curDatas={};
    end
    layout:IEShowList(#curDatas,nil,disResetPos)
end

function OnClickTab(go)
    local type=nil;
    if go==btnGuildRank then
        type=GuildRankType.GuildGobalRank
    elseif go==btnServerRank then 
        type=GuildRankType.MemberGobalRank
    elseif go==btnGuildMineRank then
        type=GuildRankType.MemberGuildRank
    end
    if type~=nil and type~=listType then
        listType=type;
        disResetPos=false;
        SetBtnState(type)
        Refresh();
    end
end

function SetBtnState(type)
    CSAPI.SetGOActive(guildRankSB,type==GuildRankType.GuildGobalRank);
    CSAPI.SetGOActive(serverRankSB,type==GuildRankType.MemberGobalRank );
    CSAPI.SetGOActive(guildMineRankSB,type==GuildRankType.MemberGuildRank);
end

function SendProto()
    local isMax=true;
    local index=1;
    if protoInfo[listType]~=nil then--判断是否到了最后一页
        if protoInfo[listType].ix<=protoInfo[listType].max_ix then --最后一页
            index=protoInfo[listType].ix;
            isMax=false;
        else
            isMax=true;
            index=protoInfo[listType].max_ix;
        end
    else
        isMax=false;
    end
    -- if isMax==false then
    --     SetFakeData(index);
    -- end
    if isMax==false then
        if listType==GuildRankType.GuildGobalRank then
            GuildProto:GFGuildGobalRank(index);
        elseif listType==GuildRankType.MemberGobalRank then 
            GuildProto:GFMemberGobalRank(index);
        elseif listType==GuildRankType.MemberGuildRank then
            GuildProto:GFMemberGuildRank(index);
        end
    end
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

function OnClickReturn()
    view:Close();
end

-- function SetFakeData(index)
--     if protoInfo[listType]==nil then
--         protoInfo[listType]={};
--         protoInfo[listType].ix=index;
--         protoInfo[listType].max_ix=100;
--         protoInfo[listType].infos={};
--     else
--         protoInfo[listType].ix=index;
--     end
--     for i=1,10 do
--         if listType==GuildRankType.GuildGobalRank then
--             local g={};
--             g.id=i*10000000;
--             g.name="测试公会"..#protoInfo[listType].infos;
--             g.icon=3005001;
--             g.activity_type=1;
--             g.apply_lv=1;
--             g.mem_cnt=1;
--             g.rank=#protoInfo[listType].infos+1;
--             g.score=i*100000;
--             g.group_id=i%4+1;
--             table.insert(protoInfo[listType].infos,g);
--         else
--             local g={};
--             g.uid=i*10000000;
--             g.name="测试玩家"..#protoInfo[listType].infos;
--             g.icon_id=7005001;
--             g.rank=#protoInfo[listType].infos+1;
--             g.sum_rank=#protoInfo[listType].infos+1;
--             g.today_score=100000-i*100;
--             g.sum_score=10000000-i*1000;
--             table.insert(protoInfo[listType].infos,g);
--         end
--     end
--     curDatas=protoInfo[listType].infos;
--     layout:IEShowList(#curDatas,nil,disResetPos)
-- end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
btnGuildRank=nil;
guildRankSB=nil;
btnServerRank=nil;
serverRankSB=nil;
btnGuildMineRank=nil;
guildMineRankSB=nil;
sv=nil;
currNode=nil;
view=nil;
end
----#End#----