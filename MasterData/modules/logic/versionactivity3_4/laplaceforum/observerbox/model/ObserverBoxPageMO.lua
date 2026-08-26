-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/observerbox/model/ObserverBoxPageMO.lua

module("modules.logic.versionactivity3_4.laplaceforum.observerbox.model.ObserverBoxPageMO", package.seeall)

local ObserverBoxPageMO = class("ObserverBoxPageMO")

function ObserverBoxPageMO:ctor()
	self.page = 0
	self.hasGetPoss = {}
end

function ObserverBoxPageMO:init(info)
	self.page = info.page

	self:_buildPosList(info.hasGetPoss)
end

function ObserverBoxPageMO:_buildPosList(infos)
	self.hasGetPoss = {}

	for _, info in ipairs(infos) do
		local posMO = ObserverBoxPosMO.New()

		posMO:init(info)

		self.hasGetPoss[info.pos] = posMO
	end
end

function ObserverBoxPageMO:updatePos(info)
	if not self.hasGetPoss[info.pos] then
		local posMO = ObserverBoxPosMO.New()

		posMO:init(info)

		self.hasGetPoss[info.pos] = posMO
	else
		self.hasGetPoss[info.pos]:update(info)
	end
end

function ObserverBoxPageMO:getPosBonusId(pos)
	for _, getPos in pairs(self.hasGetPoss) do
		if pos == getPos.pos then
			return getPos.bonusId
		end
	end

	return 0
end

return ObserverBoxPageMO
