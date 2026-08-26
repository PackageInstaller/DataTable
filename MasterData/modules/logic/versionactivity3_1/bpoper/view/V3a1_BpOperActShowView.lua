-- chunkname: @modules/logic/versionactivity3_1/bpoper/view/V3a1_BpOperActShowView.lua

module("modules.logic.versionactivity3_1.bpoper.view.V3a1_BpOperActShowView", package.seeall)

local V3a1_BpOperActShowView = class("V3a1_BpOperActShowView", BaseView)

function V3a1_BpOperActShowView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._goskin = gohelper.findChild(self.viewGO, "Left/image_Skin")
	self._skinClick = gohelper.getClickWithAudio(self._goskin, AudioEnum.UI.play_artificial_ui_carddisappear)
	self._simagelogo2 = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_logo2")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Info")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Right/#txt_desc")
	self._txtremainTime = gohelper.findChildText(self.viewGO, "Right/#txt_remainTime")
	self._goscrollList = gohelper.findChild(self.viewGO, "Right/#go_scroll_List")
	self._goitem = gohelper.findChild(self.viewGO, "Right/#go_scroll_List/Viewport/Content/#go_item")
	self._txtlv = gohelper.findChildText(self.viewGO, "Right/Bottom/Level/icon/#txt_lv")
	self._txttotal = gohelper.findChildText(self.viewGO, "Right/Bottom/txt_decibel/#txt_total")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/Bottom/#go_reddot")
	self._btnarrow = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Bottom/#btn_arrow")
	self._gomax = gohelper.findChild(self.viewGO, "Right/#go_max")
	self._txtmax = gohelper.findChildText(self.viewGO, "Right/#go_max/txt_MAX")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_BpOperActShowView:addEvents()
	self._btnInfo:AddClickListener(self._btnInfoOnClick, self)
	self._btnarrow:AddClickListener(self._btnarrowOnClick, self)
	self._skinClick:AddClickListener(self._onSkinClick, self)
end

function V3a1_BpOperActShowView:removeEvents()
	self._btnInfo:RemoveClickListener()
	self._btnarrow:RemoveClickListener()
	self._skinClick:RemoveClickListener()
end

function V3a1_BpOperActShowView:_btnarrowOnClick()
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.BpOperActLvUpReddotShow, 0)
	gohelper.setActive(self._goreddot, false)
	self:closeThis()

	if ViewMgr.instance:isOpen(ViewName.ActivityBeginnerView) then
		ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
	end

	BpController.instance:openBattlePassView()
end

function V3a1_BpOperActShowView:_btnInfoOnClick()
	local title = CommonConfig.instance:getConstStr(ConstEnum.BPOperActTitle)
	local desc = CommonConfig.instance:getConstStr(ConstEnum.BPOperActDesc)

	HelpController.instance:openStoreTipView(desc, title)
end

function V3a1_BpOperActShowView:_onSkinClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, BpConfig.instance:getCurSkinId(BpModel.instance.id), false, nil, false)
end

function V3a1_BpOperActShowView:_editableInitView()
	self._taskItems = {}

	self:_addEvents()
end

function V3a1_BpOperActShowView:_getInfoSuccess(typeIds)
	local contain = false

	for _, typeId in ipairs(typeIds) do
		if typeId == TaskEnum.TaskType.BpOperAct then
			contain = true
		end
	end

	if not contain then
		return
	end

	self:_refresh(true)
end

function V3a1_BpOperActShowView:_addEvents()
	self.addEventCb(self, BpController.instance, BpEvent.OnLevelUp, self._onBpLevelUp, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._updateTask, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivitySelectState, self._onCategorySelected, self)
end

function V3a1_BpOperActShowView:_removeEvents()
	self.removeEventCb(self, BpController.instance, BpEvent.OnLevelUp, self._onBpLevelUp, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._updateTask, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivitySelectState, self._onCategorySelected, self)
end

function V3a1_BpOperActShowView:_onCategorySelected()
	local actId = ActivityModel.instance:getCurTargetActivityCategoryId()

	if self._actId ~= actId then
		self._isOpenPlayed = false
	end
end

function V3a1_BpOperActShowView:_onBpLevelUp(lv)
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.BpOperActLvUpReddotShow, lv)
	self:_refresh()
end

function V3a1_BpOperActShowView:_updateTask()
	self:_refresh()
end

function V3a1_BpOperActShowView:onUpdateParam()
	return
end

function V3a1_BpOperActShowView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._actId = self.viewParam.actId
	self._config = ActivityConfig.instance:getActivityCo(self._actId)
	self._txtdesc.text = self._config.actDesc

	self:_refreshRemainTime()
	gohelper.setActive(self._gomax, false)
	self:_refresh(not self._isOpenPlayed)

	if not self._isOpenPlayed then
		AudioMgr.instance:trigger(AudioEnum3_1.BpOperAct.play_ui_bpoper_turn_card)

		self._isOpenPlayed = true
	end

	TaskDispatcher.runRepeat(self._refreshRemainTime, self, TimeUtil.OneMinuteSecond)
end

function V3a1_BpOperActShowView:_refreshRemainTime()
	self._txtremainTime.text = self:_getRemainTimeStr()
end

function V3a1_BpOperActShowView:_getRemainTimeStr()
	local remainTimeSec = ActivityModel.instance:getRemainTimeSec(self._actId) or 0

	if remainTimeSec <= 0 then
		return luaLang("turnback_end")
	end

	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(remainTimeSec)

	if day > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			day,
			hour
		})
	elseif hour > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			hour,
			min
		})
	elseif min > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			min
		})
	elseif sec > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

function V3a1_BpOperActShowView:_refresh(withAnim)
	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local scoreInThisLevel = BpModel.instance.score % levelScore

	self._txtlv.text = math.floor(BpModel.instance.score / levelScore)
	self._txttotal.text = scoreInThisLevel .. "/" .. levelScore

	local reddotShow = NationalGiftModel.instance:isNeedShowReddot()

	gohelper.setActive(self._goreddot, reddotShow)
	self:_refreshTask(withAnim)
end

function V3a1_BpOperActShowView:_refreshTask(withAnim)
	local isAllFinished = V3a1_BpOperActModel.instance:isAllTaskFinihshed()
	local isLvMax = BpModel.instance:isMaxLevel()

	gohelper.setActive(self._gomax, isAllFinished or isLvMax)

	if isAllFinished then
		self._txtmax.text = luaLang("v3a1_bpoperactshowview_txt_finish")
	end

	if isLvMax then
		self._txtmax.text = luaLang("v3a1_bpoperactshowview_txt_MAX")
	end

	local taskList = V3a1_BpOperActModel.instance:getAllShowTask(self._actId)

	for _, taskItem in pairs(self._taskItems) do
		taskItem:show(false, withAnim)
	end

	for index, taskId in ipairs(taskList) do
		local taskCo = V3a1_BpOperActConfig.instance:getTaskCO(taskId)

		if not self._taskItems[taskCo.id] then
			self._taskItems[taskCo.id] = V3a1_BpOperActShowTaskItem.New()

			local go = gohelper.cloneInPlace(self._goitem)

			self._taskItems[taskCo.id]:init(go, taskCo, index)
		end

		gohelper.setSibling(self._taskItems[taskCo.id].go, index - 1)
		self._taskItems[taskCo.id]:show(true, withAnim)
		self._taskItems[taskCo.id]:refresh()
	end
end

function V3a1_BpOperActShowView:onClose()
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.BpOperActLvUpReddotShow, 0)
end

function V3a1_BpOperActShowView:onDestroyView()
	self:_removeEvents()
	TaskDispatcher.cancelTask(self._refreshRemainTime, self)

	if self._taskItems then
		for _, v in pairs(self._taskItems) do
			v:destroy()
		end

		self._taskItems = nil
	end
end

return V3a1_BpOperActShowView
