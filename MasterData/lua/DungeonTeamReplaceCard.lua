local isCheckCard = false
local card = nil
local item = nil

function Awake()
    CSAPI.SetGOActive(leaderImg,false)
    CSAPI.SetGOActive(assistImg,false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

--teamItemData
function Refresh(_data,_elseData)
    data = _data
    isCheckCard = _elseData and _elseData.isCheckCard
    if data then
        SetLeader()
        card = data:GetCard()
        if card then
            SetItem()
            SetShow()
        end
    end
    SetAssist()
    SetEmpty()
end

function SetLeader()
    CSAPI.SetGOActive(leaderImg,data:IsLeader())
end

function SetAssist()
    CSAPI.SetGOActive(assistImg,index == 6)
end

function SetItem()
    if item then
        item.Refresh(card,{hideFormat = true})
    else
        ResUtil:CreateUIGOAsync("RoleLittleCard/RoleLittleCard",itemParent,function (go)
            item = ComUtil.GetLuaTable(go)
            item.SetClickCB(cb)
            item.Refresh(card,{hideFormat = true,disDrag = true})
            item.SetCanClick(true)
        end)
    end
end

function SetShow()
    if isCheckCard then
        local isHas = RoleMgr:GetData(card:GetCfgID()) ~= nil
        if RoleMgr:IsLeader(card:GetCfgID()) or RoleMgr:IsExtraLeader(card:GetCfgID()) then
            isHas = true
        end
        CSAPI.SetGOAlpha(itemParent, isHas and 1 or 0.5)
        CSAPI.SetGOActive(mask,not isHas)
    else
        CSAPI.SetGOAlpha(itemParent,1)
        CSAPI.SetGOActive(mask,false)
    end
end

function SetEmpty()
    CSAPI.SetGOActive(empty ,data == nil)
    CSAPI.SetGOActive(node ,data ~= nil)
end
