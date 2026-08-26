-- chunkname: @modules/logic/rouge/dlc/101/define/RougeDLCEnum101.lua

module("modules.logic.rouge.dlc.101.define.RougeDLCEnum101", package.seeall)

local RougeDLCEnum101 = _M

RougeDLCEnum101.LimitState = {
	Unlocked = 2,
	Locked = 1
}
RougeDLCEnum101.BuffType = {
	Middle = 2,
	Large = 3,
	Small = 1
}
RougeDLCEnum101.BuffState = {
	Unlocked = 2,
	Locked = 1,
	CD = 3,
	Equiped = 4
}
RougeDLCEnum101.MaxRiskDescCount = 3
RougeDLCEnum101.Const = {
	SpeedupCost = 4,
	MaxEmblemCount = 5
}
RougeDLCEnum101.LimiterBuffType = {
	Middle = 2,
	Large = 3,
	Small = 1
}
RougeDLCEnum101.StressPrefabPath = "ui/viewres/fight/fightstressitem.prefab"

return RougeDLCEnum101
