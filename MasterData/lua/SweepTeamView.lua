--扫荡编队
local data = nil
local teamItems = {}
local startTeamIdx=0; --起始队伍下标
local endTeamIdx=0; --结束队伍下标
local localCfg=nil;--本地保存信息
local teamMax=1;
local choosieID={};--当前选择的队伍id
local count=0;--当前可用队伍数量
local downListView = nil

function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Team_Confirm_Refreh, RefreshItems)
    eventMgr:AddListener(EventType.Team_Confirm_ItemDisable, OnOptionChange)
    eventMgr:AddListener(EventType.Team_Card_Refresh, RefreshTeams); 
    -- eventMgr:AddListener(EventType.Team_Data_Update, RefreshItems)
end

function Refresh(_data)
    data = _data
    if data then
        TeamMgr:ClearAssistTeamIndex();

        startTeamIdx = 1;
        endTeamIdx = g_TeamMaxNum;  

        LoadConfig()
        InitChoosieIDs();--初始化已选择的队伍id
        InitOptions();
        InitItem();
        -- EventMgr.Dispatch(EventType.Guide_Trigger_View,data);--尝试触发引导
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function InitChoosieIDs()
    local choosieCount=0;
    local otherID={};--未选中的可用队伍id
    --查找当前可用的队伍中是否有对应的id
    for i = startTeamIdx, endTeamIdx do
        local team=TeamMgr:GetTeamData(i);
        if team and team:GetCount()>0 and team:HasLeader() then
            if  localCfg~=nil then
                local hasID=false;
                local idx=0;
                for k,v in ipairs(localCfg) do
                    if v.order==-1 then --置空
                        hasID=true;
                        choosieID[v.index]={index=v.index,teamId=v.order};
                        choosieCount=choosieCount+1;
                        idx=k;
                        break;
                    elseif i==v.order then                 
                        hasID=true;
                        --可以选中的队伍
                        choosieID[v.index]={index=v.index,teamId=i};--index:子物体的下标，teamId:队伍id
                        choosieCount=choosieCount+1;
                        idx=k;
                        break;
                    end
                end
                if hasID==false then
                    table.insert(otherID,i);
                else
                    table.remove(localCfg,idx);
                end
            else
                table.insert(otherID,i);
            end
        end
    end
    if choosieCount<teamMax and otherID~=nil and #otherID>0 then
        local otherIndex=1;
        for i=1,teamMax  do
            if choosieCount>0 then
                for k,v in pairs(choosieID) do
                    if i~=v.index then
                        choosieID[i]={index=i,teamId=otherID[otherIndex]};
                        otherIndex=otherIndex+1;
                        choosieCount=choosieCount+1;
                    end
                end
            else
                choosieID[i]={index=i,teamId=otherID[otherIndex]};
                otherIndex=otherIndex+1;
                choosieCount=choosieCount+1;
            end
            if choosieCount==teamMax then
                break;
            end
        end
    end
    count=choosieCount;
end

function InitItem()
    local list={};
    for i=1,1 do
        local state=TeamConfirmItemState.Normal;
        -- if openSetting==TeamConfirmOpenType.Matrix then
            state=TeamConfirmItemState.UnAssist;
        -- end
        if i>teamMax then
            state=TeamConfirmItemState.Disable;
        end
        table.insert(list,{id=i,num=i,options=optionsData,showClean=teamMax>1,forceNPC=nil,NPCList=nil,state=state,ShowDownList=ShowDownList});
    end
    ItemUtil.AddItems("Sweep/SweepTeamList", teamItems, list, itemNode, nil, 1, nil)
end

--刷新下拉面板
function ShowDownList(pos,itemID,func,func2)
    if downListView==nil then
        local go=ResUtil:CreateUIGO("TeamConfirm/TeamDownListView",gameObject.transform);
        downListView=ComUtil.GetLuaTable(go);
    end
    
    downListView.Show(pos,optionsData,itemID);
    downListView.AddOnValueChange(OnDownValChange);
    downListView.AddOnClose(func2);
end

function OnDownValChange(options)
    for k,v in pairs(options) do
        if teamItems[v.itemID] then
            teamItems[v.itemID].OnDropValChange(v);
            choosieID[v.itemID]={index=v.itemID,teamId=v.id};
        end
    end
end

function InitOptions()
    optionsData = {};
    local sNum=0;--选中的id数
    for i = startTeamIdx, endTeamIdx do
        local team=TeamMgr:GetTeamData(i);
        if team  then
            local option={};
            if sNum<count then
                for k,v in pairs(choosieID) do
                    if i==v.teamId then
                        option.isSelect=true;
                        option.itemID=v.index; --子物体id
                        sNum=sNum+1;
                        break;
                    end
                end   
            end
            option.desc=i<10 and "0".. i or i; --选项描述
            option.name=team:GetTeamName();
            option.id=i; --队伍id
            -- option.index=#optionsData+1;--选项下标
            if team:GetCount()>0 and team:HasLeader() then
                option.enable=true;
                table.insert(optionsData, option);
            -- else
            --     option.enable=false;
            end
        end
    end
end

function RefreshItems()
    RefreshChoosieIDs();
    InitOptions()
    local list={};
    for k,v in ipairs(teamItems) do
        local state=TeamConfirmItemState.Normal;
        -- if openSetting==TeamConfirmOpenType.Matrix or isNotAssist then
            state=TeamConfirmItemState.UnAssist;
        -- end
        if k>teamMax then
            state=TeamConfirmItemState.Disable;
        end
        local npc=k==1 and forceNPC or nil
        table.insert(list,{id=k,num=k,options=optionsData,forceNPC=mil,NPCList=nil,showClean=teamMax>1,currState=v.GetState(),state=state,ShowDownList=ShowDownList});
    end
    ItemUtil.AddItems("Sweep/SweepTeamList", teamItems, list, itemNode, nil, 1, nil)
end

function RefreshChoosieIDs() --当编队消失时查找下一支符合编队条件的队伍
    local choosieCount=0;
    local otherID={};--未选中的可用队伍id
    local choosieIndex=0;
    --查找当前可用的队伍中是否有对应的id
    for i = startTeamIdx, endTeamIdx do
        local team=TeamMgr:GetTeamData(i);
        local hasID=false;
        if choosieID then
            for k,v in pairs(choosieID) do
                if v.teamId==i and team and team:GetCount()>0 and team:HasLeader() then --置空
                    hasID=true;
                    choosieCount=choosieCount+1;
                    choosieIndex=v.index;
                    break;
                elseif v.teamId==-1 then                 
                    hasID=true;
                    choosieID[v.index]={index=tonumber(v.index),teamId=i};--index:子物体的下标，teamId:队伍id
                    choosieCount=choosieCount+1;
                    break;
                end
            end
        end
        if hasID==false and team and team:GetCount()>0 and team:HasLeader() then
            table.insert(otherID,i);
        end
    end
    if choosieCount<teamMax and otherID~=nil and #otherID>0 then
        local otherIndex=1;
        for i=1,teamMax  do
            if choosieCount>0 then
                for k,v in pairs(choosieID) do
                    if choosieIndex~=v.index then
                        choosieID[v.index]={index=v.index,teamId=otherID[otherIndex]};
                        otherIndex=otherIndex+1;
                        choosieCount=choosieCount+1;
                    end
                end
            else
                choosieID[i]={index=i,teamId=otherID[otherIndex]};
                otherIndex=otherIndex+1;
                choosieCount=choosieCount+1;
            end
            if choosieCount==teamMax then
                break;
            end
        end
    end
    count=choosieCount;
end

function RefreshTeams()
    for k,v in ipairs(teamItems) do
        v.SetTeamData(v.GetTeamIndex());
    end
end

--本地保存当前选择的队伍id
function SaveConfig(tab)
    if tab then
        FileUtil.SaveToFile("config_sweep_"..data.id..".txt",tab);
    end
end

--读取当前选择的队伍id
function LoadConfig()
    localCfg=FileUtil.LoadByPath("config_sweep_"..data.id..".txt");
end

function OnOptionChange(eventData)
    for k,v in ipairs(optionsData) do
        if v.itemID==eventData then
            v.itemID=nil;
            v.isSelect=false;
            break;
        end
    end
end

function GetListItem()
    for k,v in ipairs(teamItems) do
        return v
    end
end

