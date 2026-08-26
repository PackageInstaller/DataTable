-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_Controller.lua

module("modules.logic.rouge2.common.controller.Rouge2_Controller", package.seeall)

local Rouge2_Controller = class("Rouge2_Controller", BaseController)

function Rouge2_Controller:onInit()
	return
end

function Rouge2_Controller:reInit()
	return
end

function Rouge2_Controller:addConstEvents()
	return
end

function Rouge2_Controller:startRouge()
	self:reallyStartRouge()
end

function Rouge2_Controller:reallyStartRouge()
	local actId = Rouge2_Model.instance:getCurActId()

	if not Rouge2_Controller.instance:checkIsOpen(true) then
		return
	end

	if Rouge2_Model.instance:isStarted() then
		self:enterRouge()
	elseif Rouge2_Model.instance:isFinishedDifficulty() then
		Rouge2_ViewHelper.openCareerSelectView()
	else
		Rouge2_ViewHelper.openDifficultySelectView()
	end
end

function Rouge2_Controller:enterRouge()
	DungeonModel.instance.curSendEpisodeId = nil

	if not LoginController.instance:isEnteredGame() then
		return
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Rouge2_MapView)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.Rouge2_MapLoadingView)
	GameSceneMgr.instance:startScene(SceneType.Rouge2, 1, 1, true)
end

function Rouge2_Controller:checkIsOpen(showToast)
	if not Rouge2_Model.instance:isUnlock() then
		if showToast then
			GameFacade.showToast(ToastEnum.Rouge2FunctionLockTip)
		end

		return false
	end

	if not Rouge2_Model.instance:isRogueOpen() then
		if showToast then
			GameFacade.showToast(ToastEnum.ActivityNotOpen)
		end

		return false
	end

	return true
end

function Rouge2_Controller:isFirstGetInfo()
	return Rouge2_Model.instance:isFirstGetInfo()
end

function Rouge2_Controller:openMainView(viewParam, isImmediate, callback, callbackTarget)
	Rouge2_Rpc.instance:sendGetRouge2InfoRequest(function(_, resultCode)
		if resultCode ~= 0 then
			logError("openRouge2MainView sendGetRouge2InfoRequest resultCode=" .. tostring(resultCode))

			return
		end

		Rouge2_ViewHelper.openMainView(viewParam, isImmediate)

		if callback then
			callback(callbackTarget)
		end
	end)
end

function Rouge2_Controller:openEnterView(viewParam, isImmediate, callback, callbackTarget)
	Rouge2_ViewHelper.openEnterView(viewParam, isImmediate)

	if callback then
		callback(callbackTarget)
	end
end

function Rouge2_Controller:enterDungeonView()
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Rouge2)
	DungeonController.instance:enterDungeonView()
end

function Rouge2_Controller:tryEnd()
	Rouge2_StatController.instance:setReset()
	Rouge2_Rpc.instance:sendRouge2AbortRequest(self._onReceiveEndReply, self)
end

function Rouge2_Controller:_onReceiveEndReply()
	Rouge2_Controller.instance:startEndFlow()
end

function Rouge2_Controller:startEndFlow()
	if Rouge2_Model.instance:isFinish() then
		self:clearFlow()

		self.endFlow = FlowSequence.New()

		local endId = Rouge2_Model.instance:getEndId()
		local hadEnd = endId and endId ~= 0

		if hadEnd then
			self:addEndStoryFlow(endId)
		end

		self.endFlow:addWork(Rouge2_WaitFinishViewDoneWork.New(hadEnd, endId))
		self.endFlow:addWork(OpenViewAndWaitCloseWork.New(ViewName.Rouge2_ResultView))
		self.endFlow:addWork(OpenViewAndWaitCloseWork.New(ViewName.Rouge2_SettlementView))
		self.endFlow:addWork(Rouge2_WaitOpenSettlementUnlockWork.New())
		self.endFlow:addWork(Rouge2_WaitOpenReviewWork.New())
		self.endFlow:registerDoneListener(self.onEndFlowDone, self)
		self.endFlow:start()
	end
end

function Rouge2_Controller:addEndStoryFlow(endId)
	local endCo = Rouge2_Config.instance:getEndingCO(endId)
	local storyId = endCo and endCo.endingStoryId

	if storyId then
		self.endFlow:addWork(Rouge2_WaitRougeStoryDoneWork.New(storyId))
	end
end

function Rouge2_Controller:clearFlow()
	if self.endFlow then
		self.endFlow:destroy()

		self.endFlow = nil
	end
end

function Rouge2_Controller:onEndFlowDone()
	self:clearAllData()
	Rouge2_MapLocalDataHelper.clear()
	Rouge2OutsideRpc.instance:sendGetRouge2OutsideInfoRequest()
end

function Rouge2_Controller:isEndFlowRunning()
	return self.endFlow ~= nil
end

function Rouge2_Controller:clearAllData()
	Rouge2_MapHelper.clearMapData()
	Rouge2_Model.instance:clear()
	Rouge2_MapModel.instance:setManualCloseHeroGroupView(false)
end

local ViewParam = {}

function Rouge2_Controller:openTechniqueView(techniqueId)
	ViewParam.techniqueId = techniqueId

	ViewMgr.instance:openView(ViewName.FightRouge2TechniqueView, ViewParam)
end

Rouge2_Controller.instance = Rouge2_Controller.New()

return Rouge2_Controller
