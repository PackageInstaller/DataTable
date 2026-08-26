-- chunkname: @modules/logic/rouge2/map/view/choice/Rouge2_MapChoiceView.lua

module("modules.logic.rouge2.map.view.choice.Rouge2_MapChoiceView", package.seeall)

local Rouge2_MapChoiceView = class("Rouge2_MapChoiceView", Rouge2_MapChoiceBaseView)

function Rouge2_MapChoiceView:onInitView()
	Rouge2_MapChoiceView.super.onInitView(self)
end

function Rouge2_MapChoiceView:addEvents()
	Rouge2_MapChoiceView.super.addEvents(self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChoiceFlowDone, self.onChoiceFlowDone, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChoiceEventChange, self.onChoiceEventChange, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onReceiveChoiceEvent, self.onReceiveChoiceEvent, self)
end

function Rouge2_MapChoiceView:onChoiceFlowDone()
	if self:checkIsChangeMap() or self.nodeMo:isFinishEvent() then
		self:changeState(Rouge2_MapEnum.ChoiceViewState.Finish)

		if self.hasTweenDialogue then
			self:playChoiceHideAnim()
		else
			self:closeThis()
		end

		return
	end

	self:triggerEventHandle()
end

function Rouge2_MapChoiceView:onReceiveChoiceEvent()
	self:playSelectDialogue()
end

function Rouge2_MapChoiceView:playSelectDialogue()
	self:changeState(Rouge2_MapEnum.ChoiceViewState.PlayingDialogue)

	self.hasTweenDialogue = Rouge2_MapDialogueHelper.select(self._dialogueListComp, self.nodeMo)

	if self.hasTweenDialogue then
		self:playChoiceHideAnim()
	end
end

function Rouge2_MapChoiceView:triggerEventHandle()
	local curNode = Rouge2_MapModel.instance:getCurNode()

	Rouge2_MapChoiceEventHelper.triggerEventHandleOnChoiceView(curNode)
end

function Rouge2_MapChoiceView:onChoiceEventChange(nodeMo)
	if self:checkIsChangeMap() then
		self:closeThis()

		return
	end

	if nodeMo.nodeId ~= self.nodeMo.nodeId then
		return
	end

	local newEventId = nodeMo.eventId

	if newEventId == self.curEventId then
		if nodeMo:isFinishEvent() then
			self:changeState(Rouge2_MapEnum.ChoiceViewState.Finish)

			return
		end

		self:switch2SelectChoice()
	else
		self.curEventId = newEventId
		self.eventCo = Rouge2_MapConfig.instance:getRougeEvent(self.curEventId)

		self:changeState(Rouge2_MapEnum.ChoiceViewState.PlayingDialogue)
		Rouge2_MapDialogueHelper.init(self._dialogueListComp, self.nodeMo, self.onChoiceFlowDone, self)
	end

	self:refreshUI()
end

function Rouge2_MapChoiceView:initViewData()
	self.nodeMo = self.viewParam
	self.curEventId = self.nodeMo.eventId
	self.eventCo = Rouge2_MapConfig.instance:getRougeEvent(self.curEventId)
	self.isPassEvent = Rouge2_OutsideModel.instance:passedEventId(self.curEventId)
end

function Rouge2_MapChoiceView:onOpen()
	Rouge2_MapChoiceView.super.onOpen(self)
	self:refreshUI()
	Rouge2_MapDialogueHelper.init(self._dialogueListComp, self.nodeMo, self.switch2SelectChoice, self)
end

function Rouge2_MapChoiceView:switch2SelectChoice()
	self:changeState(Rouge2_MapEnum.ChoiceViewState.WaitSelect)
	self:refreshChoice()
	self:playChoiceShowAnim()
end

function Rouge2_MapChoiceView:refreshUI()
	local hasBG = not string.nilorempty(self.eventCo.image)

	gohelper.setActive(self._goBG, hasBG)

	if hasBG then
		self._simageFullBG:LoadImage(ResUrl.getRouge2Icon("choice/" .. self.eventCo.image))
	end

	self._txtName.text = self.eventCo.name
end

function Rouge2_MapChoiceView:refreshChoice()
	local choiceIdList = self.nodeMo.eventMo:getChoiceIdList()

	if not choiceIdList then
		logError("choiceIdList is nil, curNode : " .. tostring(self.nodeMo))

		return
	end

	Rouge2_MapHelper.loadItemWithCustomUpdateFunc(self.goChoiceItem, Rouge2_MapNodeChoiceItem, choiceIdList, self.choiceItemList, self.updateItem, self)
end

function Rouge2_MapChoiceView:onPlayDialogueDone()
	Rouge2_MapChoiceView.super.onPlayDialogueDone(self)

	if self:checkIsChangeMap() or self.nodeMo:isFinishEvent() then
		self:changeState(Rouge2_MapEnum.ChoiceViewState.Finish)
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onDialogueFlowDone)
	end
end

function Rouge2_MapChoiceView:changeState(state)
	Rouge2_MapChoiceView.super.changeState(self, state)

	if self.isPassEvent then
		local isJumpChoice = state == Rouge2_MapEnum.ChoiceViewState.PlayingDialogue

		gohelper.setActive(self._btnSkip.gameObject, isJumpChoice)
	end
end

function Rouge2_MapChoiceView:updateItem(item, index, choiceId)
	item:update(choiceId, self.nodeMo, index)
end

function Rouge2_MapChoiceView:checkIsChangeMap()
	return Rouge2_MapModel.instance:needPlayMoveToEndAnim()
end

function Rouge2_MapChoiceView:onClickBlockOnFinishState()
	self:triggerEventHandle()
end

return Rouge2_MapChoiceView
