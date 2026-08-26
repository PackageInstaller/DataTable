-- chunkname: @modules/logic/seasonver/act123/view/Season123EntryItem.lua

module("modules.logic.seasonver.act123.view.Season123EntryItem", package.seeall)

local Season123EntryItem = class("Season123EntryItem", UserDataDispose)

function Season123EntryItem:ctor()
	self:__onInit()
end

function Season123EntryItem:dispose()
	TaskDispatcher.cancelTask(self._enterEpiosdeList, self)
	self:removeEvents()
	self:__onDispose()
end

function Season123EntryItem:init(viewGO, animator)
	self.viewGO = viewGO
	self.anim = animator

	self:initComponent()
end

function Season123EntryItem:initComponent()
	self._btnentrance = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_entrance")
	self._txtpassround = gohelper.findChildText(self.viewGO, "#go_time/#txt_time")
	self._txtmapname = gohelper.findChildText(self.viewGO, "#txt_mapname")
	self._gotime = gohelper.findChild(self.viewGO, "#go_time")
	self._btnrecords = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_records")
	self._gonew = gohelper.findChild(self.viewGO, "#go_new")
	self._gofighting = gohelper.findChild(self.viewGO, "#go_fighting")
	self._gounlockline = gohelper.findChild(self.viewGO, "decorates/line")
	self._goprogress = gohelper.findChild(self.viewGO, "progress")
	self._progressActives = self:getUserDataTb_()
	self._progressDeactives = self:getUserDataTb_()
	self._progressHard = self:getUserDataTb_()
	self._progressAnim = self:getUserDataTb_()

	for i = 1, Activity123Enum.SeasonStageStepCount do
		self._progressActives[i] = gohelper.findChild(self.viewGO, string.format("progress/#go_progress%s/light", i))
		self._progressDeactives[i] = gohelper.findChild(self.viewGO, string.format("progress/#go_progress%s/dark", i))
		self._progressHard[i] = gohelper.findChild(self.viewGO, string.format("progress/#go_progress%s/red", i))
		self._progressAnim[i] = gohelper.findChild(self.viewGO, string.format("progress/#go_progress%s/levelup", i))
	end

	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._txtunlocktime = gohelper.findChildText(self.viewGO, "#go_locked/#txt_lockedtime")

	self._btnentrance:AddClickListener(self._btnentranceOnClick, self)
	self._btnrecords:AddClickListener(self._btnrecordsOnClick, self)

	self.animLock = self._golocked:GetComponent(gohelper.Type_Animator)

	TaskDispatcher.runRepeat(self.refreshLockRepeat, self, 3)
end

function Season123EntryItem:removeEvents()
	self._btnentrance:RemoveClickListener()
	self._btnrecords:RemoveClickListener()
	TaskDispatcher.cancelTask(self.refreshLockRepeat, self)
end

function Season123EntryItem:initData(actId)
	self._actId = actId

	self:refreshUI()
end

function Season123EntryItem:refreshUI()
	self._stageId = Season123EntryModel.instance:getCurrentStage()

	if not self._stageId then
		return
	end

	local stageCO = Season123Config.instance:getStageCo(self._actId, self._stageId)

	if stageCO then
		self._txtmapname.text = stageCO.name
	end

	gohelper.setActive(self._gofighting, Season123ProgressUtils.stageInChallenge(self._actId, self._stageId))
	self:refreshRound()
	self:refreshLock()
	self:refreshProgress()
	self:refreshNew()
	self:refreshRecordBtn()
end

function Season123EntryItem:refreshRound()
	local seasonMO = Season123Model.instance:getActInfo(self._actId)

	if seasonMO then
		local stageMO = seasonMO:getStageMO(self._stageId)

		if stageMO and stageMO:alreadyPass() then
			local round = stageMO.minRound

			if round == 0 then
				gohelper.setActive(self._gotime, false)
			else
				gohelper.setActive(self._gotime, true)

				self._txtpassround.text = tostring(round)
			end
		else
			gohelper.setActive(self._gotime, false)
		end
	else
		gohelper.setActive(self._gotime, false)
	end
end

function Season123EntryItem:refreshLock()
	local rs, reason, value = Season123ProgressUtils.isStageUnlock(self._actId, self._stageId)

	if reason == Activity123Enum.PreCondition.OpenTime then
		if value.showSec then
			local timeStr = string.format("%s%s", TimeUtil.secondToRoughTime2(value.remainTime))

			self._txtunlocktime.text = string.format(luaLang("season123_overview_unlocktime_custom"), timeStr)
		else
			self._txtunlocktime.text = string.format(luaLang("season123_overview_unlocktime"), value.day)
		end
	else
		self._txtunlocktime.text = string.format(luaLang("season123_entry_is_lock"), value)
	end

	if rs then
		if Season123EntryModel.instance:needPlayUnlockAnim(self._actId, self._stageId) then
			gohelper.setActive(self._gounlockline, false)
			gohelper.setActive(self._golocked, true)
			self.animLock:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_unlock)
			Season123EntryModel.instance:setAlreadyUnLock(self._actId, self._stageId)
		else
			gohelper.setActive(self._golocked, false)
			gohelper.setActive(self._gounlockline, true)
		end
	else
		gohelper.setActive(self._gounlockline, false)
		gohelper.setActive(self._golocked, true)
	end
end

function Season123EntryItem:refreshProgress()
	local isPass = Season123EntryModel.instance:stageIsPassed(self._stageId)
	local isShowStar = isPass

	gohelper.setActive(self._goprogress, isPass)

	if isPass then
		local curStageStep, maxStep = Season123ProgressUtils.getStageProgressStep(self._actId, self._stageId)

		isShowStar = isShowStar and maxStep > 0

		for i = 1, Activity123Enum.SeasonStageStepCount do
			local isActive = i <= curStageStep
			local keepActive = i <= maxStep

			gohelper.setActive(self._progressActives[i], isActive and i < maxStep)
			gohelper.setActive(self._progressDeactives[i], not isActive and keepActive)
			gohelper.setActive(self._progressHard[i], i == maxStep and curStageStep == maxStep)
		end
	end

	if self._gounlockline.activeSelf and not isShowStar then
		gohelper.setActive(self._gounlockline, false)
	end
end

function Season123EntryItem:refreshNew()
	local seasonMO = Season123Model.instance:getActInfo(self._actId)

	if not seasonMO then
		gohelper.setActive(self._gonew, false)

		return
	end

	local rs, reason, value = Season123ProgressUtils.isStageUnlock(self._actId, self._stageId)
	local stageMO = seasonMO:getStageMO(self._stageId)

	if not stageMO then
		gohelper.setActive(self._gonew, false)

		return
	end

	gohelper.setActive(self._gonew, rs and stageMO:isNeverTry())
end

function Season123EntryItem:refreshRecordBtn()
	local seasonMO = Season123Model.instance:getActInfo(self._actId)

	if not seasonMO then
		gohelper.setActive(self._btnrecords, false)

		return
	end

	local stageMO = seasonMO:getStageMO(self._stageId)

	gohelper.setActive(self._btnrecords, stageMO and stageMO.isPass)
end

function Season123EntryItem:refreshLockRepeat()
	self:refreshLock()
	self:refreshProgress()
end

function Season123EntryItem:_btnentranceOnClick()
	logNormal("_btnentranceOnClick ： " .. tostring(self._stageId))

	local actId = self._actId
	local actMO = Season123Model.instance:getActInfo(actId)
	local rs, reason, value = Season123ProgressUtils.isStageUnlock(self._actId, self._stageId)

	if rs then
		if Season123EntryController.instance:openStage(self._stageId) then
			self.anim:Play(UIAnimationName.Close)
			Season123Controller.instance:dispatchEvent(Season123Event.EnterEpiosdeList, true)
			TaskDispatcher.runDelay(self._enterEpiosdeList, self, 0.17)
		end
	else
		local stageCO = Season123Config.instance:getStageCo(self._actId, self._stageId)

		GameFacade.showToast(ToastEnum.SeasonStageLockTip, stageCO.name)
	end
end

function Season123EntryItem:_enterEpiosdeList()
	ViewMgr.instance:openView(Season123Controller.instance:getEpisodeListViewName(), {
		actId = Season123EntryModel.instance.activityId,
		stage = self._stageId
	})
end

function Season123EntryItem:_btnrecordsOnClick()
	Season123EntryController.instance:openStageRecords(self._stageId)
end

return Season123EntryItem
