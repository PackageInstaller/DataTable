-- chunkname: @modules/logic/rouge/map/view/choice/RougeMapChoiceView.lua

module("modules.logic.rouge.map.view.choice.RougeMapChoiceView", package.seeall)

local RougeMapChoiceView = class("RougeMapChoiceView", RougeMapChoiceBaseView)

function RougeMapChoiceView:_editableInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "all_bg/#simage_FullBG")
	self._simageEpisodeBG = gohelper.findChildSingleImage(self.viewGO, "all_bg/#simage_EpisodeBG")
	self._simageFrameBG = gohelper.findChildSingleImage(self.viewGO, "all_bg/#simage_FrameBG")

	self._simageFullBG:LoadImage("singlebg/rouge/episode/rouge_episode_fullbg.png")
	self._simageFrameBG:LoadImage("singlebg/rouge/rouge_illustration_framebg.png")
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onChoiceEventChange, self.onChoiceEventChange, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onClearInteract, self.onClearInteract, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onPopViewDone, self.onPopViewDone, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onReceiveChoiceEvent, self.onReceiveChoiceEvent, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onBeforeActorMoveToEnd, self.onBeforeActorMoveToEnd, self)
	RougeMapChoiceView.super._editableInitView(self)
end

function RougeMapChoiceView:onBeforeActorMoveToEnd()
	self.beforeChangeMap = true
end

function RougeMapChoiceView:onReceiveChoiceEvent()
	if RougeMapModel.instance:isInteractiving() then
		logNormal("wait interact")

		self.waitInteract = true

		return
	end

	if RougePopController.instance:hadPopView() then
		logNormal("wait pop view")

		self.waitInteract = true
	end

	self.waitInteract = nil

	self:playSelectedDialogue()
end

function RougeMapChoiceView:onClearInteract()
	if not self.waitInteract then
		return
	end

	self:playSelectedDialogue()
end

function RougeMapChoiceView:onPopViewDone()
	if not self.waitInteract then
		return
	end

	self:playSelectedDialogue()
end

function RougeMapChoiceView:playSelectedDialogue()
	self:playChoiceHideAnim()

	local preChoiceId = RougeMapModel.instance:getCurChoiceId()
	local choiceCo = preChoiceId and lua_rouge_choice.configDict[preChoiceId]
	local selectDesc = choiceCo and choiceCo.selectedDesc

	if string.nilorempty(selectDesc) then
		self:triggerEventHandle()
	else
		self.startPlayDialogue(self, selectDesc, self.onSelectedDescPlayDone, self)
	end
end

function RougeMapChoiceView:onSelectedDescPlayDone()
	self:changeState(RougeMapEnum.ChoiceViewState.Finish)
end

function RougeMapChoiceView:triggerEventHandle()
	local curNode = RougeMapModel.instance:getCurNode()

	RougeMapChoiceEventHelper.triggerEventHandleOnChoiceView(curNode)
end

function RougeMapChoiceView:onClickBlockOnFinishState()
	self:triggerEventHandle()
end

function RougeMapChoiceView:onChoiceEventChange(nodeMo)
	if self.beforeChangeMap then
		self:closeThis()

		return
	end

	if nodeMo.nodeId ~= self.nodeMo.nodeId then
		return
	end

	local newEventId = nodeMo.eventId

	if newEventId == self.curEventId then
		return
	end

	self.curEventId = newEventId
	self.eventCo = RougeMapConfig.instance:getRougeEvent(self.curEventId)
	self.choiceEventCo = lua_rouge_choice_event.configDict[self.curEventId]

	self:refreshUI()

	local desc = self.choiceEventCo.desc

	self.startPlayDialogue(self, desc, self.onChangeDialogueDone, self)
end

function RougeMapChoiceView:onChangeDialogueDone()
	self:changeState(RougeMapEnum.ChoiceViewState.WaitSelect)
	self:refreshChoice()
	self:playChoiceShowAnim()
end

function RougeMapChoiceView:initViewData()
	self.nodeMo = self.viewParam
	self.curEventId = self.nodeMo.eventId
	self.eventCo = RougeMapConfig.instance:getRougeEvent(self.curEventId)
	self.choiceEventCo = lua_rouge_choice_event.configDict[self.curEventId]
end

function RougeMapChoiceView:onOpen()
	RougeMapChoiceView.super.onOpen(self)
	self:initViewData()
	self:refreshUI()

	local desc = self.choiceEventCo.desc

	self.startPlayDialogue(self, desc, self.onEnterDialogueDone, self)
end

function RougeMapChoiceView:refreshUI()
	self._simageEpisodeBG:LoadImage(string.format("singlebg/rouge/episode/%s.png", self.choiceEventCo.image))

	self._txtName.text = self.choiceEventCo.title
	self._txtNameEn.text = ""
end

function RougeMapChoiceView:onEnterDialogueDone()
	self:changeState(RougeMapEnum.ChoiceViewState.WaitSelect)
	self:refreshChoice()
	self:playChoiceShowAnim()
end

function RougeMapChoiceView:refreshChoice()
	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewChoiceOpen)
	gohelper.setActive(self.goRight, true)
	gohelper.setActive(self.goLeft, true)

	local choiceIdList = self.nodeMo.eventMo:getChoiceIdList()

	if not choiceIdList then
		logError("choiceIdList is nil, curNode : " .. tostring(self.nodeMo))

		return
	end

	local len = #choiceIdList

	self.posList = RougeMapEnum.ChoiceItemPos[len]

	RougeMapHelper.loadItemWithCustomUpdateFunc(self.goChoiceItem, RougeMapNodeChoiceItem, choiceIdList, self.choiceItemList, self.updateItem, self)
end

function RougeMapChoiceView:updateItem(item, index, choiceId)
	item:update(choiceId, self.posList[index], self.nodeMo)
end

function RougeMapChoiceView:onDestroyView()
	self._simageFullBG:UnLoadImage()
	self._simageEpisodeBG:UnLoadImage()
	self._simageFrameBG:UnLoadImage()
	RougeMapChoiceView.super.onDestroyView(self)
end

return RougeMapChoiceView
