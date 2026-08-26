-- chunkname: @modules/logic/fight/system/work/FightWorkColdSaturdayHurt336.lua

module("modules.logic.fight.system.work.FightWorkColdSaturdayHurt336", package.seeall)

local FightWorkColdSaturdayHurt336 = class("FightWorkColdSaturdayHurt336", FightEffectBase)

function FightWorkColdSaturdayHurt336:onStart()
	local fromId = self.actEffectData.reserveStr
	local toId = self.actEffectData.targetId
	local layer = self.actEffectData.effectNum
	local entity = FightHelper.getEntity(fromId)

	if not entity then
		self:onDone(true)

		return
	end

	local toEntity = FightHelper.getEntity(toId)

	if not toEntity then
		self:onDone(true)

		return
	end

	local entityMO = entity:getMO()
	local skin = entityMO.skin
	local fightStepData = FightStepData.New(FightDef_pb.FightStep())

	fightStepData.isFakeStep = true
	fightStepData.fromId = fromId
	fightStepData.toId = toId
	fightStepData.actType = FightEnum.ActType.SKILL

	table.insert(fightStepData.actEffect, self.actEffectData)

	if not lua_fight_she_fa_ignite.configDict[skin] then
		local config = lua_fight_she_fa_ignite.configDict[0]
		local configList = {}

		for k, v in pairs(config) do
			table.insert(configList, v)
		end

		table.sort(configList, FightWorkColdSaturdayHurt336.sortConfig)

		for i, v in ipairs(configList) do
			if layer <= v.layer then
				config = v

				break
			end
		end

		local timeline = config.timeline
		local work = entity.skill:registTimelineWork(timeline, fightStepData)

		self:playWorkAndDone(work)
	end
end

function FightWorkColdSaturdayHurt336.sortConfig(item1, item2)
	return item1.layer < item2.layer
end

return FightWorkColdSaturdayHurt336
