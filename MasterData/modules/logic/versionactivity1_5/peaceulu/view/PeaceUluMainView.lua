-- chunkname: @modules/logic/versionactivity1_5/peaceulu/view/PeaceUluMainView.lua

module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluMainView", package.seeall)

local PeaceUluMainView = class("PeaceUluMainView", BaseView)

function PeaceUluMainView:onInitView()
	self._txtremaintime = gohelper.findChildText(self.viewGO, "left/remaintime/bg/#txt_remaintime")
	self._txttitle = gohelper.findChildText(self.viewGO, "left/#txt_title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "left/#txt_desc")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "right/progress/#scroll_view")
	self._imgfill = gohelper.findChildImage(self.viewGO, "right/progress/#scroll_view/Viewport/Content/fill/#go_fill")
	self._goContent = gohelper.findChild(self.viewGO, "right/progress/#scroll_view/Viewport/Content")
	self._goprogressitem = gohelper.findChild(self.viewGO, "right/progress/#scroll_view/Viewport/Content/#go_progressitem")
	self._txtschedule = gohelper.findChildText(self.viewGO, "right/progress/bg/#txt_schedule")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.bonusItemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PeaceUluMainView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._updateUI, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self.addEventCb(self, PeaceUluController.instance, PeaceUluEvent.OnUpdateInfo, self._updateUI, self)
	self.addEventCb(self, PeaceUluController.instance, PeaceUluEvent.onSwitchTab, self._toSwitchTab, self)
	self.addEventCb(self, self.viewContainer, PeaceUluEvent.onFinishTask, self.playFinishAnim, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function PeaceUluMainView:removeEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._updateUI, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self.removeEventCb(self, PeaceUluController.instance, PeaceUluEvent.OnUpdateInfo, self._updateUI, self)
	self.removeEventCb(self, PeaceUluController.instance, PeaceUluEvent.onSwitchTab, self._toSwitchTab, self)
	self.removeEventCb(self, self.viewContainer, PeaceUluEvent.onFinishTask, self.playFinishAnim, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function PeaceUluMainView:onOpen()
	self._animator:Play(UIAnimationName.Open, 0, 0)
	self._animator:Update(0)
	self:_initBonus()
	self:_initTaskMoList(true)

	local lastGameRecord = PeaceUluModel.instance:getLastGameRecord()

	if not string.nilorempty(lastGameRecord) then
		GameFacade.showToast(ToastEnum.PeaceUluMainViewTips, lastGameRecord)
		PeaceUluRpc.instance:sendAct145ClearGameRecordRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu)
	end

	self:_refreshRemainTime()
	self:_checkCanGetReward()
	self:_refreshSchedule()
end

function PeaceUluMainView:_refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_5Enum.ActivityId.PeaceUlu]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)

	if day >= 1 then
		self._txtremaintime.text = string.format(luaLang("remain"), string.format("%s%s%s%s", day, luaLang("time_day"), hour, luaLang("time_hour2")))

		return
	end

	if hour >= 1 then
		self._txtremaintime.text = string.format(luaLang("remain"), hour .. luaLang("time_hour2"))

		return
	end

	local minuteSecond = hourSecond % TimeUtil.OneHourSecond
	local minute = Mathf.Floor(minuteSecond / TimeUtil.OneMinuteSecond)

	if minute >= 1 then
		self._txtremaintime.text = string.format(luaLang("remain"), minute .. luaLang("time_minute2"))

		return
	end

	self._txtremaintime.text = string.format(luaLang("remain"), "<1" .. luaLang("time_minute2"))
end

function PeaceUluMainView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CharacterBackpackView then
		PeaceUluRpc.instance:sendGet145InfosRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu)
	end
end

function PeaceUluMainView:_editableInitView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#scroll_task"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self.viewContainer:getSetting().otherRes[1]
	scrollParam.cellClass = PeaceUluTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1160
	scrollParam.cellHeight = 160
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	self._csListView = SLFramework.UGUI.ListScrollView.Get(gohelper.findChild(self.viewGO, "right/#scroll_task"))
	self._scrolltaskview = LuaListScrollView.New(PeaceUluTaskModel.instance, scrollParam)

	self:addChildView(self._scrolltaskview)

	self._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._scrolltaskview)

	self._taskAnimRemoveItem:setMoveInterval(0)
	self._taskAnimRemoveItem:setMoveAnimationTime(PeaceUluEnum.TaskMaskTime - PeaceUluEnum.TaskGetAnimTime)
end

function PeaceUluMainView:playFinishAnim(index)
	if index then
		self._tweenIndexes = {
			index
		}
	end

	TaskDispatcher.runDelay(self.delayPlayFinishAnim, self, PeaceUluEnum.TaskGetAnimTime)
end

function PeaceUluMainView:delayPlayFinishAnim()
	self._taskAnimRemoveItem:removeByIndexs(self._tweenIndexes)
end

function PeaceUluMainView:_initBonus()
	local path = self.viewContainer:getSetting().otherRes[2]
	local content = gohelper.findChild(self._scrollview.gameObject, "Viewport/Content")
	local bonusCo = PeaceUluConfig.instance:getBonusCoList()

	for i, v in ipairs(bonusCo) do
		local item = self.bonusItemList[i]

		if not item then
			local child = self:getResInst(path, content, "bonus" .. i)

			item = PeaceUluProgressItem.New()

			item:init(child.gameObject)
			item:initMo(i, v)
			table.insert(self.bonusItemList, item)
		end

		item:refreshProgress()
	end
end

function PeaceUluMainView:_updateUI()
	self:_refreshSchedule()
	self:_checkCanGetReward()
	self:refreshBonusItem()
	self:_initTaskMoList()
	self:_refreshRemainTime()
end

function PeaceUluMainView:_refreshSchedule()
	self._imgfill.fillAmount = PeaceUluModel.instance:getSchedule()

	local maxNum = PeaceUluConfig.instance:getMaxProgress()
	local havenum = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act145).quantity

	self._txtschedule.text = havenum .. "/" .. maxNum

	local num = self:_getnextIndex() - 1
	local space = 40
	local progresswidth = 268
	local width = (progresswidth - space) * num - 174

	if self._dotweenId then
		ZProj.TweenHelper.KillById(self._dotweenId)

		self._dotweenId = nil
	end

	self._dotweenId = ZProj.TweenHelper.DOAnchorPosX(self._goContent.transform, -width, 0.2)
end

function PeaceUluMainView:_getnextIndex()
	local bonusCoList = PeaceUluConfig.instance:getBonusCoList()
	local havenum = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act145).quantity

	for index, co in ipairs(bonusCoList) do
		local needProgressCo = string.split(co.needProgress, "#")
		local targetNum = needProgressCo[3]

		if havenum <= tonumber(targetNum) then
			return index
		end
	end

	return #bonusCoList
end

function PeaceUluMainView:_checkCanGetReward()
	local bonusCoList = PeaceUluConfig.instance:getBonusCoList()
	local havenum = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act145).quantity

	for index, co in ipairs(bonusCoList) do
		local needProgressCo = string.split(co.needProgress, "#")
		local targetNum = needProgressCo[3]

		if havenum >= tonumber(targetNum) and not PeaceUluModel.instance:checkGetReward(co.id) then
			PeaceUluRpc.instance:sendAct145GetRewardsRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu)

			break
		end
	end
end

function PeaceUluMainView:_initTaskMoList(open)
	PeaceUluTaskModel.instance:sortTaskMoList(open)
end

function PeaceUluMainView:refreshBonusItem()
	for _, item in ipairs(self.bonusItemList) do
		item:refreshProgress()
	end
end

function PeaceUluMainView:_onDailyRefresh()
	PeaceUluRpc.instance:sendGet145InfosRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu)
end

function PeaceUluMainView:_toSwitchTab(tabIndex)
	self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, tabIndex)
end

function PeaceUluMainView:onClose()
	TaskDispatcher.cancelTask(self.delayPlayFinishAnim, self)
end

function PeaceUluMainView:onDestroyView()
	for _, v in ipairs(self.bonusItemList) do
		v:onDestroyView()
	end
end

return PeaceUluMainView
