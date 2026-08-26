-- chunkname: @modules/logic/versionactivity1_8/warmup/view/Act1_8WarmUpLeftView.lua

module("modules.logic.versionactivity1_8.warmup.view.Act1_8WarmUpLeftView", package.seeall)

local Act1_8WarmUpLeftView = class("Act1_8WarmUpLeftView", BaseView)
local iconName = "v1a8_warmup_img_pic"
local testName = "v1a8_warmup_img_test"

function Act1_8WarmUpLeftView:onInitView()
	self._imageicon = gohelper.findChildImage(self.viewGO, "Middle/#image_icon")
	self._imagetest = gohelper.findChildImage(self.viewGO, "Middle/#image_test")
	self._gocorrect = gohelper.findChild(self.viewGO, "Middle/#go_correct")
	self._btncorrect = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#go_correct/#btn_correct")
	self._goerror = gohelper.findChild(self.viewGO, "Middle/#go_error")
	self._btnerror = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#go_error/#btn_error")
	self._gofile = gohelper.findChild(self.viewGO, "Middle/#go_file")
	self._btnfile = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#go_file/#btn_file")
	self._goinput = gohelper.findChild(self.viewGO, "Middle/#go_input")
	self._btnbubblemask = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#go_input/#btn_bubblemask")
	self._inputanswer = gohelper.findChildTextMeshInputField(self.viewGO, "Middle/#go_input/#input_answer")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#go_input/#btn_confirm")
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#go_input/#btn_tips")
	self._gobubble = gohelper.findChild(self.viewGO, "Middle/#go_input/#btn_tips/bubble")
	self._txttips = gohelper.findChildText(self.viewGO, "Middle/#go_input/#btn_tips/bubble/#txt_tips")
	self._btnbubble = gohelper.findChildButtonWithAudio(self._gobubble, "")

	local go = gohelper.findChild(self.viewGO, "Middle/eff_badtv")

	self._flashAnim = go:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act1_8WarmUpLeftView:addEvents()
	self._btncorrect:AddClickListener(self._btnCorrectOnClick, self)
	self._btnerror:AddClickListener(self._btnErrorOnClick, self)
	self._btnfile:AddClickListener(self._btnFileOnClick, self)
	self._btnbubblemask:AddClickListener(self._btnMaskOnClick, self)
	self._btnconfirm:AddClickListener(self._btnConfirmOnClick, self)
	self._btntips:AddClickListener(self._btnTipsOnClick, self)
	self._btnbubble:AddClickListener(self._btnBubbleOnClick, self)
	self.addEventCb(self, Activity125Controller.instance, Activity125Event.DataUpdate, self._refreshUI, self)
	self.addEventCb(self, Activity125Controller.instance, Activity125Event.SwitchEpisode, self._onSwitchEpisode, self)
end

function Act1_8WarmUpLeftView:removeEvents()
	self._btncorrect:RemoveClickListener()
	self._btnerror:RemoveClickListener()
	self._btnfile:RemoveClickListener()
	self._btnbubblemask:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btntips:RemoveClickListener()
	self._btnbubble:RemoveClickListener()
	self.removeEventCb(self, Activity125Controller.instance, Activity125Event.DataUpdate, self._refreshUI, self)
	self.removeEventCb(self, Activity125Controller.instance, Activity125Event.SwitchEpisode, self._onSwitchEpisode, self)
end

function Act1_8WarmUpLeftView:_editableInitView()
	return
end

function Act1_8WarmUpLeftView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Warmup1_8.play_noise)

	self.userId = PlayerModel.instance:getMyUserId()
	self._actId = ActivityEnum.Activity.Activity1_8WarmUp

	local mo = Activity125Model.instance:getById(self._actId)

	if mo then
		self:_refreshUI()
	end
end

function Act1_8WarmUpLeftView:onClose()
	return
end

function Act1_8WarmUpLeftView:onDestroyView()
	return
end

function Act1_8WarmUpLeftView:_refreshUI()
	self._curLvl = Activity125Model.instance:getSelectEpisodeId(self._actId)
	self._errorTimesKey = string.format("%s_%s_%s_%s", self.userId, "1_8WarmUpErrorTime", self._actId, self._curLvl)
	self._episodeCfg = Activity125Config.instance:getEpisodeConfig(self._actId, self._curLvl)

	UISpriteSetMgr.instance:setV1a8WarmUpSprite(self._imageicon, iconName .. self._curLvl)
	UISpriteSetMgr.instance:setV1a8WarmUpSprite(self._imagetest, testName .. self._curLvl)

	self._txttips.text = self._episodeCfg.key

	self._inputanswer:SetText("")
	self:_refreshActiveStatus()
end

function Act1_8WarmUpLeftView:_refreshActiveStatus()
	local isRecevied = Activity125Model.instance:isEpisodeFinished(self._actId, self._curLvl)
	local isOld = Activity125Model.instance:checkIsOldEpisode(self._actId, self._curLvl)
	local localPlay = Activity125Model.instance:checkLocalIsPlay(self._actId, self._curLvl)
	local isFinished = isRecevied or localPlay or isOld
	local clickFilePrefs = PlayerPrefsHelper.getNumber(PlayerPrefsKey.Act1_8WarmUpClickFile .. self.userId, 0)
	local showFile = self._curLvl == 1 and clickFilePrefs == 0

	gohelper.setActive(self._imageicon, isFinished)
	gohelper.setActive(self._gofile, not isFinished and showFile)
	gohelper.setActive(self._imagetest, not isFinished and not showFile)
	gohelper.setActive(self._goinput, not isFinished and not showFile)
	gohelper.setActive(self._gocorrect, false)
	gohelper.setActive(self._goerror, false)

	local errorTimes = self:_getErrorTimes(self._actId, self._curLvl)

	if errorTimes < 3 then
		gohelper.setActive(self._btntips, false)
	else
		gohelper.setActive(self._btntips, true)
	end
end

function Act1_8WarmUpLeftView:_btnCorrectOnClick()
	self._flashAnim:Play("switch", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Warmup1_8.play_noise)
	Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
end

function Act1_8WarmUpLeftView:_btnErrorOnClick()
	gohelper.setActive(self._imagetest, true)
	gohelper.setActive(self._goinput, true)
	gohelper.setActive(self._goerror, false)

	local errorTimes = self:_getErrorTimes(self._actId, self._curLvl)

	if errorTimes >= 3 then
		gohelper.setActive(self._btntips, true)
	end
end

function Act1_8WarmUpLeftView:_btnFileOnClick()
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.Act1_8WarmUpClickFile .. self.userId, 1)
	gohelper.setActive(self._gofile, false)
	gohelper.setActive(self._imagetest, true)
	gohelper.setActive(self._goinput, true)
	Activity125Controller.instance:dispatchEvent(Activity125Event.OnClickFile)
end

function Act1_8WarmUpLeftView:_btnMaskOnClick()
	gohelper.setActive(self._gobubble, false)
	gohelper.setActive(self._btnbubblemask, false)
end

function Act1_8WarmUpLeftView:_btnConfirmOnClick()
	local answer = LuaUtil.full2HalfWidth(self._inputanswer:GetText())
	local key = string.lower(self._episodeCfg.key)

	if string.lower(answer) == key then
		self:_delErrorTimes()
		self:_showRight()
	else
		self:_upErrorTimes()
		self:_showError()
	end
end

function Act1_8WarmUpLeftView:_btnTipsOnClick()
	local isActive = self._gobubble.activeInHierarchy

	gohelper.setActive(self._gobubble, not isActive)
	gohelper.setActive(self._btnbubblemask, not isActive)
end

function Act1_8WarmUpLeftView:_btnBubbleOnClick()
	gohelper.setActive(self._gobubble, false)
	gohelper.setActive(self._btnbubblemask, false)
	self._inputanswer:SetText(self._episodeCfg.key)
end

function Act1_8WarmUpLeftView:_showRight()
	gohelper.setActive(self._gobubble, false)
	gohelper.setActive(self._btnbubblemask, false)
	gohelper.setActive(self._imagetest, false)
	gohelper.setActive(self._gocorrect, true)
	gohelper.setActive(self._goinput, false)
	Activity125Model.instance:setOldEpisode(self._actId, self._curLvl)
end

function Act1_8WarmUpLeftView:_showError()
	AudioMgr.instance:trigger(AudioEnum.Warmup1_8.play_wrong)
	gohelper.setActive(self._imagetest, false)
	gohelper.setActive(self._goinput, false)
	gohelper.setActive(self._goerror, true)
end

function Act1_8WarmUpLeftView:_upErrorTimes()
	local value = self:_getErrorTimes()

	PlayerPrefsHelper.setNumber(self._errorTimesKey, value + 1)
end

function Act1_8WarmUpLeftView:_getErrorTimes()
	return PlayerPrefsHelper.getNumber(self._errorTimesKey, 0)
end

function Act1_8WarmUpLeftView:_delErrorTimes()
	PlayerPrefsHelper.deleteKey(self._errorTimesKey)
end

function Act1_8WarmUpLeftView:_onSwitchEpisode()
	self._flashAnim:Play("switch", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Warmup1_8.play_noise)
	self:_refreshUI()
end

return Act1_8WarmUpLeftView
