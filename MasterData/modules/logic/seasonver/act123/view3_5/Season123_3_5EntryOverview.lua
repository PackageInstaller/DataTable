-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EntryOverview.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EntryOverview", package.seeall)

local Season123_3_5EntryOverview = class("Season123_3_5EntryOverview", BaseView)

function Season123_3_5EntryOverview:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5EntryOverview:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Season123_3_5EntryOverview:removeEvents()
	self._btnclose:RemoveClickListener()
end

Season123_3_5EntryOverview.UI_Item_Count = 4

function Season123_3_5EntryOverview:_editableInitView()
	self._entryList = {}

	self:initItems()
end

function Season123_3_5EntryOverview:onDestroyView()
	if self._entryList then
		for index, item in ipairs(self._entryList) do
			item.btnclick:RemoveClickListener()
		end

		self._entryList = nil
	end

	Season123EntryOverviewController.instance:onCloseView()
	TaskDispatcher.cancelTask(self._closeCallback, self)
	TaskDispatcher.cancelTask(self._playUnlockAnim, self)
end

function Season123_3_5EntryOverview:onOpen()
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
end

function Season123_3_5EntryOverview:onClose()
	return
end

function Season123_3_5EntryOverview:refreshUI()
	self:refreshItems()
end

function Season123_3_5EntryOverview:refreshItems()
	local actId = Season123EntryOverviewModel.instance:getActId()
	local stageCOList = Season123Config.instance:getStageCos(actId)

	if stageCOList then
		for index = 1, Season123_3_5EntryOverview.UI_Item_Count do
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

function Season123_3_5EntryOverview:refreshItem(item, stageCO, stageMO)
	local actId = Season123EntryOverviewModel.instance:getActId()

	gohelper.setActive(item.gofighting, false)
	gohelper.setActive(item.gofinish, stageMO and stageMO:alreadyPass())

	item.txtpassround.text = stageMO and stageMO:alreadyPass() and tostring(stageMO.minRound or 0) or ""
	item.txtname.text = stageCO.name

	self:refreshProgress(item, stageCO, stageMO)
	self:refreshUnlockStatus(item, stageCO)
end

function Season123_3_5EntryOverview:refreshProgress(item, stageCO, stageMO)
	local rs = Season123ProgressUtils.isStageUnlock(self.viewParam.actId, stageCO.stage)

	gohelper.setActive(item.goprogress, rs)

	if not rs then
		return
	end

	local current, total = stageMO:getProgressStar()

	item.txtCurrentStar.text = tostring(current)
	item.txtTotalStar.text = tostring(total)
end

function Season123_3_5EntryOverview:refreshUnlockStatus(item, stageCO, stageMO)
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

function Season123_3_5EntryOverview:initItems()
	for i = 1, Season123_3_5EntryOverview.UI_Item_Count do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, "go_center/go_item" .. tostring(i))
		item.txtname = gohelper.findChildText(item.go, "#txt_name")
		item.imageicon = gohelper.findChildImage(item.go, "#image_icon")
		item.imagechapter = gohelper.findChildImage(item.go, "image_chapternum")
		item.gofinish = gohelper.findChild(item.go, "#image_finish")
		item.gofighting = gohelper.findChild(item.go, "#image_fighting")
		item.goprogress = gohelper.findChild(item.go, "#go_progress")
		item.txtCurrentStar = gohelper.findChildTextMesh(item.go, "#go_progress/#txt_current")
		item.txtTotalStar = gohelper.findChildTextMesh(item.go, "#go_progress/#txt_total")
		item.txtpassround = gohelper.findChildText(item.go, "#image_finish/#txt_time")
		item.btnclick = gohelper.findChildButton(item.go, "btn_click")

		item.btnclick:AddClickListener(self.onClickIndex, self, i)

		item.gounlocked = gohelper.findChild(item.go, "#image_locked")
		item.gounlockedtime = gohelper.findChild(item.go, "#image_unlockedtime")
		item.txtunlocktime = gohelper.findChildText(item.go, "#image_unlockedtime/#txt_time")
		item.animtor = item.go:GetComponent(gohelper.Type_Animator)
		self._entryList[i] = item
	end
end

function Season123_3_5EntryOverview:handleGetActInfo(actId)
	if self.viewParam.actId == actId then
		self:refreshUI()
	end
end

function Season123_3_5EntryOverview:onClickIndex(index)
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

function Season123_3_5EntryOverview:_btncloseOnClick()
	self._viewAnimator:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(self._closeCallback, self, 0.17)
end

function Season123_3_5EntryOverview:_closeCallback()
	self:closeThis()
end

function Season123_3_5EntryOverview:_playUnlockAnim()
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

return Season123_3_5EntryOverview
