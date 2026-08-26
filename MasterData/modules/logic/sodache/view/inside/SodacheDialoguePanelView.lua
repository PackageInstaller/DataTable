-- chunkname: @modules/logic/sodache/view/inside/SodacheDialoguePanelView.lua

module("modules.logic.sodache.view.inside.SodacheDialoguePanelView", package.seeall)

local SodacheDialoguePanelView = class("SodacheDialoguePanelView", BaseView)
local DialogueType = {
	Option = 4,
	RightMessage = 2,
	LeftMessage = 1,
	SystemMessage = 3
}
local DialogueTypeToCls = {
	[DialogueType.LeftMessage] = SodacheEventLeftDialogItem,
	[DialogueType.RightMessage] = SodacheEventRightDialogItem,
	[DialogueType.SystemMessage] = SodacheEventCenterDialogItem,
	[DialogueType.Option] = SodacheEventChoiceItem
}
local IntervalY = 26

function SodacheDialoguePanelView:onInitView()
	self._godialog = gohelper.findChild(self.viewGO, "right/dialogue")
	self._goArrow = gohelper.findChild(self.viewGO, "right/dialogue/#go_dialoguecontainer/#go_arrow")
	self._gocontent = gohelper.findChild(self.viewGO, "right/dialogue/#go_dialoguecontainer/Scroll View/Viewport/#go_content")
	self._goleftdialogueitem = gohelper.findChild(self.viewGO, "right/dialogue/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_leftdialogueitem")
	self._gorightdialogueitem = gohelper.findChild(self.viewGO, "right/dialogue/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_rightdialogueitem")
	self._gosystemmessageitem = gohelper.findChild(self.viewGO, "right/dialogue/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_systemmessageitem")
	self._gooptionitem = gohelper.findChild(self.viewGO, "right/dialogue/#go_optionitem")
	self._gonextstep = gohelper.findChild(self.viewGO, "right/dialogue/#go_nextstep")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_close")
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "left/#txt_title")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "left/#scroll_descview/Viewport/Content/#txt_desc")
	self.itemSourceGoDict = {
		[DialogueType.LeftMessage] = self._goleftdialogueitem,
		[DialogueType.RightMessage] = self._gorightdialogueitem,
		[DialogueType.SystemMessage] = self._gosystemmessageitem,
		[DialogueType.Option] = self._gooptionitem
	}

	gohelper.setActive(self._goArrow, false)

	self.scrollContent = gohelper.findChildScrollRect(self.viewGO, "right/dialogue/#go_dialoguecontainer/Scroll View")
	self.contentMinHeight = recthelper.getHeight(self.scrollContent.transform)

	self.scrollContent:AddOnValueChanged(self.onScrollValueChanged, self)

	self.nextStepClick = gohelper.getClickWithDefaultAudio(self._gonextstep)

	self.nextStepClick:AddClickListener(self.onClickNextStep, self)

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
	self.isFinishDialogue = false
end

function SodacheDialoguePanelView:addEvents()
	self._btnclose:AddClickListener(self.onClickModalMask, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnUpdatePanel, self._refreshSteps, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnClosePanel, self._delayClosePanel, self)
end

function SodacheDialoguePanelView:removeEvents()
	self._btnclose:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnUpdatePanel, self._refreshSteps, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnClosePanel, self._delayClosePanel, self)
end

function SodacheDialoguePanelView:onOpen()
	local insideMo = SodacheModel.instance:getInsideMo()
	local panelMo = insideMo.panelBox.currPanel
	local unitMo = panelMo:getUnitMo()

	self._unitMo = unitMo
	self._panelMo = panelMo
	self._txtname.text = unitMo.eventCo.name
	self._txtdesc.text = unitMo.eventCo.desc

	local preStepCount = self:_refreshSteps()

	if not preStepCount then
		return
	end

	local curIndex = self.curStepIndex

	self.isEventFinish = panelMo.isClose

	for i = curIndex, preStepCount do
		self:playNext()
	end
end

local resultToDescKey = {
	[0] = "descLose",
	"descSuccess",
	"descBigSuccess"
}
local resultToDialogKey = {
	[0] = "dialogLose",
	"dialogSuccess",
	"dialogBigSuccess"
}

function SodacheDialoguePanelView:_refreshSteps()
	if self._unitMo.type == SodacheEnum.UnitType.Container then
		gohelper.setActive(self._godialog, false)

		return
	end

	gohelper.setActive(self._godialog, true)

	local preStepCount = 0
	local datas = {}
	local initChoiceIds = SodacheConfig.instance:getInitChoice(self._unitMo.eventCo.id)

	self:addChoiceDialogs(initChoiceIds, datas)

	for i, v in ipairs(self._panelMo.selectLinkIds) do
		local choiceCo = lua_sodache_choice.configDict[v]

		if not self._panelMo.optionId2result[v] then
			local result = 1
			local desc = choiceCo[resultToDescKey[result]]

			if not string.nilorempty(desc) then
				table.insert(datas, {
					type = DialogueType.SystemMessage,
					data = {
						desc = desc
					}
				})
			end

			local dialogCos2 = SodacheConfig.instance:getEventDialog(choiceCo[resultToDialogKey[result]])

			if dialogCos2 then
				for _, vv in ipairs(dialogCos2) do
					table.insert(datas, {
						type = vv.position,
						data = vv
					})
				end
			end

			preStepCount = #datas

			local nextChoices = choiceCo["choiceIds" .. result]

			self:addChoiceDialogs(string.splitToNumber(nextChoices, "#"), datas)
		end
	end

	if #self._panelMo.options > 0 then
		table.insert(datas, {
			type = DialogueType.Option,
			data = self._panelMo.options
		})
	end

	if self.datas and self.datas[self.curStepIndex] and self.datas[self.curStepIndex].type == DialogueType.Option and self.optionObj then
		self.optionObj:hide()

		self.curStepIndex = self.curStepIndex - 1
	end

	self.datas = datas

	self:playNext()

	return preStepCount
end

function SodacheDialoguePanelView:addChoiceDialogs(ids, datas)
	if not ids or #ids == 0 then
		return
	end

	for i, v in ipairs(ids) do
		local choiceCo = lua_sodache_choice.configDict[v]
		local dialogCos = SodacheConfig.instance:getEventDialog(choiceCo and choiceCo.dialogDefault)

		if dialogCos then
			for _, vv in ipairs(dialogCos) do
				table.insert(datas, {
					type = vv.position,
					data = vv
				})
			end
		end
	end
end

function SodacheDialoguePanelView:playNext()
	self.curStepIndex = self.curStepIndex or 0

	local stepCo = self.datas[self.curStepIndex + 1]

	if not stepCo then
		gohelper.setActive(self._gonextstep, false)

		if self.isEventFinish then
			gohelper.setActive(self._btnclose, true)
		end

		return
	end

	self.curStepIndex = self.curStepIndex + 1

	if self.isEventFinish and not self.datas[self.curStepIndex + 1] then
		gohelper.setActive(self._btnclose, true)
	end

	gohelper.setActive(self._gonextstep, self.datas[self.curStepIndex + 1])

	if stepCo.type == DialogueType.Option and self.optionObj then
		self.optionObj:show(stepCo.data)
	else
		local go = gohelper.cloneInPlace(self.itemSourceGoDict[stepCo.type])
		local cls = DialogueTypeToCls[stepCo.type]

		if go and cls then
			local obj = MonoHelper.addNoUpdateLuaComOnceToGo(go, cls)

			if stepCo.type == DialogueType.Option then
				obj:initData(stepCo.data)

				self.optionObj = obj
			else
				obj:initData(stepCo.data, self.contentHeight)

				self.contentHeight = self.contentHeight + obj:getHeight() + IntervalY
			end
		else
			logError(string.format("Error!!!%s %s %s", tostring(go), tostring(cls), tostring(stepCo.type)))
		end
	end

	recthelper.setHeight(self.rectTrContent, Mathf.Max(self.contentHeight, self.contentMinHeight))
	self:playUpAnimation()
end

function SodacheDialoguePanelView:onClickModalMask()
	if self.isEventFinish then
		self:closeThis()

		return
	end
end

function SodacheDialoguePanelView:tweenFrameCallback(value)
	self.scrollContent.verticalNormalizedPosition = value
end

function SodacheDialoguePanelView:playUpAnimation()
	if self.contentHeight <= self.contentMinHeight then
		return
	end

	self:killTween()

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(self.scrollContent.verticalNormalizedPosition, 0, 0.5, self.tweenFrameCallback, self.tweenFinishCallback, self)
end

function SodacheDialoguePanelView:onClickNextStep()
	if self.dragging then
		return
	end

	self:playNext()
end

function SodacheDialoguePanelView:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function SodacheDialoguePanelView:tweenFinishCallback()
	gohelper.setActive(self._goArrow, false)
end

function SodacheDialoguePanelView:_delayClosePanel()
	self.isEventFinish = true

	if not self.curStepIndex then
		return
	end

	local stepCo = self.datas[self.curStepIndex + 1]

	if not stepCo then
		gohelper.setActive(self._btnclose, true)
	end
end

function SodacheDialoguePanelView:onDestroyView()
	self:killTween()

	for _, item in ipairs(self.dialogueItemList) do
		item:destroy()
	end

	self.nextStepClick:RemoveClickListener()
	self.nextStepClick2:RemoveClickListener()
	self.scrollContent:RemoveOnValueChanged()
	self.drag:RemoveDragBeginListener()
	self.drag:RemoveDragEndListener()
end

return SodacheDialoguePanelView
