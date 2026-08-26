-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/base/ArcadeSkillClass.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.base.ArcadeSkillClass", package.seeall)

local ArcadeSkillClass = class("ArcadeSkillClass", ArcadeSkillObject)

function ArcadeSkillClass:ctor()
	ArcadeSkillClass.super.ctor(self)

	self._childClassList = {}
	self._childInsIdDict = {}
end

function ArcadeSkillClass:setOwner(ownerEntityType, ownerUid)
	self.ownerEntityType = ownerEntityType
	self.ownerUid = ownerUid

	for _, child in ipairs(self._childClassList) do
		child:setOwner(ownerEntityType, ownerUid)
	end
end

function ArcadeSkillClass:setSpecBelongSkillSetMO(skillSetMO)
	self._specBelongSkillSetMO = skillSetMO
end

function ArcadeSkillClass:getOwner()
	local mo = ArcadeGameModel.instance:getMOWithType(self.ownerEntityType, self.ownerUid)

	if not mo then
		logError(string.format("%s getOwner error, mo is nil, ownerEntityType:%s, ownerUid:%s", self.__cname, tostring(self.ownerEntityType), tostring(self.ownerUid)))
	end

	return mo
end

function ArcadeSkillClass:getBelongSkillSetMO()
	if self._specBelongSkillSetMO then
		return self._specBelongSkillSetMO
	end

	local owner = self:getOwner()

	if owner and owner.getSkillSetMO then
		return owner:getSkillSetMO()
	end
end

function ArcadeSkillClass:addChild(child)
	if not child then
		return
	end

	local childInsId = child:getInstanceID()

	if self._childInsIdDict[childInsId] then
		return
	end

	self._childInsIdDict[childInsId] = child

	table.insert(self._childClassList, child)

	if self._skillBase then
		child:setSkillBase(self._skillBase)
	end
end

function ArcadeSkillClass:setSkillBase(skillBase)
	self._skillBase = skillBase
end

function ArcadeSkillClass:getSkillConfig()
	return self._skillBase and self._skillBase:getSkillConfig()
end

function ArcadeSkillClass:getSkillId()
	return self._skillBase and self._skillBase.skillId
end

function ArcadeSkillClass:getLogPrefixStr()
	return string.format("%s skillId:%s", self.__cname, self:getSkillId())
end

function ArcadeSkillClass:clearTable(data)
	if data and type(data) == "table" then
		for datakey in pairs(data) do
			rawset(data, datakey, nil)
		end
	end
end

function ArcadeSkillClass:clearList(list)
	if list and #list > 0 then
		local len = #list

		for i = len, 1, -1 do
			table.remove(list, i)
		end
	end
end

function ArcadeSkillClass:clearKey()
	return
end

return ArcadeSkillClass
