-- chunkname: @modules/logic/fight/model/data/FightLYDataMgr.lua

module("modules.logic.fight.model.data.FightLYDataMgr", package.seeall)

local FightLYDataMgr = FightDataClass("FightLYDataMgr", FightDataMgrBase)

function FightLYDataMgr:onConstructor()
	self.LYCardAreaSize = 0
	self.LYPointAreaSize = 0
	self.pointList = nil
end

function FightLYDataMgr:setLYCardAreaBuff(buffMo)
	self.cardAreaBuff = buffMo
	self.LYCardAreaSize = 0

	local buffCo = buffMo and buffMo:getCO()
	local featureList = FightBuffHelper.getFeatureList(buffCo, FightEnum.BuffType_CardAreaRedOrBlue)

	if featureList then
		self.LYCardAreaSize = tonumber(featureList[2])
	end

	FightController.instance:dispatchEvent(FightEvent.LY_CardAreaSizeChange)
end

function FightLYDataMgr:getCardColor(cardList, index)
	if cardList then
		if not #cardList then
			local len = 0
			local isBlue = len - index < self.LYCardAreaSize
			local isRed = index <= self.LYCardAreaSize

			if isBlue and isRed then
				return FightEnum.CardColor.Both
			end

			if isBlue then
				return FightEnum.CardColor.Blue
			end

			if isRed then
				return FightEnum.CardColor.Red
			end

			return FightEnum.CardColor.None
		end
	end
end

function FightLYDataMgr:checkIsMySideBuff(buffMo)
	if not buffMo then
		return true
	end

	local uid = buffMo.entityId
	local entityMo = FightDataHelper.entityMgr:getById(uid)
	local side = entityMo.side

	return side == FightEnum.EntitySide.MySide
end

function FightLYDataMgr:setLYCountBuff(buffMo)
	if not self:checkIsMySideBuff(buffMo) then
		return
	end

	self.countBuff = buffMo

	self:refreshPointList()
	self:refreshShowAreaSize()
end

function FightLYDataMgr:setLYChangeTriggerBuff(buffMo)
	if not self:checkIsMySideBuff(buffMo) then
		return
	end

	self.changeTriggerBuff = buffMo

	self:refreshShowAreaSize()
end

function FightLYDataMgr:refreshShowAreaSize()
	self.LYPointAreaSize = 0

	if self.countBuff then
		local buffCo = self.countBuff:getCO()
		local featureList = FightBuffHelper.getFeatureList(buffCo, FightEnum.BuffType_RedOrBlueCount)

		if featureList then
			self.LYPointAreaSize = tonumber(featureList[2])
		end

		if self.changeTriggerBuff then
			buffCo = self.changeTriggerBuff:getCO()
			featureList = FightBuffHelper.getFeatureList(buffCo, FightEnum.BuffType_RedOrBlueChangeTrigger)

			if featureList then
				local tempCount = tonumber(featureList[2]) or 0

				self.LYPointAreaSize = self.LYPointAreaSize + tempCount * self.changeTriggerBuff.layer
			end
		end
	end

	FightController.instance:dispatchEvent(FightEvent.LY_PointAreaSizeChange)
end

function FightLYDataMgr:getPointList()
	return self.pointList
end

function FightLYDataMgr:refreshPointList(force)
	if self.pointList then
		if not #self.pointList then
			local preLen = 0

			if not self.countBuff then
				self.pointList = nil

				FightController.instance:dispatchEvent(FightEvent.LY_HadRedAndBluePointChange, self.pointList, preLen)

				return
			end

			if not force then
				local curPointList = FightStrUtil.instance:getSplitToNumberCache(self.countBuff.actCommonParams, "#")

				if preLen > #curPointList then
					return
				end
			end

			local pointList = FightStrUtil.instance:getSplitToNumberCache(self.countBuff.actCommonParams, "#")

			self.pointList = tabletool.copy(pointList)

			table.remove(self.pointList, 1)
			FightController.instance:dispatchEvent(FightEvent.LY_HadRedAndBluePointChange, self.pointList, preLen)
		end
	end
end

function FightLYDataMgr:hasCountBuff()
	return self.countBuff ~= nil
end

return FightLYDataMgr
