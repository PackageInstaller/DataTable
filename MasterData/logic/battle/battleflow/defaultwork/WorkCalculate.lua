-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkCalculate.lua

module("logic.battle.battleflow.defaultwork.WorkCalculate", package.seeall)

local WorkCalculate = class("WorkCalculate", WorkBase)

function WorkCalculate:onEnter(context)
	local model = context.model
	local resultMO = context.model:getResultMO()
	local phase = context.model:getPhase()

	if resultMO:isSkip() or not resultMO:isValid() or resultMO:isSurrender() and phase ~= BattleEnum.Phase.NORMAL then
		self:onDone(WorkResult.Succeed)

		return
	end

	self:_setEvent(true)
	BattleCalculateModel.instance:setIsWin(model:isWin())
	context:setupCalculateModel()
	CriwareAudioFacade.instance:stopBgm()
	CriwareAudioFacade.instance:stopCurrentEnvironment()

	if model:isWin() then
		CriwareAudioFacade.instance:playBgmInnerById(CriwareAudioEnum.music_battle_victory, nil, nil)
	else
		CriwareAudioFacade.instance:playBgmInnerById(CriwareAudioEnum.music_battle_fail, nil, nil)
	end

	if resultMO:isSurrender() then
		BattleDispatcher:dispatchEvent(BattleEventType.ON_CALCULATE_FINISH)
	elseif model:isWin() then
		ViewMgr.instance:open(ViewName.BattleResultWinView)
	else
		ViewMgr.instance:open(ViewName.BattleResultFailView)
	end
end

function WorkCalculate:onExit(isInterrupt)
	self:_setEvent(false)
	BattleCalculateModel.instance:clear()
	CriwareAudioPlayer.instance:stopAllSESound()
end

function WorkCalculate:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.ON_CALCULATE_FINISH, self._onCalculateFinish, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.ON_CALCULATE_FINISH, self._onCalculateFinish, self)
	end
end

function WorkCalculate:_onCalculateFinish(eventId)
	self:onDone(WorkResult.Succeed)
end

return WorkCalculate
