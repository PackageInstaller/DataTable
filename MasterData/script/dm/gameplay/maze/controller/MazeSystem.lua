-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/controller/MazeSystem.lua

require("dm.gameplay.maze.model.MazeChapter")
require("dm.gameplay.maze.model.MazeEvent")
require("dm.gameplay.maze.model.MazeSeal")

MazeSystem = class("MazeSystem", Facade, _M)

MazeSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
MazeSystem:has("_bagSystem", {
	is = "r"
}):injectWith("BagSystem")
MazeSystem:has("_mazeService", {
	is = "r"
}):injectWith("MazeService")
MazeSystem:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
MazeSystem:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
MazeSystem:has("_sealData", {
	is = "rw"
})
MazeSystem:has("_normalTimes", {
	is = "rw"
})
MazeSystem:has("_totalDp", {
	is = "rw"
})
MazeSystem:has("_isInPoint", {
	is = "rw"
})

EVT_MAZE_UPDATE_OPTION = "EVT_MAZE_UPDATE_OPTION"
EVT_MAZE_HERO_SHOP_BUY_SUC = "EVT_MAZE_HERO_SHOP_BUY_SUC"
EVT_MAZE_HERO_UP_SUC = "EVT_MAZE_HERO_UP_SUC"
EVT_MAZE_TREASURE_USE_SUC = "EVT_MAZE_TREASURE_USE_SUC"
EVT_MAZE_REFRESH_OPTION_SUC = "EVT_MAZE_REFRESH_OPTION_SUC"
EVT_MAZE_TREASURE_BOX_OPTION_SUC = "EVT_MAZE_TREASURE_BOX_OPTION_SUC"
EVT_MAZE_TREASURE_BOX_UPDATE_SUC = "EVT_MAZE_TREASURE_BOX_UPDATE_SUC"
EVT_MAZE_HERO_BOX_OPTION_SUC = "EVT_MAZE_HERO_BOX_OPTION_SUC"
EVT_MAZE_HERO_BOX_UPDATE_SUC = "EVT_MAZE_HERO_BOX_UPDATE_SUC"
EVT_MAZE_TREASURE_EXCHANGE = "EVT_MAZE_TREASURE_EXCHANGE"
EVT_MAZE_TREASURE_COPY = "EVT_MAZE_TREASURE_COPY"
EVT_MAZE_TREASURE_BUY_SUC = "EVT_MAZE_TREASURE_BUY_SUC"
EVT_MAZE_TALENT_ENABLE_SUC = "EVT_MAZE_TALENT_ENABLE_SUC"
EVT_MAZE_DPBOX_REWARD_GET_SUC = "EVT_MAZE_DPBOX_REWARD_GET_SUC"
EVT_MAZE_CLUE_SUC = "EVT_MAZE_CLUE_SUC"
EVT_MAZE_SUSPECT_SUC = "EVT_MAZE_SUSPECT_SUC"
EVT_MAZE_FINALL_BOSS_SHOW = "EVT_MAZE_FINALL_BOSS_SHOW"
EVT_MAZE_BUFF_SUC = "EVT_MAZE_BUFF_SUC"
EVT_MAZE_EVENT_SKILL_SUC = "EVT_MAZE_EVENT_SKILL_SUC"
EVT_MAZE_SHOW_GP = "EVT_MAZE_SHOW_GP"

function MazeSystem:initialize()
	super.initialize(self)

	self._chapterCount = 0
	self._optionCount = 0
	self._masterList = {}
	self._selectMaster = nil
	self._treasures = nil
	self._nextChapterIds = nil
	self._mazeChapter = nil
	self._mazeEvent = nil
	self._sealData = nil
	self._leftOptionsList = {}
	self._masterList = {}
	self._masterId = nil
	self._master = {}
	self._heros = nil
	self._mazeType = ""
	self._haveMaster = false
	self._sealHeroList = {}
	self._sealTreasureList = {}
	self._sealEventList = {}
	self._mazeState = 0
	self._normalTimes = 0

	self:initMazeEventConfig()
end

function MazeSystem:userInject()
	self._player = self._developSystem:getPlayer()
	self._masterSystem = self._developSystem:getMasterSystem()
	self._bagSystem = self._developSystem:getBagSystem()
end

function MazeSystem:initMazeEventConfig()
	self._mazeEventConfig = ConfigReader:getDataTable("PansLabList")
end

function MazeSystem:syncMazeData(data)
	if not data then
		return
	end

	if data.points then
		self._isInPoint = table.nums(data.points) > 0
	end

	if data.events then
		self._events = data.events

		if self._mazeEvent == nil then
			self._mazeEvent = MazeEvent:new(self)
		end

		self._mazeEvent:syncData(data.events)
	end

	if data.totalDp then
		self._totalDp = data.totalDp
	end

	if data.points then
		local pointsValue = data.points[self._mazeEvent:getConfigId()]

		if pointsValue then
			if pointsValue.chapterCount then
				self._chapterCount = pointsValue.chapterCount
			end

			if pointsValue.optionCount then
				self._optionCount = pointsValue.optionCount
			end
		end

		if pointsValue then
			if self._mazeChapter == nil then
				self._mazeChapter = MazeChapter:new(self)
			end

			self._mazeChapter:syncData(pointsValue)
		end
	end

	if data.unlockTasks and (not GameConfigs.mazeDebugMode or true) then
		if self._sealData == nil then
			self._sealData = MazeSeal:new(self)
		end

		self._sealData:syncData(data.unlockTasks)
	end

	if data.normalTimes then
		self._normalTimes = data.normalTimes.value
	end
end

function MazeSystem:syncDiffMaze(data)
	return
end

function MazeSystem:syncMazeDelfData(data)
	if data.points then
		local pointValue = data.points[self._mazeEvent:getConfigId()]

		if pointValue or data.points.INFINITY then
			self._mazeChapter:syncDelData(pointValue)
		end
	end
end

function MazeSystem:screenShotBlur(parent)
	local fileName = "printScreen.png"

	cc.Director:getInstance():getTextureCache():removeTextureForKey(fileName)
	parent:removeChildByTag(1000)

	local sp

	cc.utils:captureScreen(function(succeed, outputFile)
		if succeed then
			local winSize = cc.Director:getInstance():getWinSize()

			parent:loadTexture(outputFile)
			parent:setVisible(true)
			parent:setEnabled(true)
			CustomShaderUtils.setBlurToNode(parent, 10, 10, cc.size(1386, 852))
			print(outputFile)
		else
			print("截屏失败")
		end
	end, fileName)
end

function MazeSystem:getChapterPassCount()
	return self._optionCount
end

function MazeSystem:getNormalChallengeCount()
	local alltimes = ConfigReader:getDataByNameIdAndKey("Reset", "PansLabNormalTimes", "ResetSystem")

	return alltimes.setValue - self._normalTimes
end

function MazeSystem:getNormalAllTimes()
	local alltimes = ConfigReader:getDataByNameIdAndKey("Reset", "PansLabNormalTimes", "ResetSystem")

	return alltimes.setValue
end

function MazeSystem:getCluesByEventId(eventId)
	if self._events then
		for k, v in pairs(self._events) do
			if k == eventId and v.clues then
				return v.clues
			end
		end
	end

	return nil
end

function MazeSystem:haveClue(clueId)
	local eventId = self._mazeEvent:getConfigId()
	local clueList = self:getCluesByEventId(eventId)

	if clueList then
		for k, v in pairs(clueList) do
			if v == clueId then
				return true
			end
		end
	end

	return false
end

function MazeSystem:getClueHeroInfoList(clueId)
	local list = {}
	local cfg = ConfigReader:getRecordById("PansLabClue", clueId)

	assert(cfg ~= nil, "clueId " .. tostring(clueId) .. " is Null")

	local Suspect = cfg.Suspect

	for k, v in pairs(Suspect) do
		local sucfg = ConfigReader:getRecordById("PansLabSuspects", k)

		list[#list + 1] = {
			suspectId = k,
			heroId = sucfg.Model,
			num = v
		}
	end

	return list
end

function MazeSystem:isNewUnlockClueHero(suspectId)
	local allSuspect = self._mazeChapter._suspectPointList

	return (not allSuspect[suspectId] or nil) and true
end

function MazeSystem:getAllSuspectList()
	local allSuspect = self._mazeChapter._suspectPointList
	local suspectList = {}

	for k, v in pairs(allSuspect) do
		suspectList[#suspectList + 1] = {
			id = k,
			num = v
		}
	end

	table.sort(suspectList, function(a, b)
		return a.num > b.num
	end)

	return suspectList
end

function MazeSystem:getMzaeMoney()
	return
end

function MazeSystem:setSelectMaster(master)
	self._master = master
end

function MazeSystem:getSelectMaster()
	return self._master
end

function MazeSystem:setMazeState(gamestate)
	if gamestate ~= self._mazeState then
		self._mazeState = gamestate
	end
end

function MazeSystem:getMazeState()
	return self._mazeState
end

function MazeSystem:getChapter()
	return self._mazeChapter
end

function MazeSystem:getMazeEvent()
	return self._mazeEvent
end

function MazeSystem:getMazeEventConfigByPos(pos)
	for k, v in pairs(self._mazeEventConfig) do
		if v.Position == pos then
			return v
		end
	end

	return nil
end

function MazeSystem:getNextChaptersId()
	if self._mazeChapter._nextChapterIds == "" then
		return {}
	else
		return {
			self._mazeChapter._nextChapterIds
		}
	end
end

function MazeSystem:getMazeGold()
	self._bagSystem:getItemCount(CurrencyIdKind.kMazeGold)
end

function MazeSystem:getMazeGoldCoin()
	if self._mazeChapter._chapterType == "NORMAL" then
		return self:getMazeNormalGold()
	elseif self._mazeChapter._chapterType == "INFINITY" then
		return self:getMazeInfiniteGold()
	end
end

function MazeSystem:getMazeNormalGold()
	return self._bagSystem:getItemCount(CurrencyIdKind.kMazeNormalGold)
end

function MazeSystem:getMazeInfiniteGold()
	return self._bagSystem:getItemCount(CurrencyIdKind.kMazeInfinityGold)
end

function MazeSystem:getSelectMasterLv()
	return self._master.level
end

function MazeSystem:getMasterCurHp()
	return self._master.curHp
end

function MazeSystem:getMasterMaxHp()
	return ConfigReader:getDataByNameIdAndKey("PansLabAttr", self._master.attrId, "Hp")
end

function MazeSystem:getMasterCurExp()
	return self._master.exp
end

function MazeSystem:getMasterLevelMaxExp()
	return ConfigReader:getDataByNameIdAndKey("PansLabAttr", self._master.attrId, "NeedExp")
end

function MazeSystem:getMasterExp()
	return
end

function MazeSystem:getSelectMasterId()
	return self._master.id
end

function MazeSystem:getSelectMasterName()
	return Strings:get(ConfigReader:getDataByNameIdAndKey("MasterBase", self._master.id, "Name"))
end

function MazeSystem:setSelectMasterId(id)
	self._master.id = id
end

function MazeSystem:setMasterData(data)
	self._masterUp = false

	if data.curHp then
		self._master.curHp = data.curHp
	end

	if data.exp then
		self._master.exp = data.exp
	end

	if data.level then
		if data.level >= self._master.level then
			self._masterUp = true
			self._masterOldLv = self._master.level
			self._masterNewLv = data.level
		else
			self._masterUp = false
		end

		self._master.level = data.level
	end

	if data.attrId then
		self._oldAttrId = self._master.attrId
		self._newAttrId = data.attrId
		self._master.attrId = data.attrId
	end

	self:setMasterAttr()
end

function MazeSystem:setMasterAttr()
	if (not self._newAttrId or not self._oldAttrId) and self._master.attrId then
		self._newAttrId = self._master.attrId
		self._oldAttrId = self._master.attrId
	end

	local old = ConfigReader:getRecordById("PansLabAttr", self._oldAttrId)
	local new = ConfigReader:getRecordById("PansLabAttr", self._newAttrId)

	self._infoOld = {
		atk = old.Attack,
		def = old.Defence,
		hp = old.Hp
	}
	self._infoNew = {
		atk = new.Attack,
		def = new.Defence,
		hp = new.Hp
	}

	local a = self._infoNew.atk - self._infoOld.atk
	local d = self._infoNew.def - self._infoOld.def
	local h = self._infoNew.hp - self._infoOld.hp

	self._infoDif = {
		atk = a,
		def = d,
		hp = h
	}
end

function MazeSystem:getMasterUpAttr()
	return self._infoOld, self._infoNew, self._infoDif
end

function MazeSystem:getMasterIsLvUp()
	return self._masterUp
end

function MazeSystem:setMasterIsLvUp(show)
	self._masterUp = show
end

function MazeSystem:setHeros(heros)
	self._heros = heros
end

function MazeSystem:syncHeros()
	local heros = {}
	local sourcedata = self._heros

	for k, v in pairs(sourcedata) do
		heros[v.id] = v
	end

	self._player._mazeHeroList:synchronize(heros)
end

function MazeSystem:getHeros()
	return self._heros
end

function MazeSystem:getCurHeroNum()
	local num = 0

	for k, v in pairs(self._heros) do
		if v ~= nil then
			num = num + 1
		end
	end

	return num
end

function MazeSystem:getSelectMasterIcon(parentNode)
	parentNode:removeAllChildren(true)

	return (IconFactory:createPlayerIcon({
		clipType = 4,
		id = string.split(self._master.id, "_")[2],
		size = parentNode:getContentSize()
	}))
end

function MazeSystem:getHeroById(heroid)
	for k, v in pairs(self._player._mazeHeroList._heros) do
		if heroid == k then
			return v
		end
	end
end

function MazeSystem:setCurOptionReward(reward)
	self.rewardData = reward
end

function MazeSystem:getCurOptionReward()
	return self.rewardData
end

function MazeSystem:setCurOptionIndex(index)
	self._curOptionIndex = index
end

function MazeSystem:setCurChapterIndex(index)
	self._curChapterIndex = index
end

function MazeSystem:getOptionIndex()
	return self._curOptionIndex
end

function MazeSystem:getChapterIndex()
	return self._curChapterIndex
end

function MazeSystem:setHaveMaster(have)
	if self._haveMaster == true then
		-- block empty
	else
		self._haveMaster = have
	end
end

function MazeSystem:haveMaster()
	return self._haveMaster
end

function MazeSystem:getMasterSkill()
	return self._player._mazeTeam:getMazeMasterSkill()
end

function MazeSystem:getMazeTeam()
	return self._player._mazeTeam
end

function MazeSystem:getMasterTreasure()
	return self._mazeChapter:getTreasures()
end

function MazeSystem:setOptionEventName(optionname)
	self._optionEventName = optionname
end

function MazeSystem:getOptionEventName()
	return self._optionEventName
end

function MazeSystem:haveQuestion()
	if self._mazeChapter then
		local showOptions = self._mazeChapter:getShowOptions()

		for k, v in pairs(showOptions) do
			if v:isTypeEnemy() and v:haveQuestion() then
				return true, v:getQuestionDesc()
			end
		end
	end

	return false, ""
end

function MazeSystem:haveBossSuspect()
	if self._mazeChapter then
		local showOptions = self._mazeChapter:getShowOptions()

		for k, v in pairs(showOptions) do
			if v:isTypeBoss() and v:haveSuspect() then
				return true, v:getClueSetIds()
			end
		end

		return false
	else
		return false
	end
end

function MazeSystem:getBossSuspectEff()
	if self._mazeChapter then
		local showOptions = self._mazeChapter:getShowOptions()

		for k, v in pairs(showOptions) do
			if v:getType() == "Boss" and v:haveSuspect() then
				return v:getSuspectEff(self._mazeChapter:getChapterId())
			end
		end
	end
end

function MazeSystem:getBossSuspectQues()
	if self._mazeChapter then
		local showOptions = self._mazeChapter:getShowOptions()

		for k, v in pairs(showOptions) do
			if v:getType() == "Boss" and v:haveSuspect() then
				return v:getSuspectQuestion(self._mazeChapter:getChapterId())
			end
		end
	end
end

function MazeSystem:getClueSet()
	if self._mazeChapter then
		local showOptions = self._mazeChapter:getShowOptions()
		local clueset = {}

		for k, v in pairs(showOptions) do
			if v:getType() == "Enemy" and v:haveQuestion() then
				clueset = v:getClueSet()
			end
		end

		return clueset
	end

	return nil
end

function MazeSystem:getClueSetId()
	if self._mazeChapter then
		local showOptions = self._mazeChapter:getShowOptions()
		local clueset = {}

		for k, v in pairs(showOptions) do
			if v:getType() == "Enemy" and v:haveQuestion() then
				clueset = v:getClueSetId()
			end
		end

		return clueset
	else
		return nil
	end
end

function MazeSystem:getClueOptionIndex()
	if self._mazeChapter then
		local showOptions = self._mazeChapter:getShowOptions()

		for k, v in pairs(showOptions) do
			if v:getType() == "Enemy" then
				if v:haveQuestion() then
					return k
				end
			elseif v:getType() == "Boss" then
				return k
			end
		end
	end
end

function MazeSystem:checkTeamHeroLimit()
	local num = 0

	for k, v in pairs(self._heros) do
		if v ~= nil then
			num = num + 1
		end
	end

	print("队伍中英魂数量:", num)

	if num >= 10 then
		return true
	else
		return false
	end
end

function MazeSystem:requestFirstEnterMaze(mazeType, level, callback)
	local params = {
		eventId = mazeType,
		type = level
	}

	if GameConfigs.mazeDebugMode then
		dump(params, "首次进入迷宫参数")
	end

	self._mazeService:requestFirstEnterMaze(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._mazeChapter:setShowOptions(response.data)
		else
			dump("-->>>>>>>>>", response.resCode)
		end

		if callback then
			callback(response)
		end
	end)
end

function MazeSystem:requestMazeEnableTalent(eId, tId, callback)
	local params = {
		eventId = eId,
		talentId = tId
	}

	if GameConfigs.mazeDebugMode then
		dump(params, "点亮指定推理事件的指定天赋")
	end

	self._mazeService:requestMazeEnableTalent(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_MAZE_TALENT_ENABLE_SUC, nil))
		end

		if callback then
			callback(response)
		end
	end)
end

function MazeSystem:requestMazeResetTalent(eId, callback)
	local params = {
		eventId = eId
	}

	if GameConfigs.mazeDebugMode then
		dump(params, "重置指定推理事件的全部天赋")
	end

	self._mazeService:requestMazeResetTalent(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_MAZE_TALENT_ENABLE_SUC, nil))
		end

		if callback then
			callback(response)
		end
	end)
end

function MazeSystem:requestGetDpReward(eId, edp, callback)
	local params = {
		eventId = eId,
		dp = edp
	}

	if GameConfigs.mazeDebugMode then
		dump(params, "领取dp奖励")
	end

	self._mazeService:requestGetDpReward(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_MAZE_DPBOX_REWARD_GET_SUC, nil))
			print("---领取极限推理dp奖励成功---")
		end

		if callback then
			callback(response)
		end
	end)
end

function MazeSystem:requestNextChapterMaze(eid, callback)
	local params = {
		eventId = eid
	}

	if GameConfigs.mazeDebugMode then
		dump(params, "进入下一章节")
	end

	self._mazeService:requestNextChapterMaze(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._mazeChapter:setShowOptions(response.data)
		end

		if callback then
			callback(response)
		end
	end)
end

function MazeSystem:requestOverMaze(mazeType, callback)
	local params = {
		eventId = mazeType
	}

	if GameConfigs.mazeDebugMode then
		dump(params, "结束迷宫")
	end

	self._mazeService:requestOverMaze(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			dump(response, "结束迷宫")
		end

		if callback then
			callback(response)
		end
	end)
end

function MazeSystem:requestMazeSelectMasterBuff(eid, lv, bid, callback)
	local params = {
		eventId = eid,
		level = lv,
		buffId = bid
	}

	if GameConfigs.mazeDebugMode then
		dump(params, "--选择主角等级对应的buff")
	end

	self._mazeService:requestMazeSelectMasterBuff(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_MAZE_BUFF_SUC, nil))
		end

		if callback then
			callback(response)
		end
	end)
end

function MazeSystem:requestDelOneOption(eid, id, callback)
	local params = {
		eventId = eid,
		index = tonumber(id)
	}

	self._mazeService:requestDelOneOption(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._mazeChapter:setShowOptions(response.data)
			self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
		end

		if callback then
			callback(response)
		end
	end)
end

function MazeSystem:requestMazeBattleBefor(id, callback)
	local mazeType = self._mazeEvent:getConfigId()
	local params = {
		eventId = mazeType,
		index = tonumber(id)
	}

	self._mazeService:requestMazeBattleBefor(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			local playerData = response.data.data.playerData
			local enemyData = response.data.data.enemyData
			local pointid = response.data.data.pointId

			self:enterBattle(playerData, enemyData, pointid)

			if callback then
				callback()
			end
		end
	end)
end

function MazeSystem:requestMazeFinalBossBattleBefore(eid, sid, callback)
	local params = {
		eventId = eid,
		suspectId = sid
	}

	self._mazeService:requestMazeFinalBossBattleBefore(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			local playerData = response.data.data.playerData
			local enemyData = response.data.data.enemyData
			local pointid = response.data.data.pointId

			self:enterFinalBossBattle(playerData, enemyData, pointid)

			if callback then
				callback()
			end
		end
	end)
end

function MazeSystem:requestMazeFinalBossBattleResult(eid, sid, battleresult, callback)
	local params = {
		eventId = eid,
		suspectId = sid,
		result = battleresult
	}

	self._mazeService:requestMazeFinalBossBattleResult(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			dump(response, "--------最终嫌疑人boss战斗结果--------")

			self._finalBossReward = response.data.reward

			if callback then
				callback()
			end
		end
	end)
end

function MazeSystem:requestMazestStartOption(id, param, callback)
	local mazeType = self._mazeEvent:getConfigId()
	local params = {
		eventId = mazeType,
		index = tonumber(id),
		params = param
	}

	self._mazeService:requestMazestStartOption(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if self._mazeChapter then
				self._mazeChapter:setShowOptions(response.data)
			end

			if self:getOptionEventName() ~= "" then
				self:dispatch(Event:new(self:getOptionEventName(), response))
				self:setOptionEventName("")
			end

			if callback then
				callback(response)
			end
		end
	end)
end

function MazeSystem:requestMazeEventSkillId(mazeType, param, callback)
	local params = {
		eventId = mazeType,
		params = param
	}

	if GameConfigs.mazeDebugMode then
		-- block empty
	end

	self._mazeService:requestMazeEventSkillId(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			dump(response, "---使用事件技能成功---")
			self:dispatch(Event:new(EVT_MAZE_EVENT_SKILL_SUC, response))
		end

		if callback then
			callback(response)
		end
	end)
end

function MazeSystem:tryEnter()
	if self:getIsInPoint() and self._mazeState == 0 then
		local view = self:getInjector():getInstance("MazeMainView")
		local data = {}

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
	else
		local view = self:getInjector():getInstance("MazeEventMainView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))
	end
end

function MazeSystem:checkSystemEnable()
	local unlock, tips = self._systemKeeper:isUnlock("PansLabNormal")

	return unlock, tips
end

function MazeSystem:requestMazestUseTreasure(mazeType, id, callback)
	local params = {
		eventId = mazeType,
		itemId = id
	}

	if GameConfigs.mazeDebugMode then
		dump(params, "使用宝物")
	end

	self._mazeService:requestMazestUseTreasure(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._mazeChapter:setShowOptions(response.data)

			if GameConfigs.mazeDebugMode then
				dump(response, "使用宝物_返回")
			end

			self:dispatch(Event:new(EVT_MAZE_TREASURE_USE_SUC, response))

			if callback then
				callback(response)
			end
		end
	end)
end

function MazeSystem:enterFinalBossBattle(playerData, enemyData, pointId)
	local battleType = SettingBattleTypes.kMaze
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(battleType)
	local isReplay = false
	local outSelf = self
	local battleDelegate = {}
	local randomSeed = tonumber(tostring(os.time()):reverse():sub(1, 6))
	local battleSession = MazeFinalBossBattleSession:new({
		playerData = playerData,
		enemyData = enemyData,
		pointId = pointId,
		logicSeed = randomSeed
	})

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

	local battlePassiveSkill = battleSession:getBattlePassiveSkill()
	local logicInfo = {
		director = battleDirector,
		interpreter = battleInterpreter,
		teams = battleSession:genTeamAiInfo(),
		mainPlayerId = {
			playerData.rid
		}
	}
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
	local speedOpenSta = systemKeeper:getBattleSpeedOpen("maze_battle")

	function battleDelegate:onAMStateChanged(sender, isAuto)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(battleType, isAuto)
	end

	function battleDelegate:onLeavingBattle()
		BattleLoader:popBattleView(outSelf)
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

	function battleDelegate:onBattleFinish(result)
		local realData = battleSession:getResultSummary()

		realData.sid = pointId, outSelf:finalBossBattleResultCallBack(realData)
	end

	function battleDelegate:onDevWin()
		local realData = {
			randomSeed = 123321,
			opData = "dev",
			result = kBattleSideAWin,
			winners = {
				playerData.rid
			},
			statist = {
				totalTime = 10000,
				roundCount = 4,
				players = {
					[playerData.rid] = {
						unitsDeath = 0,
						hpRatio = 0.99999,
						unitsTotal = 3
					},
					[pointId] = {
						unitsDeath = 20,
						hpRatio = 0,
						unitsTotal = 20
					}
				}
			}
		}

		outSelf:finalBossBattleResultCallBack(realData)
	end

	function battleDelegate:onTimeScaleChanged(timeScale)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(battleType, nil, timeScale)
	end

	function battleDelegate:showBossCome(pauseFunc, resumeCallback, paseSta)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if resumeCallback then
				resumeCallback()
			end
		end

		local bossView = outSelf:getInjector():getInstance("battleBossComeView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
			paseSta = paseSta
		}, popupDelegate))

		if pauseFunc then
			pauseFunc()
		end
	end

	function battleDelegate:onShowRestraint(continueCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender)
			continueCallback()
		end

		local view = outSelf:getInjector():getInstance("battlerofessionalRestraintView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}, popupDelegate))
	end

	local pointConfig = ConfigReader:getRecordById("PansLabFightPoint", pointId)

	if not pointConfig.Background then
		if not pointConfig.BGM then
			local BGM = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Music_BattleBGM_Maze", "content")
			local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
			local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
			local var_102_1 = {
				battleData = battleData,
				battleConfig = battleConfig,
				isReplay = isReplay,
				logicInfo = logicInfo,
				delegate = battleDelegate
			}
			local var_102_2 = {
				opPanelClazz = "BattleUIMediator",
				mainView = "battlePlayer",
				opPanelRes = "asset/ui/BattleUILayer.csb",
				canChangeSpeedLevel = true,
				finalHitShow = true,
				finalTaskFinishShow = true,
				battleSettingType = battleType,
				battleType = battleSession:getBattleType(),
				bulletTimeEnabled = BattleLoader:getBulletSetting("BulletTime_PVE_Tower"),
				bgm = BGM,
				background = pointConfig.Background,
				refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content,
				battleSuppress = BattleDataHelper:getBattleSuppress()
			}

			var_102_2.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
			var_102_2.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
			var_102_2.passiveSkill = battlePassiveSkill
			var_102_2.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
			var_102_2.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("maze_battle")

			local var_102_3 = {}
			local var_102_4 = {}

			var_102_4.visible = speedOpenSta and self:getInjector():getInstance(SystemKeeper):canShow("BattleSpeed")
			var_102_4.lock = not unlockSpeed
			var_102_4.tip = tipsSpeed
			var_102_4.speedConfig = battleSpeed_Actual
			var_102_4.speedShowConfig = battleSpeed_Display
			var_102_4.timeScale = timeScale
			var_102_3.speed = var_102_4
			var_102_3.skip = {
				visible = false
			}

			local var_102_5 = {}

			var_102_5.visible = self:getInjector():getInstance(SystemKeeper):canShow("AutoFight")
			var_102_5.state = isAuto
			var_102_5.lock = not systemKeeper:isUnlock("AutoFight")
			var_102_3.auto = var_102_5
			var_102_3.pause = {
				visible = true
			}

			local var_102_6 = {}

			var_102_6.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
			var_102_6.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
			var_102_3.restraint = var_102_6
			var_102_2.btnsShow = var_102_3
			var_102_1.viewConfig = var_102_2
			var_102_1.loadingType = LoadingType.KMaze

			local data = var_102_1

			BattleLoader:pushBattleView(self, data)
		end
	end
end

function MazeSystem:enterBattle(playerData, enemyData, pointId)
	local battleType = SettingBattleTypes.kMaze
	local isAuto, timeScale = self:getInjector():getInstance(SettingSystem):getSettingModel():getBattleSetting(battleType)
	local isReplay = false
	local outSelf = self
	local battleDelegate = {}
	local randomSeed = tonumber(tostring(os.time()):reverse():sub(1, 6))
	local battleSession = StageMazeBattleSession:new({
		playerData = playerData,
		enemyData = enemyData,
		pointId = pointId,
		logicSeed = randomSeed
	})

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

	local battlePassiveSkill = battleSession:getBattlePassiveSkill()
	local logicInfo = {
		director = battleDirector,
		interpreter = battleInterpreter,
		teams = battleSession:genTeamAiInfo(),
		mainPlayerId = {
			playerData.rid
		}
	}
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
	local speedOpenSta = systemKeeper:getBattleSpeedOpen("maze_battle")

	function battleDelegate:onAMStateChanged(sender, isAuto)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(battleType, isAuto)
	end

	function battleDelegate:onLeavingBattle()
		BattleLoader:popBattleView(outSelf)
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

	function battleDelegate:onBattleFinish(result)
		local realData = battleSession:getResultSummary()

		outSelf:battleResultCallBack(realData)
	end

	function battleDelegate:onDevWin()
		local realData = {
			randomSeed = 123321,
			opData = "dev",
			result = kBattleSideAWin,
			winners = {
				playerData.rid
			},
			statist = {
				totalTime = 10000,
				roundCount = 4,
				players = {
					[playerData.rid] = {
						unitsDeath = 0,
						hpRatio = 0.99999,
						unitsTotal = 3
					},
					[pointId] = {
						unitsDeath = 20,
						hpRatio = 0,
						unitsTotal = 20
					}
				}
			}
		}

		outSelf:battleResultCallBack(realData)
	end

	function battleDelegate:onTimeScaleChanged(timeScale)
		outSelf:getInjector():getInstance(SettingSystem):getSettingModel():setBattleSetting(battleType, nil, timeScale)
	end

	function battleDelegate:showBossCome(pauseFunc, resumeCallback, paseSta)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if resumeCallback then
				resumeCallback()
			end
		end

		local bossView = outSelf:getInjector():getInstance("battleBossComeView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
			paseSta = paseSta
		}, popupDelegate))

		if pauseFunc then
			pauseFunc()
		end
	end

	function battleDelegate:onShowRestraint(continueCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender)
			continueCallback()
		end

		local view = outSelf:getInjector():getInstance("battlerofessionalRestraintView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}, popupDelegate))
	end

	local pointConfig = ConfigReader:getRecordById("PansLabFightPoint", pointId)

	if not pointConfig.Background then
		if not pointConfig.BGM then
			local BGM = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Music_BattleBGM_Maze", "content")
			local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
			local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")
			local var_115_1 = {
				battleData = battleData,
				battleConfig = battleConfig,
				isReplay = isReplay,
				logicInfo = logicInfo,
				delegate = battleDelegate
			}
			local var_115_2 = {
				finalHitShow = true,
				mainView = "battlePlayer",
				opPanelRes = "asset/ui/BattleUILayer.csb",
				canChangeSpeedLevel = true,
				opPanelClazz = "BattleUIMediator",
				finalTaskFinishShow = true,
				battleSettingType = battleType,
				battleType = battleSession:getBattleType(),
				bulletTimeEnabled = BattleLoader:getBulletSetting("BulletTime_PVE_Tower"),
				bgm = BGM,
				background = pointConfig.Background,
				refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content,
				battleSuppress = BattleDataHelper:getBattleSuppress()
			}

			var_115_2.hpShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getHpShowSetting()
			var_115_2.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
			var_115_2.passiveSkill = battlePassiveSkill
			var_115_2.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
			var_115_2.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("maze_battle")

			local var_115_3 = {}
			local var_115_4 = {}

			var_115_4.visible = speedOpenSta and self:getInjector():getInstance(SystemKeeper):canShow("BattleSpeed")
			var_115_4.lock = not unlockSpeed
			var_115_4.tip = tipsSpeed
			var_115_4.speedConfig = battleSpeed_Actual
			var_115_4.speedShowConfig = battleSpeed_Display
			var_115_4.timeScale = timeScale
			var_115_3.speed = var_115_4
			var_115_3.skip = {
				visible = false
			}

			local var_115_5 = {}

			var_115_5.visible = self:getInjector():getInstance(SystemKeeper):canShow("AutoFight")
			var_115_5.state = isAuto
			var_115_5.lock = not systemKeeper:isUnlock("AutoFight")
			var_115_3.auto = var_115_5
			var_115_3.pause = {
				visible = true
			}

			local var_115_6 = {}

			var_115_6.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
			var_115_6.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
			var_115_3.restraint = var_115_6
			var_115_2.btnsShow = var_115_3
			var_115_1.viewConfig = var_115_2
			var_115_1.loadingType = LoadingType.KMaze

			local data = var_115_1

			BattleLoader:pushBattleView(self, data)
		end
	end
end

function MazeSystem:requestPass(mapId, pointId, resultData, callback, blockUI)
	local params = {
		mapId = mapId,
		pointId = pointId,
		resultData = resultData
	}
	local pointInfo = self:getPointById(pointId)

	pointInfo:recordOldStar()
	Bdump("requestPass:{}", params)
	self._stageService:requestPass(params, function(response)
		if response.resCode == GS_SUCCESS and (not response.data.pointData or true) then
			self:dispatch(Event:new(EVT_STAGE_FIGHT_SUCC, {}))

			if callback then
				callback(response.data)
			end
		end
	end, blockUI)
end

function MazeSystem:finalBossBattleResultCallBack(realData, mapData, winCallBack)
	self:requestMazeFinalBossBattleResult(self._mazeEvent:getConfigId(), realData.sid, realData, function(response)
		if realData.result == 1 then
			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("FightWinView"), {}, {
				rewards = {
					itemRewards = self._finalBossReward
				},
				maze = self._mazeType,
				mazeState = self:getMazeState(),
				mazedispatcher = self
			}, self))

			if self._mazeState == 0 then
				self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
			end
		else
			local loseData = {
				isMaze = true,
				roundCount = realData.statist.roundCount,
				mazeState = self:getMazeState(),
				mazedispatcher = self
			}

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("FightLoseView"), {}, loseData, self))
		end
	end, false)
end

function MazeSystem:battleResultCallBack(realData, mapData)
	self:requestMazestStartOption(self:getOptionIndex(), realData, function(response)
		if GameConfigs.mazeDebugMode and self._mazeChapter then
			self._mazeChapter:setShowOptions(response.data)
		end

		if realData.result == 1 then
			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("FightWinView"), {}, {
				rewards = {
					itemRewards = self:getCurOptionReward()
				},
				maze = self._mazeType,
				mazeState = self:getMazeState()
			}, self))

			if self._mazeState == 0 then
				self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
			end
		else
			local loseData = {
				isMaze = true,
				roundCount = realData.statist.roundCount,
				mazeState = self:getMazeState(),
				mazedispatcher = self
			}

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("FightLoseView"), {}, loseData, self))
		end
	end, false)
end

function MazeSystem:gameOver()
	self._chapterCount = 0
	self._optionCount = 0
	self._masterList = {}
	self._selectMaster = nil
	self._treasures = nil
	self._nextChapterIds = nil
	self._mazeChapter = nil
	self._leftOptionsList = {}
	self._masterList = {}
	self._masterId = nil
	self._master = {}
	self._heros = nil
	self._mazeType = ""
	self._haveMaster = false

	self._player._mazeTeam:clearData()
end

function MazeSystem:createOneMasterAni(modelid, gray, play)
	local modelId = modelid
	local pre = "asset/anim/"

	print("要创建的模型id--->", modelId)

	local jsonFile = pre .. modelId .. ".skel"

	if not cc.FileUtils:getInstance():isFileExist(jsonFile) then
		modelId = ConfigReader:getDataByNameIdAndKey("EnemyMaster", modelId, "RoleModel")

		local modle = ConfigReader:getDataByNameIdAndKey("RoleModel", modelId, "Model")

		jsonFile = pre .. modle .. ".skel"
	end

	local roleAnim = sp.SkeletonAnimation:create(jsonFile)

	if gray then
		roleAnim:setGray(gray)
	else
		roleAnim:setGray(true)
	end

	if play then
		roleAnim:playAnimation(0, "stand", true)
	end

	return roleAnim
end

function MazeSystem:enterTeamView(data)
	local view = self:getInjector():getInstance("MazeTeamView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
end
