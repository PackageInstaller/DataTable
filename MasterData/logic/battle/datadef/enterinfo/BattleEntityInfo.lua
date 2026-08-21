-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/enterinfo/BattleEntityInfo.lua

module("logic.battle.datadef.enterinfo.BattleEntityInfo", package.seeall)

local BattleEntityInfo = class("BattleEntityInfo", AbstractGlobalReusable)

function BattleEntityInfo:ctor()
	self.entityId = 0
	self.userId = 0
	self.battleCamp = 0
	self.level = 0
	self.entityCode = 0
	self.viewEntityCode = 0
	self.entityType = 0
	self.campId = 0
	self.bornUnionIndex = -1
	self.direction = 2
	self.lookAtDirection = false
	self.lowModelOnly = false
	self.baseAttributes = {}
	self.attributes = {}
	self.states = {}
	self.skills = {}
	self.buffs = {}
	self.tags = {}
	self.cellUnionIndex = 0
	self.tagEnhances = false
	self.modelId = 0
	self.immuneBuffs = {}
	self.bodyEffect = false
end

function BattleEntityInfo:reset()
	self.modelId = 0
	self.entityType = 0
	self.bornUnionIndex = -1
	self.cellUnionIndex = 0
	self.direction = 2
	self.lookAtDirection = false
	self.lowModelOnly = false
	self.tagEnhances = false

	if self.lookAtDirection then
		self.lookAtDirection:returnSelf()

		self.lookAtDirection = false
	end

	self.bodyEffect = false

	BattleTableUtil.clearTable(self.baseAttributes)
	BattleTableUtil.clearTable(self.attributes)

	for _, skill in pairs(self.skills) do
		skill:returnSelf()
	end

	BattleTableUtil.clearTable(self.skills)

	for _, buff in pairs(self.buffs) do
		buff:returnSelf()
	end

	BattleTableUtil.clearTable(self.buffs)
	BattleTableUtil.clearTable(self.states)
	BattleTableUtil.clearTable(self.tags)
	BattleTableUtil.clearTable(self.immuneBuffs)
end

function BattleEntityInfo:destroy()
	self:reset()
end

function BattleEntityInfo:setAttributeIfNil(attributeCode, attributeValue)
	if not self.attributes[attributeCode] then
		self.attributes[attributeCode] = attributeValue
	end
end

function BattleEntityInfo:addAttribute(attributeCode, attributeValue)
	self.attributes[attributeCode] = attributeValue
end

function BattleEntityInfo:getAttribute(propertyCode)
	return self.attributes[propertyCode]
end

function BattleEntityInfo:addBaseAttribute(attributeCode, attributeValue)
	self.baseAttributes[attributeCode] = attributeValue
end

function BattleEntityInfo:addState(stateCode)
	table.insert(self.states, stateCode)
end

function BattleEntityInfo:removeState(stateCode)
	table.removebyvalue(self.states, stateCode)
end

function BattleEntityInfo:addSkillFromSkillNO(skillNO)
	local skill = BattleEntityInfo.Skill:createFromSkillNO(skillNO)

	table.insert(self.skills, skill)
end

function BattleEntityInfo:addBuff(id, code, round, layer)
	local buff = BattleEntityInfo.Buff:createInstance(id, code, round, layer)

	table.insert(self.buffs, buff)
end

function BattleEntityInfo:addTag(tag)
	table.insert(self.tags, tag)
end

function BattleEntityInfo:addImmuneBuffs(buff)
	table.insert(self.immuneBuffs, buff)
end

function BattleEntityInfo:toString()
	return self.entityId
end

function BattleEntityInfo:getCapacity()
	return BattleConst.ObjPoolCapacityMid
end

function BattleEntityInfo:addCell(cell)
	if cell then
		self.cellUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(cell.x, cell.z)
	end
end

function BattleEntityInfo:getCellUnionIndex()
	return self.cellUnionIndex
end

BattleEntityInfo.Skill = class("BattleEntityInfo.Skill", AbstractGlobalReusable)

function BattleEntityInfo.Skill:createFromSkillNO(skillNO)
	local skill = BattleEntityInfo.Skill:createInstance(skillNO.code, skillNO.enhanced)

	skill.skillCd = skillNO.cd
	skill.skillSourceType = skillNO.source.type
	skill.skillSourceEntityId = skillNO.source.id

	return skill
end

function BattleEntityInfo.Skill:getCapacity()
	return BattleConst.ObjPoolCapacityMax
end

function BattleEntityInfo.Skill:ctor(skillCode, enhanceCodes)
	self.skillCode = false
	self.skillCd = false
	self.enhanceCodes = {}
	self.skillSourceType = false
	self.skillSourceEntityId = false

	self:reuse(skillCode, enhanceCodes)
end

function BattleEntityInfo.Skill:reuse(skillCode, enhanceCodes)
	self.skillCode = skillCode

	BattleTableUtil.insertto(self.enhanceCodes, enhanceCodes)
end

function BattleEntityInfo.Skill:reset()
	self.skillCode = false
	self.skillCd = false

	BattleTableUtil.clearTable(self.enhanceCodes)
end

function BattleEntityInfo.Skill:toString()
	return self.skillCode
end

BattleEntityInfo.Buff = class("BattleEntityInfo.Buff", AbstractGlobalReusable)

function BattleEntityInfo.Buff:getCapacity()
	return BattleConst.ObjPoolCapacityMax
end

function BattleEntityInfo.Buff:ctor(id, code, round, layer)
	self.id = false
	self.buffCode = false
	self.round = false
	self.layer = false

	self:reuse(id, code, round, layer)
end

function BattleEntityInfo.Buff:reuse(id, code, round, layer)
	self.id = id
	self.buffCode = code
	self.round = round
	self.layer = layer
end

function BattleEntityInfo.Buff:reset()
	self.id = false
	self.buffCode = false
	self.round = false
	self.layer = false
end

function BattleEntityInfo.Buff:toString()
	return string.format("{id = %s, code = %s}", self.id, self.buffCode)
end

return BattleEntityInfo
