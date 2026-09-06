-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collection/view/CollectionViewNew.lua

module("logic.extensions.collection.view.CollectionViewNew", package.seeall)

local CollectionViewNew = class("CollectionViewNew", TableViewComponent)

CollectionViewNew._curPlayType = 1

local PlayLaw = {
	LimitTime = 3,
	Idle = 1,
	Battle = 2
}

function CollectionViewNew:_getPath()
	return {
		cellPath = "cell",
		viewPath = "ScrollView"
	}
end

function CollectionViewNew:ctor()
	CollectionViewNew.super.ctor(self)
end

function CollectionViewNew:destroyUI()
	CollectionViewNew.super.destroyUI(self)
end

function CollectionViewNew:onExitFinished()
	CollectionViewNew.super.onExitFinished(self)
end

function CollectionViewNew:onEnterFinished()
	CollectionViewNew.super.onEnterFinished(self)
end

function CollectionViewNew:unbindEvents()
	CollectionViewNew.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnBattle:RemoveClickListener()
	self._btnIdle:RemoveClickListener()
	self._btnLimitTime:RemoveClickListener()
end

function CollectionViewNew:bindEvents()
	CollectionViewNew.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnBattle:AddClickListener(self._onClickBtnBattle, self)
	self._btnIdle:AddClickListener(self._onClickBtnIdle, self)
	self._btnLimitTime:AddClickListener(self._onClickBtnLimitTime, self)
end

function CollectionViewNew:onExit()
	removetimer(self._tickCollectionView, self)
	print("exit CollectionViewNew")

	for k, v in pairs(PlayLaw) do
		RedPointController.instance:unregRedPoint(self.playLawList[v].redpoint)
	end

	GuideController.instance:setViewVar("collection_list_move_end", nil)

	if self.tween then
		self.tween:Kill(false)

		self.tween = nil
	end

	if self.tween2 then
		self.tween2:Kill(false)

		self.tween2 = nil
	end

	self._expedFinishStamp = nil

	CollectionViewNew.super.onExit(self)
end

function CollectionViewNew:buildUI()
	CollectionViewNew.super.buildUI(self)

	self._closeButton = self:getBtn("lefttop/btnClose")
	self._BattleSelectGo = self:getGo("btnBattle/select")
	self._IdleSelectGo = self:getGo("btnIdle/select")
	self._LimitTimeSelectGo = self:getGo("btnLimitTime/select")
	self.btnList = {}

	table.insert(self.btnList, self._BattleSelectGo)
	table.insert(self.btnList, self._IdleSelectGo)
	table.insert(self.btnList, self._LimitTimeSelectGo)

	self.playLawList = {}

	for k, v in pairs(PlayLaw) do
		local single = {}

		single.select = self:getGo("btn" .. k .. "/select")
		single.redpoint = self:getGo("btn" .. k .. "/imgRed")
		self.playLawList[v] = single
	end

	self._btnBattle = self:getBtn("btnBattle")
	self._btnIdle = self:getBtn("btnIdle")
	self._btnLimitTime = self:getBtn("btnLimitTime")
	self.animators = {}
	self.effectCells = {}
end

function CollectionViewNew:onEnter()
	CollectionViewNew.super.onEnter(self)

	for k, v in pairs(PlayLaw) do
		local data = CollectionModel.instance:getPlayListByType(v)

		if data then
			local repointIds = {}

			for _, single in pairs(data) do
				local ids = single.redpointID

				if type(ids) == "table" then
					for _, idd in pairs(ids) do
						if idd then
							table.insert(repointIds, idd)
						end
					end
				elseif ids then
					table.insert(repointIds, ids)
				end
			end

			RedPointController.instance:regRedPoint(self.playLawList[v].redpoint, unpack(repointIds))
		end
	end

	self._curPlayType = CollectionModel.instance:getCurrTabIdx()
	self._curViewDatas = self:_handledPlayList(CollectionModel.instance:getPlayListByType(self._curPlayType) or {})

	self:_refresh(false)
	settimer(1, self._tickCollectionView, self)
end

function CollectionViewNew:_clearTableview(cell)
	local rewards = {}

	for i = 1, 3 do
		rewards[i] = goutil.findChild(cell, "reward/item" .. i)

		goutil.setActive(rewards[i], false)
		MaterialMgr.resetAll(rewards[i])
	end
end

function CollectionViewNew:_updateCell(view, cell, data)
	local _imgIcon = goutil.findChildComponent(cell, "imgIcon", "UIImageSpriteChange")
	local _goLock = goutil.findChild(cell, "lock")
	local _goOnGoing = goutil.findChild(cell, "txtOnGoing")
	local _txtGoOnGoing = goutil.findChildTextComponent(cell, "txtOnGoing")
	local _txtLock = goutil.findChildComponent(cell, "lock/txtLock", "Text")
	local _redpoint = goutil.findChild(cell, "imgPoint")
	local _goTime = goutil.findChild(cell, "textTime")
	local _textTime = goutil.findChildComponent(cell, "textTime", "Text")
	local _back = goutil.findChild(cell, "back")
	local _back_2 = goutil.findChild(cell, "back_2")
	local _double = goutil.findChild(cell, "double")
	local txtResetTime = goutil.findChildTextComponent(cell, "txtResetTime")
	local _title = goutil.findChild(cell, "title")
	local _txtTitle = goutil.findChildTextComponent(cell, "title/txt")
	local rewards = {}

	for i = 1, 3 do
		rewards[i] = goutil.findChild(cell, "reward/item" .. i)
	end

	local prize = data.prize
	local lockTimeTips

	GameUtil.SetActive(_back_2, false)
	GameUtil.SetActive(_title, false)

	if data.funcId == 725 and string.nilorempty(data.prize) then
		local seasonId = SeasonModel.instance:getSeasonId()
		local seasonPrize = SeasonConfig.instance:getSeasonModeMainRewardBySeasonId(seasonId).keyPrize

		if not string.nilorempty(seasonPrize) then
			prize = seasonPrize
		end
	end

	if not string.nilorempty(data.prize) then
		local list = string.split(data.prize, "#")
		local count = #list

		count = count < 3 and count or 3

		for i = 1, 3 do
			if i <= count then
				goutil.setActive(rewards[i], true)
				MaterialMgr.resetAll(rewards[i])
				MaterialMgr.setCellByCfg(list[i], rewards[i])
			else
				goutil.setActive(rewards[i], false)
				MaterialMgr.resetAll(rewards[i])
			end
		end
	else
		for i = 1, 3 do
			MaterialMgr.resetAll(rewards[i])
		end
	end

	local cag = cell:GetComponent("CanvasGroup")

	cag.alpha = 1

	local imgIdx = checknumber(data.imgIdx)
	local _funcId = checknumber(data.funcId)
	local _cfg = FuncOpenConfig.instance:getFunctionOpenById(_funcId)
	local funcIsOpen

	if _cfg ~= nil then
		funcIsOpen = FuncOpenController.instance:getConditionReached(_cfg.openCondition)

		_imgIcon:SetState(imgIdx - 1)

		local repointIds = data.redpointID

		if repointIds then
			local dot = false

			if type(repointIds) == "table" then
				for _, id in pairs(repointIds) do
					dot = RedPointModel.instance:isActive(id)

					if dot then
						break
					end
				end
			else
				dot = RedPointModel.instance:isActive(repointIds)
			end

			goutil.setActive(_redpoint, dot and funcIsOpen)
		else
			goutil.setActive(_redpoint, false)
		end
	end

	local isOpenTime = false

	if data.tab == PlayLaw.LimitTime then
		goutil.setActive(_goTime, true)

		local sr = "开启时间"
		local goingStr = "进行中..."
		local isNeedGoOnGoing = false

		if data.funcId == 91 then
			local time = EscortConfig.instance:GetBaxBaseInfo().openTimes

			for i = 1, #time do
				local beginTime = string.format("%02d:%02d", time[i].startHour, time[i].startMin)
				local endTime = string.format("%02d:%02d", time[i].endHour, time[i].endMin)

				sr = sr .. "\n" .. beginTime .. "-" .. endTime

				if GameUtil.checkIsInTimePeriod(beginTime, endTime, true) then
					isOpenTime = true
				end
			end

			goutil.setActive(_redpoint, false)

			isNeedGoOnGoing = funcIsOpen and isOpenTime
		elseif data.funcId == 93 then
			local now = ServerTime.now()
			local curDate = GameUtil.time2date(now - 18000)
			local _worldBossCommonConfig = WorldBossConfig.instance:getWorldBossCommonConfig()
			local _bossFightEndTime = _worldBossCommonConfig.BOSS_FIGHT_END_TIME.value * 60
			local _bossTimeList = WorldBossConfig.instance:getWorldBossLayoutByGameDay(now)

			for i, v in ipairs(_bossTimeList) do
				local stamp = string.split(v.time, ":")
				local startTime = os.time({
					year = curDate.year,
					month = curDate.month,
					day = curDate.day,
					hour = stamp[1],
					min = stamp[2],
					sec = stamp[3]
				})
				local begin = GameUtil.time2date(startTime)
				local over = GameUtil.time2date(startTime + _bossFightEndTime)
				local beginTime = string.format("%02d:%02d", begin.hour, begin.min)
				local endTime = string.format("%02d:%02d", over.hour, over.min)

				sr = over.hour < begin.hour and sr .. "\n" .. beginTime .. "-次日" .. endTime or sr .. "\n" .. beginTime .. "-" .. endTime

				if GameUtil.checkIsInTimePeriod(beginTime, endTime, true) then
					isOpenTime = true
				end
			end

			goutil.setActive(_redpoint, false)

			isNeedGoOnGoing = funcIsOpen and isOpenTime
		elseif data.funcId == 297 then
			local begin = AnswerSceneModel.instance:getQuestionStartDate()
			local beginTime = string.format("%02d:%02d", begin.hour, begin.min)
			local over = AnswerSceneModel.instance:getQuestionEndDate()
			local endTime = string.format("%02d:%02d", over.hour, over.min)

			sr = sr .. "\n" .. beginTime .. "-" .. endTime

			if GameUtil.checkIsInTimePeriod(beginTime, endTime, true) then
				isOpenTime = true
			end

			goutil.setActive(_redpoint, false)

			isNeedGoOnGoing = funcIsOpen and isOpenTime
		elseif data.funcId == 725 then
			isOpenTime = true

			local seasonId = SeasonModel.instance:getSeasonId()
			local seasonData = SeasonConfig.instance:getSeasonConfigBySeasonId(seasonId)
			local openDate, endDate = GameUtil.string2date(seasonData.startTime), GameUtil.string2date(seasonData.endTime)
			local beginTime = string.format("%d月%d日 %02d:%02d", openDate.month, openDate.day, openDate.hour, openDate.min)
			local endTime = string.format("%d月%d日 %02d:%02d", endDate.month, endDate.day, endDate.hour, endDate.min)

			sr = sr .. "\n" .. beginTime .. "-" .. endTime
			isNeedGoOnGoing = funcIsOpen and isOpenTime

			if not GameUtil.checkIsInTimePeriod(seasonData.startTime, seasonData.endTime) then
				goingStr = "赛季已结束"
				isNeedGoOnGoing = true
			end
		end

		_textTime.text = sr
		_txtGoOnGoing.text = goingStr

		goutil.setActive(_back, funcIsOpen and isOpenTime)

		_txtLock.text = "尚未开启"

		goutil.setActive(_goLock, not funcIsOpen or not isOpenTime)
		goutil.setActive(_goOnGoing, isNeedGoOnGoing)
	else
		isOpenTime = FuncOpenController.instance:getConditionReached(nil, _cfg.openTime)

		if not funcIsOpen or not isOpenTime then
			_txtLock.text = not string.nilorempty(_cfg.lockedTips) and _cfg.lockedTips or FuncOpenController.instance:getConditionLockTips(_cfg.openCondition)
		end

		goutil.setActive(_goTime, false)
		goutil.setActive(_back, false)
		goutil.setActive(_goLock, not funcIsOpen or not isOpenTime)
		goutil.setActive(_goOnGoing, false)

		if data.tab == PlayLaw.Battle and data.funcId == 69 then
			local isSeasonLock = RankRaceController.instance:isSeasonLock()

			goutil.setActive(_goLock, not funcIsOpen or not isOpenTime or isSeasonLock)

			if isSeasonLock then
				goutil.setActive(_goTime, true)

				_textTime.text = "下一个赛季\n" .. RankRaceController.instance:getNextSeasonTimeStr()
			end
		end

		if data.funcId == 729 then
			goutil.setActive(_back, true)
			goutil.setActive(_goTime, true)

			_textTime.text = PeakTournamentConfig.instance:getPtCommonValue("QUALIFIER_RANK_SHOW_TIME")
		end
	end

	if _funcId == 1138 then
		local textTimeStr = ""
		local goOnGoingStr = ""
		local lockStr = "尚未开启"

		if not funcIsOpen then
			isOpenTime = false
			lockStr = not string.nilorempty(_cfg.lockedTips) and _cfg.lockedTips or FuncOpenController.instance:getConditionLockTips(_cfg.openCondition)
		else
			local nextSeasonId = 0
			local newestSeasonId = KingArenaController.instance:getNewestSeasonId()
			local next = newestSeasonId + 1
			local nextSeasonData = KingArenaConfig.instance:getSeasonData(next)

			if nextSeasonData then
				nextSeasonId = next
			end

			if KingArenaController.instance:isInTimeOfSeason(newestSeasonId) then
				local seasonData = KingArenaConfig.instance:getSeasonData(newestSeasonId)
				local sStamp, eStamp = GameUtil.string2time(seasonData.openTime), GameUtil.string2time(seasonData.endTime)
				local nowStamp = ServerTime.now()
				local formatTime = KingArenaController.instance:FormatTimeWords(Mathf.Max(eStamp - nowStamp, 0))

				textTimeStr = string.format("赛季剩余\n%s", formatTime)

				local newestPeriodId = 0
				local nextPeriodId = 0
				local newestPeriodCfg = KingArenaConfig.instance:getPeriodCfg(newestSeasonId)

				if newestPeriodCfg then
					for _, v in ipairs(newestPeriodCfg) do
						local timePeriod = GameUtil.getTimePeriod(v.openTime, v.endTime)

						if timePeriod < GameUtil.inTimePeriod then
							break
						elseif timePeriod == GameUtil.inTimePeriod then
							newestPeriodId = v.periodId

							break
						elseif timePeriod > GameUtil.inTimePeriod then
							newestPeriodId = v.periodId
						end
					end

					local next = newestPeriodId + 1
					local nextPeriodData = KingArenaConfig.instance:getPeriodData(newestSeasonId, next)

					if nextPeriodData then
						nextPeriodId = next
					end
				end

				if KingArenaController.instance:isInTimeOfSeasonPeriod(newestSeasonId, newestPeriodId) then
					local periodData = KingArenaConfig.instance:getPeriodData(newestSeasonId, newestPeriodId)
					local sStamp, eStamp = GameUtil.string2time(periodData.openTime), GameUtil.string2time(periodData.endTime)
					local nowStamp = ServerTime.now()
					local formatTime = KingArenaController.instance:FormatTimeWords(Mathf.Max(eStamp - nowStamp, 0))

					goOnGoingStr = string.format("本周比赛剩余\n%s", formatTime)
				else
					local periodData = KingArenaConfig.instance:getPeriodData(newestSeasonId, nextPeriodId)

					if periodData then
						local sStamp, eStamp = GameUtil.string2time(periodData.openTime), GameUtil.string2time(periodData.endTime)
						local nowStamp = ServerTime.now()
						local endDate = GameUtil.time2date(eStamp)
						local formatTime = KingArenaController.instance:FormatTimeWords(Mathf.Max(sStamp - nowStamp, 0))

						goOnGoingStr = string.format("距离下次竞技开启\n%s", formatTime)
					end
				end
			else
				isOpenTime = false

				local nextSeasonData = KingArenaConfig.instance:getSeasonData(nextSeasonId)

				if nextSeasonData then
					local sd = GameUtil.string2date(nextSeasonData.openTime)

					lockStr = string.format("下一个赛季\n%02d.%02d.%02d %02d:%02d\n开启", sd.year, sd.month, sd.day, sd.hour, sd.min)
					lockTimeTips = string.format("%02d.%02d.%02d %02d:%02d开启", sd.year, sd.month, sd.day, sd.hour, sd.min)
				else
					lockStr = "赛季未开启"
					lockTimeTips = "赛季未开启"
				end
			end
		end

		_txtTitle.text = textTimeStr

		goutil.setActive(_title, not string.nilorempty(textTimeStr))

		_txtGoOnGoing.text = goOnGoingStr

		goutil.setActive(_goOnGoing, not string.nilorempty(goOnGoingStr))
		goutil.setActive(_back_2, GameUtil.GetActive(_goOnGoing))

		_txtLock.text = lockStr

		goutil.setActive(_goLock, not funcIsOpen or not isOpenTime)
	end

	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCell, self, _cfg, cell, funcIsOpen, isOpenTime, data.reportBehavior, lockTimeTips))

	local isDouble = false

	if _funcId == 52 then
		isDouble = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.Expedition)
		isDouble = isDouble or NewhandwelfareController.instance:isInNewPrivilegeTime()
	elseif _funcId == 172 then
		isDouble = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.EndlessAttack)
	elseif _funcId == 18 then
		isDouble = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.breachWorldPrize)
	end

	if txtResetTime then
		goutil.setActive(txtResetTime.gameObject, data.funcId == 52 and ExpeditionController.instance.todayHasPlay)
		self:_updateExpedFinishTime(txtResetTime)
	end

	goutil.setActive(_double, isDouble)
end

function CollectionViewNew:_onClickCell(cfg, cell, funcIsOpen, isOpenTime, reportBehavior, lockTimeTips)
	CollectionModel.instance:setOffset(self._tableview:GetOffset())

	local isOpen = funcIsOpen and isOpenTime

	if isOpen then
		if cfg.funcId == 91 then
			if FamilyController.instance:getFamilyLv() <= 0 then
				FloatWordMgr.instance:show("请加入一个家族")

				return
			end

			if not EscortModel.instance:IsOpenEscortView() then
				FloatWordMgr.instance:show("未到开放时间！")

				return
			end
		elseif cfg.funcId == 69 and RankRaceController.instance:isSeasonLock() then
			FloatWordMgr.instance:show("未到开放时间")

			return
		end

		if self.tween == nil then
			local function narrow()
				self.tween = nil
				self.tween2 = TweenUtil.ValueTo(0, 1, 0.2, function(val)
					local cag = cell:GetComponent("CanvasGroup")

					cag.alpha = val

					GameUtil.setLocalScale(cell, 2 - val)
				end, nil, self)
			end

			self.tween = TweenUtil.ValueTo(1, 0, 0.2, function(val)
				local cag = cell:GetComponent("CanvasGroup")

				cag.alpha = val

				GameUtil.setLocalScale(cell, 2 - val)
			end, function()
				narrow()

				if reportBehavior > 0 then
					SurveyController.instance:reportBehavior(reportBehavior)
				end

				FuncOpenController.instance:onClickFunc(cfg, GameUtil.handler(self._onClickClose, self))
			end, self)
		end
	elseif not funcIsOpen then
		FloatWordMgr.instance:show(cfg.lockedTips)
	elseif not isOpenTime then
		if not string.nilorempty(lockTimeTips) then
			FloatWordMgr.instance:show(lockTimeTips)
		else
			FloatWordMgr.instance:show("未到开放时间")
		end
	end
end

function CollectionViewNew:_onClickClose()
	CollectionModel.instance:setCurrTabIdx(nil)
	CollectionModel.instance:setOffset(0)
	self:close()
end

function CollectionViewNew:_onClickBtnBattle()
	self:_clickBtn(PlayLaw.Battle)
end

function CollectionViewNew:_onClickBtnIdle()
	self:_clickBtn(PlayLaw.Idle)
end

function CollectionViewNew:_onClickBtnLimitTime()
	self:_clickBtn(PlayLaw.LimitTime)
end

function CollectionViewNew:_clickBtn(playType)
	if playType == self._curPlayType then
		return
	end

	self._curPlayType = playType

	CollectionModel.instance:setCurrTabIdx(self._curPlayType)
	CollectionModel.instance:setOffset(0)
	self:_refresh()
end

function CollectionViewNew:_refresh(spring)
	self._tableview:SetOffsetWithoutRefresh(0)

	self._unfoldEffect = true

	if spring == nil then
		spring = true
	end

	self._isSpring = spring

	for k, v in pairs(self.playLawList) do
		GameUtil.SetActive(v.select, self._curPlayType == k)
	end

	self:updateListData(self:_handledPlayList(CollectionModel.instance:getPlayListByType(self._curPlayType)))
end

function CollectionViewNew:_handledPlayList(list)
	local newList = {}

	for i = 1, #list do
		local data = list[i]
		local _funcId = checknumber(data.funcId)

		if _funcId == 297 then
			local _cfg = FuncOpenConfig.instance:getFunctionOpenById(_funcId)

			if FuncOpenController.instance:getConditionReached(nil, _cfg.openTime) then
				table.insert(newList, data)
			end
		else
			table.insert(newList, data)
		end
	end

	return newList
end

function CollectionViewNew:_onReloadFinish()
	if self._unfoldEffect then
		self:_playEffect()
	else
		GuideController.instance:setViewVar("collection_list_move_end", self._curPlayType)
	end
end

function CollectionViewNew:_playEffect()
	for i, k in pairs(self.effectCells) do
		k:Stop()
	end

	table.clear(self.effectCells)

	self.playEndCount = 0

	local visibleCount = self._tableview:GetVisibleCount() - 1

	for i = 0, visibleCount do
		local cell = self._tableview:GetCellByIndex(i)
		local x, y = self:_cellSize()
		local offsetX = 14

		cell.transform.localPosition = Vector3.New(x / 2, y / 2, 0)

		local effect = cell:GetComponent(UnityTweensType.TweenPositionBy)

		table.insert(self.effectCells, effect)

		self.effectCells[i + 1].positionBy = Vector3.New((x + offsetX) * i, 0, 0)

		self.effectCells[i + 1]:Begin()
		effect:AddListener(self.onPlayEffectFinish, self)
	end

	self._unfoldEffect = false
end

function CollectionViewNew:onPlayEffectFinish(eff)
	eff:RemoveListener()

	local len = #self.effectCells

	self.playEndCount = checknumber(self.playEndCount) + 1

	if len <= self.playEndCount then
		GuideController.instance:setViewVar("collection_list_move_end", self._curPlayType)
	end
end

function CollectionViewNew:_cellSize()
	return 266, 540
end

function CollectionViewNew:_tickCollectionView()
	local cnt = self._tableview:GetVisibleCount() - 1

	for i = 0, cnt do
		local cell = self._tableview:GetCellByIndex(i)
		local data = self._curViewDatas[cell.index + 1]

		if data.funcId == 52 then
			local txtResetTime = goutil.findChildTextComponent(cell.gameObject, "txtResetTime")

			self:_updateExpedFinishTime(txtResetTime)
		end
	end
end

function CollectionViewNew:_updateExpedFinishTime(text)
	if not text then
		return
	end

	if checknumber(self._expedFinishStamp) == 0 then
		self._expedFinishStamp = GameUtil.GetGameResetTimeStamp()
	end

	local leftTime = math.max(0, self._expedFinishStamp - ServerTime.nowMs() * 0.001)
	local hour, min, sec = GameUtil.getTimeHHMMSS(math.ceil(leftTime))

	text.text = string.format(lang("text_countdown_second"), hour, min, sec)

	if leftTime <= 0 then
		self._expedFinishStamp = nil

		removetimer(self._tickCollectionView, self)
		goutil.setActive(text.gameObject, false)
	end
end

return CollectionViewNew
