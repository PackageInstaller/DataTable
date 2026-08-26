-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameBaseUnitMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameBaseUnitMO", package.seeall)

local ArcadeGameBaseUnitMO = class("ArcadeGameBaseUnitMO")

function ArcadeGameBaseUnitMO:ctor(moData)
	self.id = moData.id
	self.uid = moData.uid or self.id

	self:setDirection(ArcadeGameEnum.Const.DefaultEntityDirection)

	self._entityType = moData.entityType
	self._curHp = 0
	self._corpseTime = 0
	self._attackAttrId = nil

	self:setGridPos(moData.x, moData.y)

	self._skillSetMO = ArcadeGameSkillSetMO.New(self.id, self)
	self._buffSetMO = ArcadeGameBuffSetMO.New(self)
	self._baseAttrSetMO = ArcadeGameAttributeSetMO.New()

	local cfg = self:getCfg()

	for attrName, attrId in pairs(ArcadeGameEnum.BaseAttr) do
		if cfg and cfg[attrName] then
			local attrMO = self:getAttrMO(attrId)

			if attrMO then
				attrMO:setBase(cfg[attrName])
			end
		end
	end

	local hpCap = self:getAttributeValue(ArcadeGameEnum.BaseAttr.hpCap)

	self:setHp(hpCap)
	self:onCtor(moData.extraParam)
end

function ArcadeGameBaseUnitMO:getId()
	return self.id
end

function ArcadeGameBaseUnitMO:getUid()
	return self.uid or self.id
end

function ArcadeGameBaseUnitMO:getEntityType()
	return self._entityType
end

function ArcadeGameBaseUnitMO:getSkillSetMO()
	return self._skillSetMO
end

function ArcadeGameBaseUnitMO:getSkillList()
	return self._skillSetMO:getSkillList()
end

function ArcadeGameBaseUnitMO:getBuffSetMO()
	return self._buffSetMO
end

function ArcadeGameBaseUnitMO:getAttrSetMO()
	return self._baseAttrSetMO
end

function ArcadeGameBaseUnitMO:getAttrMO(attrId)
	return self._baseAttrSetMO and self._baseAttrSetMO:getAttrById(attrId)
end

function ArcadeGameBaseUnitMO:getAttributeValue(attrId)
	local result = 0

	if attrId == ArcadeGameEnum.BaseAttr.hp then
		result = self:getHp()
	else
		local attrMO = self:getAttrMO(attrId)

		if attrMO then
			result = attrMO:getValue()
		end
	end

	return result
end

function ArcadeGameBaseUnitMO:getHp()
	return self._curHp or 0
end

function ArcadeGameBaseUnitMO:getDirection(isEntityForward)
	if isEntityForward then
		return self.entityForwardDirection
	else
		return self.direction
	end
end

function ArcadeGameBaseUnitMO:getGridId()
	if self._gridX and self._gridY then
		return ArcadeGameHelper.getGridId(self._gridX, self._gridY)
	end
end

function ArcadeGameBaseUnitMO:getGridPos()
	return self._gridX, self._gridY
end

function ArcadeGameBaseUnitMO:getIsDead()
	return self._isDead
end

function ArcadeGameBaseUnitMO:getIsRemoving()
	return self._isRemoving
end

function ArcadeGameBaseUnitMO:getIsRespawning()
	return self._isRespawning
end

function ArcadeGameBaseUnitMO:getBorderGridList()
	local result = {}
	local gridX, gridY = self:getGridPos()
	local sizeX, sizeY = self:getSize()

	if not gridX or not gridY or not sizeX or not sizeY then
		return result
	end

	local leftX = gridX - 1
	local hasLeft = leftX >= ArcadeGameEnum.Const.RoomMinCoordinateValue
	local rightX = gridX + sizeX
	local hasRight = rightX <= ArcadeGameEnum.Const.RoomSize

	for y = gridY, gridY + sizeY - 1 do
		if y >= ArcadeGameEnum.Const.RoomMinCoordinateValue and y <= ArcadeGameEnum.Const.RoomSize then
			if hasLeft then
				result[#result + 1] = {
					gridX = leftX,
					gridY = y
				}
			end

			if hasRight then
				result[#result + 1] = {
					gridX = rightX,
					gridY = y
				}
			end
		end
	end

	local bottomY = gridY - 1
	local hasBottom = bottomY >= ArcadeGameEnum.Const.RoomMinCoordinateValue
	local topY = gridY + sizeY
	local hasTop = topY <= ArcadeGameEnum.Const.RoomSize

	for x = gridX, gridX + sizeX - 1 do
		if x >= ArcadeGameEnum.Const.RoomMinCoordinateValue and x <= ArcadeGameEnum.Const.RoomSize then
			if hasBottom then
				result[#result + 1] = {
					gridX = x,
					gridY = bottomY
				}
			end

			if hasTop then
				result[#result + 1] = {
					gridX = x,
					gridY = topY
				}
			end
		end
	end

	return result
end

function ArcadeGameBaseUnitMO:getCorpseTime()
	return self._corpseTime or 0
end

function ArcadeGameBaseUnitMO:getStateEffectIdList()
	local result = {}
	local stateShowEffectId
	local isDead = self:getIsDead()

	result[#result + 1] = isDead and ArcadeConfig.instance:getStateShowEffectId(ArcadeGameEnum.StateShowId.Dead) or self:getIdleShowEffectId()

	if not isDead then
		local buffSetMO = self:getBuffSetMO()
		local buffList = buffSetMO and buffSetMO:getBuffList()

		if buffList then
			for _, buffMO in ipairs(buffList) do
				local buffId = buffMO:getId()
				local loopBuffEffect = ArcadeConfig.instance:getArcadeBuffLoopEffect(buffId)

				if loopBuffEffect and loopBuffEffect ~= 0 then
					result[#result + 1] = loopBuffEffect
				end
			end
		end
	end

	return result
end

function ArcadeGameBaseUnitMO:getAttackAttrId()
	return self._attackAttrId
end

function ArcadeGameBaseUnitMO:getIsCanDead()
	local entityType = self:getEntityType()

	return entityType == ArcadeGameEnum.EntityType.Monster or entityType == ArcadeGameEnum.EntityType.Character
end

function ArcadeGameBaseUnitMO:getIsHaveHPBar()
	local entityType = self:getEntityType()

	return entityType == ArcadeGameEnum.EntityType.Monster or entityType == ArcadeGameEnum.EntityType.Character
end

function ArcadeGameBaseUnitMO:getHpPos()
	local cfg = self:getCfg()
	local hpPosArr = cfg and cfg.hpPos

	if hpPosArr then
		return tonumber(hpPosArr[1]), tonumber(hpPosArr[2])
	end
end

function ArcadeGameBaseUnitMO:getIsAlive()
	local isDead = self:getIsDead()
	local isRemoving = self:getIsRemoving()
	local hp = self:getHp()

	return not isDead and not isRemoving and hp > 0
end

function ArcadeGameBaseUnitMO:getIsCollection()
	return false
end

function ArcadeGameBaseUnitMO:addSkillById(skillId)
	self._skillSetMO:addSkillById(skillId)
end

function ArcadeGameBaseUnitMO:removeSkillById(skillId)
	self._skillSetMO:removeSkillById(skillId)
end

function ArcadeGameBaseUnitMO:setGridPos(gridX, gridY)
	local var_29_0

	if not gridX then
		::label_29_0::

		var_29_0 = self._gridX or 0
	end

	self._gridX = var_29_0

	local var_29_1

	if not gridY then
		::label_29_1::

		var_29_1 = self._gridY or 0
	end

	self._gridY = var_29_1
end

function ArcadeGameBaseUnitMO:setAttributeBaseValue(attrId, baseValue)
	local attrMO = self:getAttrMO(attrId)

	if attrMO and baseValue then
		attrMO:setBase(baseValue)
	end
end

function ArcadeGameBaseUnitMO:setIsDead(isDead)
	self._isDead = isDead
end

function ArcadeGameBaseUnitMO:setIsRemoving(isRemoving)
	self._isRemoving = isRemoving
end

function ArcadeGameBaseUnitMO:setIsRespawning(isRespawning)
	self._isRespawning = isRespawning
end

function ArcadeGameBaseUnitMO:addCorpseTime()
	self._corpseTime = (self._corpseTime or 0) + 1
end

function ArcadeGameBaseUnitMO:setDirection(dir)
	if not dir then
		return
	end

	self.direction = dir

	self:_setEntityForwardDirection(dir)
end

function ArcadeGameBaseUnitMO:_setEntityForwardDirection(dir)
	if dir ~= ArcadeEnum.Direction.Right and dir ~= ArcadeEnum.Direction.Left then
		return
	end

	self.entityForwardDirection = dir
end

function ArcadeGameBaseUnitMO:setAttackAttr(attackAttrId)
	self._attackAttrId = attackAttrId
end

function ArcadeGameBaseUnitMO:addHp(value)
	local realChangeVal = 0
	local phVal = tonumber(value)

	if not phVal or phVal == 0 then
		return realChangeVal
	end

	local hpCap = self:getAttributeValue(ArcadeGameEnum.BaseAttr.hpCap)
	local newHp = Mathf.Clamp(phVal + self._curHp, 0, hpCap)

	realChangeVal = phVal < 0 and phVal or newHp - self._curHp
	self._curHp = newHp

	self:setAttributeBaseValue(ArcadeGameEnum.BaseAttr.hp, self._curHp)

	return realChangeVal
end

function ArcadeGameBaseUnitMO:setHp(value)
	local phVal = tonumber(value)
	local hpCap = self:getAttributeValue(ArcadeGameEnum.BaseAttr.hpCap)

	self._curHp = Mathf.Clamp(phVal, 0, hpCap)

	self:setAttributeBaseValue(ArcadeGameEnum.BaseAttr.hp, self._curHp)
end

function ArcadeGameBaseUnitMO:triggerSkillSetMOCounterRecord(counterName, counterParam, count)
	local skillSetMO = self:getSkillSetMO()

	if skillSetMO then
		skillSetMO:triggerSkillCounterRecord(counterName, counterParam, count)
	end
end

function ArcadeGameBaseUnitMO:onCtor(extraParam)
	return
end

function ArcadeGameBaseUnitMO:getCfg()
	logError("ArcadeGameBaseUnitMO.getCfg error, need override this func")
end

function ArcadeGameBaseUnitMO:getSize()
	logError("ArcadeGameBaseUnitMO.getSize error, need override this func")

	return 1, 1
end

function ArcadeGameBaseUnitMO:getRes()
	logError("ArcadeGameBaseUnitMO.getRes error, need override this func")
end

function ArcadeGameBaseUnitMO:getHasCorpse()
	return false
end

function ArcadeGameBaseUnitMO:getDropList()
	return
end

function ArcadeGameBaseUnitMO:getIsCanRespawn()
	return false
end

function ArcadeGameBaseUnitMO:getScale()
	local cfg = self:getCfg()
	local scaleArr = cfg and cfg.scale

	if scaleArr and type(scaleArr) == "table" then
		return tonumber(scaleArr[1]), tonumber(scaleArr[2])
	end
end

function ArcadeGameBaseUnitMO:getPosOffset()
	local cfg = self:getCfg()
	local posArr = cfg and cfg.posOffset

	if posArr and type(posArr) == "table" then
		return tonumber(posArr[1]), tonumber(posArr[2])
	end
end

function ArcadeGameBaseUnitMO:getName()
	local cfg = self:getCfg()

	return cfg.name
end

function ArcadeGameBaseUnitMO:getDesc()
	local cfg = self:getCfg()

	return cfg.desc
end

function ArcadeGameBaseUnitMO:getIcon()
	local cfg = self:getCfg()

	return cfg.icon
end

function ArcadeGameBaseUnitMO:getTipIsUseImg()
	return false
end

function ArcadeGameBaseUnitMO:getImgOffsetArr()
	return
end

function ArcadeGameBaseUnitMO:getImgScaleArr()
	return
end

function ArcadeGameBaseUnitMO:setLockRound(round)
	return
end

function ArcadeGameBaseUnitMO:getLockRound()
	return 0
end

function ArcadeGameBaseUnitMO:getIdleShowEffectId()
	return (ArcadeConfig.instance:getStateShowEffectId(ArcadeGameEnum.StateShowId.Idle))
end

return ArcadeGameBaseUnitMO
