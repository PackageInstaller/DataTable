-- chunkname: @modules/logic/fight/system/work/FightWorkEnterQTE.lua

module("modules.logic.fight.system.work.FightWorkEnterQTE", package.seeall)

local FightWorkEnterQTE = class("FightWorkEnterQTE", FightWorkItem)
local EntityMoList = {}

FightWorkEnterQTE.ActiveKey = "FightQteHideEffect"

function FightWorkEnterQTE:onStart()
	local roundData = FightDataHelper.roundMgr:getRoundData()
	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkSendEvent, FightEvent.QTE_BeforeEnterQte)

	local myVertin = FightGameMgr.entityMgr:getMyVertin()

	if myVertin then
		local timelineName = lua_fight_qte_const.configDict[4].value
		local fightStepData = FightStepData.New()

		fightStepData.actEffect = LuaUtil.emptyTable
		fightStepData.fromId = myVertin.id
		fightStepData.toId = FightEntityScene.EnemySideId

		local timelineWork = myVertin.skill:registTimelineWork(timelineName, fightStepData)

		flow:addWork(timelineWork)
	end

	local stepWorkList = FightStepBuilder.buildStepWorkList(roundData and roundData.fightStep)

	if stepWorkList then
		local i = 1

		while i <= #stepWorkList do
			local work = stepWorkList[i]

			i = i + 1

			flow:addWork(work)
		end
	end

	flow:addWork(WorkWaitSeconds.New(0.1 / FightModel.instance:getSpeed()))
	flow:addWork(FunctionWork.New(self.hideEntityEffect))
	flow:addWork(FightWorkCompareDataAfterPlay.New())
	flow:registFinishCallback(self.onEnterQteDone, self)
	self:playWorkAndDone(flow, {})
end

function FightWorkEnterQTE.hideEntityEffect()
	local entityList = FightDataHelper.entityMgr:getMyNormalList(EntityMoList)

	for _, entityMo in ipairs(entityList) do
		if not entityMo:isQteEntity() then
			local entity = FightHelper.getEntity(entityMo.uid)

			if entity then
				entity.effect:setActive(false, FightWorkEnterQTE.ActiveKey)
			end
		end
	end

	tabletool.clear(EntityMoList)

	local vertin = FightGameMgr.entityMgr:getMyVertin()

	if vertin then
		vertin.effect:setActive(false, FightWorkEnterQTE.ActiveKey)
	end
end

function FightWorkEnterQTE.showEntityEffect()
	local entityList = FightDataHelper.entityMgr:getMyNormalList(EntityMoList)

	for _, entityMo in ipairs(entityList) do
		if not entityMo:isQteEntity() then
			local entity = FightHelper.getEntity(entityMo.uid)

			if entity then
				entity.effect:setActive(true, FightWorkEnterQTE.ActiveKey)
			end
		end
	end

	tabletool.clear(EntityMoList)

	local vertin = FightGameMgr.entityMgr:getMyVertin()

	if vertin then
		vertin.effect:setActive(true, FightWorkEnterQTE.ActiveKey)
	end
end

function FightWorkEnterQTE:onEnterQteDone()
	FightController.instance:dispatchEvent(FightEvent.QTE_AfterEnterQte)
end

return FightWorkEnterQTE
