-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/data/GswPillarMapMo.lua

module("logic.extensions.godstatueswar.data.GswPillarMapMo", package.seeall)

local GswPillarMapMo = class("GswPillarMapMo")

function GswPillarMapMo:ctor()
	self._groupInfos = {}
	self._pillarIdDicByFId = {}
	self._todayDivinePillarFightTime = 0
	self._nestLeftFightTime = 0
	self._familyEnergy = 0
	self._attackFlagFamilyId = 0
	self._noAttackFlagFamilyId = 0
	self._curTierOfMyFamily = 0
end

function GswPillarMapMo:onReset()
	table.clear(self._groupInfos)

	self._todayDivinePillarFightTime = 0
	self._nestLeftFightTime = 0
	self._familyEnergy = 0
	self._attackFlagFamilyId = 0
	self._noAttackFlagFamilyId = 0
	self._curTierOfMyFamily = 0
end

function GswPillarMapMo:initData(msg)
	for _, v in ipairs(msg.groupList) do
		local info = GameUtil.pbToTable(v)

		self._groupInfos[v.pillarId] = info
		self._pillarIdDicByFId[info.familyId] = info.pillarId
	end

	self._todayDivinePillarFightTime = msg.todayDivinePillarFightTime
	self._nestLeftFightTime = msg.nestLeftFightTime
	self._familyEnergy = msg.familyEnergy
	self._attackFlagFamilyId = msg.attackFlagFamilyId
	self._noAttackFlagFamilyId = msg.noAttackFlagFamilyId
	self._curTierOfMyFamily = msg.curTier
end

function GswPillarMapMo:getGroupInfo(pillarId)
	return self._groupInfos[pillarId]
end

function GswPillarMapMo:getFamilyIdInGroup(pillarId)
	local info = self:getGroupInfo(pillarId)

	return (info or nil) and info.familyId
end

function GswPillarMapMo:getPillarIdInGroup(familyId)
	return self._pillarIdDicByFId[familyId] or 0
end

function GswPillarMapMo:getEnergyInGroup(pillarId)
	local info = self:getGroupInfo(pillarId)

	return (info or nil) and info.energy
end

function GswPillarMapMo:getFamilyNameInGroup(pillarId)
	local info = self:getGroupInfo(pillarId)

	return (info or nil) and info.familyName
end

function GswPillarMapMo:getTotalZdlInGroup(pillarId)
	local info = self:getGroupInfo(pillarId)

	return (info or nil) and info.totalZdl
end

function GswPillarMapMo:getTodayDivinePillarFightTime()
	return self._todayDivinePillarFightTime
end

function GswPillarMapMo:setTodayDivinePillarFightTime(value)
	self._todayDivinePillarFightTime = value
end

function GswPillarMapMo:getNestLeftFightTime()
	return self._nestLeftFightTime
end

function GswPillarMapMo:setNestLeftFightTime(value)
	self._nestLeftFightTime = value
end

function GswPillarMapMo:getFamilyEnergy()
	return self._familyEnergy
end

function GswPillarMapMo:setFamilyEnergy(value)
	self._familyEnergy = value
end

function GswPillarMapMo:getAttackFlagFamilyId()
	return self._attackFlagFamilyId
end

function GswPillarMapMo:setAttackFlagFamilyId(familyId)
	self._attackFlagFamilyId = familyId
end

function GswPillarMapMo:getNoAttackFlagFamilyId()
	return self._noAttackFlagFamilyId
end

function GswPillarMapMo:setNoAttackFlagFamilyId(familyId)
	self._noAttackFlagFamilyId = familyId
end

function GswPillarMapMo:getMyFamilyCurTierInMap()
	return self._curTierOfMyFamily
end

return GswPillarMapMo
