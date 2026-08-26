-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogRoleView.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogRoleView", package.seeall)

local AergusiDialogRoleView = class("AergusiDialogRoleView", BaseView)

function AergusiDialogRoleView:onInitView()
	self._gochesscontainer = gohelper.findChild(self.viewGO, "#go_chesscontainer")
	self._goleftchessitem = gohelper.findChild(self.viewGO, "#go_chesscontainer/#go_leftchessitem")
	self._gorightchessitem = gohelper.findChild(self.viewGO, "#go_chesscontainer/#go_rightchessitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AergusiDialogRoleView:addEvents()
	return
end

function AergusiDialogRoleView:removeEvents()
	return
end

function AergusiDialogRoleView:_editableInitView()
	self:_addEvents()
end

function AergusiDialogRoleView:onOpen()
	self:_initRoleItem()
end

function AergusiDialogRoleView:_initRoleItem()
	gohelper.setActive(self._goleftchessitem, false)
	gohelper.setActive(self._gorightchessitem, false)

	self._episodeConfig = AergusiConfig.instance:getEpisodeConfig(nil, self.viewParam.episodeId)

	if self._episodeConfig.playerPieces ~= "" then
		self._rightRoleItem = AergusiDialogRoleRightItem.New()

		self._rightRoleItem:init(self._gorightchessitem, self._episodeConfig.playerPieces)
	end

	if self._episodeConfig.opponentPieces ~= "" then
		self._leftRoleItem = AergusiDialogRoleLeftItem.New()

		self._leftRoleItem:init(self._goleftchessitem, self._episodeConfig.opponentPieces)
	end
end

function AergusiDialogRoleView:_addEvents()
	self.addEventCb(self, AergusiController.instance, AergusiEvent.OnStartDialogNextStep, self._onEnterNextStep, self)
	self.addEventCb(self, AergusiController.instance, AergusiEvent.OnStartAutoBubbleDialog, self._onStartAutoBubbleDialog, self)
	self.addEventCb(self, AergusiController.instance, AergusiEvent.OnDialogAskFail, self._onDialogAskFail, self)
	self.addEventCb(self, AergusiController.instance, AergusiEvent.OnStartErrorBubbleDialog, self._onDialogStartErrorBubble, self)
	self.addEventCb(self, AergusiController.instance, AergusiEvent.OnDialogNotKeyAsk, self._onDialogNotKeyAsk, self)
end

function AergusiDialogRoleView:_removeEvents()
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.OnStartDialogNextStep, self._onEnterNextStep, self)
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.OnStartAutoBubbleDialog, self._onStartAutoBubbleDialog, self)
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.OnDialogAskFail, self._onDialogAskFail, self)
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.OnStartErrorBubbleDialog, self._onDialogStartErrorBubble, self)
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.OnDialogNotKeyAsk, self._onDialogNotKeyAsk, self)
end

function AergusiDialogRoleView:_onEnterNextStep(stepCo)
	self._stepCo = stepCo

	if self._rightRoleItem then
		self._rightRoleItem:hideTalking()
	end

	if self._leftRoleItem then
		self._leftRoleItem:hideTalking()
	end

	if self._stepCo.pos == AergusiEnum.DialogType.NormalLeft then
		if self._leftRoleItem then
			self._leftRoleItem:showTalking()
		end
	elseif self._stepCo.pos == AergusiEnum.DialogType.NormalRight and self._rightRoleItem then
		self._rightRoleItem:showTalking()
	end
end

function AergusiDialogRoleView:_onStartAutoBubbleDialog(param)
	TaskDispatcher.cancelTask(self._playNextAutoBubble, self)

	self._autoCallback = param.callback
	self._autoCallbackObj = param.callbackObj
	self._stepCo = param.stepCo

	if self._stepCo.condition ~= "" then
		local conditions = string.splitToNumber(self._stepCo.condition, "#")

		if conditions[1] == AergusiEnum.OperationType.AutoBubble then
			self:_playBubbleGroup(conditions[2])

			return
		end
	end

	self:_autoFinishCallback()
end

function AergusiDialogRoleView:_onDialogAskFail(stepCo)
	TaskDispatcher.cancelTask(self._playNextAutoBubble, self)

	self._stepCo = stepCo

	local bubbleGroupId = AergusiConfig.instance:getEvidenceConfig(self._stepCo.id).tips

	self:_playBubbleGroup(bubbleGroupId)
end

function AergusiDialogRoleView:_onDialogStartErrorBubble(param)
	TaskDispatcher.cancelTask(self._playNextAutoBubble, self)

	self._autoCallback = param.callback
	self._autoCallbackObj = param.callbackObj

	self:_playBubbleGroup(param.bubbleId)
end

function AergusiDialogRoleView:_onDialogNotKeyAsk(bubbleGroupId)
	self:_playBubbleGroup(bubbleGroupId)
end

function AergusiDialogRoleView:_playBubbleGroup(bubbleGroupId)
	UIBlockMgrExtend.setNeedCircleMv(false)

	self._playIndex = 1
	self._bubbleId = bubbleGroupId

	self:_playNextAutoBubble()
end

function AergusiDialogRoleView:_playNextAutoBubble()
	if self._rightRoleItem then
		self._rightRoleItem:hideBubble()
		self._rightRoleItem:hideTalking()
	end

	if self._leftRoleItem then
		self._leftRoleItem:hideBubble()
		self._leftRoleItem:hideTalking()
	end

	local stepList = AergusiDialogModel.instance:getBubbleStepList(self._bubbleId)

	if self._playIndex > #stepList then
		self:_autoFinishCallback()

		return
	else
		local bubbleCo = AergusiConfig.instance:getBubbleConfig(self._bubbleId, stepList[self._playIndex].stepId)

		if bubbleCo.direction == AergusiEnum.DialogBubblePos.Left then
			if self._leftRoleItem then
				self._leftRoleItem:showBubble(stepList[self._playIndex])
			end
		elseif self._rightRoleItem then
			self._rightRoleItem:showBubble(stepList[self._playIndex])
		end

		local intervelTime = 0.05 * LuaUtil.getStrLen(bubbleCo.content) + 1

		TaskDispatcher.runDelay(self._playNextAutoBubble, self, intervelTime)
	end

	self._playIndex = self._playIndex + 1
end

function AergusiDialogRoleView:_autoFinishCallback()
	if self._autoCallback then
		self._autoCallback(self._autoCallbackObj)

		self._autoCallback = nil
		self._autoCallbackObj = nil
	end
end

function AergusiDialogRoleView:onClose()
	return
end

function AergusiDialogRoleView:onDestroyView()
	TaskDispatcher.cancelTask(self._playNextAutoBubble, self)

	if self._rightRoleItem then
		self._rightRoleItem:destroy()

		self._rightRoleItem = nil
	end

	if self._leftRoleItem then
		self._leftRoleItem:destroy()

		self._leftRoleItem = nil
	end

	self:_removeEvents()
end

return AergusiDialogRoleView
