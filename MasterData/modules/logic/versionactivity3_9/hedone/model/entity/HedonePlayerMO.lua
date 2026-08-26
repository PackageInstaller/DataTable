-- chunkname: @modules/logic/versionactivity3_9/hedone/model/entity/HedonePlayerMO.lua

module("modules.logic.versionactivity3_9.hedone.model.entity.HedonePlayerMO", package.seeall)

local HedonePlayerMO = class("HedonePlayerMO", HedoneBaseUnitMO)

function HedonePlayerMO:onCtor(data)
	local attrSet = self:getAttrSetMO()
	local gameId = HedoneGameModel.instance:getGameId()
	local baseAttrArr = HedoneConfig.instance:getHedoneGamePlayerBaseAttr(gameId)

	for attrId, value in ipairs(baseAttrArr) do
		if HedoneGameEnum.BaseAttribute[attrId] then
			attrSet:initAttrBaseValue(attrId, nil, value)

			if attrId == HedoneGameEnum.Attribute.HpCap then
				attrSet:setHp(value)
			end
		end
	end

	local attrIdList = HedoneConfig.instance:getHedoneOwnerAttrIdList(HedoneGameEnum.AttributeOwnerType.Unit)

	if attrIdList then
		for _, attrId in ipairs(attrIdList) do
			if not HedoneGameEnum.BaseAttribute[attrId] then
				local defaultValue = HedoneConfig.instance:getHedoneAttributeDefaultValue(attrId)

				attrSet:initAttrBaseValue(attrId, nil, defaultValue)
			end
		end
	end

	local skillTypeList = HedoneConfig.instance:getHedoneAllSkillTypeList()
	local effectGroupList = HedoneConfig.instance:getHedoneAllEffectGroupList()

	self:_initSkillAttr(skillTypeList, effectGroupList)

	local skipDefaultCDSkill = data and data.skipDefaultCDSkill

	if not skipDefaultCDSkill then
		local defaultCDSkillId = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.PlayerDefaultCDSKill, false, true)

		self:addSkill(defaultCDSkillId)
	end

	self._lvNeedExpList = {}

	local needExpArr = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.PlayerLvNeedExp, false, false, "|")

	if needExpArr then
		for i, str in ipairs(needExpArr) do
			local expData = string.splitToNumber(str, "#")

			self._lvNeedExpList[i] = expData[2]
		end
	end

	self._fixNeedExpFactor = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.EndlessLvNeedExpFactor, false, true)
	self._lv = 0
	self._curExp = 0
end

function HedonePlayerMO:addExp(exp)
	if exp <= 0 then
		return
	end

	self._curExp = self._curExp + exp
end

function HedonePlayerMO:tryLevelUp()
	local needExp = self:getLevelUpNeedExp()
	local curExp = self:getCurExp()

	if curExp < needExp then
		logError(string.format("HedonePlayerMO:tryLevelUp error, Not enough exp to level up, curExp = %d, needExp = %d", curExp, needExp))

		return
	end

	self._curExp = curExp - needExp
	self._lv = self._lv + 1

	return true
end

function HedonePlayerMO:_onAddSkill(skill)
	if not skill then
		return
	end

	local skillId = skill:getId()

	HedoneGameModel.instance:tryInitCDSkillDamageData(skillId)
end

function HedonePlayerMO:getIsAlive()
	local hp = self:getAttrValue(HedoneGameEnum.Attribute.Hp)

	return hp > 0
end

function HedonePlayerMO:getCurLv()
	return self._lv
end

function HedonePlayerMO:getCurExp()
	return self._curExp or 0
end

function HedonePlayerMO:getLevelUpNeedExp()
	local lvExpLen = #self._lvNeedExpList
	local curLv = self:getCurLv()
	local nextLv = curLv + 1

	if curLv < lvExpLen then
		return self._lvNeedExpList[nextLv]
	end

	return nextLv * (self._fixNeedExpFactor or 0)
end

return HedonePlayerMO
