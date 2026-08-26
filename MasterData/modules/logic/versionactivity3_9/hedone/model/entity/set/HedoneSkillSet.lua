-- chunkname: @modules/logic/versionactivity3_9/hedone/model/entity/set/HedoneSkillSet.lua

module("modules.logic.versionactivity3_9.hedone.model.entity.set.HedoneSkillSet", package.seeall)

local HedoneSkillSet = class("HedoneSkillSet", HedoneBaseSet)

function HedoneSkillSet:onCtor()
	self._skillUidDict = {}
	self._skillId2UidList = {}
	self._skillUidListWithCd = {}
	self._skillUidListNoCd = {}
	self._triggerPoint2SkillUidList = {}
end

function HedoneSkillSet:addSkill2Set(skillId)
	local isUnique = HedoneConfig.instance:getHedoneSkillIsUnique(skillId)

	if isUnique then
		local isHave = self:getIsHaveSkillInSet(skillId)

		if isHave then
			logError(string.format("HedoneSkillSet:addSkill2Set error, already have unique skill, skillId:%s", skillId))

			return
		end
	end

	local unitMO = self:getUnitMO()
	local skillUid = self:_generateUid()
	local skill = HedoneGameHelper.createSkill(skillUid, skillId, unitMO)

	if not skill then
		return
	end

	self._skillUidDict[skillUid] = skill

	local skillUidList = GameUtil.tabletool_checkDictTable(self._skillId2UidList, skillId)

	table.insert(skillUidList, skillUid)

	if skill:getHasCfgCD() then
		table.insert(self._skillUidListWithCd, skillUid)
	else
		table.insert(self._skillUidListNoCd, skillUid)
	end

	local triggerPointDict = skill:getTriggerPoint2TriggerDict()

	for triggerPoint, _ in pairs(triggerPointDict) do
		local list = GameUtil.tabletool_checkDictTable(self._triggerPoint2SkillUidList, triggerPoint)

		list[#list + 1] = skillUid
	end

	return skill
end

function HedoneSkillSet:resetSkillCDInSet(skillId)
	local uidList = self._skillId2UidList[skillId]

	if uidList then
		for _, uid in ipairs(uidList) do
			local skill = self:getSkillInSet(uid)

			if skill then
				skill:resetRemainCD()
			end
		end
	end
end

function HedoneSkillSet:handleAttributeChange(attrId)
	if attrId ~= HedoneGameEnum.Attribute.SkillCD and attrId ~= HedoneGameEnum.Attribute.GlobalSkillCD then
		return
	end

	local cdSkillUidList = self:getSkillUidListInSet(true)

	for _, uid in ipairs(cdSkillUidList) do
		local skill = self:getSkillInSet(uid)

		if skill then
			skill:onCDAttributeChange()
		end
	end
end

function HedoneSkillSet:getSkillUidListInSet(hasCfgCD)
	if hasCfgCD then
		return self._skillUidListWithCd
	else
		return self._skillUidListNoCd
	end
end

function HedoneSkillSet:getTriggerSkillUidListInSet(triggerPointWithParam)
	return self._triggerPoint2SkillUidList[triggerPointWithParam]
end

function HedoneSkillSet:getSkillInSet(skillUid)
	return self._skillUidDict[skillUid]
end

function HedoneSkillSet:getSkillIdListInSet(targetSkillType)
	local result = {}

	for _, skill in pairs(self._skillUidDict) do
		local skillType = skill:getSkillType()

		if not targetSkillType or skillType == targetSkillType then
			result[#result + 1] = skill:getId()
		end
	end

	return result
end

function HedoneSkillSet:getSkillId2UidList()
	return self._skillId2UidList
end

function HedoneSkillSet:getIsHaveSkillInSet(skillId)
	local uidList = self._skillId2UidList[skillId]

	return uidList and #uidList > 0
end

return HedoneSkillSet
