local cfg = nil
local data = nil
local sectionData = nil
local isSweepOpen = false

local time = 0
local timer = 0
local hotTime = 0

function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Sweep_Show_Panel, ShowSweep)
    eventMgr:AddListener(EventType.Player_HotChange, ShowCost)
    eventMgr:AddListener(EventType.Bag_Update, ShowCost)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = hotTime - TimeUtil:GetTime()
        if time <= 0 then
            ShowHotChange(false)
        end
    end
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        ShowCost()
        ShowSweep()
    end
end

function ShowCost()
    if cfg then
        local _cost = DungeonUtil.GetCost(cfg)
        if _cost~=nil then
            local cur = BagMgr:GetCount(_cost[1])
            ResUtil.IconGoods:Load(costImg, _cost[1] .. "_3")
            CSAPI.SetAnchor(costImg,-153,0)
            CSAPI.SetText(cost,"-" .. _cost[2])
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
            timer = 0
        end
    end
end

--扫荡状态
function ShowSweep()
    if cfg == nil then
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

function OnClickEnter()
    
end

function OnClickSweep()
    UIUtil:OpenSweepView(cfg.id)
end

function IsSweepOpen()
    return isSweepOpen
end