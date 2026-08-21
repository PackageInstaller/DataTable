-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/calculate/AirWorkBattleResultController.lua

module("logic.extensions.airworkshop.view.calculate.AirWorkBattleResultController", package.seeall)

local M = class("AirWorkBattleResultController", BaseController)

function M:ctor()
	M.super.ctor(self)

	self._resultData = false
	self._waitSeconds = 0
end

function M:onInit()
	self:onReset()
	self:setEvent(true)
end

function M:onReset()
	self._resultData = false
	self._rodeoFinishData = nil
	self._waitSeconds = 0
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.AIRWORKSHOP_MANAGER_TESTRESULT, self._handleTestBattleResult, self)
		GlobalDispatcher:addEventListener(EventType.AIRWORKSHOP_ON_BATTLE_SETTLE_PUSH, self._handleBattleResult, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_RODEO_FINISH_PUSH, self._handleRodeoFinishPush, self)
	else
		GlobalDispatcher:removeEventListener(EventType.AIRWORKSHOP_MANAGER_TESTRESULT, self._handleTestBattleResult, self)
		GlobalDispatcher:removeEventListener(EventType.AIRWORKSHOP_ON_BATTLE_SETTLE_PUSH, self._handleBattleResult, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_RODEO_FINISH_PUSH, self._handleRodeoFinishPush, self)
	end
end

function M:clearResultData()
	AirWorkMapModel.instance:resetTestResult()

	self._resultData = false
	self._waitSeconds = 0
end

function M:_handleTestBattleResult(e, params)
	if enableLog then
		printWarn("=====handleTestAirMapResultPush====")
	end
end

function M:_handleBattleResult(e, params)
	self._resultData = params

	if enableLog then
		printWarn("=====_handleAirBattleResultPush====")
	end
end

function M:_handleRodeoFinishPush(e, msg)
	if enableLog then
		printWarn("=====_handleRodeoFinishPush")
	end

	self:setRodeoFinishData(msg)
end

function M:setRodeoFinishData(data)
	self._rodeoFinishData = data
end

function M:getRodeoFinishData()
	return self._rodeoFinishData
end

function M:tryPushRodeFinishResultTips(exitFunc, exitHandler)
	local roundList = self:getRodeoFinishData()

	if roundList and #roundList > 0 then
		ToolTipsMgr.showAirWorkShopRodeoFinishResultTips(roundList, exitFunc, exitHandler)

		return true
	end

	return false
end

function M:openResult()
	local resultData = AirWorkMapModel.instance:getTestResult()

	if resultData then
		local style = AirWorkShopEnum.CalculateStyle.Test

		ViewMgr.instance:open(ViewName.AirWorkShopBattleResult, style, resultData)

		return
	end

	resultData = self._resultData

	if resultData then
		local style = AirWorkShopEnum.CalculateStyle.Free

		if self._resultData.rodeo and self._resultData.rodeo.round > 0 then
			style = AirWorkShopEnum.CalculateStyle.Competitive
		end

		ViewMgr.instance:open(ViewName.AirWorkShopBattleResult, style, resultData)

		return
	end

	self._waitSeconds = self._waitSeconds + 1

	if self._waitSeconds > 30 then
		BattleDispatcher:dispatchEvent(BattleEventType.ON_CALCULATE_FINISH)

		return
	end

	settimer(1, self.openResult, self, false)
end

M.instance = M.New()

return M
