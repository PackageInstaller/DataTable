-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\AsycPvpCheckTeamDlg.lua

local CheckTeamBase = require("UI/PVPMode/CheckTeamBase")
local strClassName = "AsycPvpCheckTeamDlg"
local AsycPvpCheckTeamDlg = Class(strClassName, CheckTeamBase)

function AsycPvpCheckTeamDlg:ctor(...)
	return
end

function AsycPvpCheckTeamDlg:getTeamsPos(...)
	return {
		Const.FORMATION_ASYNC_DEFEND
	}
end

function AsycPvpCheckTeamDlg:enterFormation(index)
	CurAvatar:enterDefendFormation(10001, BattleConst.FORMATION_TYPE_ASYNC_PVP, {})
end

return AsycPvpCheckTeamDlg
