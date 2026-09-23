local info = nil
local items = nil
local currItem = nil

function Refresh(_data)
    info = _data
    if info then
        local teams = TeamMgr:GetFightTeam()
        items = items or {}
        ItemUtil.AddItems("RogueMapBattle/RogueMapTeamList", items, teams, teamParent, OnTeamItemClickCB, 1, info,
            OnItemLoadSuccess)
        if #teams == 1 then
            CSAPI.SetRTSize(teamBg, 1159, 525)
        end
    end
end

-- 编队点击
function OnTeamItemClickCB(item)
    if currItem and currItem.index == item.index then
        return
    end
    if currItem then
        currItem.SetSelect(false)
        currItem = nil
    end
    currItem = item
    currItem.SetSelect(true)
end

function OnItemLoadSuccess()
    if #items > 0 then
        for i, v in ipairs(items) do
            if not v.IsCool() then
                v.OnClick()
                break
            end
        end
    end
end

function OnClickBattle()
    if not currItem then
        LanguageMgr:ShowTips(50011)
        return
    end

    RogueMapMgr:ApplyFight(currItem.GetTeamIndex(), currItem.GetGridId())
end

function OnClickDirll()
    if not currItem then
        LanguageMgr:ShowTips(50011)
        return
    end

    RogueMapMgr:ApplyFight(currItem.GetTeamIndex(), currItem.GetGridId(), true)
end

function OnClickClose()
    if currItem then
        currItem.SetSelect(false)
        currItem = nil
    end
    if this.OnViewClose then
        this.OnViewClose(this)
    end
end
