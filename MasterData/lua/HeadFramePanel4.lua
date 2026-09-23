local HeadFaceData = require("HeadFaceData")
local minEndTime = nil
local minShopTime = nil

local selectType = 0 -- 0:未选 1：选中左边 2：选中右边
local selectData = nil -- selectType=1:左侧的下标+1；selectType=2:右侧的id
local clickGO = nil
local curItem = nil

function OnInit()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Head_Face_Change, function()
        selectType = 0
        selectData = nil
        RefreshPanel()
    end)
    eventMgr:AddListener(EventType.Shop_RecordInfos_Refresh, Refresh)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnDisable()
    -- 去掉红点
    HeadFaceMgr:RefreshDatas()
end

function Refresh()
    SetDatas()
    SetExpiry()
    SetShopRefreshTime()

    RefreshPanel()
end

function SetDatas()
    curDatas = {}
    local cfgs = Cfgs.CfgIconEmote:GetAll()
    for k, v in pairs(cfgs) do
        local data = HeadFaceData.New()
        data:Init(v)
        if (data:CheckNeedShow()) then
            table.insert(curDatas, data)
        end
    end
    if (#curDatas > 1) then
        table.sort(curDatas, function(a, b)
            if (a:CheckCanUse() == b:CheckCanUse()) then
                return a:GetSortIndex() < b:GetSortIndex()
            else
                return a:CheckCanUse()
            end
        end)
    end
end

-- 最小刷新时间
function SetExpiry()
    minEndTime = nil -- 最小刷新时间
    for k, v in pairs(curDatas) do
        local isCanUse, _expiry = v:CheckCanUse()
        if (isCanUse and _expiry ~= nil) then
            if (minEndTime == nil) then
                minEndTime = _expiry
            else
                minEndTime = _expiry < minEndTime and _expiry or minEndTime
            end
        end
    end
end

-- 商店物品刷新时间
function SetShopRefreshTime()
    minShopTime = HeadFaceMgr:GetMinShopRefreshTime()
end

function Update()
    -- 头像框状态筛选
    if (minEndTime and TimeUtil:GetTime() > minEndTime) then
        SetExpiry()
        RefreshPanel()
    end
    -- 商店头像框状态刷新
    if (minShopTime and TimeUtil:GetTime() > minShopTime) then
        minShopTime = HeadFaceMgr:GetMinShopRefreshTime()
        Refresh()
    end
end

function RefreshPanel()
    SetLeft()
    SetRight()
    SetMask()
end

function SetLeft()
    lDatas = PlayerClient:GetEmotes()
    lItems = lItems or {}
    for k, v in ipairs(lDatas) do
        local _k0 = GetK0(k)
        local _k = k
        local _parent = this["parent" .. _k0 .. _k]
        if (lItems[k]) then
            lItems[k].SetIndex(k)
            lItems[k].Refresh(v)
            CSAPI.SetParent(lItems[k].gameObject, _parent)
        else
            ResUtil:CreateUIGOAsync("HeadFrame/HeadFrameLItem4", _parent, function(go)
                lItems[_k] = ComUtil.GetLuaTable(go)
                lItems[_k].SetIndex(_k)
                lItems[_k].SetClickCB(OnClickFace)
                lItems[_k].Refresh(v)
            end)
        end
    end
end

-- 右边
function SetRight()
    -- 通用，问好，胜利，失败
    local datas = {}
    for k, v in ipairs(curDatas) do
        if (v:SelectToShow(selectType, selectData)) then
            datas[v:GetType()] = datas[v:GetType()] or {}
            table.insert(datas[v:GetType()], v)
        end
    end
    local arr = {}
    for k = 1, 4 do
        if (datas[k]) then
            table.insert(arr, datas[k])
        end
    end
    items = items or {}
    ItemUtil.AddItems("HeadFrame/HeadFrameContainer4", items, arr, Content, ItemClickCB, 1, {selectType, selectData})
end

function ItemClickCB(data, _gameObject)
    clickGO = _gameObject
    if (selectType == 0) then
        InSelect(2, data:GetID())
    elseif (selectType == 1) then
        -- if (lDatas[selectData] ~= data:GetID()) then
        CSAPI.OpenView("HeadFrameDialog4", {selectData, data:GetID(), selectType})
        -- end
    elseif (selectType == 2) then
        InSelect(0, nil)
    end
end

function SetMask()
    CSAPI.SetGOActive(mask, selectType ~= 0)
    if (selectType == 0) then
        if (curItem) then
            CSAPI.RemoveGO(curItem)
            curItem = nil
        end
        CSAPI.SetParent(btnClickFace1, parent11)
        CSAPI.SetParent(btnClickFace2, parent12)
        CSAPI.SetParent(btnClickFace3, parent13)
        CSAPI.SetParent(sv, parent14)
    elseif (selectType == 1) then
        CSAPI.SetParent(this["btnClickFace" .. selectData], this["parent2" .. selectData])
        CSAPI.SetParent(sv, this["parent24"])
    elseif (selectType == 2) then
        local cfg = Cfgs.CfgIconEmote:GetByID(selectData)
        if (cfg.type == 0) then
            CSAPI.SetParent(btnClickFace1, parent21)
            CSAPI.SetParent(btnClickFace2, parent22)
            CSAPI.SetParent(btnClickFace3, parent23)
        else
            CSAPI.SetParent(this["btnClickFace" .. selectData], this["parent2" .. selectData])
        end
        -- 克隆副本
        curItem = CSAPI.CloneGO(clickGO, node2.transform)
        local x, y, z = CSAPI.GetPos(clickGO)
        CSAPI.SetPos(curItem, x, y, z)
    end
end

function InSelect(_selectType, _selectData)
    selectType = _selectType
    selectData = _selectData
    RefreshPanel()
end

function OnClickFace(item)
    local index = item.index
    if (selectType == 0) then
        InSelect(1, index)
    elseif (selectType == 1) then
        InSelect(0, nil)
    elseif (selectType == 2) then
        -- if (lDatas[index] ~= selectData) then
        CSAPI.OpenView("HeadFrameDialog4", {index, selectData, selectType})
        -- end
    end
end

function OnClickMask()
    InSelect(0, nil)
end

function GetK0(k)
    if (selectType == 1) then
        return selectData == k and 2 or 1
    elseif (selectType == 2) then
        local cfg = Cfgs.CfgIconEmote:GetByID(selectData)
        if (cfg.type == 1 or (cfg.type - 1) == k) then
            return 2
        end
    end
    return 1
end
