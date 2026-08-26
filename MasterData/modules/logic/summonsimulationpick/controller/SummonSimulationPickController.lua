-- chunkname: @modules/logic/summonsimulationpick/controller/SummonSimulationPickController.lua

module("modules.logic.summonsimulationpick.controller.SummonSimulationPickController", package.seeall)

local SummonSimulationPickController = class("SummonSimulationPickController", BaseController)

function SummonSimulationPickController:onInit()
	return
end

function SummonSimulationPickController:onInitFinish()
	return
end

function SummonSimulationPickController:addConstEvents()
	return
end

function SummonSimulationPickController:reInit()
	return
end

function SummonSimulationPickController:getActivityInfo(activityId, callBack, callBackObj)
	SummonSimulationPickRpc.instance:getInfo(activityId, callBack, callBackObj)
end

function SummonSimulationPickController:setCurActivityId(activityId)
	self._activityId = activityId
end

function SummonSimulationPickController:getCurrentActivityInfo()
	local activityId = self._activityId

	if not activityId then
		return nil
	end

	return SummonSimulationPickModel.instance:getActInfo(activityId)
end

function SummonSimulationPickController:summonSimulation(activityId, needAdjust)
	self:setCurActivityId(activityId)

	if needAdjust == nil then
		needAdjust = true
	end

	if needAdjust then
		local activityInfo = SummonSimulationPickModel.instance:getActInfo(activityId)
		local msgId = MessageBoxIdDefine.SummonSimulationAgain
		local maxTimes = activityInfo.maxCount
		local remainTimes = activityInfo.leftTimes

		GameFacade.showMessageBox(msgId, MsgBoxEnum.BoxType.Yes_No, self.realSummonSimulation, nil, nil, self, nil, nil, remainTimes, maxTimes)

		return
	end

	self:realSummonSimulation()
end

function SummonSimulationPickController:realSummonSimulation()
	local activityId = self._activityId

	self.registerCallback(self, SummonSimulationEvent.onSummonSimulation, self.onSummonSimulationSuccess, self)
	SummonSimulationPickRpc.instance:summonSimulation(activityId)
end

function SummonSimulationPickController:onSummonSimulationSuccess(activityId)
	SummonController.instance:registerCallback(SummonEvent.summonShowBlackScreen, self.onReceiveShowBlackScreen, self)
	SummonController.instance:registerCallback(SummonEvent.summonCloseBlackScreen, self.onReceiveCloseBlackScreen, self)
	SummonController.instance:registerCallback(SummonEvent.summonMainCloseImmediately, self.closeView, self)

	local info = SummonSimulationPickModel.instance:getActInfo(activityId)

	if info.saveHeroIds then
		if not info.saveHeroIds[#info.saveHeroIds] then
			local heroIds = {}

			self:setCurrentSummonActivityId(activityId)
			SummonController.instance:doVirtualSummonBehavior(heroIds, true, true, self.backHome, self)
			self.unregisterCallback(self, SummonSimulationEvent.onSummonSimulation, self.onSummonSimulationSuccess, self)
		end
	end
end

function SummonSimulationPickController:saveResult(activityId)
	self:setCurActivityId(activityId)

	local msgId = MessageBoxIdDefine.SummonSimulationSave

	GameFacade.showMessageBox(msgId, MsgBoxEnum.BoxType.Yes_No, self.realSaveResult, nil, nil, self)
end

function SummonSimulationPickController:realSaveResult()
	local activityId = self:getCurrentSummonActivityId()

	SummonSimulationPickRpc.instance:saveResult(activityId)
end

function SummonSimulationPickController:selectResult(activityId, needAdjust)
	self:setCurActivityId(activityId)

	needAdjust = needAdjust or true

	if needAdjust then
		local activityInfo = SummonSimulationPickModel.instance:getActInfo(activityId)
		local remainTimes = activityInfo.leftTimes

		GameFacade.showMessageBox((remainTimes <= 0 or nil) and MessageBoxIdDefine.SummonSimulationSelectCurrent, MsgBoxEnum.BoxType.Yes_No, self.realSelectResult, nil, nil, self, nil, nil, remainTimes)

		return
	end

	self:realSelectResult()
end

function SummonSimulationPickController:realSelectResult()
	local activityId = self._activityId
	local selectType = SummonSimulationPickModel.instance:getCurSelectIndex()

	CharacterModel.instance:setGainHeroViewShowState(false)
	CharacterModel.instance:setGainHeroViewNewShowState(true)
	SummonSimulationPickRpc.instance:selectResult(activityId, selectType)
	self.registerCallback(self, SummonSimulationEvent.onSelectResult, self.onSelectResult, self)
end

function SummonSimulationPickController:onSelectResult()
	self:startBlack(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onViewOpen, self)
end

function SummonSimulationPickController:trySummonSimulation(activityId)
	local activityInfo = SummonSimulationPickModel.instance:getActInfo(activityId)

	if not activityInfo.isSelect and activityInfo.leftTimes < activityInfo.maxCount then
		self:setCurrentSummonActivityId(activityId)

		if activityInfo.leftTimes <= 0 then
			ViewMgr.instance:openView(ViewName.SummonSimulationPickView, {
				isFromMaterialTipView = true,
				activityId = activityId
			})
		else
			local heroIds = activityInfo.saveHeroIds[#activityInfo.saveHeroIds]
			local result = SummonController.instance:getVirtualSummonResult(heroIds, false, false)

			ViewMgr.instance:openView(ViewName.SummonSimulationResultView, {
				isReprint = true,
				summonResultList = result
			})
		end

		return
	end

	SummonSimulationPickController.instance:summonSimulation(activityId, false)
end

function SummonSimulationPickController:startBlack(isImmediate)
	if isImmediate then
		ViewMgr.instance:openView(ViewName.LoadingBlackView, nil, true)
	else
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView)
		GameSceneMgr.instance:showLoading(SceneType.Main)
	end
end

function SummonSimulationPickController:endBlack(isImmediate)
	if isImmediate then
		ViewMgr.instance:closeView(ViewName.LoadingBlackView, true)
	else
		GameSceneMgr.instance:hideLoading(SceneType.Main)
	end
end

function SummonSimulationPickController:closeView()
	self:endBlack()
	self:unregisterSceneEvent()
	ViewMgr.instance:closeAllViews({
		ViewName.SummonView
	})
end

function SummonSimulationPickController:setCurrentSummonActivityId(activityId)
	self._currentActivityId = activityId
end

function SummonSimulationPickController:getCurrentSummonActivityId()
	return self._currentActivityId
end

function SummonSimulationPickController:unregisterSceneEvent()
	SummonController.instance:unregisterCallback(SummonEvent.summonShowBlackScreen, self.onReceiveShowBlackScreen, self)
	SummonController.instance:unregisterCallback(SummonEvent.summonCloseBlackScreen, self.onReceiveCloseBlackScreen, self)
	SummonController.instance:unregisterCallback(SummonEvent.summonMainCloseImmediately, self.closeView, self)
end

function SummonSimulationPickController:backHome()
	local isSummonSceneOpen = VirtualSummonScene.instance:isOpen()
	local isBackpackViewOpen = ViewMgr.instance:isOpen(ViewName.BackpackView)

	if isSummonSceneOpen and not isBackpackViewOpen then
		self:startBlack(true)
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		MainController.instance:enterMainScene(true)
	end

	VirtualSummonScene.instance:close(true)

	if not isBackpackViewOpen then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onViewOpen, self)
		BackpackController.instance:enterItemBackpack(ItemEnum.CategoryType.UseType)
	end
end

function SummonSimulationPickController:onViewClose(viewName)
	if viewName == ViewName.CommonPropView then
		self:endBlack(true)
	end
end

function SummonSimulationPickController:onViewOpen(viewName)
	if viewName == ViewName.BackpackView or viewName == ViewName.CharacterGetView or viewName == ViewName.CommonPropView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.onViewOpen, self)
		self:endBlack(true)
	end
end

function SummonSimulationPickController:openSummonTips(activityId)
	logNormal("Click SummonSimulationTips actId: " .. activityId)

	local config = SummonSimulationPickConfig.instance:getSummonConfigById(activityId)
	local pool = SummonConfig.instance:getSummonPool(config.poolId)

	SummonMainController.instance:openSummonDetail(pool, nil, config.activityId)
end

function SummonSimulationPickController:onReceiveShowBlackScreen()
	logNormal("SummonSimulationPickController onReceiveShowBlackScreen")
	self:startBlack()
	TaskDispatcher.runDelay(self.afterBlackLoading, self, 0.3)
end

function SummonSimulationPickController:afterBlackLoading()
	logNormal("SummonSimulationPickController afterBlackLoading")
	TaskDispatcher.cancelTask(self.afterBlackLoading, self)
	SummonController.instance:onFirstLoadSceneBlock()
end

function SummonSimulationPickController:onReceiveCloseBlackScreen()
	logNormal("SummonSimulationPickController onReceiveCloseBlackScreen")
	self:closeView()
end

SummonSimulationPickController.instance = SummonSimulationPickController.New()

return SummonSimulationPickController
