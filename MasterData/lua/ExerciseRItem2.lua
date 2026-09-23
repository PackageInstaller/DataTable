local runTime = false
local timer = 0
local needTime = 0

function Update()
    if (runTime) then
        timer = timer - Time.deltaTime
        if (timer < 0) then
            timer = 0.2
            SetTime()
        end
    end
end

-- FriendInfo
function Refresh(_data, _cb)
    data = _data
    cb = _cb

    isOnLine = data:IsOnLine()
    isInPVP = false -- data:GetIsInPVP()

    local askData = ExerciseFriendTool:GetInviteData(data:GetUid())
    if (askData and askData.invite_time) then
        invite_time = askData.invite_time + g_ArmyFriendInviteDiffTime
    else
        invite_time = nil
    end
    -- name
    CSAPI.SetText(txtName, data:GetName())
    -- 
    CSAPI.SetText(txtLevel, data:GetLv().."")
    -- btn
    SetBtn()
    -- state 
    local id, colorName = 33054, "7a7b7a"
    if (isOnLine) then
        id = isInPVP and 33053 or 33052
        colorName = isInPVP and "ff7781" or "8cff46"
    end
    local str = LanguageMgr:GetByID(id)
    StringUtil:SetColorByName(txtState, str, colorName)
    --
    UIUtil:AddHeadByID(hfParent, 0.7, data:GetFrameId(), data:GetIconId(), data:GetSex())
    UIUtil:AddTitleByID(titleParent, 1, data:GetTitle())
end

function SetBtn()
    local btnShow1 = false
    local btnShow2 = false
    runTime = false
    if (isOnLine) then
        if (isInPVP) then
            -- 对战中
            btnShow1 = true
            btnShow2 = false
        elseif (invite_time ~= nil and invite_time > TimeUtil:GetTime()) then
            -- 邀请中
            btnShow1 = false
            btnShow2 = true
            runTime = true
        else
            -- 等待邀请
            btnShow1 = true
            btnShow2 = false
        end
    end
    CSAPI.SetGOActive(btnYQ1, btnShow1)
    CSAPI.SetGOActive(btnYQ2, btnShow2)
    CSAPI.SetGOAlpha(btnYQ1, (isOnLine and not isInPVP) and 1 or 0.3)
end

function SetTime()
    if (invite_time > 0) then
        needTime = invite_time - TimeUtil:GetTime()
        needTime = needTime > 0 and needTime or 0
    else
        needTime = 0
    end
    runTime = needTime > 0
    CSAPI.SetText(txtYQ2, needTime .. "")
    if (not runTime) then
        SetBtn()
    end
end

function OnClickYQ1()
    if (isOnLine and not isInPVP and not runTime and cb) then
        cb(data:GetUid())
    end
end

