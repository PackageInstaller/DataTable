-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/calculate/work/AirWorkCalculate.lua

module("logic.extensions.airworkshop.view.calculate.work.AirWorkCalculate", package.seeall)

local M = class("AirWorkCalculate", WorkCalculate)

function M:onEnter(context)
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

	AirWorkBattleResultController.instance:openResult()
end

function M:onExit(isInterrupt)
	self:_setEvent(false)
	CriwareAudioPlayer.instance:stopAllSESound()
end

function M:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.ON_CALCULATE_FINISH, self._onCalculateFinish, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.ON_CALCULATE_FINISH, self._onCalculateFinish, self)
	end
end

function M:_onCalculateFinish(eventId)
	self:onDone(WorkResult.Succeed)
	AirWorkBattleResultController.instance:clearResultData()
end

return M
