-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\SeniorPVP\\SeniorPvpCheckTeamDlg.lua

local CheckTeamBase = require("UI/PVPMode/CheckTeamBase")
local strClassName = "SeniorPvpCheckTeamDlg"
local SeniorPvpCheckTeamDlg = Class(strClassName, CheckTeamBase)

function SeniorPvpCheckTeamDlg:ctor(...)
	return
end

function SeniorPvpCheckTeamDlg:getTeamsPos(...)
	return {
		Const.FORMATION_MULTIPVP_DEFEND_1,
		Const.FORMATION_MULTIPVP_DEFEND_2,
		Const.FORMATION_MULTIPVP_DEFEND_3
	}
end

function SeniorPvpCheckTeamDlg:enterFormation(index)
	local battleData = {}

	battleData.multiPvpData = {}
	battleData.multiPvpData.formationIndex = index

	CurAvatar:enterFormation(10001, BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM, battleData)
end

function SeniorPvpCheckTeamDlg:getSaveType(...)
	return Const.FORMATION_TYPE_MULTIPVP_DEFEND
end

return SeniorPvpCheckTeamDlg
