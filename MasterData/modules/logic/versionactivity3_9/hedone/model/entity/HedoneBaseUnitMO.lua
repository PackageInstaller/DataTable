-- chunkname: @modules/logic/versionactivity3_9/hedone/model/entity/HedoneBaseUnitMO.lua

module("modules.logic.versionactivity3_9.hedone.model.entity.HedoneBaseUnitMO", package.seeall)

local HedoneBaseUnitMO = class("HedoneBaseUnitMO")

function HedoneBaseUnitMO:ctor(data)
	self._uid = data.uid
	self._id = data.id
	self._type = data.entityType
	self._rotation = data.rotation or 0

	self:setPosition(data.posX, data.posY)

	self._isArrivedTarget = false
	self._attrSet = HedoneAttrSet.New(self)
	self._buffSet = HedoneBuffSet.New(self)
	self._skillSet = HedoneSkillSet.New(self)

	self:onCtor(data)
end

function HedoneBaseUnitMO:updateMove(deltaTime)
	local isAlive = self:getIsAlive()

	if not isAlive then
		return
	end

	self:_onUpdateMove(deltaTime)
	self:_updateRotation()
end

function HedoneBaseUnitMO:notifyAttributeChange(attrId, attrSubId, oldValue, newValue)
	local skillSet = self:getSkillSetMO()

	skillSet:handleAttributeChange(attrId, attrSubId, oldValue, newValue)

	local uid = self:getUid()

	HedoneGameController.instance:dispatchEvent(HedoneEvent.OnEntityAttributeChange, uid, attrId, attrSubId, oldValue, newValue)
end

function HedoneBaseUnitMO:getId()
	return self._id
end

function HedoneBaseUnitMO:getUid()
	return self._uid or self._id
end

function HedoneBaseUnitMO:getEntityType()
	return self._type
end

function HedoneBaseUnitMO:getAttrSetMO()
	return self._attrSet
end

function HedoneBaseUnitMO:getBuffSetMO()
	return self._buffSet
end

function HedoneBaseUnitMO:getSkillSetMO()
	return self._skillSet
end

function HedoneBaseUnitMO:getAttrValue(attrId, attrSubId)
	local attrSet = self:getAttrSetMO()

	return attrSet:getAttrValueInSet(attrId, attrSubId)
end

function HedoneBaseUnitMO:getTriggerSkillUidList(triggerPointWithParam)
	local skillSet = self:getSkillSetMO()

	return skillSet:getTriggerSkillUidListInSet(triggerPointWithParam)
end

function HedoneBaseUnitMO:getCDSkillUidList()
	local skillSet = self:getSkillSetMO()

	return skillSet:getSkillUidListInSet(true)
end

function HedoneBaseUnitMO:getSkill(skillUid)
	local skillSet = self:getSkillSetMO()

	return skillSet:getSkillInSet(skillUid)
end

function HedoneBaseUnitMO:getSkillIdList(skillType)
	local skillSet = self:getSkillSetMO()

	return skillSet:getSkillIdListInSet(skillType)
end

function HedoneBaseUnitMO:getIsHaveSkill(skillId)
	local skillSet = self:getSkillSetMO()

	return skillSet:getIsHaveSkillInSet(skillId)
end

function HedoneBaseUnitMO:getPosition()
	return self._posX or 0, self._posY or 0
end

function HedoneBaseUnitMO:getRotation()
	return self._rotation
end

function HedoneBaseUnitMO:getIsArrivedTarget()
	return self._isArrivedTarget
end

function HedoneBaseUnitMO:setPosition(x, y)
	self._posX = x or 0
	self._posY = y or 0
end

function HedoneBaseUnitMO:changeHp(changeVal)
	changeVal = tonumber(changeVal)

	if changeVal and changeVal ~= 0 then
		local oldHp = self:getAttrValue(HedoneGameEnum.Attribute.Hp)
		local newHp = oldHp + changeVal
		local attrSet = self:getAttrSetMO()
		local realNewHp = attrSet:setHp(newHp)

		if realNewHp then
			self:notifyAttributeChange(HedoneGameEnum.Attribute.Hp, nil, oldHp, realNewHp)
		end
	end

	return self:getIsAlive()
end

function HedoneBaseUnitMO:addSkill(skillId)
	local isAlive = self:getIsAlive()

	if not isAlive then
		return
	end

	local skillSet = self:getSkillSetMO()
	local skill = skillSet:addSkill2Set(skillId)

	self:_onAddSkill(skill)

	return skill
end

function HedoneBaseUnitMO:_initSkillAttr(skillTypeList, effectGroupList)
	local attrSet = self:getAttrSetMO()
	local attrDefaults = {}

	local function getAttrDefaultValue(attrId)
		local dv = attrDefaults[attrId]

		if not dv then
			dv = HedoneConfig.instance:getHedoneAttributeDefaultValue(attrId)
			attrDefaults[attrId] = dv
		end

		return dv
	end

	local skillAttrIds = HedoneConfig.instance:getHedoneOwnerAttrIdList(HedoneGameEnum.AttributeOwnerType.Skill)

	if skillTypeList and skillAttrIds then
		for _, skillType in ipairs(skillTypeList) do
			for _, attrId in ipairs(skillAttrIds) do
				attrSet:initAttrBaseValue(attrId, skillType, getAttrDefaultValue(attrId))
			end
		end
	end

	local effectAttrIds = HedoneConfig.instance:getHedoneOwnerAttrIdList(HedoneGameEnum.AttributeOwnerType.Effect)

	if effectGroupList and effectAttrIds then
		for _, group in ipairs(effectGroupList) do
			for _, attrId in ipairs(effectAttrIds) do
				attrSet:initAttrBaseValue(attrId, group, getAttrDefaultValue(attrId))
			end
		end
	end
end

function HedoneBaseUnitMO:resetSkillCD(skillId)
	local isAlive = self:getIsAlive()

	if not isAlive then
		return
	end

	local skillSet = self:getSkillSetMO()

	skillSet:resetSkillCDInSet(skillId)
end

function HedoneBaseUnitMO:addBuff(buffId)
	local isAlive = self:getIsAlive()

	if not isAlive then
		return
	end

	local buffSet = self:getBuffSetMO()
	local buff = buffSet:addBuff2Set(buffId)
	local buffUid = buff and buff:getUid()

	if buffUid then
		local modifierList = HedoneGameHelper.createModifierList(buffUid, buffId)
		local attrSet = self:getAttrSetMO()

		attrSet:addBuffModifierList2Set(buffUid, buffId, modifierList)
	end

	return buff
end

function HedoneBaseUnitMO:consumeBuffLife(lifeType, subLifeType, reduceVal)
	local isAlive = self:getIsAlive()

	if not isAlive then
		return
	end

	if not HedoneGameEnum.BuffLifeRuleDict[lifeType] then
		logError(string.format("HedoneBaseUnitMO:consumeBuffLife error, buff life type %s is invalid", lifeType))

		return
	end

	if lifeType == HedoneGameEnum.BuffLifeRule.Permanent then
		return
	end

	local buffSet = self:getBuffSetMO()
	local removeBuffUidList = buffSet:consumeBuffLifeInSet(lifeType, subLifeType, reduceVal)

	if removeBuffUidList then
		for _, uid in ipairs(removeBuffUidList) do
			self:removeBuff(uid)
		end
	end
end

function HedoneBaseUnitMO:removeBuff(buffUid)
	local isAlive = self:getIsAlive()

	if not buffUid or not isAlive then
		return
	end

	local buffSet = self:getBuffSetMO()

	buffSet:removeBuffInSet(buffUid)

	local attrSet = self:getAttrSetMO()

	attrSet:removeBuffModifierListInSet(buffUid)
	self:_onRemoveBuff(buffUid)
end

function HedoneBaseUnitMO:onCtor()
	return
end

function HedoneBaseUnitMO:_onUpdateMove(deltaTime)
	local id = self:getId()
	local uid = self:getUid()
	local entityType = self:getEntityType()

	logError(string.format("HedoneBaseUnitMO:_onUpdateMove error, entity is not movable, id %s, uid %s, entityType %s", id, uid, entityType))
end

function HedoneBaseUnitMO:_onRemoveBuff(buffUid)
	return
end

function HedoneBaseUnitMO:_onAddSkill(skill)
	if not skill then
		return
	end

	local skillTypeList
	local skillId = skill:getId()
	local skillType = HedoneConfig.instance:getHedoneSkillType(skillId)
	local effectGroupList = {}
	local effectIds = skill:getEffectIdList()

	if effectIds then
		local groupSet = {}

		for _, eid in ipairs(effectIds) do
			local effectGroup = HedoneConfig.instance:getHedoneEffectGroup(eid)

			if effectGroup and not groupSet[effectGroup] then
				groupSet[effectGroup] = true
				effectGroupList[#effectGroupList + 1] = effectGroup
			end
		end
	end

	self:_initSkillAttr((skillType or nil) and {
		skillType
	}, effectGroupList)
end

function HedoneBaseUnitMO:_updateRotation()
	return
end

function HedoneBaseUnitMO:getScaleFactor()
	return HedoneGameEnum.Const.BaseScaleFactor
end

function HedoneBaseUnitMO:getIsAlive()
	logError("HedoneBaseUnitMO:getIsAlive error, need override it")
end

return HedoneBaseUnitMO
