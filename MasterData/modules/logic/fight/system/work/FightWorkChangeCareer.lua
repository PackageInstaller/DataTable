-- chunkname: @modules/logic/fight/system/work/FightWorkChangeCareer.lua

module("modules.logic.fight.system.work.FightWorkChangeCareer", package.seeall)

local FightWorkChangeCareer = class("FightWorkChangeCareer", FightEffectBase)
local career2EffectPath = {
	"buff/buff_lg_yan",
	"buff/buff_lg_xing",
	"buff/buff_lg_mu",
	"buff/buff_lg_shou",
	"buff/buff_lg_ling",
	"buff/buff_lg_zhi"
}

function FightWorkChangeCareer:beforePlayEffectData()
	local entityMO = FightDataHelper.entityMgr:getById(self.actEffectData.targetId)

	if entityMO then
		self.oldCareer = entityMO.career
	end
end

function FightWorkChangeCareer:onStart()
	local flow = self:com_registWorkDoneFlowSequence()
	local entityMO = FightDataHelper.entityMgr:getById(self.actEffectData.targetId)

	if entityMO and self.oldCareer ~= self.actEffectData.effectNum then
		flow:registWork(FightWorkFunction, self._playCareerChange, self)
		flow:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.ChangeCareer))
	end

	flow:start()
end

function FightWorkChangeCareer:_playCareerChange()
	local entityMO = FightDataHelper.entityMgr:getById(self.actEffectData.targetId)

	if entityMO then
		FightController.instance:dispatchEvent(FightEvent.ChangeCareer, entityMO.id)

		local entity = FightHelper.getEntity(entityMO.id)

		if entity and entity.effect and career2EffectPath[entityMO.career] then
			local effectWrap = entity.effect:addHangEffect(career2EffectPath[entityMO.career], "mounttop", nil, 2)

			FightRenderOrderMgr.instance:onAddEffectWrap(entity.id, effectWrap)
			effectWrap:setLocalPos(0, 0, 0)
		end
	end
end

function FightWorkChangeCareer:_onFlowDone()
	self:onDone(true)
end

function FightWorkChangeCareer:clearWork()
	return
end

return FightWorkChangeCareer
