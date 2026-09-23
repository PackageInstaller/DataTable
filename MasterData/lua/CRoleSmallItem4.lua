local effectGO = nil

function SetClickCB(_cb)
    cb = _cb
end

function SetIndex(_index)
    index = _index
end

-- 头像列表
function Refresh(_data, _selectID)
    data = _data
    -- scale
    -- CSAPI.SetScale(gameObject, 0.68, 0.68, 1)
    -- use
    CSAPI.SetGOActive(use, data:IsMe(PlayerClient:GetIconId()))
    -- lock
    local isLock = false
    if (not _data:IsRoleIcon()) then
        isLock = BagMgr:GetData(data:GetItemID()) == nil
    end
    CSAPI.SetGOActive(lock, isLock)
    -- item/icon 
    if (_data:IsRoleIcon()) then
        -- 卡牌头像
        if (effectGO) then
            CSAPI.SetGOActive(effectGO, false)
        end
        CSAPI.SetGOActive(icon, true)
        local cfgModel = _data:GetCRoleInfo():GetBaseModel()
        if (cfgModel.icon) then
            ResUtil.RoleCard:Load(icon, cfgModel.icon)
            -- CSAPI.SetScale(icon, 0.86, 0.86, 1) -- icon 和特效默认0.86大小
        end
    else
        CSAPI.SetGOActive(icon, _data:GetCfg().type ~= 2)
        -- 是头像表
        if (_data:GetCfg().type == 2) then
            -- 动态
            if (effectGO) then
                if (effectGO.name == _data:GetCfg().id) then
                    CSAPI.SetGOActive(effectGO, true)
                    return
                end
                CSAPI.RemoveGO(effectGO)
            end
            ResUtil:CreateEffect(_data:GetCfg().avatareffect, 0, 0, 0, node, function(go)
                CSAPI.SetScale(go, 0.86, 0.86, 1)
                effectGO = go
                effectGO.name = _data:GetCfg().id
            end)
        else
            -- 静态
            if (effectGO) then
                CSAPI.SetGOActive(effectGO, false)
            end
            local path = _data:GetCfg().picture
            ResUtil.Head:Load(icon, path, true)
        end
    end
    -- select
    SetSelect(_data:IsSelect(_selectID))
    -- red 
    isAdd = false
    if (not _data:IsRoleIcon()) then
        isAdd = HeadIconMgr:CheckRed(data:GetItemID())
    end
    UIUtil:SetRedPoint(alphaNode, isAdd, 58, 58, 0)
end

function SetSelect(_isSelect)
    isSelect = _isSelect
    CSAPI.SetGOActive(select, _isSelect)
end

function OnClick()
    if (isAdd) then
        HeadIconMgr:RefreshData(data:GetItemID())
    end
    if (cb) then
        if (not isSelect) then
            cb(data:GetSelectID())
        end
    end
end
