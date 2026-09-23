local cfg = nil
local data = nil
local sectionData = nil
local isSweepOpen = false

local time = 0
local timer = 0
local hotTime = 0

function Awake()
    eventMgr = ViewEvent.New();
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
    end
end

function ShowCost()
    if cfg then
        local _cost = DungeonUtil.GetCost(cfg)
        if _cost~=nil then
            local cur = BagMgr:GetCount(_cost[1])
            ResUtil.IconGoods:Load(costImg, _cost[1] .. "_3")
            if eDuplicateType.MultTeam==cfg.type then
                CSAPI.SetAnchor(costImg,-153,3)
            else
                CSAPI.SetAnchor(costImg,-153,0)
            end
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

function SetText(enterStr)
    if enterStr and enterStr ~= "" then
        CSAPI.SetText(txt_enter,enterStr)
    end
end

function HideDirll(b)
    CSAPI.SetGOActive(btnDirll,not b)
    CSAPI.SetAnchor(btnEnter,b and 1 or 59,58)
end

function OnClickEnter()
    
end

function OnClickDirll()
    
end
