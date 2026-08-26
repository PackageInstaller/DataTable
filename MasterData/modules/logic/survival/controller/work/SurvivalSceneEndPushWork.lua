-- chunkname: @modules/logic/survival/controller/work/SurvivalSceneEndPushWork.lua

module("modules.logic.survival.controller.work.SurvivalSceneEndPushWork", package.seeall)

local SurvivalSceneEndPushWork = class("SurvivalSceneEndPushWork", SurvivalMsgPushWork)

function SurvivalSceneEndPushWork:onStart(context)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if not weekInfo then
		self:onDone(true)

		return
	end

	weekInfo.inSurvival = false

	if self._msg.isWin then
		SurvivalMapModel.instance.result = SurvivalEnum.MapResult.Win or SurvivalEnum.MapResult.Lose
	end

	SurvivalMapModel.instance.resultData:init(self._msg)

	if ViewMgr.instance:isOpen(ViewName.SurvivalLoadingView) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
	else
		self:_tweenToPlayerAndDestoryUnit()
	end
end

function SurvivalSceneEndPushWork:_onViewClose(viewName)
	if viewName == ViewName.SurvivalLoadingView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
		self:_tweenToPlayerAndDestoryUnit()
	end
end

function SurvivalSceneEndPushWork:_tweenToPlayerAndDestoryUnit()
	ViewMgr.instance:closeAllModalViews()

	local isPlayAnim = self._msg.reason == 1 or self._msg.reason == 2 or self._msg.reason == 4

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Survival or not isPlayAnim then
		self:openResultView()

		return
	end

	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local player = sceneMo.player
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(player.pos.q, player.pos.r)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(x, y, z))

	local list = sceneMo:getUnitByPos(player.pos, true, true)

	if list then
		for i = #list, 1, -1 do
			local unitMo = list[i]

			sceneMo:deleteUnit(unitMo.id, false)
		end
	end

	local entity = SurvivalMapHelper.instance:getEntity(0)

	if entity and player:isDefaultModel() then
		UIBlockHelper.instance:startBlock("SurvivalCheckMapEndWork", 1.9)
		entity:playAnim("die")
		TaskDispatcher.runDelay(self.openResultView, self, 1.9)
	else
		self:openResultView()
	end
end

function SurvivalSceneEndPushWork:openResultView()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self.onViewClose, self)
	ViewMgr.instance:openView(ViewName.SurvivalMapResultPanelView, {
		isWin = SurvivalMapModel.instance.result == SurvivalEnum.MapResult.Win
	})

	self.context.fastExecute = self.context.fastExecute or true

	AudioMgr.instance:trigger(AudioEnum2_8.Survival.stop_ui_fuleyuan_tansuo_dutiao_loop)
end

function SurvivalSceneEndPushWork:onViewClose(viewName)
	if viewName == ViewName.SurvivalMapResultView then
		self:onDone(true)
	end
end

function SurvivalSceneEndPushWork:clearWork()
	SurvivalSceneEndPushWork.super.clearWork(self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self.onViewClose, self)
	TaskDispatcher.cancelTask(self.openResultView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
end

return SurvivalSceneEndPushWork
