-- chunkname: @modules/logic/rouge/map/view/choicebase/RougeMapChoiceBaseView.lua

module("modules.logic.rouge.map.view.choicebase.RougeMapChoiceBaseView", package.seeall)

local RougeMapChoiceBaseView = class("RougeMapChoiceBaseView", BaseView)

function RougeMapChoiceBaseView:onInitView()
	self._txtName = gohelper.findChildText(self.viewGO, "Bottom/#txt_Name")
	self._txtNameEn = gohelper.findChildText(self.viewGO, "Bottom/#txt_Name/#txt_NameEn")
	self._txtDesc = gohelper.findChildText(self.viewGO, "Bottom/Scroll View/Viewport/Content/#txt_Desc")
	self._godescarrow = gohelper.findChild(self.viewGO, "Bottom/#go_descarrow")
	self._gochoicecontainer = gohelper.findChild(self.viewGO, "Right/#go_choicecontainer")
	self._gorougeherogroup = gohelper.findChild(self.viewGO, "Left/#go_rougeherogroup")
	self._goroucollection = gohelper.findChild(self.viewGO, "Left/#go_rougecollection")
	self._gorougelv = gohelper.findChild(self.viewGO, "Left/#go_rougelv")
	self._godialogueblock = gohelper.findChild(self.viewGO, "#go_dialogueblock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapChoiceBaseView:addEvents()
	return
end

function RougeMapChoiceBaseView:removeEvents()
	return
end

function RougeMapChoiceBaseView:_editableInitView()
	self.rectTrBottom = gohelper.findChildComponent(self.viewGO, "Bottom", gohelper.Type_RectTransform)
	self.goRight = gohelper.findChild(self.viewGO, "Right")
	self.goLeft = gohelper.findChild(self.viewGO, "Left")
	self.dialogueScrollRect = gohelper.findChildScrollRect(self.viewGO, "Bottom/Scroll View")

	gohelper.setActive(self._godescarrow, false)
	gohelper.setActive(self.goRight, false)
	gohelper.setActive(self.goLeft, false)
	self.dialogueScrollRect:AddOnValueChanged(self.onScrollValueChange, self)

	self.scrollClick = gohelper.getClickWithDefaultAudio(self.dialogueScrollRect.gameObject)

	self.scrollClick:AddClickListener(self.onClickDialogueBlock, self)

	self.dialogueBlockClick = gohelper.getClickWithDefaultAudio(self._godialogueblock)

	self.dialogueBlockClick:AddClickListener(self.onClickDialogueBlock, self)

	self.choiceItemList = {}
	self.choiceItemResPath = self.viewContainer:getSetting().otherRes[1]
	self.goChoiceItem = self.viewContainer:getResInst(self.choiceItemResPath, self._gochoicecontainer)

	gohelper.setActive(self.goChoiceItem, false)

	self.goHeroGroup = self.viewContainer:getResInst(RougeEnum.ResPath.CommonHeroGroupItem, self._gorougeherogroup)
	self.goCollection = self.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, self._goroucollection)
	self.goLv = self.viewContainer:getResInst(RougeEnum.ResPath.CommonLvItem, self._gorougelv)
	self.groupComp = RougeHeroGroupComp.Get(self.goHeroGroup)
	self.collectionComp = RougeCollectionComp.Get(self.goCollection)
	self.lvComp = RougeLvComp.Get(self.goLv)
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.rightAnimator = self.goRight:GetComponent(gohelper.Type_Animator)
	self.leftAnimator = self.goLeft:GetComponent(gohelper.Type_Animator)

	self:changeState(RougeMapEnum.ChoiceViewState.WaitSelect)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
end

function RougeMapChoiceBaseView:onChangeMapInfo()
	self:closeThis()
end

function RougeMapChoiceBaseView:onClickDialogueBlock()
	self:_initStateHandle()

	local handle = self._stateHandleDict[self.state]

	if handle then
		handle(self)
	end
end

function RougeMapChoiceBaseView:_initStateHandle()
	if self._stateHandleDict then
		return
	end

	self._stateHandleDict = {
		[RougeMapEnum.ChoiceViewState.PlayingDialogue] = self.onPlayDialogueDone,
		[RougeMapEnum.ChoiceViewState.Finish] = self.onClickBlockOnFinishState
	}
end

function RougeMapChoiceBaseView:onClickBlockOnFinishState()
	return
end

function RougeMapChoiceBaseView:changeState(state)
	self.state = state

	gohelper.setActive(self._godialogueblock, self.state ~= RougeMapEnum.ChoiceViewState.WaitSelect)
end

function RougeMapChoiceBaseView:onScrollValueChange(x, y)
	gohelper.setActive(self._godescarrow, y >= 1)
end

function RougeMapChoiceBaseView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewOpen)
	self.groupComp:onOpen()
	self.collectionComp:onOpen()
	self.lvComp:onOpen()
end

function RougeMapChoiceBaseView:startPlayDialogue(desc, callback, callbackObj)
	if self.closeed then
		logError("start dialogue after close view !!! desc : " .. tostring(desc))

		return
	end

	if string.nilorempty(desc) then
		self.callback = nil
		self.callbackObj = nil

		if callback then
			callback(callbackObj)
		end

		return
	end

	self:changeState(RougeMapEnum.ChoiceViewState.PlayingDialogue)

	self.callback = callback
	self.callbackObj = callbackObj
	self.desc = desc
	self.preEndIndex = 0

	RougeMapModel.instance:setPlayingDialogue(true)
	self:_playNext()
	TaskDispatcher.runRepeat(self._playNext, self, RougeMapEnum.DialogueInterval)
end

function RougeMapChoiceBaseView:_playNext()
	if not self.preEndIndex then
		self:onPlayDialogueDone()

		return
	end

	self:updateText()
end

function RougeMapChoiceBaseView:onPlayDialogueDone()
	self:changeState(RougeMapEnum.ChoiceViewState.WaitSelect)

	self._txtDesc.text = self.desc

	ZProj.UGUIHelper.RebuildLayout(self.dialogueScrollRect.transform)

	self.dialogueScrollRect.verticalNormalizedPosition = RougeMapEnum.ScrollPosition.Bottom

	TaskDispatcher.cancelTask(self._playNext, self)
	RougeMapModel.instance:setPlayingDialogue(false)

	if self.callback then
		-- block empty
	end
end

function RougeMapChoiceBaseView:updateText()
	self._txtDesc.text = self:getCurDesc()
	self.dialogueScrollRect.verticalNormalizedPosition = RougeMapEnum.ScrollPosition.Bottom
end

function RougeMapChoiceBaseView:getCurDesc()
	local startIndex = self.preEndIndex + 1
	local inRichTag = false
	local index = 0

	while index < 1000 do
		local endIndex = utf8.next(self.desc, startIndex)

		if not endIndex then
			self.preEndIndex = nil

			return self.desc
		end

		local endChar = self.desc:sub(startIndex, endIndex - 1)

		if endChar == "<" then
			inRichTag = true
		elseif endChar == ">" then
			inRichTag = false
		elseif not inRichTag then
			self.preEndIndex = endIndex - 1

			return self.desc:sub(1, self.preEndIndex)
		end

		index = index + 1
		startIndex = endIndex
	end

	logError("endless loop !!!")

	self.preEndIndex = nil

	return self.desc
end

function RougeMapChoiceBaseView:playChoiceShowAnim()
	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewChoiceOpen)
	self.animator:Play("right", 0, 0)
	self.rightAnimator:Play("open", 0, 0)
	self.leftAnimator:Play("open", 0, 0)
end

function RougeMapChoiceBaseView:playChoiceHideAnim()
	self.animator:Play("left", 0, 0)
	self.rightAnimator:Play("close", 0, 0)
	self.leftAnimator:Play("close", 0, 0)
end

function RougeMapChoiceBaseView:onClose()
	self.closeed = true

	TaskDispatcher.cancelTask(self._playNext, self)
	self.groupComp:onClose()
	self.collectionComp:onClose()
	self.lvComp:onClose()
end

function RougeMapChoiceBaseView:onDestroyView()
	self.groupComp:destroy()
	self.collectionComp:destroy()
	self.lvComp:destroy()
	self.dialogueScrollRect:RemoveOnValueChanged()
	self.scrollClick:RemoveClickListener()
	self.dialogueBlockClick:RemoveClickListener()

	if self.choiceItemList then
		for _, item in ipairs(self.choiceItemList) do
			item:destroy()
		end
	end

	self.choiceItemList = nil
end

return RougeMapChoiceBaseView
