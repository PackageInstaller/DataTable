-- chunkname: @modules/logic/explore/view/ExploreInteractView.lua

module("modules.logic.explore.view.ExploreInteractView", package.seeall)

local ExploreInteractView = class("ExploreInteractView", BaseView)

function ExploreInteractView:onInitView()
	self._btnfullscreen = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullscreen")
	self._gochoicelist = gohelper.findChild(self.viewGO, "#go_choicelist")
	self._gochoiceitem = gohelper.findChild(self.viewGO, "#go_choicelist/#go_choiceitem")
	self._txttalkinfo = gohelper.findChildText(self.viewGO, "go_normalcontent/txt_contentcn")
	self._txttalker = gohelper.findChildText(self.viewGO, "#txt_talker")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreInteractView:addEvents()
	NavigateMgr.instance:addSpace(ViewName.ExploreInteractView, self.onClickFull, self)
	self._btnfullscreen:AddClickListener(self.onClickFull, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, self.OnStoryDialogSelect, self)
end

function ExploreInteractView:removeEvents()
	NavigateMgr.instance:removeSpace(ViewName.ExploreInteractView)
	self._btnfullscreen:RemoveClickListener()
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, self.OnStoryDialogSelect, self)
end

function ExploreInteractView:onClickFull()
	if self._hasIconDialogItem and self._hasIconDialogItem:isPlaying() then
		self._hasIconDialogItem:conFinished()

		return
	end

	if not self._btnDatas[1] then
		self._curStep = self._curStep + 1

		if self.config[self._curStep] then
			self:onStep()
		else
			if self.viewParam.callBack then
				self.viewParam.callBack(self.viewParam.callBackObj)
			end

			self:closeThis()
		end
	end
end

function ExploreInteractView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)

	self.config = ExploreConfig.instance:getDialogueConfig(self.viewParam.id)

	if not self.config then
		logError("对话配置不存在，id：" .. tostring(self.viewParam.id))
		self:closeThis()

		return
	end

	self._curStep = 1

	self:onStep()
end

function ExploreInteractView:onStep()
	local co = self.config[self._curStep]

	if not co or co.interrupt == 1 then
		if self.viewParam.callBack then
			self.viewParam.callBack(self.viewParam.callBackObj)
		end

		self:closeThis()

		return
	end

	local content = string.gsub(co.desc, " ", " ")

	self._hasIconDialogItem = self._hasIconDialogItem or MonoHelper.addLuaComOnceToGo(self.viewGO, TMPFadeIn)

	self._hasIconDialogItem:playNormalText(content)

	if co.audio and co.audio > 0 then
		GuideAudioMgr.instance:playAudio(co.audio)
	else
		GuideAudioMgr.instance:stopAudio()
	end

	self._txttalker.text = co.speaker

	local btnDatas = {}

	if not string.nilorempty(co.acceptButton) then
		table.insert(btnDatas, {
			accept = true,
			text = co.acceptButton
		})
	end

	if not string.nilorempty(co.refuseButton) then
		table.insert(btnDatas, {
			accept = false,
			text = co.refuseButton
		})
	end

	if not string.nilorempty(co.selectButton) then
		local arr = GameUtil.splitString2(co.selectButton)

		for _, v in ipairs(arr) do
			table.insert(btnDatas, {
				jumpStep = tonumber(v[2]),
				text = v[1]
			})
		end
	end

	gohelper.CreateObjList(self, self._createItem, btnDatas, self._gochoicelist, self._gochoiceitem)

	self._btnDatas = btnDatas
end

function ExploreInteractView:_createItem(obj, data, index)
	local txt = gohelper.findChildText(obj, "info")

	txt.text = data.text

	local btn = gohelper.findChildButtonWithAudio(obj, "click")

	self:removeClickCb(btn)
	self.addClickCb(self, btn, self.onBtnClick, self, data)

	local keytips = gohelper.findChild(obj, "#go_pcbtn")

	if keytips then
		PCInputController.instance:showkeyTips(keytips, nil, nil, index)
	end
end

function ExploreInteractView:OnStoryDialogSelect(index)
	if index <= #self._btnDatas and index > 0 then
		self:onBtnClick(self._btnDatas[index])
	end
end

function ExploreInteractView:onBtnClick(data)
	if data.jumpStep then
		self._curStep = data.jumpStep

		self:onStep()
	else
		local isAccept = data.accept

		if isAccept then
			if self.viewParam.callBack then
				self.viewParam.callBack(self.viewParam.callBackObj)
			end
		elseif self.viewParam.refuseCallBack then
			self.viewParam.refuseCallBack(self.viewParam.refuseCallBackObj)
		end

		self:closeThis()
	end
end

function ExploreInteractView:onClose()
	GuideAudioMgr.instance:stopAudio()
end

return ExploreInteractView
