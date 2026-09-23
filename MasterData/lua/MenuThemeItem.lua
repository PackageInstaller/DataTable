local expiry = nil

function SetClickCB(_cb)
    cb = _cb
end

function Update()
    if (expiry) then
        local timer = expiry - TimeUtil:GetTime()
        timer = timer <= 0 and 0 or timer
        CSAPI.SetText(txtTime, TimeUtil:GetTimeStr10(timer))
        if (timer <= 0) then
            expiry = nil
            Refresh(data)
        end
    end
end

function Refresh(_data, selectID)
    data = _data
    -- icon 
    local iconName = data:GetCfg().icon
    ResUtil.MenuTheme:Load(icon, iconName)
    -- name
    CSAPI.SetText(txtName, data:GetCfg().name)
    -- objTime 
    local isCanUse, _expiry = data:CheckCanUse()
    expiry = _expiry
    CSAPI.SetGOActive(objTime, expiry ~= nil)
    -- use
    local useID = MenuThemeMgr:GetMenuThemeID()
    CSAPI.SetGOActive(use, useID == data:GetID())
    -- lock 
    CSAPI.SetGOActive(lock, not isCanUse)
    CSAPI.SetGOAlpha(icon, isCanUse and 1 or 0.5)
    -- select
    CSAPI.SetGOActive(select, selectID == data:GetID())
    -- red 
    isAdd = MenuThemeMgr:CheckRed(data:GetItemID())
    UIUtil:SetRedPoint(clickNode, isAdd, 304, 83, 0)
end

function OnClick()
    if (isAdd) then
        MenuThemeMgr:RefreshData(data:GetItemID())
    end
    if (cb) then
        cb(data:GetID())
    end
end
