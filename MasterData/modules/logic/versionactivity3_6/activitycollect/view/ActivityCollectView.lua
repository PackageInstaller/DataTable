-- chunkname: @modules/logic/versionactivity3_6/activitycollect/view/ActivityCollectView.lua

module("modules.logic.versionactivity3_6.activitycollect.view.ActivityCollectView", package.seeall)

local ActivityCollectView = class("ActivityCollectView", BaseView)

function ActivityCollectView:onInitView()
	self._goactivity1 = gohelper.findChild(self.viewGO, "root/#go_activity1")
	self._goact1limittime = gohelper.findChild(self.viewGO, "root/#go_activity1/#go_act1limittime")
	self._txtact1limittime = gohelper.findChildText(self.viewGO, "root/#go_activity1/#go_act1limittime/#txt_act1limittime")
	self._goact1opentime = gohelper.findChild(self.viewGO, "root/#go_activity1/#go_act1opentime")
	self._txtact1opentime = gohelper.findChildText(self.viewGO, "root/#go_activity1/#go_act1opentime/#txt_act1opentime")
	self._btnact1jump = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_activity1/#btn_act1jump")
	self._goact1rewardicon = gohelper.findChild(self.viewGO, "root/#go_activity1/go_reward/#go_act1rewardicon")
	self._goactivity2 = gohelper.findChild(self.viewGO, "root/#go_activity2")
	self._goact2limittime = gohelper.findChild(self.viewGO, "root/#go_activity2/#go_act2limittime")
	self._txtact2limittime = gohelper.findChildText(self.viewGO, "root/#go_activity2/#go_act2limittime/#txt_act2limittime")
	self._goact2opentime = gohelper.findChild(self.viewGO, "root/#go_activity2/#go_act2opentime")
	self._txtact2opentime = gohelper.findChildText(self.viewGO, "root/#go_activity2/#go_act2opentime/#txt_act2opentime")
	self._btnact2jump = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_activity2/#btn_act2jump")
	self._goactivity3 = gohelper.findChild(self.viewGO, "root/#go_activity3")
	self._btnact3jump = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_activity3/#btn_act3jump")
	self._goactivity4 = gohelper.findChild(self.viewGO, "root/#go_activity4")
	self._btnact4jump = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_activity4/#btn_act4jump")
	self._goactivitysign = gohelper.findChild(self.viewGO, "root/#go_activitysign")
	self._goactsignreward1 = gohelper.findChild(self.viewGO, "root/#go_activitysign/#go_actsignreward1")
	self._goactsignreward2 = gohelper.findChild(self.viewGO, "root/#go_activitysign/#go_actsignreward2")
	self._goactsignreward3 = gohelper.findChild(self.viewGO, "root/#go_activitysign/#go_actsignreward3")
	self._goactivity5 = gohelper.findChild(self.viewGO, "root/#go_activity5")
	self._btnact5jump = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_activity5/#btn_act5jump")
	self._txtact5num = gohelper.findChildText(self.viewGO, "root/#go_activity5/#txt_act5num")
	self._goact5icon = gohelper.findChild(self.viewGO, "root/#go_activity5/#txt_act5num/icon")
	self._txtact5limit = gohelper.findChildText(self.viewGO, "root/#go_activity5/#txt_act5limit")
	self._goactivity6 = gohelper.findChild(self.viewGO, "root/#go_activity6")
	self._btnact6jump = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_activity6/#btn_act6jump")
	self._txtact6num = gohelper.findChildText(self.viewGO, "root/#go_activity6/#txt_act6num")
	self._goact6icon = gohelper.findChild(self.viewGO, "root/#go_activity6/#txt_act6num/icon")
	self._txtact6limit = gohelper.findChildText(self.viewGO, "root/#go_activity6/#txt_act6limit")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityCollectView:addEvents()
	self._btnact1jump:AddClickListener(self._btnact1jumpOnClick, self)
	self._btnact2jump:AddClickListener(self._btnact2jumpOnClick, self)
	self._btnact3jump:AddClickListener(self._btnact3jumpOnClick, self)
	self._btnact4jump:AddClickListener(self._btnact4jumpOnClick, self)
	self._btnact5jump:AddClickListener(self._btnact5jumpOnClick, self)
	self._btnact6jump:AddClickListener(self._btnact6jumpOnClick, self)
end

function ActivityCollectView:removeEvents()
	self._btnact1jump:RemoveClickListener()
	self._btnact2jump:RemoveClickListener()
	self._btnact3jump:RemoveClickListener()
	self._btnact4jump:RemoveClickListener()
	self._btnact5jump:RemoveClickListener()
	self._btnact6jump:RemoveClickListener()
end

function ActivityCollectView:_btnact1jumpOnClick()
	local co = ActivityCollectConfig.instance:getPublicityCfg(1, self._actId)

	if not co or not co.jumpId or co.jumpId <= 0 then
		return
	end

	GameFacade.jump(co.jumpId)
end

function ActivityCollectView:_btnact2jumpOnClick()
	local co = ActivityCollectConfig.instance:getPublicityCfg(2, self._actId)

	if not co or not co.jumpId or co.jumpId <= 0 then
		return
	end

	GameFacade.jump(co.jumpId)
end

function ActivityCollectView:_btnact3jumpOnClick()
	local co = ActivityCollectConfig.instance:getPublicityCfg(3, self._actId)

	if not co or not co.jumpId or co.jumpId <= 0 then
		return
	end

	GameFacade.jump(co.jumpId)
end

function ActivityCollectView:_btnact4jumpOnClick()
	local co = ActivityCollectConfig.instance:getPublicityCfg(4, self._actId)

	if not co or not co.jumpId or co.jumpId <= 0 then
		return
	end

	GameFacade.jump(co.jumpId)
end

function ActivityCollectView:_btnact5jumpOnClick()
	local co = ActivityCollectConfig.instance:getPublicityCfg(5, self._actId)

	if not co or not co.jumpId or co.jumpId <= 0 then
		return
	end

	GameFacade.jump(co.jumpId)
end

function ActivityCollectView:_btnact6jumpOnClick()
	local co = ActivityCollectConfig.instance:getPublicityCfg(6, self._actId)

	if not co or not co.jumpId or co.jumpId <= 0 then
		return
	end

	GameFacade.jump(co.jumpId)
end

function ActivityCollectView:_onActSignRewardClick(index)
	local infos = ActivityType101Model.instance:getType101Info(self._actId)

	if not infos[index] then
		return
	end

	if infos[index].state == ActivityEnum.Act101RewardState.Available then
		Activity101Rpc.instance:sendGet101BonusRequest(self._actId, index)
	else
		local rewardList = {}
		local act101Co = ActivityConfig.instance:getNorSignActivityCo(self._actId, index)
		local rewards = string.split(act101Co.bonus, "|")

		for _, rewardCo in ipairs(rewards) do
			local details = string.splitToNumber(rewardCo, "#")

			table.insert(rewardList, details)
		end

		MaterialTipController.instance:openPackageRewardDetailView(rewardList)
	end
end

function ActivityCollectView:_editableInitView()
	self._actId = ActivityCollectModel.instance:getCurActivityId()
	self._act1RewardItems = self:getUserDataTb_()
	self._actSignItems = self:getUserDataTb_()

	self:_addSelfEvents()
end

function ActivityCollectView:_addSelfEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._onRefreshSign, self)
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, self._onRefreshWeekWalk, self)
end

function ActivityCollectView:_removeSelfEvents()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._onRefreshSign, self)
	self.removeEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, self._onRefreshWeekWalk, self)
end

function ActivityCollectView:_onRefreshSign()
	self:_refreshSign()
end

function ActivityCollectView:_onRefreshWeekWalk()
	self:_refreshAct5()
	self:_refreshAct6()
end

function ActivityCollectView:onOpen()
	if self.viewParam then
		local parentGO = self.viewParam.parent

		gohelper.addChild(parentGO, self.viewGO)
	end

	self._actId = ActivityCollectModel.instance:getCurActivityId()
	self._config = ActivityConfig.instance:getActivityCo(self._actId)

	self:_refresh()
	self:_refreshTimes()
	TaskDispatcher.runRepeat(self._refreshTimes, self, 1)
end

function ActivityCollectView:_refresh()
	self:_refreshAct1()
	self:_refreshAct2()
	self:_refreshAct3()
	self:_refreshAct4()
	self:_refreshAct5()
	self:_refreshAct6()
	self:_refreshSign()
end

function ActivityCollectView:_refreshAct1()
	local co = ActivityCollectConfig.instance:getPublicityCfg(1, self._actId)

	if not co or not co.activityId or LuaUtil.isEmptyStr(co.activityId) then
		logError("请补充活动类型1的活动id数据！")

		return
	end

	local rewards = GameUtil.splitString2(co.activityBonus, true) or {}

	for i = 1, math.max(#rewards, #self._act1RewardItems) do
		if not self._act1RewardItems[i] then
			local go = gohelper.cloneInPlace(self._goact1rewardicon)

			self._act1RewardItems[i] = IconMgr.instance:getCommonPropItemIcon(go)
		end

		if rewards[i] then
			gohelper.setActive(self._act1RewardItems[i].go, true)
			self._act1RewardItems[i]:setMOValue(rewards[i][1], rewards[i][2], rewards[i][3] or 1, nil, true)
			self._act1RewardItems[i]:setScale(0.5)
			self._act1RewardItems[i]:isShowEquipAndItemCount(false)
			self._act1RewardItems[i]:hideEquipLvAndBreak(true)
		else
			gohelper.setActive(self._act1RewardItems[i].go, false)
		end
	end
end

function ActivityCollectView:_refreshAct2()
	return
end

function ActivityCollectView:_refreshAct3()
	return
end

function ActivityCollectView:_refreshAct4()
	return
end

function ActivityCollectView:_refreshAct5()
	local openId = OpenEnum.UnlockFunc.WeekWalk
	local isOpen = self:_isWeekWalkOpen(openId)

	gohelper.setActive(self._txtact5num.gameObject, isOpen)

	if not isOpen then
		return
	end

	local cur, total = WeekWalkTaskListModel.instance:getAllDeepTaskInfo()

	self._txtact5num.text = string.format("%s/%s", cur, total)
end

function ActivityCollectView:_isWeekWalkOpen(openId)
	local weekWalkInfo = WeekWalk_2Model.instance:getInfo()

	if not weekWalkInfo then
		return false
	end

	if not weekWalkInfo:isOpen() then
		return false
	end

	local info = WeekWalkModel.instance:getInfo()
	local mapLayerInfo = info and info:getMapInfoByLayer(WeekWalkEnum.LastShallowLayer)
	local isShallowLayerFinish = mapLayerInfo and mapLayerInfo.isFinished >= 1

	if not isShallowLayerFinish then
		return false
	end

	return OpenModel.instance:isFunctionUnlock(openId)
end

function ActivityCollectView:_refreshAct6()
	local openId = OpenEnum.UnlockFunc.WeekWalkHeart
	local isOpen = self:_isWeekWalkOpen(openId)

	gohelper.setActive(self._txtact6num.gameObject, isOpen)

	if not isOpen then
		return
	end

	local cur, total = WeekWalk_2TaskListModel.instance:getAllTaskInfo()

	self._txtact6num.text = string.format("%s/%s", cur, total)
end

function ActivityCollectView:_refreshSign()
	local infos = ActivityType101Model.instance:getType101Info(self._actId) or {}
	local loginCount = ActivityType101Model.instance:getType101LoginCount(self._actId)

	for i = 1, 3 do
		if not self._actSignItems[i] then
			self._actSignItems[i] = self:getUserDataTb_()
			self._actSignItems[i].go = self[string.format("_goactsignreward%s", i)]
			self._actSignItems[i].goget = gohelper.findChild(self._actSignItems[i].go, "go_get")
			self._actSignItems[i].gohasget = gohelper.findChild(self._actSignItems[i].go, "go_hasget")
			self._actSignItems[i].gotoday = gohelper.findChild(self._actSignItems[i].go, "go_today")
			self._actSignItems[i].gotomorrow = gohelper.findChild(self._actSignItems[i].go, "go_tomorrow")
			self._actSignItems[i].btnclaim = gohelper.findChildButtonWithAudio(self._actSignItems[i].go, "btn_claim")

			self._actSignItems[i].btnclaim:AddClickListener(self._onActSignRewardClick, self, i)
		end

		local data = infos[i]

		gohelper.setActive(self._actSignItems[i].go, data ~= nil)

		if data then
			local hasget = data.state == ActivityEnum.Act101RewardState.Received
			local couldGet = data.state == ActivityEnum.Act101RewardState.Available

			gohelper.setActive(self._actSignItems[i].btnclaim, true)
			gohelper.setActive(self._actSignItems[i].goget, couldGet)
			gohelper.setActive(self._actSignItems[i].gotoday, false)
			gohelper.setActive(self._actSignItems[i].gohasget, hasget)
			gohelper.setActive(self._actSignItems[i].gotomorrow, not hasget and loginCount == i - 1)
		end
	end
end

function ActivityCollectView:_refreshTimes()
	self:_refreshAct1Time()
	self:_refreshAct2Time()
	self:_refreshAct5Time()
	self:_refreshAct6Time()
end

function ActivityCollectView:_refreshAct1Time()
	local co = ActivityCollectConfig.instance:getPublicityCfg(1, self._actId)

	if not co or not co.activityId or LuaUtil.isEmptyStr(co.activityId) then
		return
	end

	local actId = tonumber(co.activityId)
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if not actInfoMo then
		return
	end

	local actCo = ActivityConfig.instance:getActivityCo(actId)
	local openId = actCo.openId

	if openId and openId ~= 0 then
		local isUnlock = OpenModel.instance:isFunctionUnlock(openId)

		if not isUnlock then
			self._txtact1opentime.text = luaLang("sp02_calendar_periphery_locked")

			gohelper.setActive(self._btnact1jump.gameObject, false)
			gohelper.setActive(self._goact1opentime, true)
			gohelper.setActive(self._goact1limittime, false)

			return
		end
	end

	local isOpen = actInfoMo and actInfoMo:isOpen()

	if not isOpen then
		local offsetSecond = actInfoMo:getRealStartTimeStamp() - ServerTime.now()
		local timeStr = TimeUtil.secondToRoughTime3(offsetSecond)

		self._txtact1opentime.text = string.format(luaLang("seasonmainview_timeopencondition"), timeStr)
	else
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		self._txtact1limittime.text = TimeUtil.secondToRoughTime3(offsetSecond)
	end

	gohelper.setActive(self._goact1opentime, not isOpen)
	gohelper.setActive(self._goact1limittime, isOpen)
	gohelper.setActive(self._btnact1jump.gameObject, isOpen)
end

function ActivityCollectView:_refreshAct2Time()
	local co = ActivityCollectConfig.instance:getPublicityCfg(2, self._actId)

	if not co or not co.activityId or co.activityId == 0 then
		return
	end

	local actId = tonumber(co.activityId)
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if not actInfoMo then
		return
	end

	local actCo = ActivityConfig.instance:getActivityCo(actId)
	local openId = actCo.openId

	if openId and openId ~= 0 then
		local isUnlock = OpenModel.instance:isFunctionUnlock(openId)

		if not isUnlock then
			local episodeId = OpenConfig.instance:getOpenCo(openId).episodeId
			local episodetxt = DungeonConfig.instance:getEpisodeDisplay(episodeId)

			self._txtact2opentime.text = formatLuaLang("dungeon_unlock_episode_mode", episodetxt)

			gohelper.setActive(self._btnact2jump.gameObject, false)
			gohelper.setActive(self._goact2opentime, true)
			gohelper.setActive(self._goact2limittime, false)

			return
		end
	end

	local isOpen = actInfoMo:isOpen()

	if not isOpen then
		local offsetSecond = actInfoMo:getRealStartTimeStamp() - ServerTime.now()
		local timeStr = TimeUtil.secondToRoughTime3(offsetSecond)

		self._txtact2opentime.text = string.format(luaLang("seasonmainview_timeopencondition"), timeStr)
	else
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		self._txtact2limittime.text = TimeUtil.secondToRoughTime3(offsetSecond)
	end

	gohelper.setActive(self._btnact2jump.gameObject, isOpen)
	gohelper.setActive(self._goact2opentime, not isOpen)
	gohelper.setActive(self._goact2limittime, isOpen)
end

function ActivityCollectView:_refreshAct5Time()
	local openId = OpenEnum.UnlockFunc.WeekWalk
	local isOpen = self:_isWeekWalkOpen(openId)

	if not isOpen then
		self._txtact5limit.text = luaLang("collectView_weekwalk_unlock_tip")

		return
	end

	local info = WeekWalkModel.instance:getInfo()
	local endTime = info.endTime

	if not endTime then
		return
	end

	local limitSec = info.endTime - ServerTime.now()

	if limitSec <= 0 then
		return
	end

	local time, format = TimeUtil.secondToRoughTime2(math.floor(limitSec))

	self._txtact5limit.text = GameUtil.getSubPlaceholderLuaLang(luaLang("weekwalkview_devicerestart"), {
		time .. format
	})
end

function ActivityCollectView:_refreshAct6Time()
	local openId = OpenEnum.UnlockFunc.WeekWalkHeart
	local isOpen = self:_isWeekWalkOpen(openId)

	if not isOpen then
		self._txtact6limit.text = luaLang("collectView_weekwalk_unlock_tip")

		return
	end

	local info = WeekWalk_2Model.instance:getInfo()
	local endTime = info.endTime

	if not endTime then
		return
	end

	local limitSec = endTime - ServerTime.now()

	if limitSec <= 0 then
		return
	end

	local time, format = TimeUtil.secondToRoughTime2(math.floor(limitSec))

	self._txtact6limit.text = GameUtil.getSubPlaceholderLuaLang(luaLang("weekwalkview_devicerestart"), {
		time .. format
	})
end

function ActivityCollectView:onClose()
	return
end

function ActivityCollectView:onDestroyView()
	self:_removeSelfEvents()
	TaskDispatcher.cancelTask(self._refreshTimes, self)

	if self._actSignItems then
		for _, v in ipairs(self._actSignItems) do
			v.btnclaim:RemoveClickListener()
		end

		self._actSignItems = nil
	end

	if self._act1RewardItems then
		for _, v in pairs(self._act1RewardItems) do
			v:onDestroy()
		end

		self._act1RewardItems = nil
	end
end

return ActivityCollectView
