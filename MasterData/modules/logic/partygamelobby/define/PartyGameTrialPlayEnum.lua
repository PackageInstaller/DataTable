-- chunkname: @modules/logic/partygamelobby/define/PartyGameTrialPlayEnum.lua

module("modules.logic.partygamelobby.define.PartyGameTrialPlayEnum", package.seeall)

local PartyGameTrialPlayEnum = class("PartyGameTrialPlayEnum")

PartyGameTrialPlayEnum.selectCountMap = {
	nil,
	1,
	nil,
	1,
	nil,
	nil,
	nil,
	2
}
PartyGameTrialPlayEnum.trialPlayerNumStep = {
	8,
	4,
	2
}

return PartyGameTrialPlayEnum
