-- chunkname: @modules/logic/versionactivity2_5/challenge/view/enter/Act183DailyGroupEntranceItem.lua

module("modules.logic.versionactivity2_5.challenge.view.enter.Act183DailyGroupEntranceItem", package.seeall)

local Act183DailyGroupEntranceItem = class("Act183DailyGroupEntranceItem", Act183BaseGroupEntranceItem)

function Act183DailyGroupEntranceItem.Get(goroot, gotemplate, groupMo, index)
	local groupType = groupMo and groupMo:getGroupType()
	local goname = "daily_" .. index
	local gopath = "root/right/#scroll_daily/Viewport/Content/" .. goname
	local go = gohelper.findChild(goroot, gopath)

	if gohelper.isNil(go) then
		go = gohelper.cloneInPlace(gotemplate, goname)
	end

	local cls = Act183Enum.GroupEntranceItemClsType[groupType]

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, cls, index)
end

function Act183DailyGroupEntranceItem:init(go)
	Act183DailyGroupEntranceItem.super.init(self, go)

	self._golock = gohelper.findChild(go, "go_lock")
	self._gounlock = gohelper.findChild(go, "go_unlock")
	self._goempty = gohelper.findChild(go, "go_Empty")
	self._gofinish = gohelper.findChild(go, "go_unlock/go_Finished")
	self._txtunlocktime = gohelper.findChildText(go, "go_lock/txt_unlocktime")
	self._txtindex = gohelper.findChildText(go, "go_unlock/txt_index")
	self._txtprogress = gohelper.findChildText(go, "go_unlock/txt_progress")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "btn_click")
	self._animlock = gohelper.onceAddComponent(self._golock, gohelper.Type_Animator)
	self._animfinish = gohelper.onceAddComponent(self._gofinish, gohelper.Type_Animator)
end

function Act183DailyGroupEntranceItem:addEventListeners()
	Act183DailyGroupEntranceItem.super.addEventListeners(self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function Act183DailyGroupEntranceItem:removeEventListeners()
	Act183DailyGroupEntranceItem.super.removeEventListeners(self)
	self._btnclick:RemoveClickListener()
end

function Act183DailyGroupEntranceItem:_btnclickOnClick()
	if not self._groupMo then
		return
	end

	local isLocked = self._status == Act183Enum.GroupStatus.Locked

	if isLocked then
		GameFacade.showToast(ToastEnum.Act183GroupNotOpen)

		return
	end

	local groupId = self._groupMo:getGroupId()
	local params = Act183Helper.generateDungeonViewParams(Act183Enum.GroupType.Daily, groupId)

	Act183Controller.instance:openAct183DungeonView(params)
end

function Act183DailyGroupEntranceItem:onUpdateMO(groupMo)
	Act183DailyGroupEntranceItem.super.onUpdateMO(self, groupMo)
	self:refreshUI()
end

function Act183DailyGroupEntranceItem:refreshUI()
	local isLocked = self._status == Act183Enum.GroupStatus.Locked

	gohelper.setActive(self._golock, false)
	gohelper.setActive(self._goempty, isLocked)
	gohelper.setActive(self._gounlock, not isLocked)

	if not isLocked then
		local taskCount, taskFinishCount = Act183Helper.getGroupEpisodeTaskProgress(self._actId, self._groupId)
		local isFinished = taskCount <= taskFinishCount

		self._txtindex.text = string.format("<color=#E1E1E14D>RT</color><color=#E1E1E180><size=77>%s</size></color>", self._index)
		self._txtprogress.text = string.format("%s/%s", taskFinishCount, taskCount)

		gohelper.setActive(self._gofinish, isFinished)
		self:tryPlayUnlockAnim()
	end
end

function Act183DailyGroupEntranceItem:showUnlockCountDown()
	local isLocked = self._status == Act183Enum.GroupStatus.Locked

	if not isLocked then
		return
	end

	gohelper.setActive(self._goempty, false)
	gohelper.setActive(self._golock, true)

	local date, dateFormat = TimeUtil.secondToRoughTime(self._groupMo:getUnlockRemainTime())

	self._txtunlocktime.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v2a5_challenge_mainview_unlock"), date, dateFormat)
end

function Act183DailyGroupEntranceItem:startPlayUnlockAnim()
	gohelper.setActive(self._golock, true)
	self._animlock:Play("unlock", 0, 0)
	self:onPlayUnlockAnimDone()
end

return Act183DailyGroupEntranceItem
