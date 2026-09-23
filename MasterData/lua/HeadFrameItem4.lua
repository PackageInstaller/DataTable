local effectGO = nil

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _selectInfo)
    data = _data
    -- select
    local isSelect = false
    if (_selectInfo[1] == 2 and data:GetID() == _selectInfo[2]) then
        isSelect = true
    end
    CSAPI.SetGOActive(select, isSelect)
    -- lock 
    CSAPI.SetGOActive(lock, not data:CheckCanUse())
    -- 
    --CSAPI.SetGOAlpha(effectParent,data:CheckCanUse() and 1 or 0.5)
    -- icon或特效
    SetIcon(data:GetCfg())
    -- use
    CSAPI.SetGOActive(use, data:CheckUse())
    -- red 
    isAdd = HeadFaceMgr:CheckRed(data:GetItemID())
    UIUtil:SetRedPoint(clickNode, isAdd, 65, 65, 0)
    local isLimit = false 
    if (not isAdd) then
        -- 限时
        local isCanUse, expiry = data:CheckCanUse()
        if(isCanUse and expiry~=nil)then 
            isLimit = expiry~=0 
        end
    end
    UIUtil:SetLimitPoint(clickNode, isLimit,65, 65, 0)
    -- 
    --CSAPI.SetGOAlpha(icon, data:CheckCanUse() and 1 or 0.5)
end

function SetIcon(cfg)
    CSAPI.SetGOActive(icon, cfg.picture ~= nil)
    CSAPI.SetGOActive(effectParent, cfg.avatareffect ~= nil)
    local picture = cfg.picture
    local avatareffect = cfg.avatareffect
    if (picture ~= nil) then
        ResUtil.HeadFace:Load(icon, picture[1], true)
        ResUtil.HeadFace:Load(icon2, picture[2], true)
        local textPos = cfg.textPos or {0, 0}
        CSAPI.SetAnchor(icon2, textPos[1], textPos[2])
    else
        if (effectGO) then
            if (effectGO.name == avatareffect) then
                return
            end
            CSAPI.RemoveGO(effectGO)
        end
        ResUtil:CreateEffect(avatareffect, 0, 0, 0, effectParent, function(go)
            effectGO = go
            effectGO.name = avatareffect
        end)
    end
end

function OnClick()
    if (isAdd) then
        HeadFaceMgr:RefreshData(data:GetItemID())
    end
    if (cb) then
        cb(data,gameObject)
    end
end
