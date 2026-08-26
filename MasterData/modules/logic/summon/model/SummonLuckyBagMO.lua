-- chunkname: @modules/logic/summon/model/SummonLuckyBagMO.lua

module("modules.logic.summon.model.SummonLuckyBagMO", package.seeall)

local SummonLuckyBagMO = pureTable("SummonLuckyBagMO")

function SummonLuckyBagMO:ctor()
	self.luckyBagIdUseDic = {}
	self.luckyBagIdGotDic = {}
	self.summonTimes = 0
	self.openedTimes = 0
	self.getTimes = 0
	self.notSSRCount = 0
end

function SummonLuckyBagMO:update(info)
	local openedTimes = 0
	local getTimes = 0

	if info.singleBagInfos and #info.singleBagInfos > 0 then
		for _, singleBagInfo in ipairs(info.singleBagInfos) do
			if singleBagInfo.isOpen then
				openedTimes = openedTimes + 1
			end

			getTimes = getTimes + 1
			self.luckyBagIdGotDic[singleBagInfo.bagId] = singleBagInfo.bagId
			self.luckyBagIdUseDic[singleBagInfo.bagId] = singleBagInfo.isOpen
		end
	end

	self.openedTimes = openedTimes
	self.getTimes = getTimes
	self.summonTimes = info.count or 0
	self.notSSRCount = info.notSSRCount or 0
end

function SummonLuckyBagMO:isGot(luckyBagId)
	if luckyBagId == nil then
		return self.getTimes > 0
	else
		if self.luckyBagIdGotDic == nil then
			return false
		end

		return self.luckyBagIdGotDic[luckyBagId] ~= nil
	end
end

function SummonLuckyBagMO:isOpened(luckyBagId)
	if luckyBagId == nil then
		return self:isGot() and self.getTimes <= self.openedTimes
	else
		if self.luckyBagIdUseDic == nil then
			return false
		end

		return self.luckyBagIdUseDic[luckyBagId]
	end
end

function SummonLuckyBagMO:getOpenTimes()
	return self.openedTimes or 0
end

return SummonLuckyBagMO
