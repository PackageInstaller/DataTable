local landIDs = {72002, 72003, 72004}
-- {index,newid,selectType}
function OnOpen()
    icon_emotes = table.copy(PlayerClient:GetEmotes())
    -- icons 
    SetIcons()
    -- tips 
    local landID = landIDs[data[1]]
    local str = LanguageMgr:GetByID(landID)
    LanguageMgr:SetText(txtTips1, 72007, str)
end

function OnDestroy()
    cacheID = nil
    RoleAudioPlayMgr:StopSound()
end

function SetIcons()
    -- old 
    local oldID = icon_emotes[data[1]]
    if (lItem) then
        lItem.Refresh(oldID)
    else
        ResUtil:CreateUIGOAsync("HeadFrame/HeadFrameLItem4", parent1, function(go)
            lItem = ComUtil.GetLuaTable(go)
            lItem.SetIndex(data[1])
            lItem.SetClickNodeRaycastTarget(false)
            lItem.Refresh(oldID)
        end)
    end
    -- new 
    local newID = data[2]
    if (rItem) then
        rItem.Refresh(oldID)
    else
        ResUtil:CreateUIGOAsync("HeadFrame/HeadFrameLItem4", parent2, function(go)
            rItem = ComUtil.GetLuaTable(go)
            rItem.SetIndex(data[1])
            rItem.SetClickNodeRaycastTarget(false)
            rItem.Refresh(newID)
        end)
    end
    --
    local cfg1 = Cfgs.CfgIconEmote:GetByID(oldID)
    lSound = cfg1.sound
    CSAPI.SetGOActive(imgAudio1, lSound ~= nil)
    -- 
    local rID = data[2]
    local cfg2 = Cfgs.CfgIconEmote:GetByID(rID)
    rSound = cfg2.sound
    CSAPI.SetGOActive(imgAudio2, rSound ~= nil)
end

function OnClickC()
    view:Close()
end

function OnClickSure()
    icon_emotes[data[1]] = data[2]
    PlayerProto:SetIconEmote(icon_emotes, function()
        local landID = landIDs[data[1]]
        local str = LanguageMgr:GetByID(landID)
        LanguageMgr:ShowTips(49001, str)
    end)
    view:Close()
end

---返回虚拟键公共接口
function OnClickVirtualkeysClose()
    view:Close()
end

function OnClick1()
    if (lSound) then
        PlayAudio(lSound)
    end
end

function OnClick2()
    if (rSound) then
        PlayAudio(rSound)
    end
end

function PlayAudio(id)
    cacheID = id or cacheID
    if (cacheID ~= nil) then
        RoleAudioPlayMgr:PlayById(nil, cacheID)
    end
end
