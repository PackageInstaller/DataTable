local rankDatas = {}
local isEnd = false -- 已经请求到最大排行榜长度
local getNum = 10 -- 每次请求个数
local curTeamIndex = nil
local curEmptyIndex = nil
-- 
local friendDatas = {}
local timer = 0

function Awake()
    UIUtil:AddTop2("ExerciseRView", gameObject, function()
        view:Close()
    end, nil, {})

    layout = ComUtil.GetCom(vsv1, "UIInfinite")
    layout:Init("UIs/ExerciseR/ExerciseRItem1", LayoutCallBack, true)
    UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    layout2 = ComUtil.GetCom(vsv2, "UIInfinite")
    layout2:Init("UIs/ExerciseR/ExerciseRItem2", LayoutCallBack2, true)
    UIInfiniteUtil:AddUIInfiniteAnim(layout2, UIInfiniteAnimType.Normal)
    --
    tab = ComUtil.GetCom(tabs, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Team_Data_Update, SetTeams)
    eventMgr:AddListener(EventType.Friend_Update, RefreshPanel2)
    eventMgr:AddListener(EventType.ExerciseR_End, function()
        if (openSetting == 1) then
            view:Close()
        end
    end)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed) -- 加载之后再显示奖励面板
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetRed)
end
function OnDestroy()
    eventMgr:ClearListener()
end

function OnTabChanged(_index)
    if (curTeamIndex and curTeamIndex == _index) then
        return
    end
    curTeamIndex = _index
    SetTeams()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = rankDatas[index]
        lua.Refresh(_data)
        -- 请求更多数据
        if (index ~= eFreeMatchDef.rankLen and index == #rankDatas) then
            SetR1()
        end
    end
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = friendDatas[index]
        lua.Refresh(_data, ClickYQ)
    end
end

function ClickYQ(_fid)
    fid = _fid
    OnClickPP()
end

-- function Update()
--     if (openSetting == 2 and Time.time > timer) then
--         timer = Time.time + 30
--         FriendMgr:GetFlush({"icon_id", "name", "is_online", "level"})
--     end
-- end

function OnOpen()
    mainCfg = ExerciseRMgr:GetMainCfg()
    curCfg = ExerciseRMgr:GetCurCfg()
    CSAPI.SetGOActive(L1, openSetting == 1)
    CSAPI.SetGOActive(L2, openSetting ~= 1)
    CSAPI.SetGOActive(R1, openSetting == 1)
    CSAPI.SetGOActive(R2, openSetting ~= 1)
    CSAPI.SetGOActive(DR, openSetting == 1)
    if (openSetting == 1) then
        CheckJC()
        RefreshPanel1()
    else
        --RefreshPanel2()--由update处理
        FriendMgr:GetFlush({"icon_id", "name", "is_online", "level"})
    end

    tab.selIndex = curTeamIndex or 0
    -- 
    if (not CSAPI.IsViewOpen("Loading") and not CSAPI.IsViewOpen("RewardPanel")) then
        CheckRChange()
    end
end

-- 自由匹配
function RefreshPanel1()
    -- l 
    SetL1()
    -- r 
    SetR1()
    -- dr 
    --local cnt = ExerciseRMgr:GetProto().can_join_cnt or 0
    --LanguageMgr:SetText(txtPPNum, 90016, cnt, mainCfg.pvpPlayCnt)
    -- 
    SetRed()
end

function SetL1()
    -- time1
    CSAPI.SetText(txtTime1, curCfg.showTime)
    -- time2
    local str = curCfg.startBattleTime .. ":00-" .. curCfg.endBattleTime .. ":00"
    LanguageMgr:SetText(txtTime2, 90004, str)
    -- 禁用角色
    SetRoles()
end

-- 排行榜
function SetR1()
    if (not isEnd) then
        ArmyProto:GetFreeMatchRankList(#rankDatas + 1, getNum, GetRankDatasCB)
    end
    -- 
    if (not myRankItem) then
        ResUtil:CreateUIGOAsync("ExerciseR/ExerciseRItem1", myPoint, function(go)
            myRankItem = ComUtil.GetLuaTable(go)
            myRankItem.RefreshMySelf()
        end)
    end
end

function GetRankDatasCB(proto)
    if (not proto.rank_objs or #proto.rank_objs < getNum) then
        isEnd = true
    end
    if (proto.rank_objs) then
        for k, v in ipairs(proto.rank_objs) do
            table.insert(rankDatas, v)
        end
    end
    layout:IEShowList(#rankDatas)
end

-- 队伍
function SetTeams()
    local nType = openSetting == 1 and eTeamType.PVP or eTeamType.PVPFriend
    local teamData = TeamMgr:GetTeamData(nType + curTeamIndex)
    local itemDatas = {}
    for k = 1, 5 do
        local _data = teamData:GetItemByIndex(k)
        table.insert(itemDatas, _data ~= nil and _data:GetCard() or {})
    end
    teamItems = teamItems or {}
    ItemUtil.AddItems("RoleLittleCard/RoleSmallCard", teamItems, itemDatas, dGrid, ToEditTeam, 1, nil, function()
        for k, v in pairs(teamItems) do
            v.ActiveClick(true)
        end
    end)
    -- 
    isTeamMax, teamNum, teamRoleNums = true, 0, {}
    for k = 0, 2 do
        local _teamData = TeamMgr:GetTeamData(nType + k)
        if (_teamData:GetRealCount() > 0) then
            teamNum = teamNum + 1
            if (_teamData:GetRealCount() < 5) then
                isTeamMax = false
            end
        else
            isTeamMax = false
        end
        table.insert(teamRoleNums, _teamData:GetRealCount())
    end
    -- 
    for k, v in ipairs(teamRoleNums) do
        CSAPI.SetGOActive(this["imgRed" .. k], v < 5)
    end
end

function SetRoles()
    local roleIDs = curCfg.pvpBan or {}
    local _datas = {}
    for k, v in ipairs(roleIDs) do
        local _data = RoleMgr:GetFakeData(v, 1)
        table.insert(_datas, _data)
    end
    roleItems = roleItems or {}
    ItemUtil.AddItems("RoleLittleCard/RoleSmallCard", roleItems, _datas, roleParent, nil, 1, nil, function()
        for k, v in pairs(roleItems) do
            v.ActiveClick(false)
            v.HideLv(false)
        end
    end)
end

-- 队伍有问题
function SetTips1()
    local lans = {90006, 90007, 90008}
    CSAPI.SetGOActive(tips1, true)
    local s1, s2 = "", ""
    if (teamNum < 3) then
        -- 有空队伍
        local str = ""
        for k, v in ipairs(teamRoleNums) do
            if (v == 0) then
                if (str == "") then
                    str = LanguageMgr:GetByID(lans[k])
                else
                    str = str .. "," .. LanguageMgr:GetByID(lans[k])
                end
            end
        end
        s1 = LanguageMgr:GetByID(90041, str)
        s2 = LanguageMgr:GetByID(90023)
    else
        -- 未满编
        local str = ""
        for k, v in ipairs(teamRoleNums) do
            if (v < 5) then
                if (str == "") then
                    str = LanguageMgr:GetByID(lans[k])
                else
                    str = str .. "," .. LanguageMgr:GetByID(lans[k])
                end
            end
        end
        s1 = LanguageMgr:GetByID(90042, "\n" .. str)
        s2 = LanguageMgr:GetByID(90015)
    end
    CSAPI.SetText(txtTips1, s1)
    CSAPI.SetText(txtS1, s2)
end

-- 目标
function OnClickTarget()
    CSAPI.OpenView("ExerciseRRankReward")
end

function OnClickC()
    CSAPI.SetGOActive(tips1, false)
end

function OnClickS()
    if (teamNum < 3) then
        curEmptyIndex = nil
        for k, v in ipairs(teamRoleNums) do
            if (v <= 0) then
                curEmptyIndex = k - 1
                break
            end
        end
        ToEditTeam()
    else
        if (openSetting == 1) then
            ArmyProto:JoinFreeArmy(function()
                local armyType = RealArmyType.Freedom
                CSAPI.OpenView("ExerciseRPP", nil, armyType)
            end)
        else
            ArmyProto:InviteFriend({{
                uid = fid,
                is_cancel = false
            }}, YQCB)
        end
    end
    CSAPI.SetGOActive(tips1, false)
end

function ToEditTeam()
    local index = curEmptyIndex or curTeamIndex
    local nType = openSetting == 1 and eTeamType.PVP or eTeamType.PVPFriend
    CSAPI.OpenView("TeamView", {
        currentIndex = nType + index,
        canEmpty = true,
        is2D = true,
        teamList = GetTeamList()
    }, TeamOpenSetting.PVP)
    --
    curEmptyIndex = nil
end

function GetTeamList()
    local nType = openSetting == 1 and eTeamType.PVP or eTeamType.PVPFriend
    local teamList = {}
    local x1 = nType
    local x2 = Cfgs.CfgTeamTypeEnum:GetByID(x1).endIdx
    for k = x1, x2 do
        table.insert(teamList, k)
    end
    return teamList
end

-- 开始匹配
function OnClickPP()
    -- 队伍是否已满 
    if (isTeamMax) then
        if (openSetting == 1) then
            ArmyProto:JoinFreeArmy(function()
                local armyType = openSetting == 1 and RealArmyType.Freedom or RealArmyType.Friend
                CSAPI.OpenView("ExerciseRPP", nil, armyType)
            end)
        else
            ArmyProto:InviteFriend({{
                uid = fid,
                is_cancel = false
            }}, YQCB)
        end
    else
        SetTips1()
    end
end

function YQCB(proto)
    layout2:UpdateList()
    -- 
    CSAPI.OpenView("ExerciseRPP", nil, RealArmyType.Friend)
end

-- 好友
function RefreshPanel2()
    friendDatas = FriendMgr:GetDatasByState(eFriendState.Pass)
    table.sort(friendDatas, function(a, b)
        return FriendSort(a, b)
    end)
    layout2:IEShowList(#friendDatas)
end

function FriendSort(a, b)
    if ((a:IsOnLine() and b:IsOnLine()) or (a:IsOnLine() == false and b:IsOnLine() == false)) then
        if (a:GetLv() == b:GetLv()) then
            return a:GetAdd_time() < b:GetAdd_time()
        else
            return a:GetLv() > b:GetLv()
        end
    else
        return a:IsOnLine()
    end
end

function OnClickTips1()
    CSAPI.SetGOActive(tips1, false)
end

function OnClickJY()
    CSAPI.SetGOActive(tips2, true)
end

function OnClickTips2()
    CSAPI.SetGOActive(tips2, false)
end

-- 赛季继承 
function CheckJC()
    if (ExerciseRMgr:IsChangeSJ()) then
        -- 清空编队
        RemoveTeams()
        -- 
        PlayerPrefs.SetInt(PlayerClient:GetID() .. "_exercoserpp_" .. eTeamType.PVP, 1)
        PlayerPrefs.SetInt(PlayerClient:GetID() .. "_exercoserpp_" .. eTeamType.PVPFriend, 1)
        --
        local pre_score = ExerciseRMgr:GetProto().pre_score or 0
        local per_rankLv = GCalHelp:CalFreeMatchRankLv(pre_score)
        if (ExerciseRMgr:GetProto().score ~= pre_score) then
            CSAPI.OpenView("ExerciseRJC", {pre_score, per_rankLv})
        end
        ExerciseRMgr:SetChangeSJ()
        ArmyProto:FreeMatchCfgChangeFix()
    end
end

function RemoveTeams()
    local nType = openSetting == 1 and eTeamType.PVP or eTeamType.PVPFriend
    local teamDatas = {}
    local x1 = nType
    local x2 = Cfgs.CfgTeamTypeEnum:GetByID(x1).endIdx
    for k = x1, x2 do
        local teamData = TeamMgr:GetTeamData(k)
        teamData:ClearCard()
        table.insert(teamDatas, teamData)
    end
    PlayerProto:SaveTeamList(teamDatas)
end

function SetRed()
    local _data = RedPointMgr:GetData(RedPointType.PVP)
    UIUtil:SetRedPoint2("Common/Red2", btnTarget, _data ~= nil, 97, 48, 0)
end

-- 避免loading界面与RewardPanel冲突   
function OnViewClosed(viewKey)
    -- 是否是新段位，新排名,获得积分币
    if (viewKey == "Loading" or viewKey == "RewardPanel") then
        CheckRChange()
    end
end

function CheckRChange()
    if(openSetting ~= 1)then 
        return
    end 
    local oldRewards = ExerciseRMgr:GSetOldRewards()
    if (oldRewards) then
        UIUtil:OpenReward({oldRewards})
    else
        local b = ExerciseRMgr:CheckBreak()
        if (b) then
            CSAPI.OpenView("ExerciseRChange")
        end
    end
end

--
function OnClickChangeRole()
    CSAPI.OpenView("CRoleDisplayPVP",ExerciseRMgr:GetProto())
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end

-- function OnClickShop()
--     CSAPI.OpenView("ShopView", 8001)
-- end
