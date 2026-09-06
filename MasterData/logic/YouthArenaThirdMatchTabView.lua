-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdMatchTabView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdMatchTabView", package.seeall)

local YouthArenaThirdMatchTabView = class("YouthArenaThirdMatchTabView", ViewComponent)
local TITLE_STATE = {
	[YouthArenaThirdEnum.MatchStepId.Qualifier] = 0,
	[YouthArenaThirdEnum.MatchStepId.ScoreMatch] = 1,
	[YouthArenaThirdEnum.MatchStepId.Fun] = 2
}

function YouthArenaThirdMatchTabView:ctor()
	YouthArenaThirdMatchTabView.super.ctor(self)
end

function YouthArenaThirdMatchTabView:buildUI()
	YouthArenaThirdMatchTabView.super.buildUI(self)

	self._imgTitleChange = self:getGo("imgTitle"):GetComponent("UIImageSpriteChange")
	self._txtScheduleTime1 = self:getTxt("schedules/time1/txt")
	self._scheduleTime2Root = self:getGo("schedules/time2")
	self._txtScheduleTime2 = self:getTxt("schedules/time2/txt")
	self._headRoot = self:getGo("playerInfo/headRoot")
	self._txtName = self:getTxt("playerInfo/txtName")
	self._txtMyRank = self:getTxt("playerInfo/txtMyRank")
	self._txtMyScore = self:getTxt("playerInfo/txtMyScore")
	self._openHoursRoot = self:getGo("openHours")
	self._txtOpenHours = self:getTxt("openHours/txtTime")
	self._prizeTimesRoot = self:getGo("prizeTimes")
	self._txtPrizeTimes = self:getTxt("prizeTimes/txt1")
	self._btnPk1 = self:getGo("btnPk1")
	self._btnPk2 = self:getGo("btnPk2")
	self._txtActTime = self:getTxt("opentime/txt")
	self._buffCol = self:getGo("buffCol")
	self._tagBuffEmpty = self:getGo("buffCol/tagEmpty")
	self._buffScrollerList = ScrollerList.create(self:getGo("buffCol/scrView"), self:getGo("buffCol/scrCell"), GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function YouthArenaThirdMatchTabView:bindEvents()
	YouthArenaThirdMatchTabView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnPk1, self._onClickBtnPk1, self)
	GameUtil.addClickHandler(self._btnPk2, self._onClickBtnPk2, self)
end

function YouthArenaThirdMatchTabView:unbindEvents()
	YouthArenaThirdMatchTabView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPk1)
	GameUtil.rmClickHandler(self._btnPk2)
end

function YouthArenaThirdMatchTabView:onEnter()
	YouthArenaThirdMatchTabView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetInfoRes, self._refreshProtocolInfo, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetQualifierInfoRes, self._handleQualifierInfo, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3NotifyStepChangeRes, self._handleStepChange, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._tabData = params[2]
	self._actCfg = YouthArenaThirdConfig.instance:getActivityData(self._activityId)

	self:_refreshMatchStage()
	self:_refreshStaticInfo()
	self:_refreshProtocolInfo()
	self:_sendQualifierInfoReq()
end

function YouthArenaThirdMatchTabView:onExit()
	YouthArenaThirdMatchTabView.super.onExit(self)

	if self._buffScrollerList then
		self._buffScrollerList:dispose()
	end

	HeadItemController.instance:resetHeadCell(self._headRoot)
end

function YouthArenaThirdMatchTabView:_refreshStaticInfo()
	local openHours = self:_formatOpenHours()

	self:_refreshScheduleTime()

	self._txtOpenHours.text = openHours
	self._txtActTime.text = ActivityDefineController.instance:getActTimeDesc(YouthArenaThirdController.instance:getActivityType(), self._activityId)

	if self._imgTitleChange then
		self._imgTitleChange:SetState(TITLE_STATE[self._stepId] or 0)
	end

	goutil.setActive(self._openHoursRoot, openHours ~= "全天开放")
	goutil.setActive(self._prizeTimesRoot, self:_isShowPrizeTimes())
	self:_refreshBuffList()
end

function YouthArenaThirdMatchTabView:_refreshProtocolInfo()
	local subMo = YouthArenaThirdController.instance:getSubMo(self._activityId)
	local qualifierInfo = subMo:getQualifierInfo(self._stepId, YouthArenaThirdEnum.BattleMode.One)

	if qualifierInfo then
		if not qualifierInfo.rankScore then
			local rankScore = 0

			if qualifierInfo then
				if not qualifierInfo.rank then
					local rank = 0

					if qualifierInfo then
						if not qualifierInfo.dailyFightTimes then
							local dailyFightTimes = 0

							if self._actCfg then
								if not self._actCfg.dailyMatchPrizeTimes then
									local dailyMatchPrizeTimes = 0
									local leftTimes = math.max(dailyMatchPrizeTimes - checknumber(dailyFightTimes), 0)
									local headInfo = RoleModel.instance:getHeadInfo()

									self._txtMyScore.text = string.format("我的积分：%s", rankScore)
									self._txtPrizeTimes.text = string.format("今日剩余奖励次数：%s", leftTimes)
									self._txtName.text = string.format("s%03d-%s", RoleModel.instance:getAreaId(), RoleModel.instance:getUserName())
									self._txtMyRank.text = string.format("我的排名：%s", self:_formatRank(rank))

									HeadItemController.instance:setHeadCellByInfo(self._headRoot, headInfo)
								end
							end
						end
					end
				end
			end
		end
	end
end

function YouthArenaThirdMatchTabView:_formatRank(rank)
	if self._stepId == YouthArenaThirdEnum.MatchStepId.Fun then
		return "无"
	end

	rank = checknumber(rank)

	return rank > 0 and tostring(rank) or "未上榜"
end

function YouthArenaThirdMatchTabView:_handleQualifierInfo(activityId, stepId, mode)
	if checknumber(activityId) ~= self._activityId or checknumber(stepId) ~= self._stepId or checknumber(mode) ~= YouthArenaThirdEnum.BattleMode.One then
		return
	end

	self:_refreshProtocolInfo()
end

function YouthArenaThirdMatchTabView:_handleStepChange()
	self:_refreshMatchStage()
	self:_refreshStaticInfo()
	self:_refreshProtocolInfo()
	self:_sendQualifierInfoReq()
end

function YouthArenaThirdMatchTabView:_refreshMatchStage()
	self._stepId = self:_getCurrentMatchStepId()
	self._matchCfg = YouthArenaThirdConfig.instance:getMatchData(self._activityId, self._stepId)
end

function YouthArenaThirdMatchTabView:_getCurrentMatchStepId()
	if self._tabData and self._tabData.key == YouthArenaThirdEnum.TabKey.Qualifier then
		local funStartCfg = YouthArenaThirdConfig.instance:getStepData(self._activityId, YouthArenaThirdEnum.TimeStepId.ScoreMatchStart)
		local funStartStamp = funStartCfg and GameUtil.string2time(funStartCfg.startTime) or 0

		if funStartStamp > 0 and funStartStamp <= ServerTime.now() then
			return YouthArenaThirdEnum.MatchStepId.Fun
		end

		return YouthArenaThirdEnum.MatchStepId.Qualifier
	end

	return checknumber(self._tabData and self._tabData.matchStepId)
end

function YouthArenaThirdMatchTabView:_sendQualifierInfoReq()
	if checknumber(self._activityId) <= 0 or checknumber(self._stepId) <= 0 then
		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetQualifierInfoReq(self._activityId, self._stepId, YouthArenaThirdEnum.BattleMode.One)
end

function YouthArenaThirdMatchTabView:_isShowPrizeTimes()
	return self._stepId ~= YouthArenaThirdEnum.MatchStepId.ScoreMatch
end

function YouthArenaThirdMatchTabView:_refreshBuffList()
	local buffPlanId = checknumber((self._matchCfg or nil) and self._matchCfg.buffPlanId)
	local list = buffPlanId > 0 and YouthArenaThirdConfig.instance:getBuffPlanDatas(buffPlanId) or {}

	goutil.setActive(self._buffCol, true)
	goutil.setActive(self._tagBuffEmpty, #list <= 0)
	self._buffScrollerList:reloadData(list)
end

function YouthArenaThirdMatchTabView:_updateBuffCell(view, cell, data, tag)
	if not cell.gameObject then
		local go = cell
		local item = goutil.findChild(go, "item")
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
		local raceId = checknumber(data.raceId)

		MaterialMgr.resetAll(item)

		if raceId > 0 then
			MaterialMgr.setCellByCfg(string.format("%s:%s:1", MatType.Pet, raceId), item)
		end

		txtName.text = self:_getPetName(raceId)
		txtDesc.text = data.desc
	end
end

function YouthArenaThirdMatchTabView:_clearBuffCell(cell)
	if not cell.gameObject then
		local go = cell
		local item = goutil.findChild(go, "item")

		MaterialMgr.resetAll(item)
	end
end

function YouthArenaThirdMatchTabView:_getPetName(raceId)
	local cfg = MaterialMgr.getMatCfg(MatType.Pet, raceId)

	return (cfg or nil) and (cfg.name or "")
end

function YouthArenaThirdMatchTabView:_refreshScheduleTime()
	if self._tabData then
		local isQualifierTab = self._tabData.key == YouthArenaThirdEnum.TabKey.Qualifier

		if isQualifierTab then
			self._txtScheduleTime1.text = self:_formatScheduleTime("预选赛", YouthArenaThirdEnum.TimeStepId.QualifierStart, YouthArenaThirdEnum.TimeStepId.ScoreMatchStart)
			self._txtScheduleTime2.text = self:_formatScheduleTime("娱乐赛", YouthArenaThirdEnum.TimeStepId.ScoreMatchStart, nil)
		else
			self._txtScheduleTime1.text = self:_formatScheduleTime("积分赛", YouthArenaThirdEnum.TimeStepId.ScoreMatchStart, YouthArenaThirdEnum.TimeStepId.KnockoutStart)
		end

		goutil.setActive(self._scheduleTime2Root, isQualifierTab)
	end
end

function YouthArenaThirdMatchTabView:_formatScheduleTime(name, startStepId, endStepId)
	local startCfg = YouthArenaThirdConfig.instance:getStepData(self._activityId, startStepId)
	local endCfg = checknumber(endStepId) > 0 and YouthArenaThirdConfig.instance:getStepData(self._activityId, endStepId) or nil

	if endCfg then
		if not endCfg.startTime then
			local endTime = self:_getActivityEndTime()

			return string.format("%s：%s - %s", name, self:_formatTimeStr(startCfg and startCfg.startTime), self:_formatTimeStr(endTime))
		end
	end
end

function YouthArenaThirdMatchTabView:_getActivityEndTime()
	local actDefineCfg = ActivityDefineConfig.instance:getCfgByActivitYId(self._activityId)

	return actDefineCfg and actDefineCfg.endTime
end

function YouthArenaThirdMatchTabView:_formatOpenHours()
	if self._matchCfg then
		if not self._matchCfg.closedTimeRange then
			local closedTimeRange = ""

			if string.nilorempty(closedTimeRange) then
				return "全天开放"
			end

			local arr = string.split(closedTimeRange, "-")
			local closeStart = arr[1]
			local closeEnd = arr[2]

			if string.nilorempty(closeStart) or string.nilorempty(closeEnd) then
				return "全天开放"
			end

			local prefix = self:_getSecondInDay(closeStart) <= self:_getSecondInDay(closeEnd) and "次日" or ""

			return string.format("%s-%s%s", self:_formatHourMinute(closeEnd), prefix, self:_formatHourMinute(closeStart))
		end
	end
end

function YouthArenaThirdMatchTabView:_formatTimeStr(timeStr)
	if string.nilorempty(timeStr) then
		return ""
	end

	local date = GameUtil.time2date(GameUtil.string2time(timeStr))

	return string.format("%02d.%02d %02d:%02d", date.month, date.day, date.hour, date.min)
end

function YouthArenaThirdMatchTabView:_formatHourMinute(timeStr)
	local arr = string.split(timeStr, ":")

	return string.format("%02d:%02d", checknumber(arr[1]), checknumber(arr[2]))
end

function YouthArenaThirdMatchTabView:_getSecondInDay(timeStr)
	local arr = string.split(timeStr, ":")

	return checknumber(arr[1]) * 3600 + checknumber(arr[2]) * 60 + checknumber(arr[3])
end

function YouthArenaThirdMatchTabView:_onClickBtnPk1()
	self:_openMatchHall(YouthArenaThirdEnum.BattleMode.One)
end

function YouthArenaThirdMatchTabView:_onClickBtnPk2()
	self:_openMatchHall(YouthArenaThirdEnum.BattleMode.Three)
end

function YouthArenaThirdMatchTabView:_openMatchHall(mode)
	if not YouthArenaThirdController.instance:checkMatchFightAvailable(self._activityId, self._stepId, true) then
		return
	end

	UIStateManager.instance:push(ViewName.YouthArenaThirdMatchHallView, self._activityId, self._stepId, mode)
end

return YouthArenaThirdMatchTabView
