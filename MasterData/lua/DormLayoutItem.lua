cur = 0
local isDrag = false
local colors = {"00FFBF", "FF6130", "FFC146"} -- 已放置，已占用，未拥有
local stateLanIDs = {32075, 32076, 32077}
local isSet = false -- 是已放置，并且无法再放置

-- function Awake()
--     dragCallLua = ComUtil.GetCom(clickNode, "DragCallLua")
-- end
-- function SetScrollRect(sr)
--     dragCallLua:SetScrollRect(sr)
-- end

function SetIndex(_index, _itemClick)
    index = _index
    itemClick = _itemClick
end

-- data 3种类型
-- 主题表 cfg 
-- 家具 cfg 
-- 保存的主题 themeData
function Refresh(_curDataType, _data)
    curDataType = _curDataType
    data = _data
    -- dragXY = _dragXY
    -- dragEndXY = _dragEndXY

    SetIcon()
    SetName()
    SetComfort()
    SetCount()
    CSAPI.SetGOActive(btnRemove, curDataType == 3)
    CSAPI.SetGOActive(btnLook, curDataType ~= 3)
end

function SetIcon()
    local b = false
    local scale, y = 1, 0
    if (curDataType == 1) then
        ResUtil.Theme:Load(icon, data.id .. "/" .. data.id, true)
    elseif (curDataType == 2) then
        ResUtil.Furniture:Load(icon, data.icon, true)
        b = true
    else
        DormIconUtil.SetIcon(icon, data.img .. "_s")
        scale, y = 1.4, -24 -- 0.5, -50
    end
    CSAPI.SetGOActive(iconBg, b)
    CSAPI.SetScale(icon, scale, scale, 1)
    CSAPI.SetAnchor(icon, 0, y, 0)
end

function SetName()
    local name = ""
    if (curDataType == 1) then
        name = data.sName
    elseif (curDataType == 2) then
        name = data.sName
    else
        name = data.name
    end
    CSAPI.SetText(txtName, name)
end

function SetComfort()
    local comfort = 0
    if (curDataType == 1) then
        comfort = data.comfort or 0
    elseif (curDataType == 2) then
        comfort = data.comfort or 0
    else
        if (data.furnitures) then
            for k, v in pairs(data.furnitures) do
                local cfgID = GCalHelp:GetDormFurCfgId(v.id)
                local cfg = Cfgs.CfgFurniture:GetByID(cfgID)
                comfort = comfort + cfg.comfort
            end
        end
    end
    CSAPI.SetText(txtComfort, comfort .. "")
end

function SetCount()
    isSet = false
    cur, max, use = nil, 0, 0
    if (curDataType == 1) then
        cur, max = DormMgr:GetThemeCount(data.id)
    elseif (curDataType == 2) then
        cur, max, use = DormMgr:GetFurnitureCount(data.id)
    end
    -- 状态
    if (curDataType == 2) then
        CSAPI.SetGOActive(objState, cur <= 0)
        if (cur <= 0) then
            local index = 3
            if (max > 0) then
                index = use > 0 and 1 or 2
            end
            CSAPI.SetImgColorByCode(imgState1, colors[index], true)
            LanguageMgr:SetText(txtTips, stateLanIDs[index])

            isSet = index == 1
        end
    else
        CSAPI.SetGOActive(objState, false)
    end
    CSAPI.SetGOActive(objNum, cur ~= nil)
    if (cur ~= nil) then
        CSAPI.SetText(txtNum, string.format("%s/%s", cur, max))
    end
end

-- -- 拖出
-- function IsDrag()
--     return dragCallLua:GetIsDrag() == 1
-- end

-- function OnBeginDragXY(x1, y1, x2, y2)
--     if (curDataType ~= 2 or cur <= 0) then
--         return
--     end
--     if (IsDrag() and dragXY) then
--         dragXY(data)
--     end
-- end

-- function OnEndDragXY(x1, y1, x2, y2)
--     if (curDataType ~= 2 or cur <= 0) then
--         return
--     end
--     if (IsDrag() and dragEndXY) then
--         dragEndXY(data)
--     end
-- end

-- 点击
function OnClick()
    if (itemClick ~= nil) then
        itemClick(this)
    end
end

-- 显示详情
function OnClickLook()
    if (curDataType == 1) then
        -- 点选主题
        CSAPI.OpenView("DormLayoutThemeCof", {ThemeType.Sys, data})
    elseif (curDataType == 2) then
        -- 点选家具
        -- CSAPI.OpenView("DormLayoutFurnitureCof", data)
        local goodsInfo = BagMgr:GetFakeData(data.itemId)
        UIUtil:OpenGoodsInfo(goodsInfo)
    elseif (curDataType == 3) then
        -- 保存的主题 
        CSAPI.OpenView("DormLayoutThemeCof", {ThemeType.Save, data})
    end
end

-- 移除保存的主题
function OnClickRemove()
    if (curDataType == 3) then
        UIUtil:OpenDialog(LanguageMgr:GetTips(21005), function()
            DormProto:UnSaveTheme(data.id)

            -- 移除截图
            DormIconUtil.RemoveScreenshot(data.img)
            DormIconUtil.RemoveScreenshot(data.img .. "_s") -- 小图
        end)
    end
end
