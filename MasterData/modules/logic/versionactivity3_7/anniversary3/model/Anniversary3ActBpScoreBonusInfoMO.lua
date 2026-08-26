-- chunkname: @modules/logic/versionactivity3_7/anniversary3/model/Anniversary3ActBpScoreBonusInfoMO.lua

module("modules.logic.versionactivity3_7.anniversary3.model.Anniversary3ActBpScoreBonusInfoMO", package.seeall)

local Anniversary3ActBpScoreBonusInfoMO = class("Anniversary3ActBpScoreBonusInfoMO")

function Anniversary3ActBpScoreBonusInfoMO:init()
	self.level = 0
	self.hasGetFreeBonus = false
	self.hasGetPayBonus = false
end

function Anniversary3ActBpScoreBonusInfoMO:update(info)
	self.level = info.level

	if info:HasField("hasGetfreeBonus") then
		self.hasGetFreeBonus = info.hasGetfreeBonus
	end

	if info:HasField("hasGetPayBonus") then
		self.hasGetPayBonus = info.hasGetPayBonus
	end
end

return Anniversary3ActBpScoreBonusInfoMO
