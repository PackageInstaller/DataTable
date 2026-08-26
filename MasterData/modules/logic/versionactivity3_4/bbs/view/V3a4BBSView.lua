-- chunkname: @modules/logic/versionactivity3_4/bbs/view/V3a4BBSView.lua

module("modules.logic.versionactivity3_4.bbs.view.V3a4BBSView", package.seeall)

local V3a4BBSView = class("V3a4BBSView", BaseView)

function V3a4BBSView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "root/#simage_PanelBG")
	self._gorecently = gohelper.findChild(self.viewGO, "root/left/tab/#go_recently")
	self._scrolltab = gohelper.findChildScrollRect(self.viewGO, "root/left/tab/#go_recently/#scroll_tab")
	self._gotitleitem = gohelper.findChild(self.viewGO, "root/left/tab/#go_recently/#scroll_tab/Viewport/Content/#go_titleitem")
	self._btnrefreshdisable = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#btn_refreshdisable")
	self._btnrefresh = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#btn_refresh")
	self._txtposttitle = gohelper.findChildText(self.viewGO, "root/right/Title/#txt_posttitle")
	self._scrollpost = gohelper.findChildScrollRect(self.viewGO, "root/right/post/#scroll_post")
	self._gopostitem = gohelper.findChild(self.viewGO, "root/right/post/#scroll_post/Viewport/Content/#go_postitem")
	self._txtsendername = gohelper.findChildText(self.viewGO, "root/right/post/#scroll_post/Viewport/Content/#go_postitem/top/#txt_sendername")
	self._txtsendstation = gohelper.findChildText(self.viewGO, "root/right/post/#scroll_post/Viewport/Content/#go_postitem/top/#txt_sendstation")
	self._txtsendtime = gohelper.findChildText(self.viewGO, "root/right/post/#scroll_post/Viewport/Content/#go_postitem/top/#txt_sendtime")
	self._gocontent = gohelper.findChild(self.viewGO, "root/right/post/#scroll_post/Viewport/Content/#go_postitem/#go_content")
	self._txtquoteuser = gohelper.findChildText(self.viewGO, "root/right/post/#scroll_post/Viewport/Content/#go_postitem/#go_content/#txt_quoteuser")
	self._txtreply = gohelper.findChildText(self.viewGO, "root/right/post/#scroll_post/Viewport/Content/#go_postitem/#go_content/#txt_reply")
	self._txtip = gohelper.findChildText(self.viewGO, "root/right/post/#scroll_post/Viewport/Content/#go_postitem/#txt_ip")
	self._gosend = gohelper.findChild(self.viewGO, "root/right/post/#go_send")
	self._input = gohelper.findChildTextMeshInputField(self.viewGO, "root/right/post/#go_send/content/mask/#input_content")
	self._txtdefaultreply = gohelper.findChildText(self.viewGO, "root/right/post/#go_send/content/mask/#input_content/Text Area/Placeholder")
	self._txtusercount = gohelper.findChildText(self.viewGO, "root/right/post/#go_send/#txt_usercount")
	self._btnsend = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/post/#go_send/btn/#btn_send")
	self._goempty = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/post/#go_send/btn/#go_empty")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/top/#btn_close")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "root/top/#simage_Title")
	self._gopostmask = gohelper.findChild(self.viewGO, "root/right/post/#go_mask")
	self._godialogcontainer = gohelper.findChild(self.viewGO, "#go_dialogcontainer")
	self._go2ndpanel = gohelper.findChild(self.viewGO, "#go_2ndpanel")
	self._btnYes = gohelper.findChildButtonWithAudio(self.viewGO, "#go_2ndpanel/#btn_Yes")
	self._btnNo = gohelper.findChildButtonWithAudio(self.viewGO, "#go_2ndpanel/#btn_No")
	self._btn2ndpanelclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_2ndpanel/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4BBSView:addEvents()
	self._btnrefreshdisable:AddClickListener(self._btnrefreshdisableOnClick, self)
	self._btnrefresh:AddClickListener(self._btnrefreshOnClick, self)
	self._btncontent:AddClickListener(self._btncontentOnClick, self)
	self._btnsend:AddClickListener(self._btnsendOnClick, self)
	self._goempty:AddClickListener(self._btnsendOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._input:AddOnValueChanged(self._onValueChanged, self)
	self._btnYes:AddClickListener(self._btnYesOnClick, self)
	self._btnNo:AddClickListener(self._btnNoOnClick, self)
	self._btn2ndpanelclose:AddClickListener(self._btnNoOnClick, self)
	self.addEventCb(self, V3a4BBSController.instance, V3a4BBSEvent.onFinishDialog, self._onFinishDialog, self)
end

function V3a4BBSView:removeEvents()
	self._btnrefreshdisable:RemoveClickListener()
	self._btnrefresh:RemoveClickListener()
	self._btncontent:RemoveClickListener()
	self._btnsend:RemoveClickListener()
	self._goempty:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._input:RemoveOnValueChanged()
	self._btnYes:RemoveClickListener()
	self._btnNo:RemoveClickListener()
	self._btn2ndpanelclose:RemoveClickListener()
	self.removeEventCb(self, V3a4BBSController.instance, V3a4BBSEvent.onFinishDialog, self._onFinishDialog, self)
end

local TextSpawnInterval = 0.03

function V3a4BBSView:_btnYesOnClick()
	gohelper.setActive(self._go2ndpanel, false)
	self:_reallyClose()
end

function V3a4BBSView:_btnNoOnClick()
	gohelper.setActive(self._go2ndpanel, false)
end

function V3a4BBSView:_btnrefreshdisableOnClick()
	if self:isBlockView() then
		return
	end

	self:_showToastTriggerDecs()
end

function V3a4BBSView:_btnemptyOnClick()
	if self:isBlockView() then
		return
	end

	self:_showToastTriggerDecs()
end

function V3a4BBSView:_btnrefreshOnClick()
	if self:isBlockView() then
		return
	end

	if not self:_isSuccessTrigger(V3a4BBSEnum.TriggerType.refresh) then
		self:_showToastTriggerDecs()

		return
	end

	self._postMo:finishTrigger()
	self._rightAnim:Play("switch", 0, 0)
	TaskDispatcher.runDelay(self._refreshPost, self, 0.16)
	AudioMgr.instance:trigger(AudioEnum3_4.VersionActivity3_4.play_ui_bulaochun_click_general)
end

function V3a4BBSView:_btnsendOnClick()
	if self:isBlockView() then
		return
	end

	if not self._curStepMo then
		return
	end

	if not self:_isSuccessTrigger(V3a4BBSEnum.TriggerType.send) then
		self:_showToastTriggerDecs()

		return
	end

	self._postMo:finishTrigger()
	self:_checkPostStep()
	self:_refreshStep()
	self:_setInput()
	AudioMgr.instance:trigger(AudioEnum3_4.VersionActivity3_4.play_ui_bulaochun_click_general)
end

function V3a4BBSView:_btncontentOnClick()
	if self:isBlockView() then
		return
	end

	if not self:_isSuccessTrigger(V3a4BBSEnum.TriggerType.dialogue) then
		self:_showToastTriggerDecs()

		return
	end

	local nextMo = self._postMo:getNextStepMo()

	if nextMo then
		self:_setInput(nextMo.co.decs, true)
	end

	self._postMo:finishTrigger()
	self:_checkPostStep()
end

function V3a4BBSView:_refreshDefaultReply()
	local opeation = self:_getNextTriggerOpeation()
	local reply = "v3a4bbs_wait_other_reply"
	local isDialog = false
	local isWaitReply = true
	local animation = self._txtdefaultreply.gameObject:GetComponent(typeof(UnityEngine.Animation))
	local nextMo = self._postMo:getNextStepMo()

	if nextMo and opeation then
		if opeation[1] == V3a4BBSEnum.TriggerType.click then
			if opeation[2] == V3a4BBSEnum.TriggerType.dialogue then
				isDialog = true
				isWaitReply = false
			elseif opeation[2] == V3a4BBSEnum.TriggerType.send then
				isWaitReply = false
			elseif opeation[2] == V3a4BBSEnum.TriggerType.Close then
				isWaitReply = false
				reply = ""
			end
		end
	else
		isWaitReply = false
		reply = ""
	end

	if isDialog then
		reply = "v3a4bbs_default_reply"

		animation:Play()
	else
		animation:Stop()

		local color = self._txtdefaultreply.color

		color.a = 1
		self._txtdefaultreply.color = color

		gohelper.setAsLastSibling(self._goreply)
	end

	self._txtdefaultreply.text = not string.nilorempty(reply) and luaLang(reply) or ""

	gohelper.setActive(self._goinputframe, isDialog)
	gohelper.setActive(self._goreply, isWaitReply)
end

function V3a4BBSView:_setInput(desc, isAnim)
	self._isPlayInputAnim = false

	if string.nilorempty(desc) then
		self._content = ""
		self._contentLen = 0

		self._input:SetText("")

		self._input.inputField.readOnly = true
	else
		self._input.inputField.readOnly = false
		self._content = desc
		self._contentLen = utf8.len(desc)

		self._input.inputField:Select()

		if isAnim then
			self._input:SetText("")

			self._currentCharIndex = 1
			self._lastSpawnTime = Time.time
			self._isPlayInputAnim = true

			AudioMgr.instance:trigger(AudioEnum3_4.VersionActivity3_4.play_ui_bulaochun_typing_loop)
		else
			self._input:SetText(desc)

			self._input.inputField.caretPosition = self._contentLen
			self._scollinput.verticalNormalizedPosition = 0
		end
	end
end

function V3a4BBSView:_onFrame()
	if self._isPlayInputAnim then
		if Time.time - self._lastSpawnTime > TextSpawnInterval then
			local desc = self:_tickContent()

			self._input:SetText(desc)

			self._input.inputField.caretPosition = self._currentCharIndex
			self._lastSpawnTime = Time.time
			self._scollinput.verticalNormalizedPosition = 0
		end

		if self._currentCharIndex >= self._contentLen then
			self._isPlayInputAnim = false

			self._input:SetText(self._content)

			self._input.inputField.caretPosition = self._contentLen

			AudioMgr.instance:trigger(AudioEnum3_4.VersionActivity3_4.stop_ui_bulaochun_typing_loop)
		end
	end
end

function V3a4BBSView:_onValueChanged()
	self._input:SetText((self._isPlayInputAnim or nil) and utf8.sub(self._content, 1, self._currentCharIndex))
end

function V3a4BBSView:_tickContent()
	self.lastSpawnTime = Time.time
	self._currentCharIndex = self._currentCharIndex + 1

	local curChar = utf8.sub(self._content, self._currentCharIndex - 1, self._currentCharIndex)

	if curChar == "<" then
		local checkRichText = utf8.sub(self._content, self._currentCharIndex - 1, self._currentCharIndex + 2)

		if checkRichText == "<i>" then
			self._currentCharIndex = self._currentCharIndex + 3
		end

		local checkRichText2 = utf8.sub(self._content, self._currentCharIndex - 1, self._currentCharIndex + 3)

		if checkRichText2 == "</i>" then
			self._currentCharIndex = self._currentCharIndex + 4
		end
	end

	return utf8.sub(self._content, 1, self._currentCharIndex)
end

function V3a4BBSView:isBlockView()
	return self._isPlayInputAnim
end

function V3a4BBSView:_btncloseOnClick()
	local nextStep = self._postMo:getNextStepMo()

	if nextStep then
		gohelper.setActive(self._go2ndpanel, true)
	else
		self:_reallyClose()
	end

	AudioMgr.instance:trigger(AudioEnum3_4.VersionActivity3_4.play_ui_bulaochun_click_general)
end

function V3a4BBSView:_reallyClose()
	if self:_isSuccessTrigger(V3a4BBSEnum.TriggerType.Close) then
		self._postMo:finishTrigger()
	end

	self:closeThis()
end

function V3a4BBSView:onClickModalMask()
	self:_btncloseOnClick()
end

function V3a4BBSView:_editableInitView()
	gohelper.setActive(self._gopostitem, false)
	gohelper.setActive(self._gotitleitem, false)

	self._scollinput = gohelper.findChildScrollRect(self.viewGO, "root/right/post/#go_send/content/#scroll_content")
	self._goinputframe = gohelper.findChild(self.viewGO, "root/right/post/#go_send/content/#scroll_content/#go_InputFrame")
	self._txtinput = gohelper.findChildText(self._input.gameObject, "Text Area/Text")
	self._btncontent = SLFramework.UGUI.UIClickListener.Get(self._scollinput.gameObject)
	self._goreply = gohelper.findChild(self.viewGO, "root/right/post/#scroll_post/Viewport/Content/#go_replying")
	self.updateHandle = UpdateBeat:CreateListener(self._onFrame, self)

	UpdateBeat:AddListener(self.updateHandle)

	self._goright = gohelper.findChild(self.viewGO, "root/right")
	self._rightAnim = self._goright:GetComponent(typeof(UnityEngine.Animator))
	self._closeAnim = self._btnclose.gameObject:GetComponent(typeof(UnityEngine.Animator))
end

function V3a4BBSView:onUpdateParam()
	return
end

function V3a4BBSView:onOpen()
	self._postStepItems = {}
	self._tabItems = {}
	self._postId, self._step = self.viewParam.postId, self.viewParam.step
	self._elementId = self.viewParam.elementId
	self._postMo = V3a4BBSModel.instance:getPostMo(self._postId)
	self._currentCharIndex = 1

	if self._postMo then
		self._postMo:setCurStepId(self._step)

		self._step = self._postMo:getCurStepId()
	end

	self:switchPost(true)
	self:_refreshRecently()
	AudioMgr.instance:trigger(AudioEnum3_4.VersionActivity3_4.play_ui_bulaochun_forum_open)
end

function V3a4BBSView:switchPost(delayDelay)
	self:_playPost(false)
	self:_refreshPost(delayDelay)

	if self._curStepMo then
		local opeation = self._curStepMo:getTriggerOpeation()

		if opeation and opeation[1] == V3a4BBSEnum.TriggerType.click and opeation[2] == V3a4BBSEnum.TriggerType.dialogue then
			local nextMo = self._postMo:getNextStepMo()

			self._content = nextMo.co.decs
			self._contentLen = utf8.len(self._content)
			self._currentCharIndex = self._contentLen
			self._lastSpawnTime = Time.time
			self._isPlayInputAnim = true
		end

		local title = luaLang("p_v3a4_bbsview_link")

		if self._curStepMo.co.type == V3a4BBSEnum.PostType.Element then
			local elementco = V3a4BBSModel.instance:getElementCoByPostId(self._postId)

			if elementco then
				local co = lua_chapter_map_element.configDict[elementco.id]

				title = co.flagText
			end
		end

		self._txtposttitle.text = title
	end

	AudioMgr.instance:trigger(AudioEnum3_4.VersionActivity3_4.stop_ui_bulaochun_typing_loop)
end

function V3a4BBSView:_refreshPost(delayDelay)
	self._closeAnim:Play("idle", 0, 0)

	if self._postMo then
		self._curStepMo = self._postMo:getCurStepMo()

		self:_checkPostStep()
	end

	self:_refreshStep(delayDelay)

	local opeation = self._curStepMo:getTriggerOpeation()
	local dialogue = opeation and opeation[2] == V3a4BBSEnum.TriggerType.dialogue
	local nextStepMo = self._postMo:getNextStepMo()

	if dialogue and nextStepMo then
		self._content = nextStepMo.co.decs
		self._contentLen = utf8.len(self._content)
		self._currentCharIndex = self._contentLen
		self._lastSpawnTime = Time.time
	end
end

function V3a4BBSView:_getPostItem(index)
	local item = self._postStepItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gopostitem, "step_" .. index)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a4BBSPostItem)
		self._postStepItems[index] = item
	end

	return item
end

function V3a4BBSView:_refreshStep(delayDelay)
	local stepCount = 0

	if self._postMo then
		for i = 1, self._step do
			local mo = self._postMo:getStepMo(i)

			if mo then
				local item = self:_getPostItem(i)

				item:onUpdateMO(mo)

				stepCount = stepCount + 1
			end
		end

		local nextStep = self._postMo:getNextStepMo()

		if nextStep then
			self._closeAnim:Play("idle", 0, 0)

			if self._curStepMo and self._curStepMo:isSent() then
				local item = self:_getPostItem(stepCount + 1)

				item:onUpdateMO(nextStep)

				stepCount = stepCount + 1
			end
		else
			local opeation = self:_getNextTriggerOpeation()

			if opeation and opeation[2] and opeation[2] ~= V3a4BBSEnum.TriggerType.Close then
				self:_checkPostStep()
			else
				self:_playCloseBtnAnim()
			end
		end
	end

	for i = 1, #self._postStepItems do
		gohelper.setActive(self._postStepItems[i].viewGO, i <= stepCount)
	end

	if delayDelay then
		TaskDispatcher.runDelay(self._tweenPostVNP, self, 1)
	else
		self:_tweenPostVNP()
	end
end

function V3a4BBSView:_tweenPostVNP()
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.5, self.frameCallback, self.finishCallback, self, nil, EaseType.Linear)
end

function V3a4BBSView:frameCallback(value)
	if value < self._scrollpost.verticalNormalizedPosition then
		self._scrollpost.verticalNormalizedPosition = value
	end
end

function V3a4BBSView:finishCallback()
	self._scrollpost.verticalNormalizedPosition = 0
end

function V3a4BBSView:_refreshTabSelect(item, isSelect)
	local color = isSelect and "#BFC0C4" or "#3D3D3D"

	item.txt.color = GameUtil.parseColor(color)

	gohelper.setActive(item.goSelect, isSelect)
end

function V3a4BBSView:_refreshRecently()
	if not self._curStepMo then
		return
	end

	local unlockElements = V3a4BBSModel.instance:getUnlockElements()
	local vnp = 1

	for i, element in ipairs(unlockElements) do
		local item = self:_getTabItem(i)

		item.txt.text = element.flagText
		item.postId = tonumber(element.param)

		local isSelect = element.id == self._elementId

		self:_refreshTabSelect(item, isSelect)

		if isSelect then
			vnp = #unlockElements > 0 and i / #unlockElements or 0
		end
	end

	for i = 1, #self._tabItems do
		local item = self._tabItems[i]

		gohelper.setActive(item.go, i <= #unlockElements)
	end

	self._scrolltab.verticalNormalizedPosition = 1 - vnp
end

function V3a4BBSView:_getTabItem(index)
	local item = self._tabItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gotitleitem, "tab_" .. index)
		local goSelect = gohelper.findChild(go, "#go_Selected")

		item = self:getUserDataTb_()
		item.go = go
		item.goSelect = goSelect
		item.txt = gohelper.findChildText(go, "#txt_recently")
		item.btn = gohelper.findChildButtonWithAudio(go, "#btn_click")

		item.btn:AddClickListener(self._btnTagOnClick, self, index)

		self._tabItems[index] = item
	end

	return item
end

function V3a4BBSView:_btnTagOnClick(index)
	return
end

function V3a4BBSView:_checkPostStep()
	local opeation = self:_getNextTriggerOpeation()

	if self._curStepMo then
		if opeation then
			if opeation[1] == V3a4BBSEnum.TriggerType.finish then
				local postId = tonumber(opeation[2])
				local stepId = tonumber(opeation[3])
				local time = opeation[4] and tonumber(opeation[4]) or V3a4BBSEnum.TriggerDelayTime
				local postMo = V3a4BBSModel.instance:getPostMo(postId)

				if postMo then
					local postStepMo = postMo:getStepMo(stepId)

					if postStepMo then
						self:_finishStep(time)
					end

					self:_showBtn(false, false)
				end
			elseif opeation[1] == V3a4BBSEnum.TriggerType.click then
				local isRefresh = opeation[2] == V3a4BBSEnum.TriggerType.refresh
				local isSend = opeation[2] == V3a4BBSEnum.TriggerType.send
				local isClose = opeation[2] == V3a4BBSEnum.TriggerType.Close

				if isClose then
					self:_playCloseBtnAnim()
				else
					self:_showBtn(isSend, isRefresh)
				end
			elseif opeation[1] == V3a4BBSEnum.TriggerType.Close then
				self:_finishStep(V3a4BBSEnum.TriggerDelayTime)
				TaskDispatcher.runDelay(self.closeThis, self, V3a4BBSEnum.TriggerDelayTime)
				self:_showBtn(false, false)
			elseif opeation[1] == V3a4BBSEnum.TriggerType.Playdialog then
				local id = tonumber(opeation[2])

				self._dialogView = self._dialogView or MonoHelper.addNoUpdateLuaComOnceToGo(self._godialogcontainer, V3a4BBSDialogView, self)

				self._dialogView:playDialog(id)
				self:_showBtn(false, false)
			end
		else
			local isEmptyTrigger = self._curStepMo:isEmptyTrigger()

			if isEmptyTrigger then
				if not V3a4BBSEnum.TriggerDelayTime then
					local time = 0

					self:_finishStep(time)
				end
			end
		end
	end

	self:_refreshDefaultReply()
end

function V3a4BBSView:_onFinishDialog()
	self._postMo:finishTrigger()
	self:_checkPostStep()
end

function V3a4BBSView:_showBtn(isSend, isRefresh)
	gohelper.setActive(self._goempty.gameObject, not isSend)
	gohelper.setActive(self._btnsend.gameObject, isSend)
	gohelper.setActive(self._btnrefreshdisable.gameObject, not isRefresh)
	gohelper.setActive(self._btnrefresh.gameObject, isRefresh)
end

function V3a4BBSView:_playCloseBtnAnim()
	self:_showBtn(false, false)
	self._closeAnim:Play("loop", 0, 0)
end

function V3a4BBSView:_finishStep(delayTime)
	local nextStep = self._postMo:getNextStepMo()

	if not nextStep then
		self:_playCloseBtnAnim()

		return
	end

	self:_playPost(true)
	TaskDispatcher.cancelTask(self._showNextStep, self)

	if delayTime and delayTime > 0 then
		TaskDispatcher.runDelay(self._showNextStep, self, delayTime)
	else
		self:_showNextStep()
	end
end

function V3a4BBSView:_showNextStep()
	TaskDispatcher.runDelay(self._playPost, self, 0.55)

	self._step = self._step + 1

	self._postMo:setCurStepId(self._step)

	self._curStepMo = self._postMo:getCurStepMo()

	self._curStepMo:setTriggerIndex(0)
	self:_refreshStep()
	self:_checkPostStep()
	self:_setInput()
end

function V3a4BBSView:_playPost(isPlayPost)
	TaskDispatcher.cancelTask(self._playPost, self)

	self._isPlayingPost = isPlayPost

	gohelper.setActive(self._gopostmask, isPlayPost)
end

function V3a4BBSView:_isSuccessTrigger(trigger)
	local opeation = self:_getNextTriggerOpeation()

	if opeation and opeation[1] == V3a4BBSEnum.TriggerType.click then
		return opeation[2] == trigger
	end
end

function V3a4BBSView:_getNextTriggerOpeation()
	if not self._curStepMo then
		return
	end

	return self._curStepMo:getNextTriggerOpeation()
end

function V3a4BBSView:_showToastTriggerDecs()
	if not self._curStepMo then
		return
	end

	local triggerDecs = self._curStepMo.co.triggerDecs

	if string.nilorempty(triggerDecs) then
		return
	end

	GameFacade.showToast(ToastEnum.IconId, triggerDecs)
	AudioMgr.instance:trigger(AudioEnum3_4.VersionActivity3_4.play_ui_bulaochun_error_prompt)
end

function V3a4BBSView:onClose()
	TaskDispatcher.cancelTask(self._showNextStep, self)
	TaskDispatcher.cancelTask(self._playPost, self)

	for i, item in pairs(self._tabItems) do
		item.btn:RemoveClickListener()
	end

	self._isPlayInputAnim = false

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	if self.updateHandle then
		UpdateBeat:RemoveListener(self.updateHandle)
	end

	TaskDispatcher.cancelTask(self._refreshPost, self)
	TaskDispatcher.cancelTask(self.switchPost, self)
	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.cancelTask(self._tweenPostVNP, self)

	local nextStep = self._postMo:getNextStepMo()

	if self._curStepMo and self._curStepMo.co.type == V3a4BBSEnum.PostType.Element then
		if not nextStep then
			local elementco = V3a4BBSModel.instance:getElementCoByPostId(self._postId)

			if elementco and DungeonMapModel.instance:getElementById(elementco.id) then
				DungeonRpc.instance:sendMapElementRequest(elementco.id)
			end
		end

		VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnHideInteractUI)
	end

	AudioMgr.instance:trigger(AudioEnum3_4.VersionActivity3_4.stop_ui_bulaochun_typing_loop)
	AudioMgr.instance:trigger(AudioEnum3_4.VersionActivity3_4.play_ui_bulaochun_forum_close)

	local callback = self.viewParam.callback
	local callbackTarget = self.viewParam.callbackTarget

	if not self.viewParam.callbackParams then
		if callback then
			self.viewParam.callback(callbackTarget, self.viewParam.callbackParams, self.isFinishDialogue or self._isDone)
		end
	end
end

function V3a4BBSView:onDestroyView()
	return
end

return V3a4BBSView
