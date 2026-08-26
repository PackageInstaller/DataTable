-- chunkname: @modules/logic/dialogue/view/DialogueView.lua

module("modules.logic.dialogue.view.DialogueView", package.seeall)

local DialogueView = class("DialogueView", BaseView)

function DialogueView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._godialoguecontainer = gohelper.findChild(self.viewGO, "#go_dialoguecontainer")
	self._goArrow = gohelper.findChild(self.viewGO, "#go_dialoguecontainer/#go_arrow")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content")
	self._goleftdialogueitem = gohelper.findChild(self.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_leftdialogueitem")
	self._gorightdialogueitem = gohelper.findChild(self.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_rightdialogueitem")
	self._gosystemmessageitem = gohelper.findChild(self.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_systemmessageitem")
	self._gooptionitem = gohelper.findChild(self.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_optionitem")
	self._gonextstep = gohelper.findChild(self.viewGO, "#go_nextstep")
	self._goleftblank = gohelper.findChild(self.viewGO, "#go_leftblank")
	self._gorightblank = gohelper.findChild(self.viewGO, "#go_rightblank")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DialogueView:addEvents()
	return
end

function DialogueView:removeEvents()
	return
end

function DialogueView:_editableInitView()
	self.itemSourceGoDict = {
		[DialogueEnum.Type.LeftMessage] = self._goleftdialogueitem,
		[DialogueEnum.Type.RightMessage] = self._gorightdialogueitem,
		[DialogueEnum.Type.SystemMessage] = self._gosystemmessageitem,
		[DialogueEnum.Type.Option] = self._gooptionitem
	}

	gohelper.setActive(self._goArrow, false)
	self._simagefullbg:LoadImage(ResUrl.getDialogueSingleBg("dialogue_fullbg"))

	self.scrollContent = gohelper.findChildScrollRect(self.viewGO, "#go_dialoguecontainer/Scroll View")
	self.contentMinHeight = recthelper.getHeight(self.scrollContent.transform)

	self.scrollContent:AddOnValueChanged(self.onScrollValueChanged, self)

	self.nextStepClick = gohelper.getClickWithDefaultAudio(self._gonextstep)

	self.nextStepClick:AddClickListener(self.onClickNextStep, self)

	if self._goleftblank then
		self.leftBlankClick = gohelper.getClickWithDefaultAudio(self._goleftblank)

		self.leftBlankClick:AddClickListener(self._clickBlank, self)
	end

	if self._gorightblank then
		self.rightBlankClick = gohelper.getClickWithDefaultAudio(self._gorightblank)

		self.rightBlankClick:AddClickListener(self._clickBlank, self)
	end

	self.drag = SLFramework.UGUI.UIDragListener.Get(self.scrollContent.gameObject)

	self.drag:AddDragBeginListener(self.onBeginDrag, self)
	self.drag:AddDragEndListener(self.onEndDrag, self)

	self.nextStepClick2 = gohelper.getClickWithDefaultAudio(self.scrollContent.gameObject)

	self.nextStepClick2:AddClickListener(self.onClickNextStep, self)

	self.rectTrContent = self._gocontent.transform

	for _, go in pairs(self.itemSourceGoDict) do
		gohelper.setActive(go, false)
	end

	self.dialogueItemList = {}
	self.contentHeight = 0

	self.addEventCb(self, DialogueController.instance, DialogueEvent.OnClickOption, self.onClickOption, self)

	self.isFinishDialogue = false
end

function DialogueView:_clickBlank()
	self:closeThis()
end

function DialogueView:_showBlank()
	gohelper.setActive(self._goleftblank, true)
	gohelper.setActive(self._gorightblank, true)
end

function DialogueView:onBeginDrag()
	self.dragging = true
end

function DialogueView:onEndDrag()
	self.dragging = false
end

function DialogueView:onScrollValueChanged()
	gohelper.setActive(self._goArrow, self.scrollContent.verticalNormalizedPosition >= 0.01)
end

function DialogueView:onClickNextStep()
	if self.dragging then
		return
	end

	self:playNext()
end

function DialogueView:onClickOption(jumpToGroupId)
	self:addStepList(jumpToGroupId)
	self:playNext()
end

function DialogueView:onOpen()
	self.dialogueId = self.viewParam.dialogueId
	self.dialogueCo = DialogueConfig.instance:getDialogueCo(self.dialogueId)
	self.stepCoList = {}

	self:addStepList(self.dialogueCo.startGroup)
	self:playNext()
end

function DialogueView:addStepList(groupId)
	local stepList = DialogueConfig.instance:getDialogueStepList(groupId)

	for i = #stepList, 1, -1 do
		table.insert(self.stepCoList, stepList[i])
	end
end

function DialogueView:playNext()
	local stepCo = self:popNextStep()

	if not stepCo then
		self:onDialogueDone()

		return
	end

	if stepCo.type == DialogueEnum.Type.JumpToGroup then
		self:addStepList(tonumber(stepCo.content))
		self:playNext()

		return
	end

	DialogueController.instance:dispatchEvent(DialogueEvent.BeforePlayStep, stepCo)

	local go = gohelper.cloneInPlace(self.itemSourceGoDict[stepCo.type])
	local item = DialogueItem.CreateItem(stepCo, go, self.contentHeight)

	table.insert(self.dialogueItemList, item)

	self.contentHeight = self.contentHeight + item:getHeight() + DialogueEnum.IntervalY

	recthelper.setHeight(self.rectTrContent, Mathf.Max(self.contentHeight, self.contentMinHeight))
	self:playUpAnimation()

	local isHaveNextStepCo = self:checkIsHavdNextStepCo()

	if not isHaveNextStepCo then
		self:onDialogueDone()
	end
end

function DialogueView:popNextStep()
	local stepLen = #self.stepCoList

	if stepLen <= 0 then
		return nil
	end

	self.stepCoList[stepLen] = nil

	return self.stepCoList[stepLen]
end

function DialogueView:checkIsHavdNextStepCo()
	local stepLen = #self.stepCoList

	if stepLen <= 0 then
		return false
	end

	return true
end

function DialogueView:playUpAnimation()
	if self.contentHeight <= self.contentMinHeight then
		return
	end

	self:killTween()

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(self.scrollContent.verticalNormalizedPosition, 0, 0.5, self.tweenFrameCallback, self.tweenFinishCallback, self)
end

function DialogueView:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function DialogueView:tweenFrameCallback(value)
	self.scrollContent.verticalNormalizedPosition = value
end

function DialogueView:tweenFinishCallback()
	gohelper.setActive(self._goArrow, false)
end

function DialogueView:onDialogueDone()
	if self._isDone then
		return
	end

	self._isDone = true

	self:_showBlank()
	gohelper.setActive(self._gonextstep, false)
	DialogueRpc.instance:sendRecordDialogInfoRequest(self.dialogueId, self.onReceiveInfo, self)
end

function DialogueView:onReceiveInfo()
	DialogueController.instance:dispatchEvent(DialogueEvent.OnDone, self.dialogueId)

	self.isFinishDialogue = true
end

function DialogueView:onClose()
	self:killTween()

	if self.isFinishDialogue then
		DialogueController.instance:dispatchEvent(DialogueEvent.OnCloseViewWithDialogueDone)
	end

	local callback = self.viewParam.callback
	local callbackTarget = self.viewParam.callbackTarget

	if not self.viewParam.callbackParams then
		if callback then
			self.viewParam.callback(callbackTarget, self.viewParam.callbackParams, self.isFinishDialogue or self._isDone)
		end
	end
end

function DialogueView:onDestroyView()
	for _, item in ipairs(self.dialogueItemList) do
		item:destroy()
	end

	self._simagefullbg:UnLoadImage()
	self.nextStepClick:RemoveClickListener()
	self.nextStepClick2:RemoveClickListener()

	if self.leftBlankClick then
		self.leftBlankClick:RemoveClickListener()
	end

	if self.rightBlankClick then
		self.rightBlankClick:RemoveClickListener()
	end

	self.scrollContent:RemoveOnValueChanged()
	self.drag:RemoveDragBeginListener()
	self.drag:RemoveDragEndListener()
end

return DialogueView
