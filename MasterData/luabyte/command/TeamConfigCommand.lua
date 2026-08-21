--活动命令
local TeamConfigCommand = BaseClass("TeamConfigCommand", BaseCommand)
local M = TeamConfigCommand
local EBattleStyle = EnumConst.EBattleStyle

function M:Execute(isTeach, battleMissionId, teamConfigStyle)
    TeamConfMgr:GetInstance():OpenTeamConfUI(isTeach, battleMissionId, teamConfigStyle, nil, EBattleStyle.Normal)
end

return TeamConfigCommand
