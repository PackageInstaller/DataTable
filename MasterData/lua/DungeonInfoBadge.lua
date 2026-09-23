local cfg = nil
local data = nil
local sectionData = nil

--badge
local items = nil
local currX,lastX = 0,1
local len,svLen = 0,0

function Update()
    UpdateArrow()
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetBadge()
    end
end

function SetBadge()
    local info = sectionData:GetInfo()
    if info and info.badge then
        local curDatas = BadgeMgr:GetArr(info.badge)
        items =  items or {}
        ItemUtil.AddItems("Badge/BadgeGridItem",items,curDatas,itemParent,OnItemClickCB,1,true,OnLoadSuccess)
        SetArrow()
    end
end

function OnItemClickCB(item)
    local badgeData = item.GetData()
    UIUtil:OpenBadgeTips(badgeData:GetID())
end

function OnLoadSuccess()
    if #items>0 then
        for i, v in ipairs(items) do
            v.SetScale(0.75)
        end
    end
end

function SetArrow()
    len = CSAPI.GetRTSize(itemParent)[1]
    svLen = CSAPI.GetRTSize(sv)[1]

    CSAPI.SetGOActive(arrowL,false)
    CSAPI.SetGOActive(arrowR,len > svLen)
    lastX = 1
    currX = 0
end

function UpdateArrow()
    if len > svLen then
        currX = CSAPI.GetAnchor(itemParent)
        if math.abs(currX - lastX) > 0.01 then
            CSAPI.SetGOActive(arrowL,currX < -0.1)
            CSAPI.SetGOActive(arrowR,currX <= -(len - svLen))    
            lastX = currX
        end
    end
end