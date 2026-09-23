
local curSupType = nil

function Refresh(_data)
    curSupType = nil
    local requireMax = RogueMapMgr:GetGlobal("dailyRequestNum") or 0
    LanguageMgr:SetText(txtSupDesc, 76035, math.floor(requireMax - RogueMapMgr:GetRequireNum()), "/" .. requireMax)
end


function OnClickAssist(go)
    curSupType = go.name == "btn_friend" and eDupSupportType.Friend or eDupSupportType.All
    currGridId = currGridId or RogueMapBattleMgr:GetCtrlGridId()
    if not currGridId then
        return
    end
    EventMgr.Dispatch(EventType.Net_Msg_Wait, {
        msg = "rogueMap_battle_support",
        time = 5000,
        timeOutCallBack = function()
            LanguageMgr:ShowTips(1008)
        end
    });

    FightProto:RogueMapRequireHelp(curSupType, currGridId)
    OnClickClose()
end

function OnRogueMapNeedSupport(proto)
    RogueMapMgr:SetShowSupportView()
    OnClickClose()
end

function OnClickClose()
    if RogueMapMgr:IsShowSupportView() then
        FightProto:RogueMapNeedSupport(false, OnRogueMapNeedSupport)
    end
    if this.OnViewClose then
        this.OnViewClose(this)
    end
end
