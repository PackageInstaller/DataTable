-- chunkname: @modules/logic/versionactivity4_0/sonnet/view/SonnetInterchapterGetView.lua

module("modules.logic.versionactivity4_0.sonnet.view.SonnetInterchapterGetView", package.seeall)

local SonnetInterchapterGetView = class("SonnetInterchapterGetView", BaseView)

function SonnetInterchapterGetView:onInitView()
	self._golive2d = gohelper.findChild(self.viewGO, "#go_live2d")
	self._gomind = gohelper.findChild(self.viewGO, "#go_mind")
	self._txtmind = gohelper.findChildText(self.viewGO, "#go_mind/#txt_mind")
	self._gomindwords = gohelper.findChild(self.viewGO, "#go_mind_words")
	self._goworditem = gohelper.findChild(self.viewGO, "#go_mind_words/#go_worditem")
	self._btncontinue = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_continue")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SonnetInterchapterGetView:addEvents()
	self._btncontinue:AddClickListener(self._btncontinueOnClick, self)
end

function SonnetInterchapterGetView:removeEvents()
	self._btncontinue:RemoveClickListener()
end

function SonnetInterchapterGetView:_btncontinueOnClick()
	self:_next()
end

function SonnetInterchapterGetView:_editableInitView()
	gohelper.setActive(self._gomind, false)
	gohelper.setActive(self._gomindwords, false)
	gohelper.setActive(self._goworditem, false)
end

function SonnetInterchapterGetView:onUpdateParam()
	return
end

function SonnetInterchapterGetView:onOpen()
	self._elementId = self.viewParam.id
	self._callback = self.viewParam.callback
	self._callbackObj = self.viewParam.callbackObj
	self._dialogList = SonnetInterchapterConfig.instance:getDialogs(self._elementId)
	self._words = SonnetInterchapterConfig.instance:getWords(self._elementId)
	self._dialogIndex = 1

	self:_next()
	AudioMgr.instance:trigger(SonnetInterchapterEnum.Audio.play_ui_molu_jlbn_open)
end

function SonnetInterchapterGetView:_next()
	if self._dialogIndex <= #self._dialogList then
		self:_showDialogs()

		self._dialogIndex = self._dialogIndex + 1
	elseif not self._showWords then
		self._showWords = true

		self:_showWordsView()
		AudioMgr.instance:trigger(SonnetInterchapterEnum.Audio.play_ui_wenming_cards_toushi_gone)
	else
		self._isFinished = true

		self:closeThis()

		if self._callback then
			self._callback(self._callbackObj, self._elementId)
		end
	end
end

function SonnetInterchapterGetView:_showDialogs()
	gohelper.setActive(self._gomind, true)

	self._txtmind.text = self._dialogList[self._dialogIndex].desc
end

function SonnetInterchapterGetView:_showWordsView()
	gohelper.setActive(self._gomind, false)
	gohelper.setActive(self._gomindwords, true)

	self._wordItemList = self:getUserDataTb_()

	for i, v in ipairs(self._words) do
		local go = gohelper.cloneInPlace(self._goworditem)

		gohelper.setActive(go, true)

		local pos = string.splitToNumber(v.coordinates, "#")

		if not pos[1] then
			local x = math.random(1920) - 1000

			if not pos[2] then
				local y = math.random(1080) - 600

				recthelper.setAnchor(go.transform, pos[1], y)

				local txt = gohelper.findChildText(go, "unselect/txt")

				txt.text = v.words

				local txt2 = gohelper.findChildText(go, "selected/txt")

				txt2.text = v.words

				local unselectGO = gohelper.findChild(go, "unselect")
				local selectedGO = gohelper.findChild(go, "selected")

				gohelper.setActive(unselectGO, true)
				gohelper.setActive(selectedGO, false)

				local btn = gohelper.findChildButtonWithAudio(go, "btn_click")
				local item = {
					btn = btn,
					unselect = unselectGO,
					selected = selectedGO,
					dialogId = v.dialogId
				}

				btn:AddClickListener(self._onBtnClick, self, item)
				table.insert(self._wordItemList, item)
			end
		end
	end
end

function SonnetInterchapterGetView:_onBtnClick(data)
	for _, item in ipairs(self._wordItemList) do
		local isSelected = item == data

		gohelper.setActive(item.unselect, not isSelected)
		gohelper.setActive(item.selected, isSelected)
	end

	TipDialogController.instance:openTipDialogView(data.dialogId, self._deselectAll, self)
end

function SonnetInterchapterGetView:_deselectAll()
	for _, item in ipairs(self._wordItemList) do
		gohelper.setActive(item.unselect, true)
		gohelper.setActive(item.selected, false)
	end
end

function SonnetInterchapterGetView:onClose()
	if self._wordItemList then
		for _, v in ipairs(self._wordItemList) do
			v.btn:RemoveClickListener()
		end
	end
end

function SonnetInterchapterGetView:onCloseFinish()
	if self._isFinished then
		self._isFinished = false

		DungeonRpc.instance:sendMapElementRequest(self._elementId, nil, self._onFinishElement, self)
	end
end

function SonnetInterchapterGetView:_onFinishElement(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	SonnetInterchapterController.instance:dispatchEvent(SonnetInterchapterEvent.FinishElement)
	DungeonController.instance:dispatchEvent(DungeonEvent.EndShowRewardView)
end

function SonnetInterchapterGetView:onDestroyView()
	return
end

return SonnetInterchapterGetView
