local data = nil
local canvasGroup = nil
local isLock = false
local lockStr = ""
local openInfo = nil
local currState = 0
local sectionData = nil
local enterCB = nil
local cb = nil
local itemX = 0
local isSelect = false
local isNew = false
-- time 
local sTime, eTime, eTime2 = 0, 0, 0
local timer = 0
-- 十二星宫
local sliderTotal = nil
-- 递归沙盒
local curMTBData = nil
-- 历战试炼
local trialsStartTime,trialsEndTime = 0,0
local isTrialsOpen,isChainOpen =false,false
-- 周期boss
local curPBData = nil
-- 动效
local textRand = nil
local lastSelect = false

function SetIndex(idx)
    index = idx
end

function SetEnterCB(_cb)
    enterCB = _cb
end

function SetClickCB(_cb)
    cb = _cb
end

function Awake()
    canvasGroup = ComUtil.GetCom(node, "CanvasGroup")
    textRand = ComUtil.GetCom(action, "ActionTextRand")
    sliderTotal = ComUtil.GetCom(totalSlider, "Slider")

    CSAPI.SetGOActive(selectObj, false)
end

function Refresh(_data, elseData)
    data = _data
    SetEnterCB(elseData)
    if data then
        sectionData = data.data
        currState = sectionData:GetOpenState()
        openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
        SetBG()
        SetTitle()
        SetTopPanel()
        SetLock()
        isNew = DungeonActivityMgr:GetIsNew(sectionData:GetID())
        SetNew()
        SetRed()
    end
    itemX = CSAPI.GetAnchor(gameObject)
end

function Update()
    if timer < Time.time then
        timer = Time.time + 1
        UpdateTopTime()
    end
end

function SetBG()
    if data.type == SectionActivityType.Trials then
        return
    end
    local name = sectionData:GetSectionBG()
    if name and name ~= "" then
        ResUtil:LoadBigImg(bg, "UIs/SectionImg/aBg1/" .. name)
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle1, data.chaperName)
    CSAPI.SetText(txtTitle2, sectionData:GetEName())
    textRand.targetStr = sectionData and sectionData:GetEName() or ""
end

function SetLock()
    isLock = currState < 1
    _, lockStr = sectionData:GetOpen()
    SetLockPanel(isLock, lockStr)
end

function SetLockPanel(b, str)
    canvasGroup.alpha = b and 0.3 or 1
    CSAPI.SetGOActive(lockImg, b)
    CSAPI.SetGOActive(lockObj, b)
    CSAPI.SetGOActive(unLockImg, not b)
    CSAPI.SetText(txtLock, str)
end

function SetNew()
    UIUtil:SetNewPoint(redParent, isNew)
end

function SetRed()
    if not isNew then
        UIUtil:SetRedPoint(redParent, DungeonActivityMgr:CheckRed(sectionData:GetID()))
    end
end

function GetData()
    return data
end

function GetSectionData()
    return sectionData
end

function GetID()
    return sectionData and sectionData:GetID()
end

function GetOpen()
    return currState == 1
end

function GetItemX()
    return itemX
end

function OnClick()
    if isNew then
        isNew = false
        DungeonActivityMgr:SetNew(sectionData:GetID())
        SetNew()
        SetRed()
        RedPointMgr:ApplyRefresh()
    end
    if data.type == SectionActivityType.GlobalBoss and eTime > 0 then
        Tips.ShowTips(lockStr)
        return
    end
    if data.type == SectionActivityType.Tower then
        local isCanSweep,sweepIds = TowerMgr:IsTowersSweep()
        if isCanSweep then
            PlayerProto:GetSectionTaskReward(sweepIds,OnRedCheckCallBack)
            return
        end
    end
    if cb then
        cb(this)
    end
end

function OnRedCheckCallBack()
    DungeonMgr:CheckRedPointData()
end

-------------------------------------------上方显示
function SetTopPanel()
    sTime, eTime = 0, 0
    timer = 0
    for i = 1, topObj.transform.childCount do
        CSAPI.SetGOActive(topObj.transform:GetChild(i - 1).gameObject, false)
    end
    if data.type == SectionActivityType.Tower then
        SetTower()
    elseif data.type == SectionActivityType.NewTower then
        SetNewTower()
    elseif data.type == SectionActivityType.TotalBattle and TotalBattleMgr:IsFighting() then
        SetTotalBattle()
    elseif data.type == SectionActivityType.Rogue then
        SetRogue()
    elseif data.type == SectionActivityType.TowerDeep then
        SetTowerDeep()
    elseif data.type == SectionActivityType.MultTeamBattle then
        SetMultTeamBattle()
    elseif data.type == SectionActivityType.GlobalBoss then
        SetGlobalBoss()
    elseif data.type == SectionActivityType.Trials then
        SetTrials()
    elseif data.type == SectionActivityType.EternityWarzone then
        SetEternityWarzone()
    elseif data.type == SectionActivityType.PeriodicBoss then
        SetPeriodicBoss()
    elseif IsActivity() then
        SetActivity()
    end
    CSAPI.SetGOActive(topObj, sTime <= 0 and eTime > 0)
end

function UpdateTopTime()
    if sTime > 0 then
        if data.type == SectionActivityType.Trials then
            sTime = TrialsMgr:GetStartTime() - TimeUtil:GetTime()
            if sTime > 0 then
                sTime = TrialsMgr:GetTrialsTime() - TimeUtil:GetTime()
            end
        end
        if sTime <= 0 then
            CSAPI.SetGOActive(topObj, true)
        end
    end
    if sTime <= 0 and eTime > 0 then
        if data.type == SectionActivityType.Tower then
            UpdateTower()
        elseif data.type == SectionActivityType.NewTower then
            UpdateNewTower()
        elseif data.type == SectionActivityType.TotalBattle and TotalBattleMgr:IsFighting() then
            UpdateTotalBattle()
        elseif data.type == SectionActivityType.Rogue then
            UpdateRogue()
        elseif data.type == SectionActivityType.TowerDeep then
            UpdateTowerDeep()
        elseif data.type == SectionActivityType.MultTeamBattle then
            UpdateMultTeamBattle()
        elseif data.type == SectionActivityType.GlobalBoss then
            UpdateGlobalBoss()
        elseif data.type == SectionActivityType.Trials then
            UpdateTrials()
        elseif data.type == SectionActivityType.EternityWarzone then
            UpdateEternityWarzone()
        elseif data.type == SectionActivityType.PeriodicBoss then
            UpdatePeriodicBoss()
        elseif IsActivity() then
            UpdateAcitivty()
        end
        if eTime <= 0 then
            CSAPI.SetGOActive(topObj, false)
        end
    end
end
-------------------------------------------爬塔
function SetTower()
    CSAPI.SetGOActive(towerObj, true)
    ResUtil.IconGoods:Load(icon, ITEM_ID.BIND_DIAMOND, true)
    CSAPI.SetScale(icon, 0.43, 0.43, 1)
    local info = TowerMgr:GetTowerData()
    RefreshTower(info)
end

function RefreshTower(info)
    if info then
        CSAPI.SetText(txtTowerCur, info.cur .. "")
        CSAPI.SetText(txtTowerMax, info.max .. "")
        -- time
        eTime = info.resetTime
    end
end

function UpdateTower()
    if TimeUtil:GetTime() > eTime then
        local info = TowerMgr:GetTowerData()
        if info then
            info = TowerMgr:AddTowerCur(-info.cur)
            RefreshTower(info)
        end
        eTime = eTime + 604800 -- 7天秒数
        timer = 0
    end

    LanguageMgr:SetText(txtTowerTime, 36006, TimeUtil:GetTimeStr3(eTime - TimeUtil:GetTime()))
end

function IsTower()
    return data.type == SectionActivityType.Tower
end
-------------------------------------------新爬塔
function SetNewTower()
    CSAPI.SetGOActive(towerObj2, true)
    RefreshNewTower()
end

function RefreshNewTower()
    if openInfo then
        eTime = openInfo:GetEndTime()
    end

    local datas = DungeonMgr:GetActivitySectionDatas(SectionActivityType.NewTower)
    CSAPI.SetGOActive(txt_towerHard,#datas == 2)
    CSAPI.SetGOActive(txt_towerNol,#datas == 2)
    CSAPI.SetGOActive(towerImg1,#datas == 2)
    CSAPI.SetGOActive(towerImg2,#datas ~= 2)
    CSAPI.SetAnchor(txtTowerTime2,-133,#datas == 2 and 191 or 283)
    if #datas == 2 then
        local tab = TowerMgr:GetCounts()
        tab[1] = tab[1] or {}
        CSAPI.SetText(txtTowerNol1, "/" .. (tab[1].max or 0))
        CSAPI.SetText(txtTowerNol2, (tab[1].cur or 0) .. "")
        tab[2] = tab[2] or {}
        CSAPI.SetText(txtTowerHard1, "/" .. (tab[2].max or 0))
        CSAPI.SetText(txtTowerHard2, (tab[2].cur or 0) .. "")
    end
end

function UpdateNewTower()
    if TimeUtil:GetTime() > eTime then
        return
    end

    local timeTab = TimeUtil:GetDiffHMS(eTime, TimeUtil:GetTime())
    local day = timeTab.day > 0 and timeTab.day .. LanguageMgr:GetByID(11010) or ""
    local hour = timeTab.hour > 0 and timeTab.hour .. LanguageMgr:GetByID(11009) or ""
    local min = timeTab.minute > 0 and timeTab.minute .. LanguageMgr:GetByID(11011) or ""
    LanguageMgr:SetText(txtTowerTime2, 49032, day .. hour .. min)
end
-------------------------------------------十二星宫
function SetTotalBattle()
    CSAPI.SetGOActive(totalObj, true)
    local fightInfo = TotalBattleMgr:GetFightInfo()
    if fightInfo then
        local cfg = Cfgs.MainLine:GetByID(fightInfo.id)
        if cfg then
            local sectionData = DungeonMgr:GetSectionData(cfg.group)
            CSAPI.SetText(txtTotalName, sectionData:GetName())
            local max = cfg.hp or 1
            local cur = TotalBattleMgr:GetFightBossHp() or 0
            sliderTotal.value = cur / max
            CSAPI.SetText(txtTotalNum, cur .. "/" .. max)
            eTime = TotalBattleMgr:GetFightTime()
            if eTime <= 0 then
                CSAPI.SetGOActive(totalObj, false)
            end
        end
    end
end

function UpdateTotalBattle()
    eTime = TotalBattleMgr:GetFightTime()
    local timeData = TimeUtil:GetTimeTab(eTime)
    local day = timeData[1] > 0 and timeData[1] .. LanguageMgr:GetByID(11010) or ""
    local hour = timeData[2] > 0 and timeData[2] .. LanguageMgr:GetByID(11009) or ""
    local min = timeData[3] > 0 and timeData[3] .. LanguageMgr:GetByID(11011) or ""
    LanguageMgr:SetText(txtTotalTime, 49032, day .. hour .. min)
    if eTime <= 0 then
        CSAPI.SetGOActive(totalObj, false)
    end
end
-------------------------------------------乱序演习
function SetRogue()
    CSAPI.SetGOActive(rogueObj, true)
    eTime = RogueMgr:GetRogueTime()
    if eTime <= 0 then
        CSAPI.SetGOActive(rogueObj, false)
    end
end

function UpdateRogue()
    eTime = RogueMgr:GetRogueTime()
    local timeData = TimeUtil:GetTimeTab(eTime)
    LanguageMgr:SetText(txtRogueTime, 50001, timeData[1], timeData[2], timeData[3])
    if eTime <= 0 then
        CSAPI.SetGOActive(rogueObj, false)
    end
end
-------------------------------------------深塔计划
function SetTowerDeep()
    CSAPI.SetGOActive(rogueObj, true)
    eTime = openInfo and openInfo:GetEndTime() - TimeUtil:GetTime() or 0
    if eTime <= 0 then
        CSAPI.SetGOActive(rogueObj, false)
    end
end

function UpdateTowerDeep()
    eTime = openInfo:GetEndTime() - TimeUtil:GetTime()
    local timeData = TimeUtil:GetTimeTab(eTime)
    LanguageMgr:SetText(txtRogueTime, 77032, timeData[1], timeData[2], timeData[3])
    if eTime <= 0 then
        CSAPI.SetGOActive(rogueObj, false)
    end
end
-------------------------------------------递归沙盒
function SetMultTeamBattle()
    CSAPI.SetGOActive(mtbObj, true)
    curMTBData = MultTeamBattleMgr:GetCurData();
    if curMTBData then
        local state = curMTBData:GetActivityState();
        if state ~= MultTeamActivityState.Over then
            eTime = curMTBData:GetEndTime() - TimeUtil:GetTime()
        end
    end
    if eTime <= 0 then
        CSAPI.SetGOActive(mtbObj, false)
    end
end

function UpdateMultTeamBattle()
    if curMTBData then
        eTime = curMTBData:GetEndTime() - TimeUtil:GetTime()
    end
    local timeData = TimeUtil:GetTimeTab(eTime)
    LanguageMgr:SetText(txtMTBTime, 77032, timeData[1], timeData[2], timeData[3])
    if eTime <= 0 then
        CSAPI.SetGOActive(mtbObj, false)
    end
end

-------------------------------------------世界boss
function SetGlobalBoss()
    if GlobalBossMgr:IsClose() then
        eTime = GlobalBossMgr:GetCloseTime()
        if not isLock then
            SetLockPanel(true, GlobalBossMgr:GetCloseDesc())
            lockStr = GlobalBossMgr:GetCloseDesc()
        end
    end
end

function UpdateGlobalBoss()
    eTime = GlobalBossMgr:GetCloseTime()
    if eTime <= 0 then
        if not isLock then
            SetLockPanel(false, "")
            DungeonMgr:CheckRedPointData()
        end
    end
end
-------------------------------------------副本活动
function SetActivity()
    CSAPI.SetGOActive(activityObj, true)
    local openInfo = sectionData:GetOpenInfo()
    if openInfo then
        eTime = openInfo:GetDungeonEndTime() - TimeUtil:GetTime()
        eTime = eTime > 0 and eTime or openInfo:GetEndTime() - TimeUtil:GetTime()
    end
end

function IsActivity()
    local b = false
    if data.type == SectionActivityType.Plot or data.type == SectionActivityType.TaoFa or data.type == SectionActivityType.RogueMap or data.type == SectionActivityType.VirtualCataclysm then
        b = true
    end
    if sectionData and sectionData:IsResident() then
        b = false
    end
    return b
end

function UpdateAcitivty()
    eTime = openInfo:GetDungeonEndTime() - TimeUtil:GetTime()
    eTime = eTime > 0 and eTime or openInfo:GetEndTime() - TimeUtil:GetTime()
    local timeTab = TimeUtil:GetTimeTab(eTime)
    LanguageMgr:SetText(txtActivityTime, openInfo:GetDungeonEndTime() - TimeUtil:GetTime() > 0 and 36014 or 36015,
        timeTab[1], timeTab[2], timeTab[3])
    if eTime <= 0 then
        CSAPI.SetGOActive(activityObj, false)
        EventMgr.Dispatch(EventType.Activity_Open_State)
    end
end
-------------------------------------------连锁
function SetTrials()
    CSAPI.SetGOActive(trialsObj, true)
    SetTrialsTime()
end

function SetTrialsTime()
    --历战
    trialsStartTime,trialsEndTime = TrialsMgr:GetTrialsTime()
    isTrialsOpen = trialsStartTime - TimeUtil:GetTime() <= 0 and trialsEndTime - TimeUtil:GetTime() > 0
    if isTrialsOpen then
        sTime = trialsStartTime - TimeUtil:GetTime()
        eTime = trialsEndTime - TimeUtil:GetTime()
    end
    --连锁
    isChainOpen = TrialsMgr:GetStartTime() <= TimeUtil:GetTime() and TrialsMgr:GetMissionEndTime() > TimeUtil:GetTime()
    if isChainOpen then
        sTime = TrialsMgr:GetStartTime() < trialsStartTime and TrialsMgr:GetStartTime() - TimeUtil:GetTime() or sTime
        eTime = trialsEndTime < TrialsMgr:GetMissionEndTime() and TrialsMgr:GetMissionEndTime() - TimeUtil:GetTime() or eTime
    end

    CSAPI.SetGOActive(Trials1,isTrialsOpen or isChainOpen)
    CSAPI.SetGOActive(Trials2,isTrialsOpen and isChainOpen)
    local bgName = "aBg1_45"
    if isTrialsOpen or isChainOpen then
        if isTrialsOpen and isChainOpen then --两个都开启
            LanguageMgr:SetText(txtTrialsName1,37086)
            LanguageMgr:SetText(txtTrialsName2,37085)
            local tab1,tab2 = TimeUtil:GetTimeTab(trialsEndTime - TimeUtil:GetTime()),TimeUtil:GetTimeTab(TrialsMgr:GetMissionEndTime() - TimeUtil:GetTime())
            LanguageMgr:SetText(txtTrialsTime1, 77032, tab1[1], tab1[2], tab1[3])
            LanguageMgr:SetText(txtTrialsTime2, 77032, tab2[1], tab2[2], tab2[3])
        else --单独开启
            bgName = isTrialsOpen and "aBg1_21" or "aBg1_46"
            LanguageMgr:SetText(txtTrialsName1,isTrialsOpen and 37086 or 37085)
            local tab = TimeUtil:GetTimeTab(eTime)
            LanguageMgr:SetText(txtTrialsTime1, 77032, tab[1], tab[2], tab[3])
        end
    end
    ResUtil:LoadBigImg(bg, "UIs/SectionImg/aBg1/" .. bgName)
end

function UpdateTrials()
    SetTrialsTime()    
    if eTime <= 0 then
        CSAPI.SetGOActive(TrialsObj, false)
        EventMgr.Dispatch(EventType.Activity_Open_State)
    end
end

-------------------------------------------永境战域
function SetEternityWarzone()
    CSAPI.SetGOActive(activityObj, true)
    eTime = TimeUtil:NextWeekIndexTimeStamp(1, g_ActivityDiffDayTime) - TimeUtil:GetTime()
end

function UpdateEternityWarzone()
    if eTime > 0 then
        eTime = TimeUtil:NextWeekIndexTimeStamp(1, g_ActivityDiffDayTime) - TimeUtil:GetTime()
        local timeTab = TimeUtil:GetTimeTab(eTime)
        LanguageMgr:SetText(txtActivityTime, 312020, timeTab[1], timeTab[2], timeTab[3])
        if eTime <= 0 then
            CSAPI.SetGOActive(activityObj, false)
            EventMgr.Dispatch(EventType.Activity_Open_State)
        end
    end
end
-------------------------------------------周期boss
function SetPeriodicBoss()
    CSAPI.SetGOActive(periodicBossObj, true)
    curPBData = PeriodicBossMgr:GetOpenData()
    if curPBData then
        CSAPI.SetText(txtPerBoss,curPBData:GetDungeonName())
        local iconName = curPBData:GetIcon2()
        if iconName and iconName ~= "" then
            ResUtil.PeriodicBoss:Load(perBossIcon, iconName)
        end
        eTime2 = curPBData:GetDupOverTime() - TimeUtil:GetTime()
        eTime = curPBData:GetEndTime() - TimeUtil:GetTime()
        if eTime2 <= 0 then
            LanguageMgr:SetText(txtPerBossTime, 76218)
        end
    end
end

function UpdatePeriodicBoss()
    if eTime2 > 0 then
        eTime2 = curPBData:GetDupOverTime() - TimeUtil:GetTime()
        local timeTab = TimeUtil:GetTimeTab(eTime2)
        LanguageMgr:SetText(txtPerBossTime, 77032, timeTab[1], timeTab[2], timeTab[3])
        if eTime2 <= 0 then
            LanguageMgr:SetText(txtPerBossTime, 76218)
        end
    end
    if eTime > 0 then
        eTime = curPBData:GetEndTime() - TimeUtil:GetTime()
        if eTime <= 0 then
            PeriodicBossMgr:UpdateDatasTime()
            SetPeriodicBoss()
        end
    end
end

------------------------------------动效----------------------------------------

function PlayAnim()
    textRand:Play()
end

function SetScale(value)
    CSAPI.SetScale(node, value, value, 1)
    CSAPI.SetScale(lockObj, value, value, 1)
end

function SetSelect(b)
    if lastSelect ~= b then
        lastSelect = b
        CSAPI.SetGOActive(selectObj, b)
    end
end

function ShowDowm(isShow, isSel)
    CSAPI.SetGOActive(downObj, isShow)
    CSAPI.SetGOActive(selImg, isSel)
end
