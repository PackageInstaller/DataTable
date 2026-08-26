-- chunkname: @modules/logic/summon/model/SummonCustomPickMO.lua

module("modules.logic.summon.model.SummonCustomPickMO", package.seeall)

local SummonCustomPickMO = pureTable("SummonCustomPickMO")

function SummonCustomPickMO:ctor()
	self.pickHeroIds = nil
	self._haveFirstSSR = false
end

function SummonCustomPickMO:update(info)
	self.pickHeroIds = {}

	if info.UpHeroIds then
		for i = 1, #info.UpHeroIds do
			local heroId = info.UpHeroIds[i]

			table.insert(self.pickHeroIds, heroId)
		end
	end

	self:sortPickHeroIdsByRule()

	if info.usedFirstSSRGuarantee ~= nil then
		self._haveFirstSSR = info.usedFirstSSRGuarantee
	end

	self.hasGetRewardProgresses = info.hasGetRewardProgresses or {}

	self:initOptionalRewardData(info)
end

function SummonCustomPickMO:isPicked(poolId)
	return self.pickHeroIds ~= nil and #self.pickHeroIds >= SummonCustomPickModel.instance:getMaxSelectCount(poolId)
end

function SummonCustomPickMO:isHaveFirstSSR()
	return self._haveFirstSSR
end

function SummonCustomPickMO:getRewardCount()
	if self.hasGetRewardProgresses then
		return #self.hasGetRewardProgresses
	end

	return 0
end

function SummonCustomPickMO:initOptionalRewardData(info)
	self.chooseRewardInfos = info.chooseRewardInfos or {}
	self._optionalRewardSelectDic = {}
	self._getOptionalRewardCount = 0

	if self.chooseRewardInfos and next(self.chooseRewardInfos) then
		for i, chooseRewardInfo in ipairs(self.chooseRewardInfos) do
			self:updateOptionalData(chooseRewardInfo.progress, chooseRewardInfo.chooseIndex)
		end
	end
end

function SummonCustomPickMO:updateOptionalData(progressId, chooseIndex)
	self._optionalRewardSelectDic[progressId] = chooseIndex

	if chooseIndex ~= 0 then
		self._getOptionalRewardCount = self._getOptionalRewardCount + 1
	end
end

function SummonCustomPickMO:getOptionalRewardCount()
	return self._getOptionalRewardCount or 0
end

function SummonCustomPickMO:getOptionalRewardSelect(progressId)
	return (self._optionalRewardSelectDic or nil) and (self._optionalRewardSelectDic[progressId] or 0)
end

function SummonCustomPickMO:isOptionalRewardGet(progressId)
	local selectIndex = self:getOptionalRewardSelect(progressId)

	return selectIndex ~= 0
end

function SummonCustomPickMO:sortPickHeroIdsByRule()
	if SummonEnum.ChooseNeedFirstHeroIds then
		for _, heroId in ipairs(SummonEnum.ChooseNeedFirstHeroIds) do
			for i, pickHeroId in ipairs(self.pickHeroIds) do
				if pickHeroId == heroId then
					table.remove(self.pickHeroIds, i)
					table.insert(self.pickHeroIds, 1, heroId)

					break
				end
			end
		end
	end

	if SummonEnum.ChooseNeedMiddleHeroIds then
		local middleIndex = math.ceil(#self.pickHeroIds / 2)

		for _, heroId in ipairs(SummonEnum.ChooseNeedMiddleHeroIds) do
			for i, pickHeroId in ipairs(self.pickHeroIds) do
				if pickHeroId == heroId then
					table.remove(self.pickHeroIds, i)
					table.insert(self.pickHeroIds, middleIndex, heroId)

					break
				end
			end
		end
	end
end

return SummonCustomPickMO
