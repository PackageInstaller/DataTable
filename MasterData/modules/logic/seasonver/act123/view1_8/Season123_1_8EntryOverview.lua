-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8EntryOverview.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8EntryOverview", package.seeall)

local Season123_1_8EntryOverview = class("Season123_1_8EntryOverview", BaseView)

function Season123_1_8EntryOverview:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_1_8EntryOverview:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Season123_1_8EntryOverview:removeEvents()
	self._btnclose:RemoveClickListener()
end

Season123_1_8EntryOverview.UI_Item_Count = 6

function Season123_1_8EntryOverview:_editableInitView()
	self._entryList = {}

	self:initItems()
end

function Season123_1_8EntryOverview:onDestroyView()
	if self._entryList then
		for index, item in ipairs(self._entryList) do
			item.btnclick:RemoveClickListener()
		end

		self._entryList = nil
	end

	Season123EntryOverviewController.instance:onCloseView()
	TaskDispatcher.cancelTask(self._closeCallback, self)
	TaskDispatcher.cancelTask(self._playUnlockAnim, self)
	TaskDispatcher.cancelTask(self.refreshUI, self)
end

function Season123_1_8EntryOverview:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.season123_overview_open)

	local actId = self.viewParam.actId
	local actMO = ActivityModel.instance:getActMO(actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		return
	end

	self.addEventCb(self, Season123Controller.instance, Season123Event.GetActInfo, self.handleGetActInfo, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.TaskUpdated, self.refreshUI, self)
	Season123EntryOverviewController.instance:onOpenView(actId)
	self:refreshUI()
	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
	TaskDispatcher.runDelay(self._playUnlockAnim, self, 0.83)
	TaskDispatcher.runRepeat(self.refreshUI, self, 3)
end

function Season123_1_8EntryOverview:onClose()
	return
end

function Season123_1_8EntryOverview:refreshUI()
	self:refreshItems()
end

function Season123_1_8EntryOverview:refreshItems()
	local actId = Season123EntryOverviewModel.instance:getActId()
	local stageCOList = Season123Config.instance:getStageCos(actId)

	if stageCOList then
		for index = 1, Season123_1_8EntryOverview.UI_Item_Count do
			local item = self._entryList[index]
			local stageCO = stageCOList[index]

			if stageCO then
				local stageId = stageCO.stage
				local stageMO = Season123EntryOverviewModel.instance:getStageMO(stageId)

				gohelper.setActive(item.go, true)
				self:refreshItem(item, stageCO, stageMO)
			else
				gohelper.setActive(item.go, false)
			end
		end
	end
end

function Season123_1_8EntryOverview:refreshItem(item, stageCO, stageMO)
	local actId = Season123EntryOverviewModel.instance:getActId()

	gohelper.setActive(item.gofighting, stageMO and Season123ProgressUtils.stageInChallenge(actId, stageMO.stage))
	gohelper.setActive(item.gofinish, stageMO and stageMO:alreadyPass())

	item.txtpassround.text = stageMO and stageMO:alreadyPass() and tostring(stageMO.minRound or 0) or ""
	item.txtname.text = stageCO.name

	self:refreshProgress(item, stageCO, stageMO)
	self:refreshUnlockStatus(item, stageCO)
end

function Season123_1_8EntryOverview:refreshProgress(item, stageCO, stageMO)
	local curStageStep, maxStep

	if stageMO then
		local isPass = Season123EntryOverviewModel.instance:stageIsPassed(stageMO.stage)

		gohelper.setActive(item.goprogress, isPass)

		if not isPass then
			return
		end

		curStageStep, maxStep = Season123ProgressUtils.getStageProgressStep(self.viewParam.actId, stageMO.stage)
	else
		gohelper.setActive(item.goprogress, false)

		curStageStep = 0
		maxStep = 0
	end

	for i = 1, Activity123Enum.SeasonStageStepCount do
		local rs, reason, value = Season123ProgressUtils.isStageUnlock(self.viewParam.actId, stageCO.stage)

		if rs then
			local isActive = i <= curStageStep
			local keepActive = i <= maxStep

			gohelper.setActive(item.progressActives[i], isActive and i < maxStep)
			gohelper.setActive(item.progressDeactives[i], not isActive and keepActive)
			gohelper.setActive(item.progressHard[i], i == maxStep and curStageStep == maxStep)
		else
			gohelper.setActive(item.progressActives[i], false)
			gohelper.setActive(item.progressDeactives[i], false)
			gohelper.setActive(item.progressHard[i], false)
		end
	end
end

function Season123_1_8EntryOverview:refreshUnlockStatus(item, stageCO, stageMO)
	local rs, reason, value = Season123ProgressUtils.isStageUnlock(self.viewParam.actId, stageCO.stage)
	local needPlay = Season123EntryModel.instance:needPlayUnlockAnim1(self.viewParam.actId, stageCO.stage)

	if rs and not needPlay then
		ZProj.UGUIHelper.SetGrayscale(item.imageicon.gameObject, false)
		ZProj.UGUIHelper.SetGrayscale(item.imagechapter.gameObject, false)
		gohelper.setActive(item.gounlocked, false)
		gohelper.setActive(item.gounlockedtime, false)
	else
		ZProj.UGUIHelper.SetGrayscale(item.imageicon.gameObject, true)
		ZProj.UGUIHelper.SetGrayscale(item.imagechapter.gameObject, true)

		if reason == Activity123Enum.PreCondition.OpenTime then
			gohelper.setActive(item.gounlocked, false)
			gohelper.setActive(item.gounlockedtime, true)

			if value.showSec then
				local timeStr = string.format("%s%s", TimeUtil.secondToRoughTime2(value.remainTime))

				item.txtunlocktime.text = string.format(luaLang("season123_overview_unlocktime_custom"), timeStr)
			else
				item.txtunlocktime.text = string.format(luaLang("season123_overview_unlocktime"), value.day)
			end
		else
			gohelper.setActive(item.gounlocked, true)
			gohelper.setActive(item.gounlockedtime, false)
		end
	end
end

function Season123_1_8EntryOverview:initItems()
	for i = 1, Season123_1_8EntryOverview.UI_Item_Count do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, "go_center/go_item" .. tostring(i))
		item.txtname = gohelper.findChildText(item.go, "#txt_name")
		item.imageicon = gohelper.findChildImage(item.go, "#image_icon")
		item.imagechapter = gohelper.findChildImage(item.go, "image_chapternum")
		item.gofinish = gohelper.findChild(item.go, "#image_finish")
		item.gofighting = gohelper.findChild(item.go, "#image_fighting")
		item.goprogress = gohelper.findChild(item.go, "#go_progress")
		item.txtpassround = gohelper.findChildText(item.go, "#image_finish/#txt_time")
		item.btnclick = gohelper.findChildButton(item.go, "btn_click")

		item.btnclick:AddClickListener(self.onClickIndex, self, i)

		item.progressActives = self:getUserDataTb_()
		item.progressDeactives = self:getUserDataTb_()
		item.progressHard = self:getUserDataTb_()

		for j = 1, Activity123Enum.SeasonStageStepCount do
			item.progressActives[j] = gohelper.findChild(item.go, string.format("#go_progress/#go_progress%s/light", j))
			item.progressDeactives[j] = gohelper.findChild(item.go, string.format("#go_progress/#go_progress%s/dark", j))
			item.progressHard[j] = gohelper.findChild(item.go, string.format("#go_progress/#go_progress%s/red", j))
		end

		item.gounlocked = gohelper.findChild(item.go, "#image_locked")
		item.gounlockedtime = gohelper.findChild(item.go, "#image_unlockedtime")
		item.txtunlocktime = gohelper.findChildText(item.go, "#image_unlockedtime/#txt_time")
		item.animtor = item.go:GetComponent(gohelper.Type_Animator)
		self._entryList[i] = item
	end
end

function Season123_1_8EntryOverview:handleGetActInfo(actId)
	if self.viewParam.actId == actId then
		self:refreshUI()
	end
end

function Season123_1_8EntryOverview:onClickIndex(index)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_click)

	local actId = Season123EntryOverviewModel.instance:getActId()
	local stageCOList = Season123Config.instance:getStageCos(actId)
	local stageCO = stageCOList[index]
	local seasonMO = Season123Model.instance:getActInfo()

	if not stageCO then
		return
	end

	Season123Controller.instance:dispatchEvent(Season123Event.LocateToStage, {
		actId = actId,
		stageId = stageCO.stage
	})
	self:_btncloseOnClick()
end

function Season123_1_8EntryOverview:_btncloseOnClick()
	self._viewAnimator:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(self._closeCallback, self, 0.17)
end

function Season123_1_8EntryOverview:_closeCallback()
	self:closeThis()
end

function Season123_1_8EntryOverview:_playUnlockAnim()
	local actId = Season123EntryOverviewModel.instance:getActId()
	local stageCOList = Season123Config.instance:getStageCos(actId)

	for index, item in pairs(self._entryList) do
		local stageCO = stageCOList[index]
		local rs = Season123ProgressUtils.isStageUnlock(self.viewParam.actId, stageCO.stage)
		local needPlay = Season123EntryModel.instance:needPlayUnlockAnim1(self.viewParam.actId, stageCO.stage)

		if rs and needPlay then
			item.animtor:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_unlock)
			Season123EntryModel.instance:setAlreadyUnLock1(self.viewParam.actId, stageCO.stage)
		end
	end
end

return Season123_1_8EntryOverview
