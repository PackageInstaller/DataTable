-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarResultView.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarResultView", package.seeall)

local V3a9RacingCarResultView = class("V3a9RacingCarResultView", BaseView)

function V3a9RacingCarResultView:onInitView()
	self._btncontinue = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_continue")
	self._imagerole = gohelper.findChildImage(self.viewGO, "root/#image_role")
	self._imagerank = gohelper.findChildImage(self.viewGO, "root/#image_rank")
	self._txtteam = gohelper.findChildText(self.viewGO, "root/layout/#txt_team")
	self._txtname = gohelper.findChildText(self.viewGO, "root/layout/#txt_name")
	self._txtresult = gohelper.findChildText(self.viewGO, "root/#txt_result")
	self._scrolltask = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_task")
	self._gotaskContent = gohelper.findChild(self.viewGO, "root/#scroll_task/Viewport/#go_taskContent")
	self._goTask = gohelper.findChild(self.viewGO, "root/#scroll_task/Viewport/#go_taskContent/#go_Task")
	self._goTaskItem = gohelper.findChild(self.viewGO, "root/#scroll_task/Viewport/#go_taskContent/#go_Task/#go_TaskItem")
	self._txttips = gohelper.findChildText(self.viewGO, "root/#txt_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingCarResultView:addEvents()
	self._btncontinue:AddClickListener(self._btncontinueOnClick, self)
end

function V3a9RacingCarResultView:removeEvents()
	self._btncontinue:RemoveClickListener()
end

function V3a9RacingCarResultView:_btncontinueOnClick()
	self:_delayClose()
end

function V3a9RacingCarResultView:_editableInitView()
	self._starList = self:getUserDataTb_()

	gohelper.setActive(self._goTaskItem, false)

	self._maxStarNum = V3a9RacingCarEnum.RacingLevelStarMaxCount

	for i = 1, self._maxStarNum do
		self._starList[i] = gohelper.cloneInPlace(self._goTaskItem)
	end
end

function V3a9RacingCarResultView:_decomposeScore(score)
	local ones = score % 10
	local tens = math.floor(score / 10) % 10
	local hundreds = math.floor(score / 100) % 10

	return ones, tens, hundreds
end

function V3a9RacingCarResultView:_getScore(episodeInfo, playerRank, playerFinishTime)
	local gameLevelConfig = lua_racing_game_level.configDict[self._episodeConfig.gameId]
	local conditionParams = GameUtil.splitString2(gameLevelConfig.starCondition, true, "|", "#")
	local oldScore = tonumber(episodeInfo and episodeInfo.record) or 0
	local curScore = 0

	for i = 1, #conditionParams do
		local condition = conditionParams[i]
		local conditionType = tonumber(condition[1])
		local conditionValue = tonumber(condition[2])

		if conditionType == V3a9RacingCarEnum.StarTargetType.Finish then
			curScore = curScore + 100
		elseif conditionType == V3a9RacingCarEnum.StarTargetType.Rank then
			if playerRank <= conditionValue then
				curScore = curScore + 10
			end
		elseif conditionType == V3a9RacingCarEnum.StarTargetType.Time and playerFinishTime <= conditionValue then
			curScore = curScore + 1
		end
	end

	local oldOnes, oldTens, oldHundreds = self:_decomposeScore(oldScore)
	local curOnes, curTens, curHundreds = self:_decomposeScore(curScore)
	local totalScore = math.max(oldHundreds, curHundreds) * 100 + math.max(oldTens, curTens) * 10 + math.max(oldOnes, curOnes)
	local stars = 0

	if math.max(oldOnes, curOnes) >= 1 then
		stars = stars + 1
	end

	if math.max(oldTens, curTens) >= 1 then
		stars = stars + 1
	end

	if math.max(oldHundreds, curHundreds) >= 1 then
		stars = stars + 1
	end

	return curScore, totalScore, stars
end

function V3a9RacingCarResultView:_initReport(episodeInfo, episodeConfig, playerFinishTime)
	self._newBest = playerFinishTime < episodeInfo.bestTimeMs
	self._oldClaimedStars = episodeInfo and episodeInfo.claimedStars

	local curScore, totalScore, stars = self:_getScore(episodeInfo, self._playerRank, playerFinishTime)

	V3a9RacingCarRpc.instance:sendGetAct243ReportEpisodeRequest(episodeConfig.activityId, episodeConfig.episodeId, 0, stars, playerFinishTime, tostring(totalScore), self._reportCallback, self)

	self._curScore = curScore
	self._totalScore = totalScore
end

function V3a9RacingCarResultView:_reportCallback(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self._newClaimedStars = msg.episode.claimedStars

	V3a9RacingCarEpisodeModel.instance:updateEpisodeInfo(msg.episode)
end

function V3a9RacingCarResultView:onOpen()
	self._playerFinishTime = math.floor(V3a9RacingCarModel.instance:getPlayerFinishTime())

	local episodeConfig = V3a9RacingCarModel.instance:getEpisodeConfig()

	self._episodeConfig = episodeConfig
	self._episodeInfo = V3a9RacingCarEpisodeModel.instance:getEpisodeInfo(episodeConfig.episodeId)

	self:_calculateAndShowRank()
	self:_initReport(self._episodeInfo, self._episodeConfig, self._playerFinishTime)
	self:_refreshLevelInfo()

	local completedCombatTargets = self:_getCompletedCombatTargets()

	V3a9RacingCarController.instance:sendGameSuccessStat(#completedCombatTargets, self._playerRank, completedCombatTargets)

	self._time = V3a9RacingCarEnum.PostFinishDelay
	self._txttips.text = string.format(luaLang("v3a9Racing_car_continue"), self._time)

	TaskDispatcher.runRepeat(self._updatePerSecond, self, 1)
	AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayWin)
end

function V3a9RacingCarResultView:_getCompletedCombatTargets()
	local result = {}
	local curScoreStr = tostring((not self._curScore or nil) and 0)
	local gameLevelConfig = lua_racing_game_level.configDict[self._episodeConfig.gameId]
	local conditionParams = GameUtil.splitString2(gameLevelConfig.starCondition, true, "|", "#")

	for i, condition in ipairs(conditionParams) do
		if string.sub(curScoreStr, i, i) == "1" then
			table.insert(result, string.format(luaLang("v3a9Racing_car_target" .. i), condition[2]))
		end
	end

	return result
end

function V3a9RacingCarResultView:_updatePerSecond()
	self._time = self._time - 1
	self._txttips.text = string.format(luaLang("v3a9Racing_car_continue"), self._time)

	if self._time <= 0 then
		self:_delayClose()
	end
end

function V3a9RacingCarResultView:_delayClose()
	self:closeThis()
	V3a9RacingCarController.instance:openV3a9RacingCarRecordView({
		newBest = self._newBest,
		oldClaimedStars = self._oldClaimedStars,
		newClaimedStars = self._newClaimedStars,
		curScore = self._curScore,
		totalScore = self._totalScore
	})
end

function V3a9RacingCarResultView:_calculateAndShowRank()
	local playerCtrl = V3a9RacingCarModel.instance:getPlayerVehicleController()
	local playerDist = playerCtrl:getTotalTrackDistance()
	local aiRacers = V3a9RacingCarModel.instance:getAIRacers()
	local playerFinishTime = V3a9RacingCarModel.instance:getPlayerFinishTime()
	local racers = {}

	table.insert(racers, {
		isPlayer = true,
		distance = playerDist,
		time = playerFinishTime,
		racerConfig = playerCtrl:getRacerConfig()
	})

	for _, ai in ipairs(aiRacers) do
		if ai and ai.getTotalTrackDistance then
			if ai._aiConfig then
				local aiId = "ai_" .. tostring(ai._aiConfig.racerId or 0)
				local aiFinishTime = V3a9RacingCarModel.instance:getRacerFinishTime(aiId)

				table.insert(racers, {
					isPlayer = false,
					distance = ai:getTotalTrackDistance(),
					time = aiFinishTime,
					racerConfig = ai:getRacerConfig()
				})
			end
		end
	end

	table.sort(racers, function(a, b)
		if a.time then
			local aFinished = a.time > 0

			if b.time then
				local bFinished = b.time > 0

				if aFinished == bFinished then
					return a.time < b.time
				end

				return aFinished
			end
		end
	end)

	self._playerRank = 1

	for i, racer in ipairs(racers) do
		if racer.isPlayer then
			self._playerRank = i

			break
		end
	end

	if self._txtresult then
		self._txtresult.text = self:_formatTime(playerFinishTime)
	end

	local playerRacerConfig = playerCtrl:getRacerConfig()
	local playerInfo = PlayerModel.instance:getPlayinfo()

	self._txtname.text = playerInfo and playerInfo.name
	self._txtteam.text = playerRacerConfig.team

	local icon = "v3a9_racing_game_character_choose_" .. playerRacerConfig.pic

	UISpriteSetMgr.instance:setV3a9RacingSprite(self._imagerole, icon)
	UISpriteSetMgr.instance:setV3a9RacingSprite(self._imagerank, "v3a9_racing_game_rank" .. self._playerRank)
end

function V3a9RacingCarResultView:_refreshLevelInfo()
	local curScoreStr = tostring(self._curScore)
	local gameLevelConfig = lua_racing_game_level.configDict[self._episodeConfig.gameId]
	local conditionParams = GameUtil.splitString2(gameLevelConfig.starCondition, true, "|", "#")

	for i = 1, self._maxStarNum do
		local star = self._starList[i]
		local showStarGo = self._episodeInfo ~= nil

		gohelper.setActive(star, showStarGo)

		if showStarGo then
			local goFinished = gohelper.findChild(star, "bg/go_finished")
			local targetValue = string.sub(curScoreStr, i, i)
			local isFinished = targetValue == "1"

			gohelper.setActive(goFinished, isFinished)

			local desc = gohelper.findChildText(star, "txt_taskDesc")

			desc.text = string.format(luaLang("v3a9Racing_car_target" .. i), conditionParams[i][2])
		end
	end
end

function V3a9RacingCarResultView:_formatTime(seconds)
	local mins = math.floor(seconds / 60)
	local secs = math.floor(seconds % 60)
	local ms = math.floor(seconds % 1 * 100)

	return string.format("%02d:%02d:%02d", mins, secs, ms)
end

function V3a9RacingCarResultView:onClose()
	TaskDispatcher.cancelTask(self._updatePerSecond, self)
end

function V3a9RacingCarResultView:onDestroyView()
	return
end

return V3a9RacingCarResultView
