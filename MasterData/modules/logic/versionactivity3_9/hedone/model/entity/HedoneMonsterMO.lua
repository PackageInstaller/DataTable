-- chunkname: @modules/logic/versionactivity3_9/hedone/model/entity/HedoneMonsterMO.lua

module("modules.logic.versionactivity3_9.hedone.model.entity.HedoneMonsterMO", package.seeall)

local HedoneMonsterMO = class("HedoneMonsterMO", HedoneBaseUnitMO)

function HedoneMonsterMO:onCtor(data)
	self._groupId = data.groupId
	self._yLevel = data.yLevel

	local attrSet = self:getAttrSetMO()
	local baseAttrArr = HedoneConfig.instance:getHedoneMonsterBaseAttr(self._id)
	local baseAttrFactor = HedoneConfig.instance:getHedoneMonsterGroupBaseAttrFactor(self._groupId)
	local difficultFactorWithTime = HedoneGameModel.instance:getMonsterDifficultFactorWithTime()

	for attrId, value in ipairs(baseAttrArr) do
		if HedoneGameEnum.BaseAttribute[attrId] then
			local newValue = value * baseAttrFactor * (1 + ((attrId == HedoneGameEnum.Attribute.Atk or nil) and 0))

			attrSet:initAttrBaseValue(attrId, nil, newValue)

			if attrId == HedoneGameEnum.Attribute.HpCap then
				attrSet:setHp(newValue)
			end
		end
	end

	local attrIdList = HedoneConfig.instance:getHedoneOwnerAttrIdList(HedoneGameEnum.AttributeOwnerType.Unit)

	if attrIdList then
		for _, attrId in ipairs(attrIdList) do
			if not HedoneGameEnum.BaseAttribute[attrId] then
				local defaultValue = HedoneConfig.instance:getHedoneAttributeDefaultValue(attrId)

				attrSet:initAttrBaseValue(attrId, nil, (attrId == HedoneGameEnum.Attribute.MonsterSpeed or nil) and HedoneConfig.instance:getHedoneMonsterMoveSpeed(self._id))
			end
		end
	end
end

function HedoneMonsterMO:_onUpdateMove(deltaTime)
	local isArrived = self:getIsArrivedTarget()

	if isArrived then
		return
	end

	local monsterXRange = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.MonsterXRange, false, true, "#")

	if monsterXRange then
		if not monsterXRange[2] then
			local endX = 0
			local curX, curY = self:getPosition()
			local dx = endX - curX
			local disSqr = dx * dx
			local newX = endX
			local moveSpeed = self:getAttrValue(HedoneGameEnum.Attribute.MonsterSpeed)
			local moveStep = moveSpeed * deltaTime
			local moveStepSqr = moveStep * moveStep

			if disSqr <= moveStepSqr then
				self._isArrivedTarget = true
			else
				local dirX = dx > 0 and 1 or -1

				newX = curX + dirX * moveStep
			end

			self:setPosition(newX, curY)
		end
	end
end

function HedoneMonsterMO:getIsAlive()
	local hp = self:getAttrValue(HedoneGameEnum.Attribute.Hp)

	return hp > 0
end

function HedoneMonsterMO:getIsAttacking()
	local isAlive = self:getIsAlive()

	if not isAlive then
		return
	end

	return self:getIsArrivedTarget()
end

function HedoneMonsterMO:getYLevel()
	return self._yLevel
end

return HedoneMonsterMO
