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
        --SetBtn()
    end
end

function SetBtn()
    local dungeonCfg = Cfgs.DungeonGroup:GetByID(cfg.dungeonGroup)
    teamData = TeamMgr:GetTeamData(RogueTMgr:GetTeamIndex(dungeonCfg.hard))
    local alpha = teamData:GetCount() > 0 and 1 or 0.5
    CSAPI.SetGOAlpha(btnChallenge, alpha)
end

function OnClickEnter()

end
