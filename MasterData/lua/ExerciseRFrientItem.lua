local runTime = false
local timer = 0
local needTime = 0

function Awake()
    cg_btnYQ1 = ComUtil.GetCom(btnYQ1, "CanvasGroup")
end

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
function Refresh(_data)
    data = _data

    isOnLine = data:IsOnLine()
    isInPVP = data:GetIsInPVP()

    local askData = ExerciseFriendTool:GetInviteData(data:GetUid())
    if (askData) then
        if(askData.is_cancel)then 
            invite_time = askData.invite_time + g_ArmyInviteCoolDown
        else 
            invite_time = askData.invite_time + g_ArmyFriendInviteDiffTime
        end  
    else
        invite_time = nil
    end
    -- 
    --AddCRoleItem()

    -- name
    CSAPI.SetText(txtName, data:GetName())
    -- uid 
    CSAPI.SetText(txtUID, "UID  " .. data:GetUid() .. "")
    -- btn
    SetBtn()
    -- state 
    local id, colorName, imgName = 33054, 929296, "img_15_03"
    if (isOnLine) then
        id = isInPVP and 33053 or 33052
        colorName = isInPVP and "ff7781" or "ffc146"
        imgName = isInPVP and "img_15_02" or "img_15_01"
    end
    local str = LanguageMgr:GetByID(id)
    StringUtil:SetColorByName(txtState, str, colorName)
    CSAPI.LoadImg(imgState, "UIs/ExerciseR/" .. imgName .. ".png", true, nil, true)
    --head
    UIUtil:AddHeadByID(hfParent, 0.7, data:GetFrameId(), data:GetIconId(),data:GetSex())
end

-- function AddCRoleItem()
--     if (not cRoleLittleItem2) then
--         ResUtil:CreateUIGOAsync("CRoleItem/CRoleSmallItem2", iconParent, function(go)
--             cRoleLittleItem2 = ComUtil.GetLuaTable(go)
--             cRoleLittleItem2.Refresh(data:GetLv(), data:GetIconId())
--         end)
--     else
--         cRoleLittleItem2.Refresh(data:GetLv(), data:GetIconId())
--     end
-- end

function SetBtn()
    local btnShow1 = true
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
    cg_btnYQ1.alpha = (isOnLine and not isInPVP) and 1 or 0.3
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
    if (isOnLine and not runTime) then
        local id = data:GetUid()
        ArmyProto:InviteFriend({{
            uid = data:GetUid(),
            is_cancel = false
        }}, YQCB)
    end
end

function YQCB(proto)
    for i, v in pairs(proto.ops) do
        if (v.uid == data:GetUid()) then
            invite_time = v.invite_time + g_ArmyFriendInviteDiffTime
            SetBtn()
            break
        end
    end
end
