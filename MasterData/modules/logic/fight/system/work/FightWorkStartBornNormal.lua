-- chunkname: @modules/logic/fight/system/work/FightWorkStartBornNormal.lua

module("modules.logic.fight.system.work.FightWorkStartBornNormal", package.seeall)

local FightWorkStartBornNormal = class("FightWorkStartBornNormal", BaseWork)

function FightWorkStartBornNormal:ctor(entity, needPlayBornAnim)
	self.entity = entity
	self.needPlayBornAnim = needPlayBornAnim
end

function FightWorkStartBornNormal:onStart(context)
	local entityData = FightDataHelper.entityMgr:getById(self.entity.id)
	local skinId = entityData and entityData.skin

	self.fightClass = FightBaseClass.New()

	local flow = self.fightClass:com_registFlowSequence()
	local bornWork = self.fightClass:com_registWork(Work2FightWork, FightWorkEntityBornLegacy, self.entity, self.needPlayBornAnim)
	local config = lua_fight_skin_entity_enter_timeline.configDict[skinId]

	if config and self.entity.skill and not self.entity.IS_SUB_ENTITY_ENTER then
		local fightStepData = FightStepData.New(FightDef_pb.FightStep())

		fightStepData.fromId = entityData.id
		fightStepData.toId = entityData.id
		fightStepData.isBornTimeline = true

		self.entity:setAlpha(0)

		bornWork = self.entity.skill:registTimelineWork(config.timeline, fightStepData)
	end

	flow:addWork(bornWork)
	flow:registFinishCallback(self.onFlowFinish, self)
	flow:start()
end

function FightWorkStartBornNormal:onFlowFinish()
	self:onDone(true)
end

function FightWorkStartBornNormal:clearWork()
	if self.fightClass then
		self.fightClass:disposeSelf()

		self.fightClass = nil
	end
end

return FightWorkStartBornNormal
