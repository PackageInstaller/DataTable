local cfg = nil
local data = nil
local sectionData = nil
local isSweepOpen = false
local timeFunc = nil
local resetTime = 0
local timer = 0
local isFight = false

local time = 0
local hotTimer = 0
local hotTime = 0

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetBtn()
    end
end

function SetBtn()
    teamData = TeamMgr:GetTeamData(ColosseumMgr:GetTeamIndex(cfg.modeType))
    local alpha = teamData:GetCount() > 0 and 1 or 0.5
    CSAPI.SetGOAlpha(btnChallenge, alpha)
end

function OnClickChallenge()
    if (teamData and teamData:GetCount() > 0) then
        local duplicateTeamDatas = TeamMgr:DuplicateTeamData(1, teamData)
        local indexList = {ColosseumMgr:GetTeamIndex(cfg.modeType)}
        DungeonMgr:ApplyEnter(cfg.id, indexList, {duplicateTeamDatas})
    else
        LanguageMgr:ShowTips(44003)
    end
end
