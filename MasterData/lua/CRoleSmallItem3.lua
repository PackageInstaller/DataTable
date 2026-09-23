local effectGO = nil

function SetClickCB(_cb)
    cb = _cb
end

function SetIndex(_index)
    index = _index
end

-- 头像界面右侧 1.48
function Refresh(_skinInfo)
    skinInfo = _skinInfo
    -- use 
    CSAPI.SetGOActive(use, false)
    -- lock
    CSAPI.SetGOActive(lock, false)
    -- icon 必定是静态
    local modelCfg = Cfgs.character:GetByID(skinInfo:GetSkinID())
    if (modelCfg and modelCfg.icon) then
        ResUtil.RoleCard:Load(icon, modelCfg.icon)
    end
end

function GetIndex()
    return index
end

function SetSelect(_isSelect)
    isSelect = _isSelect
    CSAPI.SetGOActive(select, _isSelect)
    SetAlpha(isSelect and 1 or 0.5)
end

function SetSibling(index)
    index = index or 0
    if index == -1 then
        transform:SetAsLastSibling()
    else
        transform:SetSiblingIndex(index)
    end
end

-- 根据X轴距离设置大小
function SetScale(s)
    CSAPI.SetScale(alphaNode, s, s, s)
end

function SetAlpha(val)
    CSAPI.SetGOAlpha(alphaNode, val)
end

function GetPos()
    local pos = {100000, 100000, 0}
    local x, y, z = CSAPI.GetPos(alphaNode)
    pos = {x, y, z}
    return pos
end

function OnClick()
    if (isAdd) then
        HeadIconMgr:RefreshData(data:GetItemID())
    end
    if (cb) then
        cb(index)
    end
end
