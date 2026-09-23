local cfg = nil
local data = nil
local sectionData = nil
local isSweepOpen = false
local timeFunc = nil
local resetTime = 0
local timer = 0
local isFight = false

local time = 0
local hotTimer = 0
local hotTime = 0

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        ShowFight()
        ShowCost()
        ShowSweep()
        ShowDirll()
    end
end

function Update()
    if isFight and resetTime > 0 and timer < Time.time then
        timer = Time.time + 1
        resetTime = TotalBattleMgr:GetFightTime()
        local tab = TimeUtil:GetTimeTab(resetTime)
        CSAPI.SetText(txtTime,(tab[2]<10 and "0"..tab[2] or tab[2])
        ..":"..(tab[3]<10 and "0"..tab[3] or tab[3])
        ..":"..(tab[4]<10 and "0"..tab[4] or tab[4]))
        if resetTime <= 0 then
            CSAPI.SetGOActive(timeObj,false)
            CSAPI.SetAnchor(node,0,29)
            -- CSAPI.SetRTSize(gameObject,623,113)        
            PlayerProto:GetStarPalaceInfo()
        end
    end

    if time > 0 and hotTimer < Time.time then
        hotTimer = Time.time + 1
        time = hotTime - TimeUtil:GetTime()
        if time <= 0 then
            ShowHotChange(false)
        end
    end
end

function ShowCost()
    if cfg then
        local _cost = DungeonUtil.GetCost(cfg)
        if _cost~=nil then
            ResUtil.IconGoods:Load(costImg, _cost[1] .. "_3")
            CSAPI.SetAnchor(costImg,-141,0)
            CSAPI.SetText(cost,isFight and " 0" or "-" .. _cost[2])
            local cfg = Cfgs.ItemInfo:GetByID(_cost[1])
            if cfg then
                CSAPI.SetText(txt_cost, cfg.name)
            end
        else
            ResUtil.IconGoods:Load(costImg, ITEM_ID.Hot .. "_3")
            local costNum,isHotChange = DungeonUtil.GetHot(cfg)
            ShowHotChange(isHotChange)
            costNum = StringUtil:SetByColor(costNum .. "", math.abs(costNum) <= PlayerClient:Hot() and "191919" or "CD333E")
            CSAPI.SetText(cost," " .. costNum)
            LanguageMgr:SetText(txt_cost, 15004)
        end
    end
end

function ShowHotChange(b)
    UIUtil:SetHotPoint(btnEnter,b,170,51)
    if b then
        _,hotTime = DungeonUtil.GetHotChangeTime()
        if hotTime > 0  then
            time = hotTime - TimeUtil:GetTime()
            hotTimer = 0
        end
    end
end

--扫荡状态
function ShowSweep()
    if cfg == nil or isFight then
        return
    end
    if cfg.diff and cfg.diff == 3 then
        CSAPI.SetGOActive(btnSweep,false)
        CSAPI.SetAnchor(btnEnter,0,58)
        return  
    end
    CSAPI.SetGOActive(btnSweep,cfg.modUpCnt ~= nil)
    if cfg.modUpCnt == nil then
        CSAPI.SetAnchor(btnEnter,0,58)
        return
    end
    CSAPI.SetAnchor(btnEnter,59,58)
    isSweepOpen = false
    local sweepData = SweepMgr:GetData(cfg.id)
    if sweepData then
        isSweepOpen = sweepData:IsOpen()
    end 
    CSAPI.SetGOActive(sweepLock,not isSweepOpen)
    CSAPI.SetImgColor(sweepImg,255,255,255,isSweepOpen and 255 or 76)
end

function ShowFight()
    isFight =false
    if TotalBattleMgr:IsFighting() then
        local fightInfo = TotalBattleMgr:GetFightInfo()
        if fightInfo and fightInfo.id == cfg.id then
            isFight = true
        end
    end
    CSAPI.SetGOActive(btnSweep,not isFight)
    CSAPI.SetGOActive(btnGiveUp, isFight)
    CSAPI.SetGOActive(timeObj, isFight)
    CSAPI.SetAnchor(node,0,isFight and 0 or 29)
    -- CSAPI.SetRTSize(gameObject,623,isFight and 142 or 113)
    resetTime = isFight and TotalBattleMgr:GetFightTime() or 0
    timer = 0
end

function ShowDirll()
    local isOpen = DungeonMgr:IsDungeonOpen(cfg.id)
    CSAPI.SetGOActive(dirllLock,not isOpen)
    CSAPI.SetImgColor(dirllImg,255,255,255,isOpen and 255 or 76)
end

function IsSweepOpen()
    return isSweepOpen
end

function IsCurrFight()
    return isFight
end

function OnClickEnter()
    
end

function OnClickSweep()
    UIUtil:OpenSweepView(cfg.id)
end

function OnClickDirll()
    
end

function OnClickGiveUp()
    
end

