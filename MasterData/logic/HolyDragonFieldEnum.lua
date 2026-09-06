-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/data/HolyDragonFieldEnum.lua

module("logic.extensions.holydragonfield.data.HolyDragonFieldEnum", package.seeall)

local HolyDragonFieldEnum = {}

HolyDragonFieldEnum.StageType = {
	Boss = 2,
	Normal = 1
}
HolyDragonFieldEnum.SettleType = {
	CircleCount = "CircleCount",
	Alive = "Alive",
	ActiveCount = "ActiveCount",
	BossDamage = "BossDamage",
	ComboCount = "ComboCount",
	UltimateCount = "UltimateCount",
	KillCount = "KillCount"
}

return HolyDragonFieldEnum
