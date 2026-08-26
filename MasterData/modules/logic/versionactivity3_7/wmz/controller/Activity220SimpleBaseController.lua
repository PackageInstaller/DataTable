-- chunkname: @modules/logic/versionactivity3_7/wmz/controller/Activity220SimpleBaseController.lua

module("modules.logic.versionactivity3_7.wmz.controller.Activity220SimpleBaseController", package.seeall)

local Activity220SimpleBaseController = class("Activity220SimpleBaseController", BaseController)

function Activity220SimpleBaseController:ctor(...)
	Activity220SimpleBaseController.super.ctor(self, ...)
end

function Activity220SimpleBaseController:onInit()
	self:reInit()
end

function Activity220SimpleBaseController:reInit()
	Activity220SimpleBaseController.super.reInit(self)
	GameUtil.onDestroyViewMember(self, "__simpleGameFlow")

	self._cbOnPreHookGamePreStory = nil
	self._cbObjOnPreHookGamePreStory = nil
	self._cbOnPostHookGamePreStory = nil
	self._cbObjOnPostHookGamePreStory = nil
	self._cbOnPreHookRestartGame = nil
	self._cbObjOnPreHookRestartGame = nil
	self._cbOnPostHookRestartGame = nil
	self._cbObjOnPostHookRestartGame = nil
	self._cbOnPreHookGamePostStory = nil
	self._cbObjOnPreHookGamePostStory = nil
	self._cbOnPostHookGamePostStory = nil
	self._cbObjOnPostHookGamePostStory = nil
end

function Activity220SimpleBaseController:_internal_set_system(systemModel)
	assert(isTypeOf(systemModel, Activity220SimpleBaseModel))

	self._system = systemModel
end

function Activity220SimpleBaseController:_internal_set_battle(battleModel)
	assert(isTypeOf(battleModel, Activity220SimpleBaseModel))

	self._battle = battleModel
end

function Activity220SimpleBaseController:systemInst()
	return assert(self._system, "please call self:_internal_set_system(systemModel) first")
end

function Activity220SimpleBaseController:battleInst()
	return assert(self._battle, "please call self:_internal_set_battle(battleModel) first")
end

function Activity220SimpleBaseController:configInst()
	return self:systemInst():configInst()
end

function Activity220SimpleBaseController:actId()
	return self:configInst():actId()
end

function Activity220SimpleBaseController:taskType()
	return self:configInst():taskType()
end

function Activity220SimpleBaseController:addConstEvents()
	Activity220Controller.instance:registerCallback(Activity220Event.GetAct220InfoReply, self.onReceiveGetAct220InfoReply, self)
	Activity220Controller.instance:registerCallback(Activity220Event.SaveEpisodeProgressReply, self.onReceiveAct220SaveEpisodeProgressReply, self)
	Activity220Controller.instance:registerCallback(Activity220Event.FinishEpisodeReply, self.onReceiveAct220FinishEpisodeReply, self)
	Activity220Controller.instance:registerCallback(Activity220Event.ChooseEpisodeBranchReply, self.onReceiveAct220ChooseEpisodeBranchReply, self)
	Activity220Controller.instance:registerCallback(Activity220Event.EpisodePush, self.onReceiveAct220EpisodePush, self)
end

function Activity220SimpleBaseController:onReceiveGetAct220InfoReply(...)
	self._system:onReceiveGetAct220InfoReply(...)
end

function Activity220SimpleBaseController:onReceiveAct220FinishEpisodeReply(...)
	self._system:onReceiveAct220FinishEpisodeReply(...)
	self._battle:onReceiveAct220FinishEpisodeReply(...)
end

function Activity220SimpleBaseController:onReceiveAct220EpisodePush(...)
	self._system:onReceiveAct220EpisodePush(...)
end

function Activity220SimpleBaseController:onReceiveAct220SaveEpisodeProgressReply(...)
	self._system:onReceiveAct220SaveEpisodeProgressReply(...)
end

function Activity220SimpleBaseController:onReceiveAct220ChooseEpisodeBranchReply(...)
	self._system:onReceiveAct220ChooseEpisodeBranchReply(...)
end

function Activity220SimpleBaseController:sendGetAct220InfoRequest(cb, cbObj)
	Activity220Rpc.instance:sendGetAct220InfoRequest(self:actId(), cb, cbObj)
end

function Activity220SimpleBaseController:sendAct220FinishEpisodeRequest(episodeId, callback, callbackObj)
	local progress

	Activity220Rpc.instance:sendAct220FinishEpisodeRequest(self:actId(), episodeId, progress, callback, callbackObj)
end

function Activity220SimpleBaseController:enterLevelView()
	self.sendGetAct220InfoRequest(self, self._onEnterLevelViewOnSvrCb, self)
end

function Activity220SimpleBaseController:_onEnterLevelViewOnSvrCb(_, resultCode)
	if resultCode ~= 0 then
		logError("Activity220SimpleBaseController:enterLevelView resultCode=" .. tostring(resultCode))

		return
	end

	self:enterLevelViewImpl()
end

function Activity220SimpleBaseController:setOnPreHookGamePreStory(cb, cbObj)
	self._cbOnPreHookGamePreStory = cb
	self._cbObjOnPreHookGamePreStory = cbObj
end

function Activity220SimpleBaseController:setOnPostHookGamePreStory(cb, cbObj)
	self._cbOnPostHookGamePreStory = cb
	self._cbObjOnPostHookGamePreStory = cbObj
end

function Activity220SimpleBaseController:setOnPreHookRestartGame(cb, cbObj)
	self._cbOnPreHookRestartGame = cb
	self._cbObjOnPreHookRestartGame = cbObj
end

function Activity220SimpleBaseController:setOnPostHookRestartGame(cb, cbObj)
	self._cbOnPostHookRestartGame = cb
	self._cbObjOnPostHookRestartGame = cbObj
end

function Activity220SimpleBaseController:setOnPreHookGamePostStory(cb, cbObj)
	self._cbOnPreHookGamePostStory = cb
	self._cbObjOnPreHookGamePostStory = cbObj
end

function Activity220SimpleBaseController:setOnPostHookGamePostStory(cb, cbObj)
	self._cbOnPostHookGamePostStory = cb
	self._cbObjOnPostHookGamePostStory = cbObj
end

function Activity220SimpleBaseController:_hookFlowExecCb(cb, cbObj)
	if not cb then
		return
	end

	local refFlow = self.__simpleGameFlow

	callWithCatch(cb, cbObj, refFlow)
end

function Activity220SimpleBaseController:startSimpleGameFlow(episodeId)
	GameUtil.onDestroyViewMember(self, "__simpleGameFlow")

	self.__simpleGameFlow = GaoSiNiaoFlowSequence_Base.New()

	local flow = self.__simpleGameFlow
	local episodeCO = self:configInst():getEpisodeConfig(episodeId)
	local storyBefore = episodeCO.storyBefore
	local storyClear = episodeCO.storyClear
	local gameId = episodeCO.gameId

	self:_hookFlowExecCb(self._cbOnPreHookGamePreStory, self._cbObjOnPreHookGamePreStory)
	flow:addWork(GaoSiNiaoWork_PlayStory.s_create(storyBefore))
	self:_hookFlowExecCb(self._cbOnPostHookGamePreStory, self._cbObjOnPostHookGamePreStory)

	if gameId > 0 then
		self:_hookFlowExecCb(self._cbOnPreHookRestartGame, self._cbObjOnPreHookRestartGame)
		flow:addWork(FunctionWork.New(self._battle.restart, self._battle, episodeId))
		self:_hookFlowExecCb(self._cbOnPostHookRestartGame, self._cbObjOnPostHookRestartGame)
		flow:addWork(WmzWork_WaitEvent.s_create(self, Activity220Event.EpisodeFinished, episodeId))
	else
		self._battle:clear()
	end

	if not self._system:isEpisodePass(episodeId) then
		flow:addWork(FunctionWork.New(self._onFirstPassEpisode, self, episodeId))
		flow:addWork(WmzWork_WaitEvent.s_create(self, Activity220Event.ClientGameExit))
	else
		flow:addWork(FunctionWork.New(self.onTrackPassImpl, self))
	end

	self:_hookFlowExecCb(self._cbOnPreHookGamePostStory, self._cbObjOnPreHookGamePostStory)
	flow:addWork(GaoSiNiaoWork_PlayStory.s_create(storyClear))
	self:_hookFlowExecCb(self._cbOnPostHookGamePostStory, self._cbObjOnPostHookGamePostStory)
	flow:start()
end

function Activity220SimpleBaseController:completeGame(isWin, episodeId)
	episodeId = episodeId or self._battle:episodeId()

	self._battle:setIsWin(isWin, episodeId)
	self:dispatchEvent(Activity220Event.EpisodeFinished, episodeId)
end

function Activity220SimpleBaseController:_onFirstPassEpisode(episodeId)
	if self:configInst():bHasGame(episodeId) then
		local isWin = self._battle:isWin()

		if not isWin then
			self:dispatchEvent(Activity220Event.ClientGameExit)

			return
		end
	end

	self.sendAct220FinishEpisodeRequest(self, episodeId, self._onSendAct220FinishEpisodeCallback, self)
	self:onTrackPassImpl(true)
end

function Activity220SimpleBaseController:_onSendAct220FinishEpisodeCallback(_, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local episodeId = msg.episodeId

	self._system:setNewFinishEpisode(episodeId)
	self:dispatchEvent(Activity220Event.ClientGameExit)
end

function Activity220SimpleBaseController:onTrackPassImpl(bFirstPass)
	return
end

function Activity220SimpleBaseController:enterLevelViewImpl()
	assert(false, "please override this function")
end

return Activity220SimpleBaseController
