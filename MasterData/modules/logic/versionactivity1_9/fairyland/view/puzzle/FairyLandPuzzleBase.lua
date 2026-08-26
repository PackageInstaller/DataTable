-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/puzzle/FairyLandPuzzleBase.lua

module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzleBase", package.seeall)

local FairyLandPuzzleBase = class("FairyLandPuzzleBase", UserDataDispose)

function FairyLandPuzzleBase:init(param)
	self:__onInit()

	self.config = param.config
	self.viewGO = param.viewGO

	self:onInitView()
	self:start()

	local isFinish = FairyLandModel.instance:isPassPuzzle(self.config.id)

	if isFinish then
		if not FairyLandModel.instance:isFinishDialog(self.config.successTalkId) then
			self:playSuccessTalk()
		elseif not FairyLandModel.instance:isFinishDialog(self.config.storyTalkId) then
			self:playStoryTalk()
		end
	elseif not FairyLandModel.instance:isFinishDialog(self.config.afterTalkId) then
		self:playAfterTalk()
	end
end

function FairyLandPuzzleBase:start()
	self:onStart()
end

function FairyLandPuzzleBase:refresh(config)
	self.config = config

	self:onRefreshView()
end

function FairyLandPuzzleBase:destory()
	TaskDispatcher.cancelTask(self.playTipsAnim, self)
	TaskDispatcher.cancelTask(self.playTipsTalk, self)
	self:onDestroyView()
	self:__onDispose()
end

function FairyLandPuzzleBase:stopCheckTips()
	TaskDispatcher.cancelTask(self.playTipsAnim, self)
	TaskDispatcher.cancelTask(self.playTipsTalk, self)
end

function FairyLandPuzzleBase:startCheckTips()
	self:startCheckAnim()
	self:startCheckTalk()
end

function FairyLandPuzzleBase:startCheckAnim()
	TaskDispatcher.cancelTask(self.playTipsAnim, self)

	if not FairyLandModel.instance:isFinishDialog(self.config.afterTalkId) then
		return
	end

	if FairyLandModel.instance:isPassPuzzle(self.config.id) then
		return
	end

	TaskDispatcher.runDelay(self.playTipsAnim, self, 4)
end

function FairyLandPuzzleBase:startCheckTalk()
	TaskDispatcher.cancelTask(self.playTipsTalk, self)

	if not FairyLandModel.instance:isFinishDialog(self.config.afterTalkId) then
		return
	end

	if FairyLandModel.instance:isPassPuzzle(self.config.id) then
		return
	end

	TaskDispatcher.runDelay(self.playTipsTalk, self, 5)
end

function FairyLandPuzzleBase:playAfterTalk()
	self.playTalk(self, self.config.afterTalkId, self.startCheckTips, self)
end

function FairyLandPuzzleBase:playSuccessTalk()
	self:stopCheckTips()

	if not FairyLandModel.instance:isPassPuzzle(self.config.id) then
		FairyLandRpc.instance:sendResolvePuzzleRequest(self.config.id, self.config.answer)
	end

	self.playTalk(self, self.config.successTalkId, self.openCompleteView, self)
end

function FairyLandPuzzleBase:playErrorTalk()
	self:stopCheckTips()
	self.playTalk(self, self.config.errorTalkId, self.startCheckTips, self, true)
end

function FairyLandPuzzleBase:playTipsTalk()
	self.playTalk(self, self.config.tipsTalkId, self.startCheckTalk, self, true)
end

function FairyLandPuzzleBase:playTipsAnim()
	if not self.tipAnim then
		return
	end

	self.tipAnim:Stop()

	if not self.tipAnim.isActiveAndEnabled then
		return
	end

	self.tipAnim:Play("open", self.startCheckAnim, self)
end

function FairyLandPuzzleBase:playStoryTalk()
	if FairyLandModel.instance:isPassPuzzle(self.config.id) then
		if self.config.storyTalkId == 0 then
			return
		end

		if not FairyLandModel.instance:isFinishDialog(self.config.storyTalkId) then
			local param = {}

			param.dialogId = self.config.storyTalkId
			param.dialogType = FairyLandEnum.DialogType.Option

			FairyLandController.instance:openDialogView(param)
		end
	end
end

function FairyLandPuzzleBase:openCompleteView()
	local element = FairyLandModel.instance:getDialogElement(self.config.elementId)

	if element then
		element:setFinish()
	end

	FairyLandController.instance:openCompleteView(self.config.id, self.playStoryTalk, self)
end

function FairyLandPuzzleBase:playTalk(dialogId, callback, callbackObj, noCheckFinish, noTween)
	if ViewMgr.instance:isOpen(ViewName.FairyLandCompleteView) then
		return
	end

	if dialogId > 0 and (noCheckFinish or not FairyLandModel.instance:isFinishDialog(dialogId)) then
		local param = {}

		param.dialogId = dialogId
		param.dialogType = FairyLandEnum.DialogType.Bubble
		param.leftElement = FairyLandModel.instance:getDialogElement()
		param.rightElement = FairyLandModel.instance:getDialogElement(self.config.elementId)
		param.callback = callback
		param.callbackObj = callbackObj
		param.noTween = noTween

		FairyLandController.instance:openDialogView(param)
	elseif callback then
		callback(callbackObj)
	end
end

function FairyLandPuzzleBase:onInitView()
	return
end

function FairyLandPuzzleBase:onStart()
	return
end

function FairyLandPuzzleBase:onRefreshView()
	return
end

function FairyLandPuzzleBase:onDestroyView()
	return
end

return FairyLandPuzzleBase
