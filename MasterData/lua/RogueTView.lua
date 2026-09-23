local time, timer = 0, 0
local curID = nil -- 关卡组id
local curIndex = nil
function Awake()
    UIUtil:AddTop2("RogueTView", gameObject, function()
        view:Close()
    end, nil, {})
    scrollRect = ComUtil.GetCom(sr, "ScrollRect")
    CSAPI.SetGOActive(AdaptiveScreen, false)
    CSAPI.SetGOActive(mask, true)

    layout = ComUtil.GetCom(hsv, "UISV")
    layout:Init("UIs/RogueT/RogueTItem", LayoutCallBack, true)
    layout:AddOnValueChangeFunc(OnValueChange)
    layout:AddToCenterFunc(ToCenterCB)
    svUtil = SVCenterDrag.New()

    eventMgr = ViewEvent.New()
    -- 红点刷新
    eventMgr:AddListener(EventType.RedPoint_Refresh, function()
        if (curData) then
            SetDetail()
            SetReds()
        end
    end)
    eventMgr:AddListener(EventType.View_Lua_Closed, CheckOpen)
end
function OnDestroy()
    eventMgr:ClearListener()
end

--------------------------------------------------------------
function LayoutCallBack(index)
    local _data = curDatas[index]
    local item = layout:GetItemLua(index)
    item.SetIndex(index)
    item.SetClickCB(OnClickItem)
    item.Refresh(_data)
end

function ToCenterCB(index)
    local oldIndex = curIndex
    curIndex = index == nil and curIndex or (index + 1)
    if (index ~= nil and oldIndex == curIndex) then
        if (curIndex == 1) then
            SetRight(1)
        elseif (curData:CheckInfinityIsPass()) then
            SetRight(2)
        end
    end
end

function OnValueChange()
    svUtil:Update()
end

function OnClickItem(index)
    layout:MoveToCenter(index)
end

--------------------------------------------------------------

function Update()
    if (endTime ~= nil) then
        timer = Time.time + 1
        SetTime()
    end
end

function OnOpen()
    -- 请求数据
    RogueTMgr:GetRogueTInfo(function()
        CSAPI.SetGOActive(AdaptiveScreen, true)
        CSAPI.SetGOActive(mask, false)
        local fightData = RogueTMgr:GetFightData() -- 当前战斗中
        if (fightData) then
            -- 已存在战斗中的数据则打开之后的界面
            if (RogueTMgr:CheckSelectBuff()) then
                CSAPI.OpenView("RogueTEnemySelect")
            else
                CSAPI.OpenView("RogueTBuffSelect")
            end
            view:Close()
        else
            RefreshPanel()
            EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "RogueTView")
        end
        --奖励更新
        CheckOpen()
    end)
end

function CheckOpen()
    if(RogueTMgr:CheckRed3())then 
        CSAPI.OpenView("RogueTScore")
        FuncUtil:Call(function ()
            LanguageMgr:ShowTips(48002)
        end,nil,500)
        FightProto:RogueTSetWindow(1,RogueTMgr:GetRogueTTime())
    elseif(RogueTMgr:CheckRed4())then  
        CSAPI.OpenView("RogueTReward")
        FuncUtil:Call(function ()
            LanguageMgr:ShowTips(48003)
        end,nil,500)
        FightProto:RogueTSetWindow(2,g_RogueScoreLVIdx)
    end
end

function RefreshPanel()
    curData = RogueTMgr:GetMaxData()
    curID = curData:GetID()
    curIndex = 1
    --
    SetDatas()
    SetDetail()
    SetReds()
    -- time 
    endTime = RogueTMgr:GetRogueTTime()
    timer = Time.time
end

function SetDatas()
    curDatas = {curData}
    if (curData:IsisInfinity()) then
        table.insert(curDatas, curData)
    end
    -- items 
    svUtil:Init(layout, #curDatas, {803, 602}, 7, 0.2, 0.1)
    layout:IEShowList(#curDatas, FirstCB, curIndex)
end
function FirstCB()
    if (not isFirst1) then
        isFirst1 = true
        --
        svUtil:Update()
        --
        ToCenterCB()
    end
end

function SetDetail()
    local lv1, s1, ms1 = RogueTMgr:GetReward()
    local curLv = 0
    if (s1 > 0) then
        local cfgs = Cfgs.CfgRogueTScoreReward:GetAll()
        for k, v in ipairs(cfgs) do
            if (v.points <= s1) then
                curLv = k
            else
                break
            end
        end
    end
    CSAPI.SetText(txtReward, curLv .. "")
    local lv2, s2, ms2 = RogueTMgr:GetScore()
    CSAPI.SetText(txtJF, s2 .. "/" .. ms2)
    -- CSAPI.SetText(txtCurMaxScore, curData:GetScore())
    CSAPI.SetText(txtHard, curData:GetCfg().hard .. "")
    -- 大奖
    local bigRewardID = RogueTMgr:GetBigRewardID()
    CSAPI.SetGOActive(rewardBg, bigRewardID ~= nil)
    if (bigRewardID ~= nil) then
        local cfg = Cfgs.CfgRogueTScoreReward:GetByID(bigRewardID)
        local itemCfg = Cfgs.ItemInfo:GetByID(cfg.reward[1][1])
        -- iconbg
        ResUtil.IconGoods:Load(rewardBg, GridFrame[itemCfg.quality or 1], false)
        -- icon
        ResUtil.IconGoods:Load(rewardIcon, itemCfg.icon)
        --
        CSAPI.SetText(txtRewardLv, "Lv" .. bigRewardID)
    end
end

function SetTime()
    local needTime = endTime - TimeUtil:GetTime()
    if (needTime <= 0) then
        endTime = nil
        UIUtil:ToHome()
        -- LogError("周期结束，回到主界面（无多语言）")
    else
        local tab = TimeUtil:GetTimeTab(needTime)
        LanguageMgr:SetText(txtTime, 54047, tab[1], tab[2], tab[3])
    end
end

function SetReds()
    local red1 = RogueTMgr:CheckRed1()
    UIUtil:SetRedPoint(btnReward, red1, 176.7, 72.4)
    local red2 = RogueTMgr:CheckRed2()
    UIUtil:SetRedPoint(btnScore, red2, -71, 37)
    local red3 = RogueTMgr:HardIsRed()
    UIUtil:SetRedPoint(btnHard, red3, 135, 39)
end

function SetRight(_nType)
    MoveTo(_nType)
    nType = _nType
    local cfg = nil
    if (nType == 1) then
        cfg = Cfgs.DungeonGroup:GetByID(curID) -- 关卡组
    else
        cfg = Cfgs.MainLine:GetByID(curData:GetInfinityID())
    end
    local type = DungeonInfoType.RogueT
    if infoPanel == nil then
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo6", AdaptiveScreen, function(go)
            infoPanel = ComUtil.GetLuaTable(go)
            infoPanel.SetClickCB(OnClickEnter)
            infoPanel.SetClickMaskCB(OnClickBack)
            infoPanel.Show(cfg, type, function()
                infoPanel.SetFunc("Details2", "OnClickEnemy", OnClickEnemy)
            end)
        end)
    else
        infoPanel.Show(cfg, type)
    end
end

function OnClickEnemy()
    local monsters = nType == 1 and curData:GetMonsters2() or curData:GetMonsters()
    CSAPI.OpenView("FightEnemyInfo", monsters)
end

function OnClickEnter()
    -- 清空编队数据
    RemoveTeam()
    --
    if (nType == 1) then
        FightProto:EnterRogueTDuplicate(curID, false, function()
            CSAPI.OpenView("RogueTBuffSelect")
            view:Close()
        end)
    else
        if (not curData:CheckInfinityIsPass()) then
            return
        end
        local curUseIdx = curData:GetUseBuff() -- 当前使用的存档
        if (curUseIdx and curUseIdx ~= 0) then
            CSAPI.OpenView("TeamConfirm", {
                dungeonId = curData:GetInfinityID(),
                teamNum = 1,
                isNotAssist = true,
                disChoosie = true,
                rogueTData = curData
            }, TeamConfirmOpenType.RogueT)
        else
            UIUtil:OpenDialog(LanguageMgr:GetByID(54042), function()
                CSAPI.OpenView("TeamConfirm", {
                    dungeonId = curData:GetInfinityID(),
                    teamNum = 1,
                    isNotAssist = true,
                    disChoosie = true,
                    rogueTData = curData
                }, TeamConfirmOpenType.RogueT)
            end)
        end
    end
end
function RemoveTeam()
    local teamData = TeamMgr:GetTeamData(RogueTMgr:GetTeamIndex())
    teamData:ClearCard()
    PlayerProto:SaveTeamList({teamData})
end

function OnClickBack()
    infoPanel.Show()
    MoveBack()
end

-- 积分奖励
function OnClickReward()
    CSAPI.OpenView("RogueTReward")
end

-- 周期
function OnClickScore()
    CSAPI.OpenView("RogueTScore")
end

-- 更改难度
function OnClickHard()
    RogueTMgr:SetOldMaxGroup()
    SetReds()
    CSAPI.OpenView("RogueTHard", {curID, function(_newID)
        curID = _newID
        RogueTMgr:SetSelectID(curID)
        RefreshPanel()
    end})
end

-- buff存档
function OnClickCD()
    CSAPI.OpenView("RogueTSelectBuff", curID)
end

-- 排行榜
function OnClickR()
    local sectionData = RogueTMgr:GetSectionData()
    UIUtil:OpenRankView(sectionData:GetRankView(),sectionData:GetRankListInfo())
end

function MoveTo(index)
    local pos = CSAPI.csGetAnchor(hContent)
    local x2 = -100 - (index - 1) * 766
    oldX = nil
    if (math.abs(pos[0] - x2) > 1) then
        oldX = pos[0]
        scrollRect.enabled = false
        CSAPI.SetGOActive(mask, true)
        UIUtil:SetPObjMove(hContent, pos[0], x2, 0, 0, 0, 0, function()
            CSAPI.SetGOActive(mask, false)
        end, 300, 1)
    end
end
function MoveBack()
    if (oldX ~= nil) then
        local pos = CSAPI.csGetAnchor(hContent)
        scrollRect.enabled = false
        CSAPI.SetGOActive(mask, true)
        UIUtil:SetPObjMove(hContent, pos[0], oldX, 0, 0, 0, 0, function()
            scrollRect.enabled = true
            CSAPI.SetGOActive(mask, false)
        end, 300, 1)
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
