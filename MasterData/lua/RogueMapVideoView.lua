local criMovie = nil

function OnOpen()
    if data and not criMovie then
        local video = ResUtil:PlayVideo(data.name, effectParent.gameObject)
        video:AddCompleteEvent(function()
            criMovie = nil
            if openSetting then
                openSetting()
            end
            RogueMapBattleMgr:SetRollEffect(false)
            RogueMapMgr:ShowRogueMapLv() -- 延迟播放升级框
            view:Close()
        end)
    end
end

function OnClickClose()
    if not criMovie then
        return
    end
    criMovie:Remove()
    if openSetting then
        openSetting()
    end
    RogueMapBattleMgr:SetRollEffect(false)
    RogueMapMgr:ShowRogueMapLv()
    view:Close()
end
