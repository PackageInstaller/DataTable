-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventBloomMaterial.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventBloomMaterial", package.seeall)

local FightTLEventBloomMaterial = class("FightTLEventBloomMaterial", FightTimelineTrackItem)

function FightTLEventBloomMaterial:onTrackStart(fightStepData, duration, paramsArr)
	local targetType = paramsArr[1]
	local passName = paramsArr[2]

	if string.nilorempty(passName) then
		return
	end

	self._passNameList = string.split(passName, "#")
	self._targetEntitys = nil

	if targetType == "1" then
		self._targetEntitys = {}

		table.insert(self._targetEntitys, FightHelper.getEntity(fightStepData.fromId))
	elseif targetType == "2" then
		self._targetEntitys = FightHelper.getSkillTargetEntitys(fightStepData)
	elseif targetType == "3" then
		self._targetEntitys = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)
	elseif targetType == "4" then
		self._targetEntitys = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)
	elseif targetType == "5" then
		self._targetEntitys = FightHelper.getAllEntitys()
	end

	self:_setPassEnable(true)
end

function FightTLEventBloomMaterial:onTrackEnd()
	self:_clear()
end

function FightTLEventBloomMaterial:_setPassEnable(enable)
	local bloomMgr = FightGameMgr.bloomMgr

	if self._targetEntitys then
		for _, entity in ipairs(self._targetEntitys) do
			for _, passName in ipairs(self._passNameList) do
				bloomMgr:setSingleEntityPass(passName, enable, entity, "timeline_bloom")
			end
		end
	end
end

function FightTLEventBloomMaterial:_clear()
	self:_setPassEnable(false)

	self._targetEntitys = nil
end

function FightTLEventBloomMaterial:onDestructor()
	self:_clear()
end

return FightTLEventBloomMaterial
