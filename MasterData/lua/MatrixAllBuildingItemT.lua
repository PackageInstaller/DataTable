-- 建筑驻员列表
local isSelect = false

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _isSelect)
    data = _data
    isSelect = _isSelect
    if (data) then
        SetIcon()
        -- name
        CSAPI.SetText(txtName, data:GetBuildingName())
        -- lv
        CSAPI.SetText(txtLv2, "" .. data:GetLv())
        -- select
        SetSelect(isSelect)
        -- items 
        SetRoleItems()
        -- btn
        SetBtn()
    end
end

function SetBtn()
    CSAPI.SetGOActive(btnS, data:GetType() ~= BuildsType.Entry)
end

function SetSelect(b)
    CSAPI.SetGOActive(normal, not b)
    CSAPI.SetGOActive(select, b)
end

function SetIcon()
    local iconName = data:SetBaseCfg().icon
    if (iconName) then
        ResUtil.MatrixBuilding:Load(icon, iconName .. "_1", true)
    end
end

-- 驻员信息
function SetRoleItems()
    matrixRoleItems = matrixRoleItems or {}
    local datas = data:GetRoleInfos()
    ItemUtil.AddItems("CRoleItem/MatrixRole", matrixRoleItems, datas, roleGrid, ClickItemCB, 1, false, function()
        for i, v in ipairs(matrixRoleItems) do
            v.HideTxt()
        end
    end)
end

-- 点击空置
function ClickItemCB()
    -- CSAPI.OpenView("MatrixRoleSet", data)
    if (data:GetType() == BuildsType.Entry) then
        local roomID = GCalHelp:GetDormId(1, 1) -- 默认打开101房
        CSAPI.OpenView("DormSetRoleList", {roomID})
    else
        CSAPI.OpenView("DormSetRoleList", {data:GetId()})
    end
end

function OnClick()
    if (not isSelect and cb) then
        cb(data)
    end
end

-- 预设
function OnClickS()
    CSAPI.OpenView("MatrixRolePreset", data:GetId())
end
