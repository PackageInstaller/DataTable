-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/controller/PetRaceSystem.lua

EVT_PETRACE_STATE_CHANGE = "EVT_PETRACE_STATE_CHANGE"
EVT_PETRACE_STATE_MAIN_CHANGE = "EVT_PETRACE_STATE_MAIN_CHANGE"
EVT_PETRACE_BATTLEINFO_PUSH = "EVT_PETRACE_BATTLEINFO_PUSH"
EVT_PETRACE_KNOCKOUTNUM_CHANGE = "EVT_PETRACE_KNOCKOUTNUM_CHANGE"
EVT_PETRACE_SHOUT_PUSH = "EVT_PETRACE_SHOUT_PUSH"
EVT_PETRACE_ADJUSTTEAMORDER = "EVT_PETRACE_ADJUSTTEAMORDER"
EVT_PETRACE_GETREWARD = "EVT_PETRACE_GETREWARD"
EVT_PETRACE_MYSCHEDULE_CHANGE = "EVT_PETRACE_MYSCHEDULE_CHANGE"
EVT_PETRACE_EIGHT_RANK_CHANGE = "EVT_PETRACE_EIGHT_RANK_CHANGE"
EVT_PETRACE_RESULT_CHANGE = "EVT_PETRACE_RESULT_CHANGE"
EVT_PETRACE_EMBATTLE_DATA_CHANGE = "EVT_PETRACE_EMBATTLE_DATA_CHANGE"
EVT_PETRACE_AUTO_REGIST_CHANGE = "EVT_PETRACE_AUTO_REGIST_CHANGE"

local desRoundInfo = {
	Strings:get("Petrace_Text_19"),
	Strings:get("Petrace_Text_20"),
	Strings:get("Petrace_Text_21")
}

PetRaceSystem = class("PetRaceSystem", Facade)

PetRaceSystem:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
PetRaceSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PetRaceSystem:has("_petRaceService", {
	is = "r"
}):injectWith("PetRaceService")
PetRaceSystem:has("_petRace", {
	is = "r"
}):injectWith("PetRace")
PetRaceSystem:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
PetRaceSystem:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
PetRaceSystem:has("_selectIndex", {
	is = "rw"
})

function PetRaceSystem:initialize()
	super.initialize(self)

	self.__enterViewSta = false
	self._reportClickIndex = 1
	self._mainClickIndex = 3
	self._selectIndex = 0
end

function PetRaceSystem:userInject()
	self:listenPush()
end

function PetRaceSystem:dispose()
	super.dispose(self)
end

function PetRaceSystem:enterBattle(data, reportData, text_titleDes, round)
	local outSelf = self
	local battleData = data
	local playersInfo = battleData.playersInfo
	local battleDelegate = {}
	local challenger = playersInfo.challenger
	local defender = playersInfo.defender
	local selfRid = outSelf:getDevelopSystem():getPlayer():getRid()
	local isReplay = true
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(SettingBattleTypes.kPetRace)
	local battleRecorder = BattleRecorder:new():restoreRecords(battleData.timelines)
	local battleInterpreter = BattleInterpreter:new()

	battleInterpreter:setRecordsProvider(battleRecorder)

	local battleDirector = LocalBattleDirector:new()

	battleDirector:setBattleInterpreter(battleInterpreter)

	local logicInfo = {
		director = battleDirector,
		interpreter = battleInterpreter
	}

	logicInfo.mainPlayerId = selfRid == defender.rid and defender.playerId or challenger.playerId

	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
	local speedOpenSta = systemKeeper:getBattleSpeedOpen("hegemony_battle")
	local alertDelegate = {}
	local this = self

	function alertDelegate:willClose(view, data)
		BattleLoader:popBattleView(this, data)
	end

	local function battleOver()
		BattleLoader:popBattleView(this, {
			response = AlertResponse.kClose
		})
	end

	function battleDelegate:onLeavingBattle()
		battleOver()
	end

	function battleDelegate:onPauseBattle(continueCallback, leaveCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if data.opt == BattlePauseResponse.kLeave then
				leaveCallback()
			else
				continueCallback(data.hpShow, data.effectShow)
			end
		end

		local pauseView = outSelf:getInjector():getInstance("battlePauseView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, pauseView, nil, {}, popupDelegate))
	end

	function battleDelegate:tryLeaving(callback)
		callback(true)
	end

	function battleDelegate:onSkipBattle()
		battleOver()
	end

	function battleDelegate:onBattleFinish(result)
		battleOver()
	end

	function battleDelegate:onDevWin()
		self:onBattleFinish()
	end

	function battleDelegate:onTimeScaleChanged(timeScale)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(SettingBattleTypes.kPetRace, nil, timeScale)
	end

	function battleDelegate:onShowRestraint(continueCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender)
			continueCallback()
		end

		local view = outSelf:getInjector():getInstance("battlerofessionalRestraintView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}, popupDelegate))
	end

	local bgRes = round > self:getScoreMaxRound() and (ConfigReader:getDataByNameIdAndKey("ConfigValue", "KOF_FinalsBackground", "content") or "Battle_Scene_1") or ConfigReader:getDataByNameIdAndKey("ConfigValue", "KOF_ScoreBackground", "content") or "Battle_Scene_1"
	local BGM = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Music_BattleBGM_PetRace", "content")
	local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
	local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
	local var_4_0 = {
		battleRecords = battleData.timelines,
		isReplay = isReplay,
		logicInfo = logicInfo,
		delegate = battleDelegate
	}
	local var_4_1 = {
		mainView = "battlePlayer",
		opPanelRes = "asset/ui/BattleUILayer_PetRace.csb",
		canChangeSpeedLevel = true,
		opPanelClazz = "PetRaceBattleUIMediator",
		battle_type = "PET_RACE",
		battleSettingType = SettingBattleTypes.kPetRace,
		bulletTimeEnabled = BattleLoader:getBulletSetting("BulletTime_PVP_KOF"),
		bgm = BGM,
		background = bgRes,
		Text_titleDes = text_titleDes,
		refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content,
		battleSuppress = BattleDataHelper:getBattleSuppress()
	}

	var_4_1.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
	var_4_1.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
	var_4_1.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
	var_4_1.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("hegemony_battle")

	local var_4_2 = {}
	local var_4_3 = {}

	var_4_3.visible = speedOpenSta and self:getInjector():getInstance(SystemKeeper):canShow("BattleSpeed")
	var_4_3.lock = not unlockSpeed
	var_4_3.tip = tipsSpeed
	var_4_3.speedConfig = battleSpeed_Actual
	var_4_3.speedShowConfig = battleSpeed_Display
	var_4_3.timeScale = timeScale
	var_4_2.speed = var_4_3
	var_4_2.skip = {
		visible = false
	}

	local var_4_4 = {
		enable = false
	}

	var_4_4.visible = self:getInjector():getInstance(SystemKeeper):canShow("AutoFight")
	var_4_4.lock = not systemKeeper:isUnlock("AutoFight")
	var_4_2.auto = var_4_4
	var_4_2.pause = {
		visible = true
	}

	local var_4_5 = {}

	var_4_5.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
	var_4_5.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
	var_4_2.restraint = var_4_5
	var_4_1.btnsShow = var_4_2
	var_4_0.viewConfig = var_4_1
	var_4_0.loadingType = LoadingType.KKOF

	local data = var_4_0

	BattleLoader:pushBattleView(self, data)
end

function PetRaceSystem:listenPush()
	self._petRaceService:listenPushPetRaceStateChange(function(response)
		self._petRace:setRound(response.round)
		self._petRace:setState(response.state)

		if response.time then
			self._petRace:setRoundEndTime(response.time)
		end

		self:onListenStateChange()
		self:dispatch(Event:new(EVT_HOMEVIEW_REDPOINT_REF, {
			type = 3
		}))
	end)
	self._petRaceService:listenPushPetRaceKnockoutNumChange(function(response)
		self._petRace:setKnockoutNum(response.knockoutNum)
		self._petRace:setRemainNum(response.remainNum)
		self:dispatch(Event:new(EVT_PETRACE_KNOCKOUTNUM_CHANGE, {
			response = response
		}))
	end)
	self._petRaceService:listenPushShout(function(response)
		self:dispatch(Event:new(EVT_PETRACE_SHOUT_PUSH, {
			response = response
		}))
	end)
end

function PetRaceSystem:onListenStateChange()
	if self.__enterViewSta == false then
		return
	end

	local state = self:getState()

	local function callfun()
		if state == PetRaceEnum.state.match then
			self:autoEnterBattle()
		end

		self:dispatch(Event:new(EVT_PETRACE_STATE_MAIN_CHANGE))
		self:dispatch(Event:new(EVT_PETRACE_STATE_CHANGE))
	end

	self:requestData(callfun, false)
end

function PetRaceSystem:getEightRankData()
	return self._petRace:getTopEight()
end

function PetRaceSystem:getFileNum()
	return self._petRace:getLostNum()
end

function PetRaceSystem:getWinNum()
	return self._petRace:getWinNum()
end

function PetRaceSystem:getScore()
	return self._petRace:getMyScore()
end

function PetRaceSystem:getRank()
	local rank = self._petRace:getMyRank()

	if rank == -1 then
		rank = self:getTotalUser()
	end

	return rank
end

function PetRaceSystem:getTotalUser()
	return self._petRace:getTotalUser()
end

function PetRaceSystem:getScoreMaxRound()
	return ConfigReader:requireDataByNameIdAndKey("ConfigValue", "KOF_ScoreMaxRound", "content")
end

function PetRaceSystem:getMyCurrentEmbattleInfo(round)
	round = round or self:getRound()

	local scoreMaxRound = self:getScoreMaxRound()
	local roundList = self:getRoundList()

	if round > #roundList then
		round = #roundList
	end

	if not roundList[round] then
		local roundData = {}
		local currentInfo = {}

		currentInfo.name = roundData.userName or self._developSystem:getNickName()
		currentInfo.level = roundData.userLevel or self._developSystem:getLevel()

		if round == 0 then
			local embattleInfo = self:getEmbattleInfo(1)

			if not embattleInfo[1] then
				local emInfo = {}

				if not emInfo.embattle then
					local embattle = {}

					currentInfo.embattle = embattle
					currentInfo.combat = emInfo.combat or 0
					currentInfo.speed = self:getTeamSpeedByEmbattle(embattle) or 0
					currentInfo.cost = self:getTeamCostByEmbattle(embattle) or 0
				end
			end
		elseif scoreMaxRound < round then
			local embattleInfo = self:getEmbattleInfo(round)
			local embattleAll = {}

			for i = 1, 3 do
				local info = {}
				local index = (round - scoreMaxRound - 1) * 3 + i

				if not embattleInfo[index] then
					if not embattleInfo[index].embattle then
						local embattle = {}

						info.embattle = embattle
						info.combat = embattleInfo[index].combat or 0
						info.speed = self:getTeamSpeedByEmbattle(embattle) or 0
						info.cost = self:getTeamCostByEmbattle(embattle) or 0
						embattleAll[#embattleAll + 1] = info
					end
				end
			end

			currentInfo.embattleAll = embattleAll
		else
			local embattleInfo = self:getEmbattleInfo(round)

			if not embattleInfo[round] then
				local emInfo = {}

				if not emInfo.embattle then
					local embattle = {}

					currentInfo.embattle = embattle
					currentInfo.combat = emInfo.combat or 0
					currentInfo.speed = self:getTeamSpeedByEmbattle(embattle) or 0
					currentInfo.cost = self:getTeamCostByEmbattle(embattle) or 0
				end
			end
		end

		return currentInfo
	end
end

function PetRaceSystem:getEnemyCurrentEmbattleInfo(round)
	round = round or self:getRound()

	local scoreMaxRound = self:getScoreMaxRound()
	local currentInfo = {}

	currentInfo.name = Strings:get("Petrace_Text_94")
	currentInfo.level = Strings:get("Petrace_Text_94")
	currentInfo.embattle = {}
	currentInfo.combat = Strings:get("Petrace_Text_94")
	currentInfo.speed = Strings:get("Petrace_Text_94")
	currentInfo.cost = Strings:get("Petrace_Text_94")

	if scoreMaxRound < round then
		currentInfo.embattleAll = {}
	else
		currentInfo.embattle = {}
	end

	local roundList = self:getRoundList()

	if round > #roundList then
		round = #roundList
	end

	if not roundList[round] then
		local roundData = {}

		currentInfo.noneSta = not (roundData.rivalName and roundData.rivalName ~= "")

		if round > 0 and roundData and roundData.rivalEmbattle and roundData.rivalEmbattle[1] then
			local rivalEmbattle = roundData.rivalEmbattle

			if scoreMaxRound < round then
				local embattleAll = {}

				currentInfo.name = roundData.rivalName or ""
				currentInfo.level = roundData.rivalLevel or 0

				for i = 1, 3 do
					if not rivalEmbattle[i] then
						local info = {}

						if not rivalEmbattle[i].embattle then
							info.speed = self:getTeamSpeedByEmbattle(rivalEmbattle[i].embattle) or 0
							info.cost = self:getTeamCostByEmbattle(rivalEmbattle[i].embattle) or 0
							info.embattle = rivalEmbattle[i].embattle
							info.combat = rivalEmbattle[i].combat or 0
							embattleAll[#embattleAll + 1] = info
						end
					end
				end

				currentInfo.embattleAll = embattleAll
			elseif not rivalEmbattle[1] then
				local rivalInfo = {}

				if not rivalInfo.embattle then
					local embattle = {}

					currentInfo.speed = self:getTeamSpeedByEmbattle(embattle) or 0
					currentInfo.cost = self:getTeamCostByEmbattle(embattle) or 0
					currentInfo.embattle = embattle
					currentInfo.combat = rivalInfo.combat or 0
					currentInfo.name = roundData.rivalName or ""
					currentInfo.level = roundData.rivalLevel or 0
				end
			end
		end

		return currentInfo
	end
end

function PetRaceSystem:getMaxCost()
	return ConfigReader:requireDataByNameIdAndKey("ConfigValue", "KOF_MaxCost", "content")
end

function PetRaceSystem:getRoundList()
	return self._petRace:getRoundList()
end

function PetRaceSystem:getMyReportList()
	local roundList = self:getRoundList()
	local list = {}

	for k, v in pairs(roundList) do
		if v.winId and #v.winId > 0 then
			list[#list + 1] = v
		end
	end

	return list
end

function PetRaceSystem:getEmbattleInfo(round)
	round = round or self:getRound()

	if round <= self:getScoreMaxRound() then
		local var_35_0 = self:getPetRace():getScoreEmbattle()

		var_35_0 = var_35_0 or {}

		return var_35_0
	else
		local var_35_1 = self:getPetRace():getFinalEmbattle()

		var_35_1 = var_35_1 or {}

		return var_35_1
	end
end

function PetRaceSystem:isMaxRegist()
	return self:getPetRace():getIsMaxRegist()
end

function PetRaceSystem:isRegist()
	return self:getPetRace():getIsRegist()
end

function PetRaceSystem:isRegistOneMatch()
	local enterIndex = self:getPetRace():getEnterIndex()

	return enterIndex ~= -1
end

function PetRaceSystem:getRound()
	return self:getPetRace():getRound()
end

function PetRaceSystem:getRoundEndTime()
	return self:getPetRace():getRoundEndTime() / 1000
end

function PetRaceSystem:getUpdateTime()
	return self:getRoundEndTime()
end

function PetRaceSystem:getState()
	return self:getPetRace():getMatchState()
end

function PetRaceSystem:getCurMatchState()
	return self:getPetRace():getState()
end

function PetRaceSystem:getMyMatchState()
	local state = self:getPetRace():getState()

	if state == PetRaceEnum.state.matchOver then
		return state
	end

	local enterIndex = self:getPetRace():getEnterIndex()

	if enterIndex ~= -1 then
		local curIndex = self:getPetRace():getCurIndex()

		if curIndex < enterIndex then
			return PetRaceEnum.state.regist
		elseif curIndex == enterIndex then
			return state
		else
			return PetRaceEnum.state.matchOver
		end
	else
		return PetRaceEnum.state.regist
	end
end

function PetRaceSystem:getDebugRate()
	return self:getPetRace():getDebugRate()
end

function PetRaceSystem:getStartTime()
	return self:getPetRace():getStartTime() / 1000
end

function PetRaceSystem:knockout()
	local round = self:getRound()
	local roundList = self:getRoundList()
	local maxRound = self:getScoreMaxRound()

	if maxRound < round and round > #roundList then
		return true
	end

	return false
end

function PetRaceSystem:isAutoRegist()
	return self:getPetRace():getAutoEnter()
end

function PetRaceSystem:isAutoEnable()
	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "KOF_AutoSwitch", "content") == 1
end

function PetRaceSystem:getFinalVO()
	return self:getPetRace():getFinalVO()
end

function PetRaceSystem:isFinalMatch()
	local curIndex = self:getPetRace():getCurIndex()
	local matchNumbers = ConfigReader:getDataByNameIdAndKey("ConfigValue", "KOF_MatchNumber", "content")

	return #matchNumbers == curIndex + 1
end

function PetRaceSystem:isRegistAviable()
	local enterIndex = self:getPetRace():getEnterIndex()

	if enterIndex ~= -1 then
		return false
	end

	local state = self:getPetRace():getState()

	if self:isFinalMatch() and state ~= PetRaceEnum.state.regist then
		return false
	end

	return true
end

function PetRaceSystem:updateTimeDes(baseNode, round, state, updateTime, color)
	if not baseNode then
		return
	end

	round = round or self:getRound()
	state = state or self:getState()
	updateTime = updateTime or self:getUpdateTime()

	local labelRound = baseNode:getChildByFullName("Text_title")
	local labelState = baseNode:getChildByFullName("Text_des")
	local labelTime = baseNode:getChildByFullName("Text_cd")

	color = color or {}

	if not color[1] then
		local r = 0

		if not color[2] then
			local g = 0

			if not color[3] then
				local b = 0

				if not color[4] then
					local a = 219.29999999999998

					labelRound:enableOutline(cc.c4b(r, g, b, a), 1)
					labelState:enableOutline(cc.c4b(r, g, b, a), 1)
					labelTime:enableOutline(cc.c4b(r, g, b, a), 1)

					local roundDes = self:getDesRound(round)

					labelRound:setString(roundDes)

					local stateDes = self:getDesState(round, state)

					labelState:setString(stateDes)

					local time = self:getCD(updateTime)
					local timeformateStr = time > 3600 and "${HH}:${MM}:${SS}" or "${MM}:${SS}"
					local timeStr = TimeUtil:formatTime(timeformateStr, time)

					labelTime:setString(timeStr)
				end
			end
		end
	end
end

function PetRaceSystem:getDesRound(round)
	round = round or self:getRound()

	local maxRound = self:getScoreMaxRound()
	local des = ""

	if round <= maxRound then
		if round <= 0 then
			round = 1
		end

		des = string.format(Strings:get("Petrace_Text_28"), round)
	else
		des = desRoundInfo[round - maxRound]
	end

	return des
end

function PetRaceSystem:getDesState(round, state)
	local des = ""

	if state == PetRaceEnum.state.match and round == 0 then
		des = Strings:get("Petrace_Text_23")
	elseif state == PetRaceEnum.state.match then
		des = Strings:get("Petrace_Text_24")
	elseif state == PetRaceEnum.state.regist then
		des = Strings:get("Petrace_Text_29")
	elseif state == PetRaceEnum.state.embattle then
		des = Strings:get("Petrace_Text_25")
	elseif state == PetRaceEnum.state.fighting then
		des = Strings:get("Petrace_Text_18")
	end

	return des
end

function PetRaceSystem:refreshNineEmbattle(embattleInfo, node)
	embattleInfo = embattleInfo or {}

	local node_container = node:getChildByName("Node_container")

	node_container:removeAllChildren()

	for k, v in pairs(embattleInfo) do
		local heroId = v.heroId
		local posX = node:getChildByName("Node_pos_" .. k):getPositionX()
		local posY = node:getChildByName("Node_pos_" .. k):getPositionY()
		local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroId)

		roleModel = v.surfaceId and v.surfaceId ~= "" and ConfigReader:getDataByNameIdAndKey("Surface", v.surfaceId, "Model") or roleModel

		local isAwaken = v.awakenLevel and v.awakenLevel > 0 or false
		local hero = RoleFactory:createHeroAnimation(roleModel, isAwaken and "stand1" or "stand")

		hero:addTo(node_container, tonumber(k), 20000)
		hero:setPosition(cc.p(posX, posY))
		hero:setAnchorPoint(cc.p(0.5, 0))
		hero:setScale(0.45)
	end
end

function PetRaceSystem:refreshIconEmbattle(embattleInfo, node, isSelf)
	local node_container = node:getChildByName("Node_container")

	node_container:removeAllChildren()

	local index = 1

	for k, v in pairs(embattleInfo or {}) do
		local pos

		if isSelf then
			local nodeH = node:getChildByName("Node_" .. 4 - index)

			pos = cc.p(nodeH:getPosition())
		else
			local nodeH = node:getChildByName("Node_" .. index)

			pos = cc.p(nodeH:getPosition())
		end

		if pos then
			local petIcon = self:getRoleIcon(v)

			petIcon:setPosition(pos.x, pos.y)
			node_container:addChild(petIcon)
		end

		index = index + 1

		if index > 3 then
			return
		end
	end
end

function PetRaceSystem:createFrameFormation(embattleInfo, node, index)
	for k, v in pairs(embattleInfo or {}) do
		local petIcon = self:getRoleIcon(v)
		local pos = self._frame6Pos[index]

		petIcon:setPosition(pos.x, pos.y)
		self._node_headContainer:addChild(petIcon)

		index = index > 3 and index + 1 or index - 1
	end
end

function PetRaceSystem:getCD(targetTime)
	targetTime = targetTime or 0

	local time = math.floor(targetTime - self._gameServerAgent:remoteTimestamp())

	if time <= 0 then
		return 0
	end

	return time
end

function PetRaceSystem:getRoleIcon(data)
	local qualityConfig = ConfigReader:getRecordById("HeroQuality", data.qualityId)
	local heroConfig = ConfigReader:getRecordById("HeroBase", data.heroId)
	local petIcon = self:createRoleIcon({
		id = data.heroId,
		roleModel = heroConfig.RoleModel,
		roleType = heroConfig.Type,
		cost = heroConfig.Cost,
		level = data.level,
		star = data.star,
		quality = data.quality,
		rareity = data.rarity,
		qualityLevel = qualityConfig.QualityLevel,
		surfaceId = data.surfaceId,
		awakenLevel = data.awakenLevel
	})

	petIcon:setScale(0.5)

	return petIcon
end

function PetRaceSystem:createRoleIcon(data)
	local renderNode = cc.CSLoader:createNode("asset/ui/Node_petrace_heroIcon.csb")
	local baseNode = renderNode:getChildByFullName("baseNode")
	local heroPanel = baseNode:getChildByName("hero")

	heroPanel:removeAllChildren()

	local roleModel = data.roleModel

	roleModel = data.surfaceId and data.surfaceId ~= "" and ConfigReader:getDataByNameIdAndKey("Surface", data.surfaceId, "Model") or roleModel

	local heroImg = IconFactory:createRoleIconSpriteNew({
		id = roleModel
	})

	heroPanel:addChild(heroImg)
	heroImg:setScale(0.68)
	heroImg:setPosition(heroPanel:getContentSize().width / 2, heroPanel:getContentSize().height / 2)

	local bg1 = baseNode:getChildByName("bg")
	local bg2 = baseNode:getChildByName("bg1")
	local rarity = baseNode:getChildByFullName("rarityBg.rarity")

	rarity:ignoreContentAdaptWithSize(true)
	rarity:removeAllChildren()

	local rarityAnim = IconFactory:getHeroRarityAnim(data.rareity)

	rarityAnim:addTo(rarity):center(rarity:getContentSize())
	rarityAnim:setScale(1)
	rarityAnim:offset(0, -6)
	bg1:loadTexture(GameStyle:getHeroRarityBg(data.rareity)[1])
	bg2:loadTexture(GameStyle:getHeroRarityBg(data.rareity)[2])

	local cost = baseNode:getChildByFullName("costBg.cost")

	cost:setString(data.cost)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(data.roleType)
	local occupation = baseNode:getChildByName("occupation")

	occupation:loadTexture(occupationImg)

	if data.awakenLevel and data.awakenLevel > 0 then
		local awakenAnim = cc.MovieClip:create("dikuang_yinghunxuanze")

		awakenAnim:addTo(bg1):center(bg1:getContentSize()):offset(-2, 2)
		awakenAnim:setScale(2)

		local anim = cc.MovieClip:create("shangkuang_yinghunxuanze")

		anim:addTo(heroPanel):center(heroPanel:getContentSize()):offset(-2, 2)
		anim:setScale(2)
	end

	return renderNode
end

function PetRaceSystem:setEnterViewSta(sta)
	self.__enterViewSta = sta
end

function PetRaceSystem:getRestHeros()
	return self:getPetRace():getRestHeros()
end

function PetRaceSystem:getTeamCombatByEmbattle(embattleInfo)
	return self:getPetRace():getTeamCombatByEmbattle(embattleInfo)
end

function PetRaceSystem:getTeamCostByEmbattle(embattleInfo)
	return self:getPetRace():getTeamCostByEmbattle(embattleInfo)
end

function PetRaceSystem:getTeamSpeedByEmbattle(embattleInfo)
	local speed = 0

	for k, v in pairs(embattleInfo) do
		speed = speed + v.speed
	end

	return speed
end

function PetRaceSystem:getPlayerHeroIcon(id)
	local heroData = self:getDevelopSystem():getHeroList():getHeroById(id)

	return (IconFactory:createHeroIcon({
		id = heroData:getId(),
		level = tonumber(heroData:getLevel()),
		star = tonumber(heroData:getStar()),
		quality = tonumber(heroData:getQuality())
	}, {
		isRect = true,
		scale = 0.7,
		isWidget = true
	}))
end

function PetRaceSystem:getWonderBattle()
	return self:getPetRace():getWonderBattle()
end

function PetRaceSystem:checkEnabled()
	local unlock, tips = self._systemKeeper:isUnlock("KOF")

	return unlock, tips
end

function PetRaceSystem:tryEnter(data)
	local unlock, tips = self:checkEnabled()
	local openServerDay = self._developSystem:getServerOpenDay()
	local unlockDay = ConfigReader:getDataByNameIdAndKey("ConfigValue", "KOF_UnlockDay", "content")

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))
	elseif openServerDay <= unlockDay then
		local unlockDes = Strings:get("Petrace_Text_106", {
			num = unlockDay - openServerDay + 1
		})

		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = unlockDes
		}))
	else
		local function getDataSucc(response)
			self._reportClickIndex = 1
			self._mainClickIndex = 3

			local isRegist = self:isRegist()

			if isRegist and self:getState() ~= PetRaceEnum.state.regist and self:getState() ~= PetRaceEnum.state.matchOver then
				self._mainClickIndex = 2
			end

			local view = self:getInjector():getInstance("PetRaceView")
			local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil)

			self:dispatch(event)
		end

		self:requestData(getDataSucc, true)
	end
end

function PetRaceSystem:reset()
	local unlock = self._systemKeeper:isUnlock("KOF")

	if unlock then
		self:requestData(function()
			self:dispatch(Event:new(EVT_HOMEVIEW_REDPOINT_REF, {
				type = 3
			}))
		end, false)
	end
end

function PetRaceSystem:forceResetEmbattle(callback)
	local originalEmbattleInfo = self:getEmbattleInfo()
	local embattleInfo = {}
	local tempTable = table.deepcopy(originalEmbattleInfo)

	for i = 1, #tempTable do
		table.insert(embattleInfo, tempTable[i].embattle)
	end

	local sendData = {}
	local isSend = false

	for idx, teamInfo in pairs(embattleInfo) do
		local dataBase = {}

		sendData[idx] = dataBase

		for k, v in pairs(teamInfo) do
			dataBase[k] = v.heroId
		end

		local cost = self:getTeamCostByEmbattle(teamInfo)
		local costLimit = self:getMaxCost()

		if costLimit < cost then
			isSend = true

			local minCost = 0
			local minCostIdx

			for k, v in pairs(teamInfo) do
				local heroId = v.heroId
				local cost = PrototypeFactory:getInstance():getHeroPrototype(heroId):getConfig().Cost

				if minCost == 0 or cost < minCost then
					minCost = cost
					minCostIdx = k
				end
			end

			if minCostIdx ~= nil then
				dataBase[minCostIdx] = nil
			end
		end
	end

	if isSend then
		self:embattle(callback, {
			embattle = sendData
		}, false)
	end
end

function PetRaceSystem:requestAutoRegist(t)
	local params = {}

	params.type = t

	self._petRaceService:requestAutoEnter(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			local sta = t == 1

			self._petRace:setAutoEnter(sta)
			self:dispatch(Event:new(EVT_PETRACE_AUTO_REGIST_CHANGE))
		end
	end)
end

function PetRaceSystem:embattle(callback, params, blockUI)
	self._petRaceService:embattle(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if not response.data.embattleInfo then
				local embattleInfo = {}
				local info1 = table.deepcopy(embattleInfo)
				local info2 = table.deepcopy(embattleInfo)

				self:getPetRace()._scoreEmbattle = info1
				self:getPetRace()._finalEmbattle = info2

				if callback then
					callback(response)
				end

				self:dispatch(Event:new(EVT_PETRACE_EMBATTLE_DATA_CHANGE))
			end
		end
	end)
end

function PetRaceSystem:fastEmbattle(callback, params, blockUI)
	self._petRaceService:fastEmbattle(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if not response.data.embattleInfo then
				local embattleInfo = {}
				local info1 = table.deepcopy(embattleInfo)
				local info2 = table.deepcopy(embattleInfo)

				self:getPetRace()._scoreEmbattle = info1
				self:getPetRace()._finalEmbattle = info2

				if callback then
					callback(response)
				end

				self:dispatch(Event:new(EVT_PETRACE_EMBATTLE_DATA_CHANGE))
			end
		end
	end)
end

function PetRaceSystem:requestData(callback, blockUI)
	self._petRaceService:requestData(nil, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			self:getPetRace():synchronize(response.data)

			if callback then
				callback(response)
			end
		end
	end)
end

function PetRaceSystem:regist(params, callback, blockUI)
	self._petRaceService:regist(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			self:getPetRace():synchronize(response.data)

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_HOMEVIEW_REDPOINT_REF, {
				type = 3
			}))
		end
	end)
end

function PetRaceSystem:adjustTeamOrder(callback, params, blockUI)
	self._petRaceService:adjustTeamOrder(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			local finalInfo = response.data.finalInfo

			self:getPetRace()._scoreEmbattle = response.data.scoreInfo
			self:getPetRace()._finalEmbattle = finalInfo

			self:dispatch(Event:new(EVT_PETRACE_ADJUSTTEAMORDER, {}))

			if callback then
				callback(response)
			end
		end
	end)
end

function PetRaceSystem:shout(params, blockUI, callback)
	self._petRaceService:shout(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response)
		end
	end)
end

function PetRaceSystem:requestWonderBattle(params, blockUI, callback)
	self._petRaceService:requestWonderBattle(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			self:getPetRace():setWonderBattle(response.data.result)

			if callback then
				callback(response)
			end
		end
	end)
end

function PetRaceSystem:requstGetReward(params, blockUI, callback)
	local round = params.round

	self._petRaceService:getReward(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			local roundList = self:getRoundList()

			if roundList[round] then
				roundList[round].rewardId = ""
			end

			self:dispatch(Event:new(EVT_PETRACE_GETREWARD, {
				round = round
			}))

			if not response.data.rewards then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = response.data.rewards
				}))

				if callback then
					callback(response)
				end
			end
		end
	end)
end

function PetRaceSystem:autoEnterBattle()
	local knockout = self:knockout()

	if knockout then
		return
	end

	local round = self:getRound()
	local roundList = self:getRoundList()
	local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
	local topViewName = scene:getTopViewName()

	if round > 0 and round == #roundList and topViewName == "PetRaceView" then
		local popCount = scene:getPopupViewCount()

		if popCount == 0 then
			local roundInfo = roundList[round]

			if roundInfo and roundInfo.reportId and #roundInfo.reportId > 0 then
				self:requestReportDetail(round, roundInfo.reportId, false)
			else
				self:dispatch(ShowTipEvent({
					duration = 0.5,
					tip = Strings:get("Petrace_Text_50")
				}))
			end
		end
	end
end

function PetRaceSystem:requestReportDetail(round, reportId, blockUI)
	local params = {}
	local titleDes = self:getDesRound(round)

	params.reportId = reportId

	self._petRaceService:requestReportDetail(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			local cjson = require("cjson.safe")
			local battleData = cjson.decode(response.data.battle)

			self:enterBattle(battleData, nil, titleDes, round)
		end
	end)
end

function PetRaceSystem:redPointShow()
	local unlock = self._systemKeeper:isUnlock("KOF")

	if unlock then
		local state = self:getState()
		local isRegist = self:isRegist()
		local startTime = self:getStartTime() / 1000
		local knockout = self:knockout()
		local key = self._developSystem:getPlayer():getRid() .. "_petRace"

		if isRegist == false and self:isRegistAviable() then
			if cc.UserDefault:getInstance():getBoolForKey(key, false) == true then
				cc.UserDefault:getInstance():setBoolForKey(key, false)
			end

			return true
		end

		if isRegist and (state == PetRaceEnum.state.match or state == PetRaceEnum.state.embattle or state == PetRaceEnum.state.fighting) and not knockout and startTime < self._gameServerAgent:remoteTimestamp() then
			if cc.UserDefault:getInstance():getBoolForKey(key, false) == false then
				return true
			end
		end
	end

	return false
end

function PetRaceSystem:saveOpenViewState()
	local state = self:getState()
	local isRegist = self:isRegist()
	local knockout = self:knockout()
	local startTime = self:getStartTime() / 1000

	if isRegist and (state == PetRaceEnum.state.match or state == PetRaceEnum.state.embattle or state == PetRaceEnum.state.fighting) and not knockout and startTime < self._gameServerAgent:remoteTimestamp() then
		local key = self._developSystem:getPlayer():getRid() .. "_petRace"

		if cc.UserDefault:getInstance():getBoolForKey(key, false) == false then
			cc.UserDefault:getInstance():setBoolForKey(key, true)
		end
	end
end
