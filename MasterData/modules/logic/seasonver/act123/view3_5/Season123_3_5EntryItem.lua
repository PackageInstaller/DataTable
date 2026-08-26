-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EntryItem.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EntryItem", package.seeall)

local Season123_3_5EntryItem = class("Season123_3_5EntryItem", UserDataDispose)

function Season123_3_5EntryItem:ctor()
	self:__onInit()
end

function Season123_3_5EntryItem:dispose()
	TaskDispatcher.cancelTask(self._enterEpiosdeList, self)
	self:removeEvents()
	self:__onDispose()
end

function Season123_3_5EntryItem:init(viewGO, animator)
	self.viewGO = viewGO
	self.anim = animator

	self:initComponent()
end

function Season123_3_5EntryItem:initComponent()
	self._btnentrance = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_entrance")
	self._txtmapname = gohelper.findChildText(self.viewGO, "#txt_mapname")
	self._btnrecords = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_records")
	self._gonew = gohelper.findChild(self.viewGO, "#go_new")
	self._gofighting = gohelper.findChild(self.viewGO, "#go_fighting")
	self._gounlockline = gohelper.findChild(self.viewGO, "decorates/line")
	self._goprogress = gohelper.findChild(self.viewGO, "progress")
	self._txtCurrent = gohelper.findChildTextMesh(self.viewGO, "progress/#go_progress/#txt_current")
	self._txtTotal = gohelper.findChildTextMesh(self.viewGO, "progress/#go_progress/#txt_total")
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._txtunlocktime = gohelper.findChildText(self.viewGO, "#go_locked/#txt_lockedtime")

	self._btnentrance:AddClickListener(self._btnentranceOnClick, self)
	self._btnrecords:AddClickListener(self._btnrecordsOnClick, self)

	self._goRed = gohelper.findChild(self.viewGO, "#txt_mapname/#go_stageRedDot")
	self.animLock = self._golocked:GetComponent(gohelper.Type_Animator)

	TaskDispatcher.runRepeat(self.refreshLockRepeat, self, 3)
end

function Season123_3_5EntryItem:removeEvents()
	self._btnentrance:RemoveClickListener()
	self._btnrecords:RemoveClickListener()
	TaskDispatcher.cancelTask(self.refreshLockRepeat, self)
end

function Season123_3_5EntryItem:initData(actId)
	self._actId = actId

	self:refreshUI()
end

function Season123_3_5EntryItem:refreshUI()
	self._stageId = Season123EntryModel.instance:getCurrentStage()

	RedDotController.instance:addRedDot(self._goRed, RedDotEnum.DotNode.Season123StageRewardNew, self._stageId)

	if not self._stageId then
		return
	end

	local stageCO = Season123Config.instance:getStageCo(self._actId, self._stageId)

	if stageCO then
		self._txtmapname.text = stageCO.name
	end

	gohelper.setActive(self._gofighting, false)
	self:refreshLock()
	self:refreshProgress()
	self:refreshNew()
	self:refreshRecordBtn()
end

function Season123_3_5EntryItem:refreshLock()
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
			self.animLock:Play(UIAnimationName.Unlock, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_unlock)
			Season123EntryModel.instance:setAlreadyUnLock(self._actId, self._stageId)
		else
			gohelper.setActive(self._golocked, false)
			gohelper.setActive(self._gounlockline, true)
			self.animLock:Play(UIAnimationName.Idle, 0, 0)

			self.animLock.speed = 1
		end
	else
		gohelper.setActive(self._gounlockline, false)
		gohelper.setActive(self._golocked, true)
		self.animLock:Play(UIAnimationName.Idle, 0, 0)

		self.animLock.speed = 1
	end
end

function Season123_3_5EntryItem:refreshProgress()
	local isShowStar = Season123ProgressUtils.isStageUnlock(self._actId, self._stageId)

	gohelper.setActive(self._goprogress, isShowStar)
	gohelper.setActive(self._gounlockline, isShowStar)

	if isShowStar then
		local seasonMO = Season123Model.instance:getActInfo(self._actId)
		local stageMO = seasonMO:getStageMO(self._stageId)
		local current, total = stageMO:getProgressStar()

		self._txtCurrent.text = tostring(current)
		self._txtTotal.text = tostring(total)
	end
end

function Season123_3_5EntryItem:refreshNew()
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

function Season123_3_5EntryItem:refreshRecordBtn()
	gohelper.setActive(self._btnrecords, false)
end

function Season123_3_5EntryItem:refreshLockRepeat()
	self:refreshLock()
	self:refreshProgress()
end

function Season123_3_5EntryItem:_btnentranceOnClick()
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

function Season123_3_5EntryItem:_enterEpiosdeList()
	ViewMgr.instance:openView(Season123Controller.instance:getEpisodeListViewName(), {
		actId = Season123EntryModel.instance.activityId,
		stage = self._stageId
	})
end

function Season123_3_5EntryItem:_btnrecordsOnClick()
	Season123EntryController.instance:openStageRecords(self._stageId)
end

return Season123_3_5EntryItem
