-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/view/NewBreakFormationMainView.lua

module("logic.extensions.newbreakformation.view.NewBreakFormationMainView", package.seeall)

local NewBreakFormationMainView = class("NewBreakFormationMainView", ViewComponent)

NewBreakFormationMainView.weekDayNum = {
	[0] = lang("日"),
	lang("一"),
	lang("二"),
	lang("三"),
	lang("四"),
	lang("五"),
	lang("六"),
	(lang("日"))
}

function NewBreakFormationMainView:ctor()
	NewBreakFormationMainView.super.ctor(self)
end

function NewBreakFormationMainView:unbindEvents()
	NewBreakFormationMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnRule)

	for i, v in ipairs(self._stageInfoList) do
		GameUtil.rmClickHandler(v.btn)
	end
end

function NewBreakFormationMainView:bindEvents()
	NewBreakFormationMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)

	for i, v in ipairs(self._stageInfoList) do
		GameUtil.addClickHandler(v.btn, function()
			self:_onClickStage(i)
		end, self)
	end
end

function NewBreakFormationMainView:buildUI()
	NewBreakFormationMainView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._btnRule = self:getGo("static/btnTip")
	self._btnPrize = self:getGo("btnPrize")
	self._redPointPrize = self:getGo("btnPrize/redpoint")
	self._btnRank = self:getGo("btnRank")
	self._scoreGo = self:getGo("score")
	self._txtTotalScore = self:getTxt("score/txt")
	self._sliderScore = self:getSlider("score/blockSlider")
	self._rankGo = self:getGo("rank")
	self._rankImgChange = goutil.findChildComponent(self.mainGO, "rank/img", "UIImageSpriteChange")
	self._rankNameGo = self:getGo("rank/rankName")
	self._txtRank = self:getTxt("rank/rankName/txt")
	self._levelUpEffectGo = self:getGo("levelUpEffectGo")
	self._txtThemeBuff = self:getTxt("theme/txtDesc")
	self._txtTime = self:getTxt("openTime/txt")
	self._stageInfoList = {}

	for i = 1, 2 do
		local infoGo = {}

		infoGo.go = self:getGo("stage" .. i)
		infoGo.btn = self:getGo("stage" .. i)
		infoGo.txtScore = goutil.findChildTextComponent(infoGo.go, "score/txt")
		infoGo.txtName = goutil.findChildTextComponent(infoGo.go, "txtName")
		infoGo.txtOpenTime = goutil.findChildTextComponent(infoGo.go, "txtTime")
		infoGo.lockGo = goutil.findChild(infoGo.go, "imgLock")
		infoGo.stageCloseGo = goutil.findChild(infoGo.go, "txtClose")
		infoGo.openTip = goutil.findChild(infoGo.go, "openTip")
		self._stageInfoList[i] = infoGo
	end

	self._bgGo = self:getGo("static/bg")
end

function NewBreakFormationMainView:onExit()
	NewBreakFormationMainView.super.onExit(self)
	removetimer(self._clock, self)
	removetimer(self._refreshView, self)
	RedPointController.instance:unregRedPoint(self._redPointPrize)

	if self._mainEffect then
		UIEffectManager.instance:stopEffect(self._mainEffect)

		self._mainEffect = nil
	end

	if self._levelUpEffect then
		UIEffectManager.instance:stopEffect(self._levelUpEffect)

		self._levelUpEffect = nil
	end
end

function NewBreakFormationMainView:onEnter()
	NewBreakFormationMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_NewBreachFormationInfoRes, self._refreshView, self)

	local latestSeasonId

	self._seasonId, latestSeasonId = NewBreakFormationController.instance:getSeasonId()

	if self._seasonId < 0 and latestSeasonId then
		self._seasonId = latestSeasonId
	end

	self._targetTime = ServerTime.now() - 1

	if self._seasonId <= 0 then
		self:_refreshView()
	else
		NewBreachFormationAgent.instance:sendPM_NewBreachFormationInfoReq(self._seasonId)
	end

	RedPointController.instance:regRedPoint(self._redPointPrize, RedPointModel.ID_NEWBREAKFORMATION_PRIZE)

	local mainEffectPath = "20231222/pozhentianxia/fx_ui_pztx_fenwei.prefab"

	self._mainEffect = UIEffectManager.instance:playEffect(self, mainEffectPath, nil, 0, 0, true)

	self._mainEffect:setParent(self._bgGo.transform)
	self._mainEffect:setLocalPos(0, 0, 0)
	self._mainEffect:setScale(1)
end

function NewBreakFormationMainView:_refreshView()
	self:_refreshStageInfo()
	self:_refreshRankInfo()
end

function NewBreakFormationMainView:_refreshStageInfo()
	self._txtThemeBuff.text = lang("已结束")

	local isOpen = false
	local totalPeriodEndTime = ServerTime.now() - 1

	for i, v in ipairs(self._stageInfoList) do
		local var_9_0, var_9_1 = self:setTabInfo(i, v, totalPeriodEndTime)

		totalPeriodEndTime = var_9_1

		if var_9_0 == true then
			isOpen = true
		end
	end

	for i, v in ipairs(self._stageInfoList) do
		GameUtil.SetActive(v.stageCloseGo, not isOpen)

		if isOpen == false then
			GameUtil.SetActive(v.txtOpenTime, false)
		end
	end

	if totalPeriodEndTime > ServerTime.now() then
		self._targetTime = totalPeriodEndTime

		self:_clock()
		removetimer(self._clock, self)
		settimer(1, self._clock, self, true)
	else
		self._txtTime.text = lang("已结束")

		removetimer(self._clock, self)
		settimer(5, self._clock, self, true)
	end
end

function NewBreakFormationMainView:_refreshRankInfo()
	if self._seasonId <= 0 then
		GameUtil.SetActive(self._scoreGo, false)
		GameUtil.SetActive(self._rankGo, false)

		return
	else
		GameUtil.SetActive(self._scoreGo, true)
		GameUtil.SetActive(self._rankGo, true)
	end

	local totalScore = NewBreakFormationModel.instance:getTotalScoreBySeason(self._seasonId)
	local recordScore = NewBreakFormationModel.instance:getRecordScore(self._seasonId)
	local isLevelUp = false
	local seasonCfg = NewBreakFormationConfig.instance:getSeasonCfg(self._seasonId)
	local rankLevelCfgs = NewBreakFormationConfig.instance:getRankLevelCfg(seasonCfg.rankLevelPlanId)

	self._txtTotalScore.text = "0/0"
	self._txtRank.text = lang("未开放")

	self._sliderScore:SetValue(0)
	self._rankImgChange:SetState(0)

	local rankLevelCfg = rankLevelCfgs[1]

	if rankLevelCfgs then
		for i, v in ipairs(rankLevelCfgs) do
			if totalScore >= v.score then
				rankLevelCfg = v
			end
		end

		local recordLevelCfg

		if recordScore and recordScore ~= totalScore then
			recordLevelCfg = rankLevelCfgs[1]

			for i, v in ipairs(rankLevelCfgs) do
				if recordScore >= v.score then
					recordLevelCfg = v
				end
			end
		end

		if recordLevelCfg and recordLevelCfg ~= rankLevelCfg then
			NewBreakFormationModel.instance:clearRecordScore(self._seasonId)
			self._rankImgChange:ChangeSprite(recordLevelCfg.resImg)

			isLevelUp = true
		else
			self._rankImgChange:ChangeSprite(rankLevelCfg.resImg)
		end

		if rankLevelCfg.rankId >= #rankLevelCfgs then
			self._txtTotalScore.text = totalScore

			self._sliderScore:SetValue(1)
		else
			local nextLevelCfg = rankLevelCfgs[rankLevelCfg.rankId + 1]

			self._txtTotalScore.text = langPara("%d/%d", totalScore, nextLevelCfg.score)

			self._sliderScore:SetValue((totalScore - rankLevelCfg.score) / (nextLevelCfg.score - rankLevelCfg.score))
		end

		self._txtRank.text = rankLevelCfg.name
	end

	if isLevelUp == true then
		local levelUpEffectPath = "20231222/pozhentianxia/fx_ui_pztx_shengji.prefab"

		function loadDoneHandle()
			self._rankImgChange:ChangeSprite(rankLevelCfg.resImg)
		end

		function finishHandle()
			self:_refreshRankInfo()
		end

		self._levelUpEffect = UIEffectManager.instance:playEffect(self, levelUpEffectPath, nil, 0, 0, false, nil, finishHandle, loadDoneHandle)

		self._levelUpEffect:setParent(self._levelUpEffectGo.transform)
		self._levelUpEffect:setLocalPos(0, 0, 0)
		self._levelUpEffect:setScale(1)
	end
end

function NewBreakFormationMainView:setTabInfo(tabId, infoGo, totalPeriodEndTime)
	local tabCfg = NewBreakFormationConfig.instance:getTabCfg(self._seasonId, tabId)
	local periodId = tabCfg and NewBreakFormationController.instance:getPeriodId(tabCfg.periodPlanId) or 0
	local isOpen = false

	if periodId > 0 then
		local periodCfg = NewBreakFormationConfig.instance:getPeriodCfg(tabCfg.periodPlanId, periodId)
		local periodEndTime = GameUtil.string2time(periodCfg.endDateTime)

		if totalPeriodEndTime < periodEndTime then
			totalPeriodEndTime = periodEndTime
		end

		isOpen = GameUtil.checkTimeStr(tabCfg.openTime)
		self._txtThemeBuff.text = periodCfg.buffDesc
		infoGo.txtScore.text = langPara("当前积分: <color=#21B273FF>%d</color>", NewBreakFormationModel.instance:getTotalScoreByPeriod(self._seasonId, tabId, periodId))
	else
		infoGo.txtScore.text = ""

		removetimer(self._refreshView, self)
		settimer(5, self._refreshView, self, false)
	end

	if tabCfg then
		infoGo.txtOpenTime.text = tabCfg.openDesc
		infoGo.txtName.text = tabCfg.desc
	end

	GameUtil.SetActive(infoGo.lockGo, not isOpen)
	GameUtil.SetActive(infoGo.txtOpenTime, not isOpen)
	GameUtil.SetActive(infoGo.openTip, isOpen)

	return isOpen, totalPeriodEndTime
end

function NewBreakFormationMainView:getOpenTimeDesc(str)
	local startTime = 0

	if str == "全天" then
		if getStartTime then
			startTime = -1
		end

		return "全时段开放"
	else
		local arr = string.split(str, "|")
		local type = arr[1]
		local timeStr = arr[2]

		if type == "时段" then
			local tem = string.split(timeStr, ",")

			if getStartTime then
				startTime = GameUtil.string2time(tem[1])
			end

			local data1 = GameUtil.string2date(tem[1])
			local data2 = GameUtil.string2date(tem[2])

			return langPara("%d.%d %02d:%02d - %d.%d %02d:%02d开放", data1.month, data1.day, data1.hour, data1.min, data2.month, data2.day, data2.hour, data2.min)
		elseif type == "每周" then
			local timetable = GameUtil.time2date(nowTime)
			local tem = string.split(timeStr, "#")
			local daysStr = ""

			for k, v in pairs(tem) do
				local temArr = string.split(v, "@")
				local dayStr = temArr[1]
				local days = string.split(dayStr, "-")

				if #days > 1 then
					local a = checknumber(days[1])
					local len = checknumber(days[2])
					local stringDays = langPara("%s-%s", NewBreakFormationMainView.weekDayNum[a], NewBreakFormationMainView.weekDayNum[len])

					daysStr = string.nilorempty(daysStr) and stringDays or daysStr .. "、" .. stringDays
				else
					local d = checknumber(days[1])
					local stringDays = langPara("%s", NewBreakFormationMainView.weekDayNum[d])

					daysStr = string.nilorempty(daysStr) and stringDays or daysStr .. "、" .. stringDays
				end
			end

			return langPara("每周%s开放", daysStr)
		elseif type == "每月" then
			local tem = string.split(timeStr, "#")
			local daysStr = ""

			for k, v in pairs(tem) do
				local temArr = string.split(v, "@")
				local dayStr = temArr[1]
				local days = string.split(dayStr, "-")

				if #days > 1 then
					local a = checknumber(days[1])
					local len = checknumber(days[2])
					local stringDays = langPara("%d号-%d号", a, len)

					daysStr = string.nilorempty(daysStr) and stringDays or daysStr .. "、" .. stringDays
				else
					local d = checknumber(days[1])
					local stringDays = langPara("%d号", d)

					daysStr = string.nilorempty(daysStr) and stringDays or daysStr .. "、" .. stringDays
				end
			end

			return langPara("每月%s开放", daysStr)
		end
	end

	return lang("每周一、三、五开放")
end

function NewBreakFormationMainView:_clock()
	if self._targetTime < ServerTime.now() then
		local latestSeasonId

		self._seasonId, latestSeasonId = NewBreakFormationController.instance:getSeasonId()

		if self._seasonId < 0 and latestSeasonId then
			self._seasonId = latestSeasonId
		end

		if self._seasonId <= 0 then
			self:_refreshView()
		else
			NewBreachFormationAgent.instance:sendPM_NewBreachFormationInfoReq(self._seasonId)
		end

		return
	end

	self._txtTime.text = GameUtil.FormatTimeWords(self._targetTime - ServerTime.now())
end

function NewBreakFormationMainView:_onClickStage(stageId)
	if self._seasonId <= 0 then
		FloatWordMgr.instance:show(lang("未开放"))

		return
	end

	local tabCfg = NewBreakFormationConfig.instance:getTabCfg(self._seasonId, stageId)
	local periodId = NewBreakFormationController.instance:getPeriodId(tabCfg.periodPlanId)
	local isOpen = false

	if periodId > 0 then
		local periodCfg = NewBreakFormationConfig.instance:getPeriodCfg(tabCfg.periodPlanId, periodId)

		isOpen = GameUtil.checkTimeStr(tabCfg.openTime)
	end

	if isOpen == false then
		FloatWordMgr.instance:show(lang("未开放"))
	else
		UIStateManager.instance:push(ViewName.NewBreakFormationLevelView, self._seasonId, stageId)
	end
end

function NewBreakFormationMainView:_onClickPrize()
	UIStateManager.instance:push(ViewName.NewBreakFormationRewardView, self._seasonId)
end

function NewBreakFormationMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.NewBreakFormationRankView, self._seasonId)
end

function NewBreakFormationMainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "newbreakformation_rule")
end

return NewBreakFormationMainView
