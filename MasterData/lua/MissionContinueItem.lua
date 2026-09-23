local isLock = false
local isGet = false
local isSel = false
local cb = false
local daylId = {1008, 1009, 1010, 1011, 1012, 1013, 1046}
local text = nil
local mType = nil

function Awake()
    CSAPI.SetGOActive(selObj, false)
    text = ComUtil.GetCom(txtTitle, "Text")

    SetSel(false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _elseData)
    data = _data
    isLock = _elseData.isLock
    mType = _elseData.type
    if data then
        isGet = data:IsGet()
        text.text = LanguageMgr:GetByID(mType == eTaskType.Seven and 22016 or 22018, LanguageMgr:GetByID(daylId[index]))
        if isLock then
            CSAPI.SetTextColor(text.gameObject, 255, 255, 255, 178)
        end
        CSAPI.SetGOActive(lock, isLock)
        CSAPI.SetGOActive(get, IsAllGet())

        -- red
        SetRed(IsRed())
    end
end

function SetRed(b)
    if isLock then
        b = false
    end
    UIUtil:SetRedPoint2("Common/Red2", gameObject, b, 89.8, 23.8)
end

function SetSel(_isSel)
    isSel = _isSel
    CSAPI.SetGOActive(selObj, _isSel)
    local textColor = isSel and {255, 193, 70, 255} or {255, 255, 255, 255}
    CSAPI.SetTextColor(text.gameObject, textColor[1], textColor[2], textColor[3], textColor[4])
    text.fontSize = isSel and 36 or 30
    CSAPI.SetRTSize(text.gameObject,isSel and 108 or 90,0)

    -- red
    SetRed(IsRed())
end

function IsRoleReward()
    if data and data:GetCfg() then
        return data:GetCfg().bRole ~= nil
    end
    return false
end

function IsFinish()
    return data and data:IsFinish()
end

function IsGet()
    return data and data:IsGet()
end

function IsAllGet()
    if not data or not data:IsGet() then
        return false
    end

    local missDatas = MissionMgr:GetActivityDatas(mType, nil, data:GetCfgID())
    if missDatas then
        for _, v in ipairs(missDatas) do
            if not v:IsGet() then
                return false
            end
        end
    end

    return true
end

function IsRed()
    if data and data:IsFinish() and not data:IsGet() then
        return true
    end
    local cfgID = data and data:GetCfgID() or nil
    if cfgID and cfgID > 0 then
        local missDatas = MissionMgr:GetActivityDatas(mType, nil, cfgID)
        if missDatas then
            for _, v in ipairs(missDatas) do
                if v:IsFinish() and not v:IsGet() then
                    return true
                end
            end
        end
    end
    
    return false
end

function OnClick()
    if isLock then
        LanguageMgr:ShowTips(mType == eTaskType.Guide and 28002 or 28001, LanguageMgr:GetByID(daylId[index]))
        return
    end
    if cb then
        cb(this)
    end
end
