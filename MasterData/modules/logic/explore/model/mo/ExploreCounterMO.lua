-- chunkname: @modules/logic/explore/model/mo/ExploreCounterMO.lua

module("modules.logic.explore.model.mo.ExploreCounterMO", package.seeall)

local ExploreCounterMO = pureTable("ExploreCounterMO")

function ExploreCounterMO:init(id)
	self.id = id
	self.tarUnitId = id
	self.dic = {}
	self.tarCount = 0
	self.nowCount = 0
end

function ExploreCounterMO:addTarCount()
	self.tarCount = self.tarCount + 1
end

function ExploreCounterMO:addCountSource(unitId)
	self.dic[unitId] = false
	self.tarCount = tabletool.len(self.dic)
end

function ExploreCounterMO:reCalcCount()
	local dict = ExploreMapModel.instance:getUnitDic()

	for unitId in pairs(self.dic) do
		local unitMO = dict[unitId]
		local interactInfoMO = unitMO:getInteractInfoMO()

		self.dic[unitId] = interactInfoMO:getBitByIndex(ExploreEnum.InteractIndex.ActiveState) == 1
	end

	self:updateNowCount()
end

function ExploreCounterMO:add(unitId)
	self.dic[unitId] = true

	local oldCount = self.nowCount

	self:updateNowCount()

	return oldCount < self.tarCount and self.nowCount >= self.tarCount
end

function ExploreCounterMO:reduce(unitId)
	self.dic[unitId] = false

	local oldCount = self.nowCount

	self:updateNowCount()

	return oldCount >= self.tarCount and self.nowCount < self.tarCount
end

function ExploreCounterMO:updateNowCount()
	self.nowCount = 0

	for i, v in pairs(self.dic) do
		if v then
			self.nowCount = self.nowCount + 1
		end
	end
end

return ExploreCounterMO
