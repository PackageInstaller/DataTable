-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpk/controller/RTPKSystem.lua

require("dm.gameplay.rtpk.model.RTPK")

EVT_RTPK_STARTMATCH = "EVT_RTPK_STARTMATCH"
EVT_RTPK_UPDATEINFO = "EVT_RTPK_UPDATEINFO"
EVT_RTPK_CANCELMATCH = "EVT_RTPK_CANCELMATCH"
EVT_RTPK_MATCHSUCC = "EVT_RTPK_MATCHSUCC"
EVT_REFRESH_GRADE_REWARD_DONE = "EVT_REFRESH_GRADE_REWARD_DONE"
RTPKSystem = class("RTPKSystem", legs.Actor)

RTPKSystem:has("_rtpkService", {
	is = "r"
}):injectWith("RTPKService")
RTPKSystem:has("_rtpvpController", {
	is = "r"
}):injectWith("RTPVPController")
RTPKSystem:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
RTPKSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
RTPKSystem:has("_rtpk", {
	is = "r"
})

RTPKSeasonStatus = {
	kNotCanMatch = 1,
	kShow = 2,
	kRest = 3,
	kCanMatch = 0
}
RTPKGradeRewardState = {
	kCanNotGet = 2,
	kHadGet = 3,
	kCanGet = 1
}
RTPKGetRewardType = {
	KGradeReward = 2,
	KDailyReward = 1
}

function RTPKSystem:initialize()
	super.initialize(self)

	self._rtpk = RTPK:new()
end

function RTPKSystem:tryEnter()
	if CommonUtils.GetSwitch("fn_arena_rtpk") then
		local systemKeeper = self:getInjector():getInstance("SystemKeeper")
		local unlock, tips = systemKeeper:isUnlock("RTPK")

		if unlock then
			self:requestRTPKInfo(function()
				local status = self._rtpk:getCurStatus()

				if status == RTPKSeasonStatus.kRest and self:getSeasonNextCD() <= 0 then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("RTPK_SeasonReset_Tip")
					}))

					return
				end

				if status == RTPKSeasonStatus.kRest then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("RTPK_NewSeason_Ready")
					}))

					return
				end

				local view = self:getInjector():getInstance("RTPKMainView")

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))
			end)
		else
			self:dispatch(ShowTipEvent({
				tip = tips
			}))
		end
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("ClubNew_UI_37")
		}))
	end
end

function RTPKSystem:switchRTPKMainView()
	self:requestRTPKInfo(function()
		local view = self:getInjector():getInstance("RTPKMainView")

		self:dispatch(ViewEvent:new(EVT_SWITCH_VIEW, view, nil, {}))
	end)
end

function RTPKSystem:checkShowRed()
	local status = self:getRTPKState()

	if (status == RTPKSeasonStatus.kNotCanMatch or status == RTPKSeasonStatus.kCanMatch) and self:isInMatchTime() then
		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local playerId = developSystem:getPlayer():getRid()
		local key = playerId .. "rtpk_entertime"
		local lastTime = cc.UserDefault:getInstance():getIntegerForKey(key, 0)
		local gameServerAgent = self:getInjector():getInstance(GameServerAgent)
		local curTime = gameServerAgent:remoteTimestamp()
		local isSameDay = TimeUtil:isSameDay(lastTime, curTime, {
			sec = 0,
			min = 0,
			hour = 5
		})

		if not isSameDay then
			return true
		end
	end

	if self:checkGradeRewardRedpoint() then
		return true
	end

	if self:checkWinTaskRewardRedpoint() then
		return true
	end

	return false
end

function RTPKSystem:checkMatchRed()
	local status = self:getRTPKState()

	if (status == RTPKSeasonStatus.kNotCanMatch or status == RTPKSeasonStatus.kCanMatch) and self:isInMatchTime() and self._rtpk:getLeftCount() > 0 then
		return true
	end

	return false
end

function RTPKSystem:checkDailyRewardRed()
	local rewardsData = self._rtpk:getDailyRewardData()

	for i, v in pairs(rewardsData) do
		if not v.getStatus and self._rtpk:getTodayCount() >= v.count then
			return true
		end
	end

	return false
end

function RTPKSystem:checkGradeRewardRedpoint()
	local status = self._rtpk:getCurStatus()

	if status == RTPKSeasonStatus.kRest then
		return false
	end

	local gradeInfo = self:getGradeConfigInfo()

	for i, v in ipairs(gradeInfo) do
		if v.state == RTPKGradeRewardState.kCanGet then
			return true
		end
	end

	return false
end

function RTPKSystem:checkWinTaskRewardRedpoint()
	local status = self._rtpk:getCurStatus()

	if status == RTPKSeasonStatus.kRest then
		return false
	end

	local data = self._rtpk:getWinTaskData()

	for i, v in ipairs(data) do
		if v.state == RTPKGradeRewardState.kCanGet then
			return true
		end
	end

	return false
end

function RTPKSystem:enterRewardView()
	local data = {}
	local view = self:getInjector():getInstance("RTPKRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, nil))
end

function RTPKSystem:getMaxMatchTimes()
	local config = ConfigReader:getRecordById("Reset", "PTPK_Reset")

	return config.ResetSystem.setValue
end

function RTPKSystem:getDailyOpenTime()
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local curTime = gameServerAgent:remoteTimestamp()
	local date = TimeUtil:remoteDate("*t", curTime)
	local timeConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "RTPK_OpenTime", "content")
	local timeList = {}

	for i, v in pairs(timeConfig) do
		local time = string.split(v, "-")
		local startT = TimeUtil:parseTime({}, time[1])
		local startTime = TimeUtil:timeByRemoteDate({
			year = date.year,
			month = date.month,
			day = date.day,
			hour = startT.hour,
			min = startT.min,
			sec = startT.sec
		})
		local endT = TimeUtil:parseTime({}, time[2])
		local endTime = TimeUtil:timeByRemoteDate({
			year = date.year,
			month = date.month,
			day = date.day,
			hour = endT.hour,
			min = endT.min,
			sec = endT.sec
		})

		timeList[#timeList + 1] = {
			startTime = startTime,
			endTime = endTime
		}
	end

	return timeList
end

function RTPKSystem:isInMatchTime()
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local curTime = gameServerAgent:remoteTimestamp()
	local openTime = self:getDailyOpenTime()

	for i, v in pairs(openTime) do
		if curTime >= v.startTime and curTime <= v.endTime then
			return true
		end
	end

	return false
end

function RTPKSystem:formatMatchTimeParam()
	local openTime = self:getDailyOpenTime()
	local param = {}

	for i = 1, #openTime do
		param["startTime" .. i] = TimeUtil:localDate("%H:%M", openTime[i].startTime)
		param["endTime" .. i] = TimeUtil:localDate("%H:%M", openTime[i].endTime)
	end

	return param
end

function RTPKSystem:getSeasonBuffData()
	local ruleId = self._rtpk:getSeasonRule()
	local ruleConfig = ConfigReader:getRecordById("RTPKRule", ruleId)
	local ruleMap = {}
	local heroes = ruleConfig.ExcellentHero

	if heroes and table.nums(heroes) > 0 then
		local list = {}

		for i, v in pairs(heroes) do
			local skillConfig = ConfigReader:getRecordById("Skill", v.Effect)

			for _, heroId in pairs(v.Hero) do
				local heroConfig = ConfigReader:getRecordById("HeroBase", heroId)

				list[#list + 1] = {
					hero = heroId,
					buffId = v.Effect,
					name = Strings:get(heroConfig.Name),
					shortDesc = Strings:get(skillConfig.Desc),
					desc = Strings:get(skillConfig.Desc)
				}
			end
		end

		ruleMap.hero = list
	end

	if ruleConfig.StarsAttrEffect and ruleConfig.StarsAttrEffect ~= "" then
		local skillConfig = ConfigReader:getRecordById("Skill", ruleConfig.StarsAttrEffect)

		ruleMap.starSkill = {
			iconPath = "st_bg_wxhb.png",
			buffId = ruleConfig.StarsAttrEffect,
			name = Strings:get(Strings:get("Crusade_Point_17")),
			shortDesc = Strings:get(skillConfig.Desc),
			desc = Strings:get(skillConfig.Desc)
		}
	end

	if ruleConfig.AwakenAttrEffect and ruleConfig.AwakenAttrEffect ~= "" then
		local skillConfig = ConfigReader:getRecordById("Skill", ruleConfig.AwakenAttrEffect)

		ruleMap.awakenSkill = {
			iconPath = "st_bg_jxhb.png",
			buffId = ruleConfig.AwakenAttrEffect,
			name = Strings:get(Strings:get("Crusade_Point_18")),
			shortDesc = Strings:get(skillConfig.Desc),
			desc = Strings:get(skillConfig.Desc)
		}
	end

	if ruleConfig.ConfigLevelLimitID and ruleConfig.ConfigLevelLimitID ~= "" then
		local lv = DataReader:getDataByNameIdAndKey("ConfigLevelLimit", ruleConfig.ConfigLevelLimitID, "StandardLv")

		ruleMap.levelLimit = {
			iconPath = "ico_rtpk_faircombat.png",
			name = Strings:get("SpPower_ShowName"),
			shortDesc = Strings:get("RTPK_Bonus_FairPower", {
				level = lv
			}),
			desc = Strings:get("RTPK_SpPowerDesc", {
				level = lv
			})
		}
	end

	if ruleConfig.SeasonSkill and ruleConfig.SeasonSkill ~= "" then
		local skillConfig = ConfigReader:getRecordById("Skill", ruleConfig.SeasonSkill)

		ruleMap.seasonSkill = {
			iconPath = "ico_rtpk_buff.png",
			buffId = ruleConfig.SeasonSkill,
			name = Strings:get("RTPK_BonusPopUp_Buff"),
			shortDesc = Strings:get("RTPK_BonusPopUp_Buff"),
			desc = Strings:get(skillConfig.Desc, {
				fontSize = 20,
				fontName = TTF_FONT_FZYH_M
			})
		}
	end

	return ruleMap
end

function RTPKSystem:getGradeConfigByScore(score)
	local config = ConfigReader:getDataTable("RTPKGrade")

	for k, v in pairs(config) do
		if score >= v.ScoreLow and score <= v.ScoreHigh then
			return v
		end
	end
end

function RTPKSystem:checkIsNewSeason()
	local status = self._rtpk:getCurStatus()

	if status == RTPKSeasonStatus.kCanMatch or status == RTPKSeasonStatus.kNotCanMatch then
		local playerId = self:getDevelopSystem():getPlayer():getRid()

		if not cc.UserDefault:getInstance():getStringForKey(playerId .. UserDefaultKey.kRTPKNewSeasonKey) then
			local seasonId = ""
			local curSeasonId = self._rtpk:getSeasonId()

			return curSeasonId ~= seasonId
		end
	end
end

function RTPKSystem:setNewSeasonKeyValue()
	local playerId = self:getDevelopSystem():getPlayer():getRid()
	local curSeasonId = self._rtpk:getSeasonId()

	cc.UserDefault:getInstance():setStringForKey(playerId .. UserDefaultKey.kRTPKNewSeasonKey, curSeasonId)
end

function RTPKSystem:getRTPKState()
	local gameServerAgent = self:getInjector():getInstance(GameServerAgent)
	local currentTime = gameServerAgent:remoteTimestamp()

	if currentTime < self._rtpk:getStartTime() then
		return RTPKSeasonStatus.kRest
	end

	if currentTime >= self._rtpk:getStartTime() and currentTime <= self._rtpk:getEndTime() then
		if self:isInMatchTime() then
			return RTPKSeasonStatus.kCanMatch
		else
			return RTPKSeasonStatus.kNotCanMatch
		end
	end

	if currentTime <= self._rtpk:getCloseTime() then
		return RTPKSeasonStatus.kShow
	end

	return RTPKSeasonStatus.kRest
end

function RTPKSystem:getServerIdByRid(rid)
	local temp = string.split(rid, "_")

	return temp[2]
end

function RTPKSystem:getSeasonNextCD()
	local status = self._rtpk:getCurStatus()

	if status == RTPKSeasonStatus.kRest then
		return self._rtpk:getStartTime()
	end

	return -1
end

function RTPKSystem:checkSeasonData(callback)
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("RTPK")

	if unlock then
		if self._rtpk:getSeasonId() and self._rtpk:getSeasonId() == "" then
			self:requestRTPKInfo(callback, false)
		elseif self._rtpk:getCurStatus() ~= self:getRTPKState() then
			self:requestRTPKInfo(callback, false)
		end
	end
end

function RTPKSystem:isDoubleScore()
	local status = self._rtpk:getCurStatus()

	if (status == RTPKSeasonStatus.kNotCanMatch or status == RTPKSeasonStatus.kCanMatch) and self:isInMatchTime() then
		local doubleTimes = self._rtpk:getDoubleTimes()

		if doubleTimes > 0 then
			return true
		end
	end

	return false
end

function RTPKSystem:requestGetReward(data, callback)
	self._rtpkService:requestGetReward(data, function(response)
		if response.resCode == GS_SUCCESS then
			self._rtpk:synchronize(response.data)

			local rewards = response.data.rewards

			if rewards and next(rewards) then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = rewards
				}))
			end

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_REFRESH_GRADE_REWARD_DONE))
		end
	end)
end

function RTPKSystem:requestBattleReportList(callback, blockUI)
	local params = {}

	self._rtpkService:requestBattleReportList(params, function(response)
		if response.resCode == GS_SUCCESS then
			for i = 1, #response.data do
				response.data[i].nickname = self._developSystem:getNickName()
				response.data[i].headImg = self._developSystem:getheadId()
			end

			self._rtpk:syncReportList(response.data)
		end

		if callback then
			callback(response)
		end
	end, blockUI)
end

function RTPKSystem:requestBattleReport(reportId, callback, blockUI)
	return
end

function RTPKSystem:getReportById(id)
	return self._rtpk:getReportById(id)
end

function RTPKSystem:requestRTPKChangeTeam(data, callback, blockUI)
	self._rtpkService:requestRTPKChangeTeam(data, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response)
		end
	end, blockUI)
end

function RTPKSystem:getIsRecommend(heroId)
	local ruleId = self._rtpk:getSeasonRule()
	local ruleConfig = ConfigReader:getRecordById("RTPKRule", ruleId)
	local HeroBase = ConfigReader:getRecordById("HeroBase", heroId)

	if ruleConfig.ExcellentHero then
		for k, v in pairs(ruleConfig.ExcellentHero) do
			if v.Hero then
				for index, id in pairs(v.Hero) do
					if id == HeroBase.Id then
						return true
					end
				end
			end
		end
	end

	return false
end

function RTPKSystem:getRecomandHeroIds()
	local ruleId = self._rtpk:getSeasonRule()
	local ruleConfig = ConfigReader:getRecordById("RTPKRule", ruleId)
	local recomand = ruleConfig.ExcellentHero
	local recomandHeroIds = {}

	if recomand then
		for i = 1, #recomand do
			local heroIds = recomand[i].Hero

			for j = 1, #heroIds do
				table.insert(recomandHeroIds, heroIds[j])
			end
		end
	end

	return recomandHeroIds
end

function RTPKSystem:getRecomandHeroInfo()
	local ruleId = self._rtpk:getSeasonRule()
	local ruleConfig = ConfigReader:getRecordById("RTPKRule", ruleId)

	return ruleConfig.ExcellentHero
end

function RTPKSystem:getConfigLevelLimit()
	local ruleId = self._rtpk:getSeasonRule()
	local ruleConfig = ConfigReader:getRecordById("RTPKRule", ruleId)

	return ruleConfig.ConfigLevelLimitID
end

function RTPKSystem:getHeroEffectNum(heroId)
	local ruleId = self._rtpk:getSeasonRule()
	local config = ConfigReader:getRecordById("RTPKRule", ruleId)

	if self:getIsRecommend(heroId) then
		return 1
	end

	local info = self._developSystem:getHeroSystem():getHeroById(heroId)

	if info:getStar() >= 5 and config.StarsAttrEffect ~= "" then
		return 1
	end

	if info:getAwakenStar() > 0 and config.AwakenAttrEffect ~= "" then
		return 1
	end

	return 0
end

function RTPKSystem:getGradeByScore(score)
	return self._rtpk:getGradeByScore(score)
end

function RTPKSystem:getGradeConfigInfo()
	return self._rtpk:getGradeConfigInfo()
end

function RTPKSystem:getReportList()
	return self._rtpk:getReportList()
end

function RTPKSystem:requestRTPKInfo(callback, blockUI)
	self._rtpkService:requestGetInfo({}, function(response)
		if response.resCode == GS_SUCCESS then
			self._rtpk:synchronize(response.data)

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_RTPK_UPDATEINFO))
		end
	end, blockUI)
end

function RTPKSystem:requestStartMatch(callback)
	self._rtpkService:requestStartMatch({}, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			if response.data.result then
				self:dispatch(Event:new(EVT_RTPK_STARTMATCH))
			end
		end
	end, true)
end

function RTPKSystem:requestCancelMatch(callback)
	self._rtpkService:requestCancelMatch({}, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_RTPK_CANCELMATCH))
		end
	end, true)
end

function RTPKSystem:requestRobotBattleFinish(data, callback)
	self._rtpkService:requestRobotBattleFinish(data, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			self:showResultView(response.data)
		else
			self:switchRTPKMainView()
		end
	end, true)
end

function RTPKSystem:requestPvpBattleFinish(data, callback)
	self._rtpkService:requestPvpBattleFinish(data, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			self:showResultView(response.data)
		else
			self:switchRTPKMainView()
		end
	end, true)
end

function RTPKSystem:requestRobotBattleSurrender(data, callback)
	self._rtpkService:requestRobotBattleSurrender(data, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			self:showResultView(response.data)
		end
	end, true)
end

function RTPKSystem:requestTotalWinReward(data, callback)
	self._rtpkService:requestTotalWinReward(data, function(response)
		if response.resCode == GS_SUCCESS then
			self._rtpk:synchronize(response.data)

			local rewards = response.data.rewards

			if rewards and next(rewards) then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = rewards
				}))
			end

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_REFRESH_GRADE_REWARD_DONE))
		end
	end, true)
end

function RTPKSystem:listen()
	self:listenRTPKMatchInfo()
end

function RTPKSystem:listenRTPKMatchInfo()
	self._rtpkService:listenRTPKMatchInfo(function(response)
		self._battleData = response

		self:dispatch(Event:new(EVT_RTPK_MATCHSUCC, response))
	end)
end

function RTPKSystem:enterRTPVP(battleServerIP, battleServerPort, roomId, battleData, type)
	self._rtpvpController:enterRTPVP(battleServerIP, battleServerPort, roomId, battleData, type, self._rtpk:getSeasonId())
end

function RTPKSystem:connectSucc()
	self._rtpvpController:connectSucc()
end

function RTPKSystem:showResultView(data)
	data = data or {}

	local function showResult()
		local view = self:getInjector():getInstance("RTPKResultView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, data))
	end

	local developSystem = self:getInjector():getInstance(DevelopSystem)

	if data.result then
		if data.result.winner == developSystem:getPlayer():getRid() then
			if data.result.reason == nil or data.result.reason == "" then
				showResult()

				return
			end

			do
				local tips = ""

				if data.result.detail == "disconnect" or data.result.reason == "disconnect" then
					tips = Strings:get("Friend_Pvp_Tips5")
				elseif data.result.detail == "surrender" or data.result.reason == "surrender" then
					tips = Strings:get("Friend_Pvp_Tips6")
				end

				local outSelf, delegate = self, {}

				function delegate:willClose(popupMediator, data)
					showResult()
				end

				local data = {
					closeTime = 5,
					title = Strings:get("Tip_Remind"),
					content = tips,
					sureBtn = {}
				}
				local view = self:getInjector():getInstance("AlertView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, data, delegate))
			end

			goto label_60_0
		end
	end

	showResult()

	::label_60_0::
end

function RTPKSystem:enterRobotBattle(data)
	local isReplay = false
	local canSkip = false
	local outSelf, battleDelegate = self, {}
	local battleData = {
		playerData = data.br,
		enemyData = data.robot,
		logicSeed = data.logicSeed,
		strategySeedA = data.strategySeedA,
		strategySeedB = data.strategySeedB,
		seasonId = self._rtpk:getSeasonId()
	}
	local battleSession = RTPVPRobotBattleSession:new(battleData)

	battleSession:buildAll()

	local battleData = battleSession:getPlayersData()
	local battleConfig = battleSession:getBattleConfig()
	local battleSimulator = battleSession:getBattleSimulator()
	local battleLogic = battleSimulator:getBattleLogic()
	local battleInterpreter = BattleInterpreter:new()

	battleInterpreter:setRecordsProvider(battleSession:getBattleRecordsProvider())

	local battleDirector = LocalBattleDirector:new()

	battleDirector:setBattleSimulator(battleSimulator)
	battleDirector:setBattleInterpreter(battleInterpreter)

	local battlePassiveSkill = battleSession:getBattlePassiveSkill(battleData, data.br.rid)
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(SettingBattleTypes.kArena)
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("AutoFight")

	if not unlock then
		isAuto = false
	end

	if systemKeeper:isUnlock("Arena_SkipBattleCountdown") then
		canSkip = true
	end

	local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
	local speedOpenSta = systemKeeper:getBattleSpeedOpen("arena_challenge")
	local logicInfo = {
		director = battleDirector,
		interpreter = battleInterpreter,
		teams = battleSession:genTeamAiInfo(true),
		mainPlayerId = {
			data.br.rid
		}
	}

	function battleDelegate:onBattleSurrender()
		local param = {
			roomId = data.room
		}

		outSelf:requestRobotBattleSurrender(param)
	end

	function battleDelegate:onBattleFinish(result)
		local realData = battleSession:getResultSummary()
		local param = {
			roomId = data.room,
			resultData = realData
		}

		outSelf:requestRobotBattleFinish(param)
	end

	function battleDelegate:showMaster(friend, enemy, pauseFunc, resumeCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if resumeCallback then
				resumeCallback()
			end
		end

		local bossView = outSelf:getInjector():getInstance("MasterCutInView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
			friend = friend,
			enemy = enemy
		}, popupDelegate))

		if pauseFunc then
			pauseFunc()
		end
	end

	local ruleId = self._rtpk:getSeasonRule()
	local ruleConfig = ConfigReader:getRecordById("RTPKRule", ruleId)

	if not ruleConfig.BattleBackground then
		local BGM = ruleConfig.BGM
		local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
		local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
		local var_63_0 = {
			battleType = battleSession:getBattleType(),
			battleData = battleData,
			battleConfig = battleConfig,
			isReplay = isReplay,
			logicInfo = logicInfo,
			delegate = battleDelegate
		}
		local var_63_1 = {
			opPanelClazz = "BattleUIMediator",
			mainView = "rtpvpRobotBattle",
			opPanelRes = "asset/ui/BattleUILayer.csb",
			isShowEmoji = true,
			canChangeSpeedLevel = true,
			finalHitShow = true,
			battleSettingType = SettingBattleTypes.kArena,
			bulletTimeEnabled = BattleLoader:getBulletSetting("BulletTime_PVP_Arena"),
			bgm = BGM,
			background = ruleConfig.BattleBackground,
			refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content,
			battleSuppress = BattleDataHelper:getBattleSuppress()
		}

		var_63_1.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
		var_63_1.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
		var_63_1.passiveSkill = battlePassiveSkill
		var_63_1.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
		var_63_1.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("rtpk")

		local var_63_2 = {
			speed = {
				visible = false
			},
			skip = {
				visible = false
			},
			auto = {
				visible = false
			},
			pause = {
				visible = false
			}
		}
		local var_63_3 = {}

		var_63_3.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
		var_63_3.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
		var_63_2.restraint = var_63_3
		var_63_1.btnsShow = var_63_2
		var_63_0.viewConfig = var_63_1
		var_63_0.loadingType = LoadingType.kRTPK

		local data = var_63_0

		BattleLoader:pushBattleView(self, data, nil, true)
	end
end

function RTPKSystem:pvpBattleFinish()
	delayCallByTime(1000, function()
		self:requestPvpBattleFinish({
			roomId = self._battleData.room
		})
	end)
end

function RTPKSystem:enterPvpBattle(data)
	local ruleId = self._rtpk:getSeasonRule()
	local ruleConfig = ConfigReader:getRecordById("RTPKRule", ruleId)
	local battleDelegate = RTPVPDelegate:new(self._rtpvpController:getRtpvpService():fetchRid(), data.battleData, data.simulator, bind1(self.pvpBattleFinish, self), self._battleData.room)

	if not ruleConfig.BattleBackground then
		local logicInfo = {
			director = self._rtpvpController:getDirector(),
			interpreter = data.interpreter,
			teams = battleDelegate:getPlayers(),
			mainPlayerId = {
				battleDelegate:getMainPlayerId()
			}
		}
		local settingSystem = self:getInjector():getInstance(SettingSystem)
		local battleConfig = data.battleSession:getBattleConfig()
		local battleData = battleDelegate:getPlayersData()
		local battlePassiveSkill = data.battleSession:getBattlePassiveSkill(battleData, battleDelegate:getMainPlayerId())
		local systemKeeper = self:getInjector():getInstance("SystemKeeper")
		local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
		local speedOpenSta = systemKeeper:getBattleSpeedOpen("friend_battle")
		local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
		local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")

		function battleDelegate:onShowRestraint(continueCallback)
			local popupDelegate = {}

			function popupDelegate:willClose(sender)
				continueCallback()
			end

			local view = settingSystem:getInjector():getInstance("battlerofessionalRestraintView")

			settingSystem:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}, popupDelegate))
		end

		function battleDelegate:showMaster(friend, enemy, pauseFunc, resumeCallback)
			local popupDelegate = {}

			function popupDelegate:willClose(sender, data)
				if resumeCallback then
					resumeCallback()
				end
			end

			local bossView = settingSystem:getInjector():getInstance("MasterCutInView")

			if battleDelegate:getMainPlayerId() == friend.rid then
				settingSystem:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
					friend = friend,
					enemy = enemy
				}, popupDelegate))
			else
				settingSystem:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
					friend = enemy,
					enemy = friend
				}, popupDelegate))
			end

			if pauseFunc then
				pauseFunc()
			end
		end

		local var_70_0 = {
			isReplay = false,
			battleData = battleData,
			battleConfig = battleConfig,
			logicInfo = logicInfo,
			delegate = battleDelegate
		}
		local var_70_1 = {
			mainView = "rtpvpBattle",
			opPanelRes = "asset/ui/BattleUILayer.csb",
			isShowEmoji = true,
			disableHeroTip = true,
			canChangeSpeedLevel = false,
			opPanelClazz = "BattleUIMediator",
			battleType = data.battleSession:getBattleType(),
			bulletTimeEnabled = BattleLoader:getBulletSetting("BulletTime_PVP_Main"),
			bgm = ruleConfig.BGM,
			background = ruleConfig.BattleBackground,
			refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content,
			battleSuppress = BattleDataHelper:getBattleSuppress()
		}

		var_70_1.hpShow = settingSystem:getSettingModel():getHpShowSetting()
		var_70_1.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
		var_70_1.passiveSkill = battlePassiveSkill
		var_70_1.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
		var_70_1.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("friend_battle")

		local var_70_2 = {}
		local var_70_3 = {}

		var_70_3.visible = speedOpenSta and self:getInjector():getInstance(SystemKeeper):canShow("BattleSpeed")
		var_70_3.lock = not unlockSpeed
		var_70_3.tip = tipsSpeed
		var_70_3.speedConfig = battleSpeed_Actual
		var_70_3.speedShowConfig = battleSpeed_Display
		var_70_2.speed = var_70_3
		var_70_2.skip = {
			visible = false
		}
		var_70_2.auto = {
			visible = false
		}
		var_70_2.pause = {
			visible = false
		}

		local var_70_4 = {}

		var_70_4.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
		var_70_4.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
		var_70_2.restraint = var_70_4
		var_70_1.btnsShow = var_70_2
		var_70_0.viewConfig = var_70_1
		var_70_0.loadingType = LoadingType.kRTPK

		local data = var_70_0

		BattleLoader:pushBattleView(self, data, nil, true)
	end
end

function RTPKSystem:doReset()
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("RTPK")

	if unlock then
		self:requestRTPKInfo(nil, false)
	end
end

function RTPKSystem:requestUseEmoji(emojiList)
	local params = {
		list = emojiList
	}

	self._rtpkService:requestUseEmoji(params, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("RTPK_EMO_Tips3")
			}))
		end
	end, true)
end
