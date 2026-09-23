local teamInfo = nil
local items = nil
local tacItem = nil
local isNotClick = false
local teamData = nil
local tacticsData = nil
local cfgRankTeam = nil
local buffItems = nil
local isBuffDescShow = false

local isGlobalBoss = false

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Opened,OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClosed)
    eventMgr:AddListener(EventType.Team_Data_Update,OnTeamUpdate)

    CSAPI.SetGOActive(buffObj,false)
end

function OnViewOpened(viewKey)
    if viewKey == "RoleInfo"  then
        CSAPI.SetGOActive(node,false)
    end
end

function OnViewClosed(viewKey)
    if viewKey == "RoleInfo"  then
        CSAPI.SetGOActive(node,true)
    end
end

function OnTeamUpdate()
    EventMgr.Dispatch(EventType.Net_Msg_Getted,"copy_rank_team")
    LanguageMgr:ShowTips(24011)
    view:Close()
end

function OnDestroy()
    eventMgr:ClearListener()
    TeamMgr:DelEditTeam()
end

function OnOpen()
    teamInfo = data.data and data.data[1]
    isGlobalBoss = openSetting and openSetting.isGlobalBoss
    cfgRankTeam = Cfgs.CfgRankTeam:GetByID(data.rankType)
    if teamInfo then
        SetTitle()
        SetCP()
        SetTactics()
        SetItems()
        SetButton()
    end
    SetBuffs()
end

function SetTitle()
    LanguageMgr:SetText(txtTitle,22064, data.name)
end

function SetCP()
    local performance = teamInfo.performance or 0
    CSAPI.SetText(txtCP, performance .. "")
end

function SetTactics()
    if cfgRankTeam and cfgRankTeam.isHideTactics then
        CSAPI.SetGOActive(tacticsObj,false)
        return
    end
    if teamInfo.skill_group_id and teamInfo.skill_group_id > 0 then
        tacticsData = TacticsData.New();
        tacticsData:InitCfg(teamInfo.skill_group_id);
        tacticsData.data = {lv = teamInfo.skill_group_lv}
    end
    if tacItem == nil then
        ResUtil:CreateUIGOAsync("Rank/RankTeamItem",tacticsObj,function (go)
            local lua = ComUtil.GetLuaTable(go)
            lua.SetAssist()
            lua.Refresh(tacticsData,{isTactics = true})
            tacItem = lua
        end)
    else
        tacItem.SetAssist()
        tacItem.Refresh(tacticsData,{isTactics = true})
    end
end

function SetItems()
    if items == nil then
        items = {}
        local len = (cfgRankTeam and cfgRankTeam.supportShow) and 5 or 6
        for i = 1, len do
            ResUtil:CreateUIGOAsync("Rank/RankTeamItem",teamGrid,function (go)
                local lua = ComUtil.GetLuaTable(go)
                lua.SetIndex(i)
                lua.SetAssist()
                lua.SetEmpty(true)
                items[i] = lua
                if i == len then
                    ShowItems()
                end
            end)
        end
    else
        for i, v in ipairs(items) do
            v.SetIndex(i)
            v.SetAssist()
            v.SetEmpty(true)
        end
        ShowItems()
    end    
end

function ShowItems()
    local teamItemInfos = teamInfo.data
    if teamItemInfos and #teamItemInfos> 0 then
        for i, v in ipairs(teamItemInfos) do
            items[v.index].Refresh(v)
        end
    end
end

function SetButton()
    local info = RankMgr:GetMyRank(data.rankType)
    if isGlobalBoss then
        info = GlobalBossMgr:GetMyRank()
    end
    local rank = info:GetRank()
    if rank == data.rankIdx then
        CSAPI.SetGOAlpha(btn_replace,0.5)
        isNotClick = true
    end
    if cfgRankTeam and cfgRankTeam.isClose then
        CSAPI.SetGOAlpha(btn_replace,0.5)
        isNotClick = true
    end
    if not teamInfo.data or #teamInfo.data < 1 then
        CSAPI.SetGOAlpha(btn_replace,0.5)
        isNotClick = true
    end
end

function SetBuffs()
    CSAPI.SetGOActive(buffObj,cfgRankTeam and cfgRankTeam.isBuffOpen ~= nil)
    if cfgRankTeam and cfgRankTeam.isBuffOpen ~= nil then
        CSAPI.SetRTSize(bg,1627,717)
        CSAPI.SetGOActive(buffClickMask,false)
        CSAPI.SetGOActive(buffDescObj,false)
        if data.buffIds then
            buffItems = buffItems or {}
            ItemUtil.AddItems("Rank/RankTeamBuffItem",buffItems,data.buffIds,buffParent,OnBuffItemClickCB)
        end
    end
end

function OnBuffItemClickCB(item)
    isBuffDescShow = true
    ShowBuffDesc(item.GetDesc())
end

function ShowBuffDesc(str)
    CSAPI.SetGOActive(buffDescObj,isBuffDescShow)
    CSAPI.SetGOActive(buffClickMask,isBuffDescShow)
    if isBuffDescShow then
        CSAPI.SetText(txtBuffdesc,str or "")
    end
end

function OnClickReplace()
    if not isNotClick and teamInfo then
        local isSatisfy,needCards,needTactics,isNotReplace = CheckSatisfy()
        if isSatisfy then
            local dialogData= {}
            dialogData.content = (cfgRankTeam and cfgRankTeam.isHideTactics) and LanguageMgr:GetTips(24016) or LanguageMgr:GetTips(24010)
            dialogData.okCallBack = OnTeamReplace
            CSAPI.OpenView("Dialog",dialogData)
        elseif isNotReplace then --没有可替换的
            LanguageMgr:ShowTips(24014)
            OnClickClose()
        else
            CSAPI.OpenView("RankTeamReplace",{needCards,needTactics,OnTeamReplace})
        end
    end
end

function CheckSatisfy()
    local teams,tactics = {},nil
    local teamItemInfos = teamInfo.data
    local teamCount = 0
    if teamItemInfos and #teamItemInfos> 0 then
        for i, v in ipairs(teamItemInfos) do
            if v.index ~= 6 and not RoleMgr:IsLeader(v.card_info.cfgid) and not RoleMgr:IsExtraLeader(v.card_info.cfgid) then
                local card = CharacterCardsData(v.card_info)
                local _card = RoleMgr:GetDataByCfgID(card:GetCfgID())
                if _card == nil then
                    table.insert(teams,v)
                end
                teamCount = teamCount + 1
            end
        end
    end

    local tacData = TacticsMgr:GetDataByID(teamInfo.skill_group_id)
    if not (tacData and tacData:IsUnLock() and tacticsData and tacData:GetLv() >= tacticsData:GetLv()) then
        tactics = tacticsData
    end
    return #teams < 1 and tactics ==nil,teams,tactics,#teams == teamCount
end

function OnTeamReplace()
    EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="copy_rank_team",time=1000,
    timeOutCallBack=function()
        LanguageMgr:ShowTips(24012)
        view:Close()
        local viewGO = CSAPI.GetView("RankTeamReplace",nil,{isHideTactics = cfgRankTeam and cfgRankTeam.isHideTactics})
        if viewGO ~= nil then
            local lua = ComUtil.GetLuaTable(viewGO)
            lua.OnClickClose()
        end
    end})
    SetReplaceTeamData()
    TeamMgr:SaveEditTeam()
end

function SetReplaceTeamData()
    local teamType=TeamMgr:GetTeamType(teamInfo.index);
    local editTeamData = TeamMgr:GetEditTeam(teamType)
    editTeamData:ClearCard()
    teamInfo.index = teamType
    TeamMgr.currentIndex = teamType
    if teamInfo.data and #teamInfo.data > 0 then
        local teamDatas = {}
        for i, v in ipairs(teamInfo.data) do
            if RoleMgr:IsLeader(v.card_info.cfgid) then --总队长特殊处理
                local myLeaderCard = RoleMgr:GetLeader2()
                v.cid = myLeaderCard:GetID()
                v.card_info = nil --剔除卡牌信息
                table.insert(teamDatas,v)
            elseif RoleMgr:IsExtraLeader(v.card_info.cfgid) then
                local myLeaderCard = RoleMgr:GetExtraLeader()
                v.cid = myLeaderCard:GetID()
                v.card_info = nil --剔除卡牌信息
                table.insert(teamDatas,v)
            else
                local _card = RoleMgr:GetData(v.card_info.cfgid)
                if _card ~= nil then --不存则直接剔除数据
                    v.card_info = nil --剔除卡牌信息
                    table.insert(teamDatas,v)
                end
            end
        end
        teamInfo.data = teamDatas
    end
    local _data = TacticsMgr:GetDataByID(teamInfo.skill_group_id)
    if _data == nil then
        teamInfo.skill_group_id = 0
    elseif _data:GetLv() < teamInfo.skill_group_lv then
        teamInfo.skill_group_id = _data:GetCfgID()
    end
    editTeamData:SetData(teamInfo)
end

function OnClickClose()
    if isBuffDescShow then
        isBuffDescShow = false
        ShowBuffDesc()
        return
    end
    view:Close()
end