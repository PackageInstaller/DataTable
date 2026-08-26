-- chunkname: @modules/logic/tipdialog/view/TipDialogView.lua

module("modules.logic.tipdialog.view.TipDialogView", package.seeall)

local TipDialogView = class("TipDialogView", BaseView)

function TipDialogView:onInitView()
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_next")
	self._gotopcontent = gohelper.findChild(self.viewGO, "go_normalcontent")
	self._godialogbg = gohelper.findChild(self.viewGO, "go_normalcontent/#go_dialogbg")
	self._godialoghead = gohelper.findChild(self.viewGO, "go_normalcontent/#go_dialoghead")
	self._simagehead = gohelper.findChildSingleImage(self.viewGO, "go_normalcontent/#go_dialoghead/#image_headicon")
	self._txtdialogdesc = gohelper.findChildText(self.viewGO, "go_normalcontent/txt_contentcn")
	self._gobottomcontent = gohelper.findChild(self.viewGO, "#go_bottomcontent")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_bottomcontent/#go_content")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_bottomcontent/#go_content/#simage_bg")
	self._txtinfo = gohelper.findChildText(self.viewGO, "#go_bottomcontent/#go_content/#txt_info")
	self._gooptions = gohelper.findChild(self.viewGO, "#go_bottomcontent/#go_content/#go_options")
	self._gotalkitem = gohelper.findChild(self.viewGO, "#go_bottomcontent/#go_content/#go_options/#go_talkitem")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottomcontent/#btn_skip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TipDialogView:addEvents()
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
end

function TipDialogView:removeEvents()
	self._btnnext:RemoveClickListener()
	self._btnskip:RemoveClickListener()
end

function TipDialogView:_btnskipOnClick()
	return
end

function TipDialogView:_btnnextOnClick()
	if not self._btnnext.gameObject.activeInHierarchy or self._finishClose then
		return
	end

	if not self:_checkClickCd() then
		return
	end

	self:_playNextSectionOrDialog()
end

function TipDialogView:_checkClickCd()
	local time = Time.time - self._time

	if time < 0.5 then
		return
	end

	self._time = Time.time

	return true
end

function TipDialogView:_editableInitView()
	self._time = Time.time
	self._optionBtnList = self:getUserDataTb_()
	self._dialogItemList = self:getUserDataTb_()
	self._dialogItemCacheList = self:getUserDataTb_()

	gohelper.addUIClickAudio(self._btnnext.gameObject, AudioEnum.WeekWalk.play_artificial_ui_commonchoose)

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._nexticon = gohelper.findChild(self.viewGO, "#go_content/nexticon")
	self._tmpFadeIn = MonoHelper.addLuaComOnceToGo(self.viewGO, TMPFadeIn)
end

function TipDialogView:onOpen()
	self._simagebg:LoadImage(ResUrl.getWeekWalkBg("bg_wz.png"))
	NavigateMgr.instance:addSpace(ViewName.TipDialogView, self._onSpace, self)

	if self.viewParam.auto == nil then
		-- block empty
	end

	self._auto = self.viewParam.auto

	if self.viewParam.autoplayTime ~= nil then
		self._autoTime = self.viewParam.autoplayTime or 0.5
	end

	gohelper.setActive(self._btnnext, not self._auto)
	self:_playStory(self.viewParam.dialogId)

	if self._auto then
		TaskDispatcher.runDelay(self._playNextSectionOrDialog, self, self._autoTime)
	end

	local widthPercentage = self.viewParam.widthPercentage

	if widthPercentage then
		self:calTxtWightAndSetBgWight(widthPercentage)
	end
end

function TipDialogView:_onSpace()
	if not self._btnnext.gameObject.activeInHierarchy then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_commonchoose)
	self:_btnnextOnClick()
end

function TipDialogView:_playNextSectionOrDialog()
	if self._auto then
		TaskDispatcher.runDelay(self._playNextSectionOrDialog, self, self._autoTime)
	end

	if #self._sectionList >= self._dialogIndex then
		self:_playNextDialog()

		return
	end

	local prevSectionInfo = table.remove(self._sectionStack)

	if prevSectionInfo then
		self:_playSection(prevSectionInfo[1], prevSectionInfo[2])
	else
		self:_refreshDialogBtnState()
	end
end

function TipDialogView:_playStory(id)
	self._sectionStack = {}
	self._optionId = 0
	self._mainSectionId = "0"
	self._sectionId = self._mainSectionId
	self._dialogIndex = nil
	self._dialogId = id

	self:_playSection(self._sectionId, self._dialogIndex)
end

function TipDialogView:_playSection(sectionId, dialogIndex)
	self:_setSectionData(sectionId, dialogIndex)
	self:_playNextDialog()
end

function TipDialogView:_setSectionData(sectionId, dialogIndex)
	self._sectionList = TipDialogConfig.instance:getDialog(self._dialogId, sectionId)

	if self._sectionList and not string.nilorempty(self._sectionList.option_param) then
		self._option_param = self._sectionList.option_param
	end

	self._dialogIndex = dialogIndex or 1
	self._sectionId = sectionId
end

function TipDialogView:_playNextDialog()
	local config = self._sectionList[self._dialogIndex]

	if not config then
		return
	end

	if config.type == TipDialogEnum.dialogType.dialog then
		self:_showDialog(TipDialogEnum.dialogType.dialog, config, config.speaker)

		self._dialogIndex = self._dialogIndex + 1

		if #self._sectionStack > 0 and #self._sectionList < self._dialogIndex then
			local prevSectionInfo = table.remove(self._sectionStack)

			self:_setSectionData(prevSectionInfo[1], prevSectionInfo[2])
		end

		self:_refreshDialogBtnState()
	elseif config.type == TipDialogEnum.dialogType.talk then
		self:_showTalk(TipDialogEnum.dialogType.talk, config)

		self._dialogIndex = self._dialogIndex + 1

		if #self._sectionStack > 0 and #self._sectionList < self._dialogIndex then
			local prevSectionInfo = table.remove(self._sectionStack)

			self:_setSectionData(prevSectionInfo[1], prevSectionInfo[2])
		end

		self:_refreshDialogBtnState()
	end
end

function TipDialogView:_showDialog(type, config, speaker)
	self:_playAudio(config)
	gohelper.setActive(self._gobottomcontent, true)
	gohelper.setActive(self._gotopcontent, false)

	local text = config.content
	local item = self:_addDialogItem(type, text, speaker)
end

function TipDialogView:_showTalk(type, config)
	gohelper.setActive(self._gobottomcontent, false)
	gohelper.setActive(self._gotopcontent, true)
	self._tmpFadeIn:playNormalText(config.content)

	local pos = string.splitToNumber(config.pos, "#")

	recthelper.setAnchor(self._gotopcontent.transform, pos[1], pos[2])

	local path = string.format("singlebg/headicon_small/%s.png", config.icon)

	self._simagehead:LoadImage(path)
	self:_playAudio(config)
end

function TipDialogView:_playAudio(config)
	if self._audioId and self._audioId > 0 then
		AudioEffectMgr.instance:stopAudio(self._audioId, 0)
	end

	self._audioId = config.audio

	if self._audioId > 0 then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function TipDialogView:_skipOption(optionList, sectionIdList)
	local optionIndex = 1
	local index, sectionId, text = optionIndex, sectionIdList[optionIndex], optionList[optionIndex]

	self:_onOptionClick({
		sectionId,
		text,
		index
	})
end

function TipDialogView:_refreshDialogBtnState(showOption)
	if showOption then
		gohelper.setActive(self._gooptions, true)
	else
		self:_playCloseTalkItemEffect()
	end

	gohelper.setActive(self._txtinfo, not showOption)

	if not self._auto then
		gohelper.setActive(self._btnnext, not showOption)
	end

	if showOption then
		return
	end

	local hasNext = #self._sectionStack > 0 or #self._sectionList >= self._dialogIndex
	local isFinish = not hasNext

	if self._isFinish then
		local player = SLFramework.AnimatorPlayer.Get(self.viewGO)

		player:Play(UIAnimationName.Close, self._fadeOutDone, self)

		self._finishClose = true

		if self._auto then
			TaskDispatcher.cancelTask(self._playNextSectionOrDialog, self)
		end
	end

	self._isFinish = isFinish
end

function TipDialogView:_fadeOutDone()
	self:closeThis()
end

function TipDialogView:_playCloseTalkItemEffect()
	for k, v in pairs(self._optionBtnList) do
		local talkItemAnim = v[1]:GetComponent(typeof(UnityEngine.Animator))

		talkItemAnim:Play("weekwalk_options_out")
	end

	TaskDispatcher.runDelay(self._hideOption, self, 0.133)
end

function TipDialogView:_hideOption()
	gohelper.setActive(self._gooptions, false)
end

function TipDialogView:_onOptionClick(param)
	self._skipOptionParams = nil

	if not self:_checkClickCd() then
		return
	end

	local sectionId = param[1]
	local text = string.format("<indent=4.7em><color=#C66030>\"%s\"</color>", param[2])

	self:_showDialog("option", text)

	self._showOption = true
	self._optionId = param[3]

	self:_checkOption(sectionId)
end

function TipDialogView:_checkOption(sectionId)
	local dialogList = TipDialogConfig.instance:getDialog(self._dialogId, sectionId)

	if not dialogList then
		self:_playNextSectionOrDialog()

		return
	end

	if #self._sectionList >= self._dialogIndex then
		table.insert(self._sectionStack, {
			self._sectionId,
			self._dialogIndex
		})
	end

	self:_playSection(sectionId)
end

function TipDialogView:_addDialogItem(type, text, speaker)
	self._txtinfo.text = text

	self._animatorPlayer:Play(UIAnimationName.Click, self._animDone, self)
	gohelper.setActive(self._nexticon, true)
end

function TipDialogView:_animDone()
	return
end

function TipDialogView:onClose()
	for k, v in pairs(self._optionBtnList) do
		v[2]:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(self._hideOption, self)
	TaskDispatcher.cancelTask(self._playNextSectionOrDialog, self)

	local callback = self.viewParam.callback
	local callbackTarget = self.viewParam.callbackTarget

	if callback then
		self.viewParam.callback(callbackTarget)
	end
end

function TipDialogView:calTxtWightAndSetBgWight(widthPercentage)
	local txtTrans = self._txtdialogdesc.gameObject.transform
	local bgTrans = self._godialogbg.transform
	local txtWidth = recthelper.getWidth(txtTrans)
	local bgWidth = recthelper.getWidth(bgTrans)
	local diff = bgWidth - txtWidth

	recthelper.setWidth(txtTrans, txtWidth * widthPercentage)

	bgWidth = (bgWidth + diff) * widthPercentage

	recthelper.setWidth(bgTrans, bgWidth)
end

function TipDialogView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return TipDialogView
