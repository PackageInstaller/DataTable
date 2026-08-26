-- chunkname: @modules/logic/fight/system/work/FightWorkBuffAddContainer.lua

module("modules.logic.fight.system.work.FightWorkBuffAddContainer", package.seeall)

local FightWorkBuffAddContainer = class("FightWorkBuffAddContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.BUFFADD] = true
}
local BuffEffectTime = 0.15
local BuffFloatTime = 0.05

function FightWorkBuffAddContainer:onStart()
	local list = self:getAdjacentSameEffectList(parallelEffectType, true)
	local parallelFlow = self:com_registWorkDoneFlowParallel()
	local entityDic = {}

	for i, data in ipairs(list) do
		local actEffectData = data.actEffectData
		local buff = actEffectData.buff

		if buff then
			local buffConfig = lua_skill_buff.configDict[buff.buffId]

			if not buffConfig then
				logError(string.format("buffId : %s co is not found", buff.buffId))
			end

			local buffTypeConfig = lua_skill_bufftype.configDict[buffConfig.typeId]

			if buffConfig and buffTypeConfig then
				local dataList = entityDic[actEffectData.targetId]

				if not dataList then
					dataList = {}
					entityDic[actEffectData.targetId] = dataList
				end

				table.insert(dataList, data)
			end
		end
	end

	local entityFlow = {}

	for k, v in pairs(entityDic) do
		for i, data in ipairs(v) do
			local fightStepData = data.fightStepData
			local actEffectData = data.actEffectData
			local buffId = actEffectData.buff.buffId
			local buffConfig = lua_skill_buff.configDict[buffId]
			local buffTypeConfig = lua_skill_bufftype.configDict[buffConfig.typeId]
			local flow = entityFlow[actEffectData.targetId]

			if not flow then
				flow = parallelFlow:registWork(FightWorkFlowSequence)
				entityFlow[actEffectData.targetId] = flow
			end

			if buffConfig.isNoShow == 1 then
				flow:registWork(FightWorkStepBuff, fightStepData, actEffectData)
			elseif buffTypeConfig.skipDelay == 1 then
				flow:registWork(FightWorkStepBuff, fightStepData, actEffectData)
			elseif lua_fight_stacked_buff_combine.configDict[buffConfig.id] then
				local nextEffect = v[i + 1]

				if nextEffect and nextEffect.buff and nextEffect.buff.buffId == buffId then
					flow:registWork(FightWorkFunction, self._lockEntityBuffFloat, self, {
						true,
						entityId = actEffectData.targetId
					})
				else
					flow:registWork(FightWorkFunction, self._lockEntityBuffFloat, self, {
						false,
						entityId = actEffectData.targetId
					})
				end

				flow:registWork(FightWorkStepBuff, fightStepData, actEffectData)
			elseif buffConfig.effect ~= "0" and not string.nilorempty(buffConfig.effect) then
				flow:registWork(FightWorkStepBuff, fightStepData, actEffectData)
				flow:registWork(FightWorkDelayTimer, BuffEffectTime / FightModel.instance:getSpeed())
			else
				flow:registWork(FightWorkStepBuff, fightStepData, actEffectData)
				flow:registWork(FightWorkDelayTimer, BuffFloatTime / FightModel.instance:getSpeed())
			end
		end
	end

	parallelFlow:start()
end

function FightWorkBuffAddContainer:_lockEntityBuffFloat(param)
	local tar_entity = FightHelper.getEntity(param.entityId)

	if tar_entity and tar_entity.buff then
		tar_entity.buff.lockFloat = param.state
	end
end

function FightWorkBuffAddContainer:clearWork()
	return
end

return FightWorkBuffAddContainer
