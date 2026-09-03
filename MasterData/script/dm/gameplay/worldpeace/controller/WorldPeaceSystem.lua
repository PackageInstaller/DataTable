-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/controller/WorldPeaceSystem.lua

EVT_WORLDPEACE_APPLY_SUCC = "EVT_WORLDPEACE_APPLY_SUCC"
EVT_WORLDPEACE_GET_REWARD_SUCC = "EVT_WORLDPEACE_GET_REWARD_SUCC"
EVT_WORLDPEACE_MATCH_END = "EVT_WORLDPEACE_MATCH_END"
EVT_WORLDPEACE_BATTLE_FINISH = "EVT_WORLDPEACE_BATTLE_FINISH"
EVT_WORLDPESCE_MAIN_CLOSE = "EVT_WORLDPESCE_MAIN_CLOSE"
EVT_WORLDPEACE_TASK_REFRESH = "EVT_WORLDPEACE_TASK_REFRESH"
WorldPeaceSystem = class("WorldPeaceSystem", legs.Actor)

WorldPeaceSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
WorldPeaceSystem:has("_wordPeaceGame", {
	is = "rw"
})
WorldPeaceSystem:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")
WorldPeaceSystem:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
WorldPeaceSystem:has("_battlefield", {
	is = "rw"
})
WorldPeaceSystem:has("_mainPlayer", {
	is = "rw"
})
WorldPeaceSystem:has("_wordService", {
	is = "r"
}):injectWith("WorldPeaceService")
WorldPeaceSystem:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
WorldPeaceSystem:has("_worldPeace", {
	is = "rw"
})
WorldPeaceSystem:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

WorldPeaceSwearBehaviorWithBoss = {
	KPraise = 1,
	KGift = 2
}
WorldPeaceSwearBehaviorWithClub = {
	KGrab = 1
}
viewRankType = {
	kRule = 5,
	kHurt = 2,
	kScore = 3,
	kClub = 1,
	kTask = 4
}

function WorldPeaceSystem:initialize()
	super.initialize(self)
end

function WorldPeaceSystem:step(dt)
	if self._battlefield then
		self._battlefield:step(dt)
	end
end

function WorldPeaceSystem:getBattlefield()
	self._battlefield = self._battlefield or WolrdBattleField:new()

	return self._battlefield
end

function WorldPeaceSystem:getMainPlayer()
	self._mainPlayer = self._mainPlayer or MainPlayer:new()

	return self._mainPlayer
end

function WorldPeaceSystem:getWorldPeace()
	self._worldPeace = self._worldPeace or WorldPeace:new()

	return self._worldPeace
end

function WorldPeaceSystem:getWorldSwearChat()
	self._worldSwearChat = self._worldSwearChat or WorldSwearChat:new()

	return self._worldSwearChat
end

function WorldPeaceSystem:userInject(injector)
	self:listenPush()
end

function WorldPeaceSystem:listenPush()
	self._wordService:listenPushBattleField(function(data)
		if data then
			data.collectInfo = self:getBattlefield():collect(data.battleField)

			local isDirty = self:getMainPlayer():synchronize(data)

			if isDirty then
				data.collectInfo = self:getBattlefield():collect(data.battleField)
			end

			for k, v in pairs(data.collectInfo) do
				if self._mainPlayer:getTeamStatus()[k] then
					data.collectInfo[k] = self._mainPlayer:getTeamStatus()[k] ~= "REST" and "reload" or nil
				end
			end

			if self:getStatus() ~= WPStatus.kBattle then
				for k, v in pairs(data.battleField.bossData) do
					for k_, v_ in pairs(v.aTeams) do
						data.collectInfo[v_.teamKey] = true
					end
				end

				for k, v in pairs(data.battleField.bossData) do
					for k_, v_ in pairs(v.dTeams) do
						data.collectInfo[v_.teamKey] = true
					end
				end

				for k, v in pairs(data.collectInfo) do
					if self._mainPlayer:getTeamStatus()[k] then
						data.collectInfo[k] = "reload"
					end
				end
			end

			self:getBattlefield():clear()
			self:getBattlefield():synchronize(data)
			self:dispatch(Event:new(EVT_WORDPEACE_BATTLEFEILD_REFRESH, data))
		end
	end)
	self._wordService:listenPushWordBossReward(function()
		local boss = self._developSystem:getWorldBoss()

		boss.rewardStatus = 1

		self._developSystem:setWorldBoss(boss)
		self:dispatch(Event:new(EVT_WORDBOSS_CANREWARD, boss))
	end)
	self._wordService:listenPushClubBossDead(function(data)
		if data then
			self._clubSystem:getClub():synchronizeClubBossNew(data)
			self:dispatch(Event:new(EVT_CLUBBOSS_BOSSDEAD_REFRESH, data))
		end
	end)
	self._wordService:listenPushClubBossResetOne(function(data)
		if data then
			self:dispatch(Event:new(EVT_CLUBBOSS_RSETONE_REFRESH, data))
		end
	end)
	self._wordService:listenPushClubBossEnterTwo(function(data)
		if data then
			self:dispatch(Event:new(EVT_CLUBBOSS_ENTERTWO_REFRESH, data))
		end
	end)
	self._wordService:listenPushClubBossPlayerDead(function(data)
		if data then
			self:dispatch(Event:new(EVT_CLUBBOSS_PLAYERDEAD_REFRESH, data))
		end
	end)
	self._wordService:listenPushWordPeaceSwear(function(data)
		if data then
			if data.bfId == self:getWorldPeace():getBattleFieldId() then
				self:pullSwearData()
			end

			self:dispatch(Event:new(EVT_WORDPEACE_SWEAR_SYSTEMCHAT_REFRESH, data))
		end
	end)
	self:listenBattleFinish()
	self:listenMatchFinish()
end

function WorldPeaceSystem:pullSwearData(callback)
	self._wordService:enterSwearMain({}, false, function(response)
		if callback then
			callback()
		end

		local data = response.data

		if data then
			self:getWorldSwearChat():synchronize(data)
			self:dispatch(Event:new(EVT_WORDPEACE_SWEAR_GROUPINFO_REFRESH, data))
		end
	end)
end

function WorldPeaceSystem:synchronize(data)
	return
end

function WorldPeaceSystem:recallTeam(param, isBlockUI, callback)
	self._wordService:recallTeam(param, isBlockUI, function(response)
		if response.data then
			self._mainPlayer:synchronize(response.data)
			self:dispatch(Event:new(EVT_WORDPEACE_PLAYER_REFRESH, response.data))
		end

		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceSystem:cureTeam(param, isBlockUI, callback)
	self._wordService:cureTeam(param, isBlockUI, function(response)
		if response.data then
			self._mainPlayer:synchronize(response.data)
			self:dispatch(Event:new(EVT_WORDPEACE_PLAYER_REFRESH, response.data))
		end

		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceSystem:sendBossTag(param, isBlockUI, callback)
	self._wordService:sendBossTag(param, isBlockUI, function(response)
		if response.data then
			local cjson = require("cjson.safe")

			response.data.bossTag = cjson.decode(response.data.bossTag)

			self:getBattlefield():setGroup(response.data)

			local bossList = self:getBattlefield():getBossList()

			for k, v in pairs(bossList) do
				v:synchronizeTagInfo(nil)
			end

			for k, v in pairs(response.data.bossTag or {}) do
				bossList[v]:synchronizeTagInfo(k)
			end

			self:dispatch(Event:new(EVT_WORDPEACE_COMMON_REFRESH, response.data))

			if callback then
				callback(response)
			end
		elseif callback then
			callback(response)
		end
	end)
end

function WorldPeaceSystem:worldBossFinish(param, isBlockUI, callback)
	self._wordService:worldBossFinish(param, isBlockUI, function(response)
		if response.data then
			if response.data.bossIndex then
				local boss = self:getBattlefield():getBossById(param.bossId)

				if boss then
					if response.data.bossIndex ~= boss:getIndex() then
						boss:setIndex(response.data.bossIndex)
						boss:setMhp(response.data.bossReleaseHp)
					end

					boss:setHpr(response.data.bossReleaseHp)
				end
			end

			self._mainPlayer:synchronize(response.data)
			self:dispatch(Event:new(EVT_WORDPEACE_BOSS_REFRESH, response.data))
		end

		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceSystem:speedUp(param, isBlockUI, callback)
	self._wordService:speedUp(param, isBlockUI, function(response)
		if response.data then
			self._mainPlayer:synchronize(response.data)
			self:dispatch(Event:new(EVT_WORDPEACE_PLAYER_REFRESH, response.data))
		end

		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceSystem:attackBoss(param, isBlockUI, callback)
	self._wordService:attackBoss(param, isBlockUI, function(response)
		if response.data then
			self._mainPlayer:synchronize(response.data)
		end

		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceSystem:chooseBoss(param, isBlockUI, callback)
	self._wordService:chooseBoss(param, isBlockUI, function(response)
		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceSystem:getCurrentTime()
	return self._gameServerAgent:remoteTimestamp()
end

function WorldPeaceSystem:getPersonRankInfo(data, callback)
	local params = {
		viewType = data.type,
		rankType = data.type,
		start = data.rankStart,
		["end"] = data.rankEnd
	}

	params.rankType = data.type == 162 and 1 or 2

	dump(params, "params____paramsparams")
	self._wordService:getPersonRankInfo(params, isBlockUI, function(response)
		local data = response.data

		dump(response, "data____getPersonRankInfo")

		data.pr = data.self
		data.lb = data.players

		local syncTime = self:getCurrentTime()

		self._rankSystem:getRank():synchronize(response.data, params.viewType, syncTime)
		self:dispatch(Event:new(EVT_RANK_REQUEST_SUCC))

		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceSystem:quitBattle(param, isBlockUI, callback)
	self._wordService:quitBattle(param, isBlockUI, function(response)
		return
	end)
end

function WorldPeaceSystem:defenceBoss(param, isBlockUI, callback)
	self._wordService:defenceBoss(param, isBlockUI, function(response)
		if response.data then
			self._mainPlayer:synchronize(response.data)
		end

		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceSystem:getTeamState(teamKey)
	local state = self._mainPlayer:getTeamStatus()[teamKey]

	if state == "REST" then
		return k_TEAM_STATE.REST
	else
		local bossId = state
		local boss = self._battlefield:getBossById(bossId)

		if not boss then
			return k_TEAM_STATE.REST
		end

		local isAmemeber = boss:getATeamByKey(teamKey)
		local isDmemeber = boss:getDTeamByKey(teamKey)

		if isAmemeber then
			return k_TEAM_STATE.BATTLEING
		end

		if isDmemeber then
			return k_TEAM_STATE.PROTECTING
		end

		return k_TEAM_STATE.BATTLEING
	end
end

function WorldPeaceSystem:checkBossOwnBy(bossId, gid)
	local boss = self:getBattlefield():getBossById(bossId)

	if not boss then
		return false
	end

	local ownInfo = boss:getCamp()
	local tempownInfo = boss:getOwnCamp()

	gid = gid or self._mainPlayer:getGroupId()

	if ownInfo == gid then
		if tempownInfo ~= "" and ownInfo ~= tempownInfo then
			return false
		end

		return true
	end

	if tempownInfo == gid then
		return true
	end

	return false
end

function WorldPeaceSystem:checkCanAttack(bossId, camp)
	return true
end

function WorldPeaceSystem:tryEnterSwearDetailMain()
	local view = self:getInjector():getInstance("WordPeaceSwearDetailView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))
end

function WorldPeaceSystem:tryEnterMap(callback, endFunc)
	if callback and type(callback) == "table" and callback.viewType then
		callback = nil
	end

	self._wordService:enterBattle({}, true, function(response)
		local data = response.data

		if data then
			if data.player and data.battleField then
				self:getBattlefield():clear()

				data.player.teamLastAttackTime = {}

				self:getBattlefield():synchronize(data)
				self:getMainPlayer():synchronize(data)
				self:getMainPlayer():synchronize(data)
				self:getMainPlayer():synchronizeGInfo(self:getBattlefield():getGroupNameMap())
				delayCallByTime(0, function()
					self:dispatch(Event:new(EVT_WORDPEACE_ENTERMAP))
				end)
				delayCallByTime(100, function()
					if callback then
						callback()
					end
				end)
				delayCallByTime(callback and 300 or 0, function()
					self:enterBattleView(endFunc)
				end)
			else
				self:dispatch(ShowTipEvent({
					tip = Strings:get("ClubMapBoss_Chat_UI19")
				}))
			end
		end
	end)
end

function WorldPeaceSystem:enterBattleView(endFunc)
	self.runBgAnim = true

	AreanaNewLoadingModel:getInstance():clearByName("WorldPeaceMainView")
	AreanaNewLoadingModel:getInstance():showAnim(function()
		local director = cc.Director:getInstance()

		director:setAnimationInterval(0.016666666666666666)

		local view = self:getInjector():getInstance("WorldPeaceMainView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))

		if endFunc then
			endFunc()
		end
	end, {
		viewName = "WorldPeaceMainView"
	})
end

function WorldPeaceSystem:getBoss(bossData)
	self._clubBoss = self._clubBoss or ClubBossStageOne:new(bossData.id)

	if bossData then
		self._clubBoss.removeDatas = self:collect(bossData)

		self._clubBoss:synchronize(bossData)
	end

	return self._clubBoss
end

function WorldPeaceSystem:collect(bossData)
	local removeInfos = {}

	if bossData.aTeams then
		local newBollInfo = {}

		for k_, v_ in pairs(bossData.aTeams) do
			newBollInfo[k_] = v_.curHp

			if v_.curHp == 0 then
				removeInfos[k_] = true
			end
		end

		local oldBollInfo = {}

		for k, v_ in pairs(self._clubBoss:getATeams()) do
			oldBollInfo[k] = v_.curHp

			if v_.curHp == 0 then
				removeInfos[k] = true
			end
		end

		for k, v in pairs(oldBollInfo) do
			if not newBollInfo[k] then
				removeInfos[k] = true
			end
		end
	end

	for k, v in pairs(removeInfos) do
		-- block empty
	end

	return removeInfos
end

function WorldPeaceSystem:changeBossData(data)
	local bossData = data.boss
	local developSystem = DmGame:getInstance()._injector:getInstance("DevelopSystem")
	local myRid = developSystem:getRid()
	local atkInfoMap = {}
	local atkInfos = data.atkInfos

	if atkInfos then
		for i = 1, #atkInfos do
			local info = atkInfos[i]
			local rid = info.r

			if myRid ~= rid then
				atkInfoMap[rid] = atkInfoMap[rid] or {
					rid = rid,
					atkList = {}
				}

				local atkListInfo = atkInfoMap[rid].atkList

				atkListInfo[#atkListInfo + 1] = {
					rid = info.r,
					hurt = info.h,
					injured = info.injured,
					i = info.i
				}
			end
		end
	end

	if bossData and bossData.playerInfoMap then
		for rid, info in pairs(bossData.playerInfoMap) do
			if myRid ~= rid then
				atkInfoMap[rid] = atkInfoMap[rid] or {
					rid = rid
				}

				if bossData.playerInfoMap and bossData.playerInfoMap[rid] then
					atkInfoMap[rid].curHp = bossData.playerInfoMap[rid].c
					atkInfoMap[rid].maxHp = bossData.playerInfoMap[rid].m
					atkInfoMap[rid].nickName = bossData.playerInfoMap[rid].n
					atkInfoMap[rid].heroId = bossData.playerInfoMap[rid].h
					atkInfoMap[rid].buff = {}

					if bossData.pB and bossData.pB[rid] then
						atkInfoMap[rid].buff = bossData.pB[rid]
					end
				end
			end
		end
	end

	local changeData = {}

	changeData.aTeams = atkInfoMap
	changeData.curHp = bossData.curHp
	changeData.maxHp = bossData.maxHp
	changeData.status = bossData.status
	changeData.stage = bossData.stage
	changeData.rank = data.rank
	changeData.ownerRank = data.self
	changeData.id = bossData.id
	changeData.atkTimes = bossData.atkTimes
	changeData.playerInfoMap = bossData.playerInfoMap
	changeData.oneLastRecoverHpTime = bossData.oneLastRecoverHpTime
	changeData.twoStartTime = bossData.twoStartTime
	changeData.cB = bossData.cB
	changeData.pB = bossData.pB

	local clubBossNew = self._clubSystem:getClubBossNew()
	local bossData = clubBossNew:getBossById(bossData.id)

	if bossData then
		changeData.atk = bossData:getStage() == 1 and clubBossNew:getOneBossAtk() or 0
	end

	return changeData
end

function WorldPeaceSystem:tryEnterCLubBossFiled(param, isBlockUI, callback)
	self._clubBoss = nil
	param = param or {}

	local bossId = param.bossId
	local stage = param.stage
	local hasAnim = param.hasAnim
	local leftBossId = param.leftBossId
	local rightBossId = param.rightBossId

	self:clubBossHeart({
		bossId = bossId
	}, isBlockUI, function(response)
		if response.data and response.data.boss then
			if callback then
				callback()
			end

			local boss = self:getBoss(self:changeBossData(response.data))
			local viewPath = stage == 1 and "WorldPeaceBossStageOneView" or "WorldPeaceBossStageTwoView"
			local view = self:getInjector():getInstance(viewPath)

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
				bossId = bossId,
				boss = boss,
				hasAnim = hasAnim,
				showTimeAnim = param.showTimeAnim,
				leftBossId = leftBossId,
				rightBossId = rightBossId
			}))
		end
	end, isBlockUI)
end

function WorldPeaceSystem:clubBossHeart(param, isBlockUI, callback)
	self._wordService:clubBossHeart(param, isBlockUI, function(response)
		if response.data then
			-- block empty
		end

		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceSystem:clubBossOneStageAttack(param, isBlockUI, callback)
	self._wordService:clubBossOneStageAttack(param, isBlockUI, function(response)
		if response.data then
			-- block empty
		end

		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceSystem:clubBossTwoStageAttack(param, isBlockUI, callback)
	self._wordService:clubBossTwoStageAttack(param, isBlockUI, function(response)
		if response.data then
			-- block empty
		end

		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceSystem:clubBossRecover(param, isBlockUI, callback)
	self._wordService:clubBossRecover(param, isBlockUI, function(response)
		if response.data then
			-- block empty
		end

		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceSystem:getCampInfo(campId)
	for k, v in pairs(self._battlefield:getGroupNameMap()) do
		if v.gId == campId then
			return v
		end
	end
end

function WorldPeaceSystem:redPointShow()
	local status = self:getStatus()

	if status ~= WPStatus.kBattleRest and status ~= WPStatus.kResultShow then
		return false
	end

	local rewardStatus = self:getWorldPeace():getRewardStatus()

	if rewardStatus then
		for i, v in pairs(rewardStatus) do
			if v == 1 then
				return true
			end
		end
	end

	return false
end

function WorldPeaceSystem:hasRewardGetByType(type)
	if type == WPRewardType.kPersonTask then
		local tasks = self:getMainPlayer():getTask()

		for i, v in pairs(tasks) do
			if v.taskStatus == 1 then
				return true
			end
		end

		return false
	end

	local rewardStatus = self:getWorldPeace():getRewardStatusByType(type)

	return rewardStatus == 1
end

function WorldPeaceSystem:checkEnabled()
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("Arena_All")

	if not unlock then
		return unlock, tips, {
			type = 1
		}
	end

	unlock, tips = systemKeeper:isUnlock("ClubMapBoss")

	if not unlock then
		return unlock, tips, {
			type = 1
		}
	end

	if not self._clubSystem:getHasJoinClub() then
		return false, Strings:get("ClubNew_Apply_2"), {
			type = 3
		}
	end

	local day = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapApplyCondition1", "content")
	local gameServerAgent = DmGame:getInstance()._injector:getInstance("GameServerAgent")
	local curTime = gameServerAgent:remoteTimestamp()
	local developSystem = DmGame:getInstance()._injector:getInstance("DevelopSystem")
	local dis = 86400 * (day - 2) - (curTime - developSystem:getServerFirstDayEndTime() / 1000)

	if dis > 0 then
		local timeStr = TimeUtil:formatTimeStr(dis)

		return false, Strings:get("ClubMapBoss_TimeOpen", {
			time = timeStr
		}), {
			type = 2,
			dis = dis,
			timeStr = timeStr
		}
	end

	return true
end

function WorldPeaceSystem:isOpenDay()
	local needOpenDay = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapApplyCondition1", "content")

	return needOpenDay <= self._developSystem:getServerOpenDay(), needOpenDay - self._developSystem:getServerOpenDay()
end

function WorldPeaceSystem:tryEnter(callback)
	local unlock, tip = self:checkEnabled()

	if not unlock then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = tip
		}))
	else
		self:requestUpdateData(function(response)
			local curTime = self._gameServerAgent:remoteTimestamp()
			local timeList = self:getTimeList()

			print(os.date("applyTime  %Y-%m-%d %H:%M:%S", timeList.applyTime))
			print(os.date("applyTime2 %Y-%m-%d %H:%M:%S", timeList.applyTime2))
			print(os.date("enterTime %Y-%m-%d %H:%M:%S", timeList.enterTime))
			print(os.date("battleStartTime %Y-%m-%d %H:%M:%S", timeList.battleStartTime))
			print(os.date("battleStopTime %Y-%m-%d %H:%M:%S", timeList.battleStopTime))
			print(os.date("closeTime %Y-%m-%d %H:%M:%S", timeList.closeTime))
			print(os.date("聊天1 %Y-%m-%d %H:%M:%S", timeList.chatTime1))
			print(os.date("聊天2 %Y-%m-%d %H:%M:%S", timeList.chatTime2))
			print(os.date("聊天1PRE %Y-%m-%d %H:%M:%S", timeList.chatTime1PRE))
			print(os.date("聊天2LAST %Y-%m-%d %H:%M:%S", timeList.chatTime2LAST))
			print(os.date("聊天2PRE %Y-%m-%d %H:%M:%S", timeList.chatTime2PRE))
			print(os.date("curtime %Y-%m-%d %H:%M:%S", curTime))

			if curTime < timeList.applyTime then
				self:getWorldPeace():clearData()
			end

			if callback then
				callback()
			end

			if curTime < timeList.battleStartTime then
				AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

				local isMatch = self:getWorldPeace():getMatchGroup()

				if #isMatch > 0 then
					local isChatTime = curTime < timeList.battleStartTime and curTime > timeList.chatTime1PRE

					if isChatTime then
						self:tryEnterSwearMain()

						return
					else
						local view = self:getInjector():getInstance("WorldPeaceApplyView")

						self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))
					end
				end

				local view = self:getInjector():getInstance("WorldPeaceApplyView")

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))
			else
				self:tryEnterMap()
			end
		end, true)
	end
end

function WorldPeaceSystem:getClub()
	if not self._otherClub then
		require("dm.gameplay.club.model.Club")

		self._otherClub = Club:new(self)
	end

	return self._otherClub
end

function WorldPeaceSystem:getClubInfoOj()
	return self:getClub():getInfo()
end

function WorldPeaceSystem:getMemberRecordListOj()
	return self:getClub():getMemberRecordList()
end

function WorldPeaceSystem:enterBattleResultTips()
	self:requestUpdateData(function()
		local popupDelegate = {}

		function popupDelegate:willClose(sender)
			return
		end

		local view = self:getInjector():getInstance("WorldPeaceTopRankTipsView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {}, popupDelegate))
	end)
end

function WorldPeaceSystem:getOtherClubDetail(param, isBlockUI, callback)
	self._wordService:getOtherClubDetail(param, isBlockUI, function(response)
		if response.data then
			callback(response.data)
		end
	end)
end

function WorldPeaceSystem:tryEnterRankView(enterData, showTips)
	self:requestClubRank(function(response)
		local data = response and response.data

		if (showTips and not next(data) or nil) and false then
			local view = self:getInjector():getInstance("WorldPeaceRankView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, enterData))
		else
			self:dispatch(ShowTipEvent({
				tip = Strings:get("ClubMapBoss_State_BtnTips")
			}))
		end
	end, true)
end

function WorldPeaceSystem:getOwnCamp()
	local clubSystem = self:getInjector():getInstance(ClubSystem)
	local clubInfo = clubSystem:getClubInfoOj()
	local myGId = clubInfo:getClubId()
	local matchGroup = self._worldPeace:getMatchGroupChat()

	if matchGroup then
		self:setCampIndex(matchGroup)

		for k, v in pairs(matchGroup) do
			if v.gId == myGId then
				return v.camp, v.name
			end
		end
	end
end

function WorldPeaceSystem:setCampIndex(list)
	local clubSystem = self:getInjector():getInstance(ClubSystem)
	local clubInfo = clubSystem:getClubInfoOj()
	local myGId = clubInfo:getClubId()

	for i, v in pairs(list) do
		v.sort = i
	end

	table.sort(list, function(a, b)
		return a.gId < b.gId
	end)

	for i, v in pairs(list) do
		v.camp = i
	end

	table.sort(list, function(a, b)
		return a.sort < b.sort
	end)
end

function WorldPeaceSystem:getTodaySeasonDayIndex()
	local timeList = self:getTimeList()
	local curTime = self._gameServerAgent:remoteTimestamp()
	local openDay = timeList.openDay
	local curDate = TimeUtil:remoteDate("*t", curTime)
	local week = curDate.wday == 1 and 7 or curDate.wday - 1
	local battleDate = TimeUtil:remoteDate("*t", timeList.enterTime)
	local battleWeek = battleDate.wday == 1 and 7 or battleDate.wday - 1
	local startIndex = 1

	for i, v in pairs(openDay) do
		if tonumber(v) == battleWeek then
			startIndex = i
		end
	end

	local tureIndex = 1

	for i = startIndex, #openDay do
		if tonumber(openDay[i]) == tonumber(week) then
			local sameDay = TimeUtil:isSameDay(curTime, timeList.battleStartTime, {
				sec = 0,
				min = 0,
				hour = 0
			})

			tureIndex = sameDay and curTime > timeList.battleStartTime and i - startIndex + 1 or not sameDay and curTime <= timeList.battleStartTime and i - startIndex + 1 or i - 1 - startIndex + 1
		end
	end

	tureIndex = tureIndex < 1 and 1 or tureIndex
	tureIndex = tureIndex > 3 and 3 or tureIndex

	return tureIndex
end

function WorldPeaceSystem:isTodayBattle(timeList)
	local sameDay = TimeUtil:isSameDay(timeList.battleStartTime, timeList.enterTime, {
		sec = 0,
		min = 0,
		hour = 5
	})

	if sameDay then
		return true
	end

	return false
end

function WorldPeaceSystem:getStatus()
	local curTime = self._gameServerAgent:remoteTimestamp()
	local timeList = self:getTimeList()
	local status

	return curTime < timeList.applyTime and WPStatus.kApply or curTime < timeList.battleStartTime and WPStatus.kPrepare or curTime > timeList.battleStartTime and curTime <= timeList.closeTime and WPStatus.kBattle or WPStatus.kResultShow
end

function WorldPeaceSystem:getChatStatue()
	local curTime = self._gameServerAgent:remoteTimestamp()
	local timeList = self:getTimeList()
	local status

	return curTime > timeList.chatTime2PRE and WPChatStatue.kChat2 or WPChatStatue.kChat1
end

function WorldPeaceSystem:getTimeList()
	local curTime = self._gameServerAgent:remoteTimestamp()
	local curDate = TimeUtil:remoteDate("*t", curTime)
	local timeArr = {
		ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapApplyTime", "content"),
		ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapMatchTime", "content"),
		ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapEnterTime", "content"),
		ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBattleTime", "content"),
		ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapStopTime", "content"),
		ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapCloseTime", "content"),
		ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapChat1Time", "content"),
		(ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapChat2Time", "content"))
	}
	local wstateCfg = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapPhase", "content")

	local function genTimeCfg(index, timesp)
		local timesp = timesp or curTime

		index = index or 1

		local timeWeekCfg = {}

		for i = 1, 7 do
			local dayCfg = {}

			for k, v in pairs(timeArr) do
				local realOpenDate = TimeUtil:remoteDate("*t", timesp)

				dayCfg[k] = self:remoteTime(realOpenDate, v) + 86400 * (i - 1) * index
			end

			local curDate = TimeUtil:remoteDate("*t", timesp + 86400 * (i - 1) * index)
			local week = curDate.wday == 1 and 7 or curDate.wday - 1

			timeWeekCfg[#timeWeekCfg + 1] = {
				phase = wstateCfg[tostring(week)].Phase,
				timeCfg = dayCfg
			}
		end

		return timeWeekCfg
	end

	local timelist = {}

	self._timeList = self._timeList or {}

	local PhaseAEnum = {
		"applyTime",
		"matchtTime",
		"enterTime",
		"battleStartTime",
		"battleStopTime",
		"closeTime",
		"chatTime1",
		"chatTime2"
	}

	for k, v in pairs(self._timeList) do
		timelist[k] = v
	end

	for k, v in pairs(PhaseAEnum) do
		timelist[v] = timelist[v] or self:remoteTime(curDate, timeArr[k])
	end

	if self._timeList and self._timeList.closeTime and curTime > self._timeList.closeTime then
		self._timeList = {}
	end

	local function findNearestTs(timeWeekCfg, state, isrevert, compare)
		if isrevert then
			for i = #timeWeekCfg, 1, -1 do
				local v = timeWeekCfg[i]
				local containSt = false

				for k_, v_ in pairs(v.phase) do
					if v_ == state then
						containSt = true
					end
				end

				if containSt then
					if not compare then
						return v.timeCfg[state]
					end

					if compare(v.timeCfg[state], curTime) then
						return v.timeCfg[state]
					end
				end
			end
		else
			for k, v in pairs(timeWeekCfg) do
				local containSt = false

				for k_, v_ in pairs(v.phase) do
					if v_ == state then
						containSt = true
					end
				end

				if containSt then
					if not compare then
						return v.timeCfg[state]
					end

					if compare(v.timeCfg[state], curTime) then
						return v.timeCfg[state]
					end
				end
			end
		end
	end

	for i, v in pairs(PhaseAEnum) do
		if not self._timeList[v] then
			local isrevert = i == 1

			if findNearestTs(genTimeCfg(1), i, isrevert, function(a, b)
				return b < a
			end) then
				timelist[v] = findNearestTs(genTimeCfg(1), i, isrevert, function(a, b)
					return b < a
				end)
				self._timeList[v] = timelist[v]
			else
				self._timeList[v] = timelist[v]
			end
		end
	end

	timelist.closeTime2 = timelist.closeTime + 1800

	if curTime < timelist.closeTime2 then
		timelist[PhaseAEnum[1]] = findNearestTs(genTimeCfg(-1, timelist.closeTime - 86400), 1, false)
		timelist[PhaseAEnum[2]] = findNearestTs(genTimeCfg(-1, timelist.closeTime - 86400), 2, false)
		timelist[PhaseAEnum[3]] = findNearestTs(genTimeCfg(-1, timelist.closeTime - 86400), 3, false)
	else
		timelist[PhaseAEnum[6]] = findNearestTs(genTimeCfg(1, timelist.closeTime + 86400), 6, nil, function(a, b)
			return b < a
		end)
		timelist.closeTime2 = timelist.closeTime + 1800
	end

	timelist.chatTime1PRE = findNearestTs(genTimeCfg(-1, timelist.chatTime2), 7, true)
	timelist.chatTime2LAST = findNearestTs(genTimeCfg(1, timelist.chatTime2), 8, true)
	timelist.chatTime2PRE = findNearestTs(genTimeCfg(1, timelist.chatTime1PRE), 8, false)
	timelist.enterTime = timelist.battleStartTime
	timelist.battleStopTime = timelist.closeTime

	local openDayList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapOpenDay", "content")

	timelist.openDay = openDayList[1]
	self._timeList = timelist

	return timelist
end

function WorldPeaceSystem:getTimeList1()
	self:getTimeListExtra()

	local curTime = self._gameServerAgent:remoteTimestamp()
	local curDate = TimeUtil:remoteDate("*t", curTime)
	local week = curDate.wday == 1 and 7 or curDate.wday - 1
	local openDayList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapOpenDay", "content")
	local timeList = {}

	timeList.applyTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapApplyTime", "content")
	timeList.battleStartTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBattleTime", "content")
	timeList.battleStopTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapStopTime", "content")
	timeList.closeTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapCloseTime", "content")
	timeList.enterTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapEnterTime", "content")

	local curTimeList = {}

	for k, v in pairs(timeList) do
		curTimeList[k] = self:remoteTime(curDate, v)
	end

	local realOpenTime, realOpenDay

	for i, openDay in pairs(openDayList) do
		local openTime = curTime + (week <= openDay[1] and openDay[1] - week or week > openDay[1] and week < openDay[#openDay] and openDay[1] - week or week == openDay[#openDay] and (curTime < curTimeList.closeTime and openDay[1] - week or 7 - week + openDay[1]) or 7 - week + openDay[1]) * 86400

		if not realOpenTime then
			realOpenTime = openTime
			realOpenDay = openDay
		end

		if openTime < realOpenTime then
			realOpenTime = openTime
			realOpenDay = openDay
		end
	end

	local realCloseTime = realOpenTime + (#realOpenDay - 1) * 86400
	local realOpenDate = TimeUtil:remoteDate("*t", realOpenTime)
	local realCloseDate = TimeUtil:remoteDate("*t", realCloseTime)
	local realTimeList = {}

	realTimeList.applyTime = self:remoteTime(realOpenDate, timeList.applyTime)
	realTimeList.closeTime = self:remoteTime(realCloseDate, timeList.closeTime)
	realTimeList.enterTime = self:remoteTime(realOpenDate, timeList.enterTime)
	realTimeList.openDay = realOpenDay

	if curTime > curTimeList.battleStopTime then
		local sameDay = TimeUtil:isSameDay(curTimeList.battleStartTime, realTimeList.closeTime, {
			sec = 0,
			min = 0,
			hour = 5
		})

		if not sameDay then
			local nextStartTime = curTimeList.battleStartTime + 86400
			local date = TimeUtil:remoteDate("*t", nextStartTime)

			realTimeList.battleStartTime = self:remoteTime(date, timeList.battleStartTime)
			realTimeList.battleStopTime = self:remoteTime(date, timeList.battleStopTime)
		else
			realTimeList.battleStartTime = self:remoteTime(curDate, timeList.battleStartTime)
			realTimeList.battleStopTime = self:remoteTime(curDate, timeList.battleStopTime)
		end
	else
		realTimeList.battleStartTime = self:remoteTime(curDate, timeList.battleStartTime)
		realTimeList.battleStopTime = self:remoteTime(curDate, timeList.battleStopTime)
	end

	return realTimeList
end

function WorldPeaceSystem:remoteTime(date, time)
	local parts = string.split(time, "[:-]", nil, true)

	return TimeUtil:timeByRemoteDate({
		sec = 0,
		year = date.year,
		month = date.month,
		day = date.day,
		hour = parts[1],
		min = parts[2]
	})
end

function WorldPeaceSystem:formatShowNum(count)
	if count <= 99999 then
		return tostring(math.floor(count))
	else
		local curLanage = getCurrentLanguage()

		if curLanage == GameLanguageType.CN then
			count = count - count % 1000
			count = string.format("%.1f", count / 10000) .. "w"
		else
			count = count - count % 100
			count = string.format("%.1f", count / 1000) .. "k"
		end

		return count
	end

	return 0
end

function WorldPeaceSystem:formatTimeParams()
	local timeList = self:getTimeList()
	local params = {}
	local applyDate = TimeUtil:localDate("%H:%M", timeList.applyTime)
	local closeDate = TimeUtil:localDate("%H:%M", timeList.closeTime)
	local startDate = TimeUtil:localDate("%H:%M", timeList.battleStartTime)
	local stopDate = TimeUtil:localDate("%H:%M", timeList.battleStopTime)
	local openDay = timeList.openDay
	local applyD = TimeUtil:remoteDate("*t", timeList.applyTime)
	local battleD = TimeUtil:remoteDate("*t", timeList.enterTime)
	local applyWeek = applyD.wday == 1 and 7 or applyD.wday - 1
	local battleWeek = battleD.wday == 1 and 7 or battleD.wday - 1
	local closeWeek = TimeUtil:getLocalWeekByRemote(openDay[#openDay])

	params.dayssign1 = GameStyle:getWeekStr(closeWeek)
	params.dayssign2 = GameStyle:getWeekStr(applyWeek)
	params.timesign1 = closeDate
	params.timesign2 = applyDate
	params.daysbattle1 = GameStyle:getWeekStr(battleWeek)
	params.daysbattle2 = GameStyle:getWeekStr(closeWeek)
	params.timebattle1 = startDate
	params.timebattle2 = stopDate
	params.timebattle3 = closeDate

	local c = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapSupply", "content")

	params.timeSupply1 = c[1]
	params.timeSupply2 = c[2]

	return params
end

function WorldPeaceSystem:requestUpdateData(callback, isBlockUI)
	self._wordService:enterBattle({}, isBlockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if response.data.isSign ~= nil then
				self:getWorldPeace():clearData()
				self:getWorldPeace():synchronize(response.data)
			end

			if response.data.player and response.data.battleField then
				self:getBattlefield():clear()
				self:getBattlefield():synchronize(response.data)
				self:getMainPlayer():synchronize(response.data)
			end

			if callback then
				callback(response)
			end
		end
	end)
end

function WorldPeaceSystem:requestRank(callback, isBlockUI)
	self._wordService:requestRank({}, isBlockUI, function(response)
		if response.resCode == GS_SUCCESS then
			self:getWorldPeace():synchronize(response.data)

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
		end
	end)
end

function WorldPeaceSystem:requestApply(callback)
	self._wordService:requestApply({}, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:getWorldPeace():synchronize(response.data)

			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_WORLDPEACE_APPLY_SUCC))
		end
	end)
end

function WorldPeaceSystem:requestReward(rewardType, callback)
	local params = {
		type = rewardType
	}

	self._wordService:requestReward(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:getWorldPeace():synchronize(response.data)

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_WORLDPEACE_GET_REWARD_SUCC, response))
			self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
		end
	end)
end

function WorldPeaceSystem:requestSimpleBattleInfo(callback, isBlockUI)
	local params = {}

	self._wordService:requestSimpleBattleInfo(params, isBlockUI, function(response)
		if response.resCode == GS_SUCCESS then
			self:getWorldPeace():synchronize(response.data)

			if response.data.chatData then
				self:getWorldPeace():syncMatchGroup(response.data.chatData.groupData)
			end

			if callback then
				callback(response)
			end
		end
	end)
end

function WorldPeaceSystem:listenBattleFinish()
	self._wordService:listenBattleFinish(function(data)
		self:requestClubRank(nil, false)
	end)
end

function WorldPeaceSystem:listenMatchFinish()
	self._wordService:listenMatchFinish(function(data)
		self:requestUpdateData(function()
			self:dispatch(Event:new(EVT_WORLDPEACE_MATCH_END))
			self:requestTaskInfo()
		end, false)
	end)
end

function WorldPeaceSystem:listenRewardReissue()
	self._wordService:listenRewardReissue(function(data)
		self:requestRank(nil, false)

		if self:getStatus() == WPStatus.kApply then
			self:getWorldPeace():setBattleFieldId(nil)
		end
	end)
end

function WorldPeaceSystem:requestClubRank(callback, isBlockUI)
	self._wordService:requestClubRank({}, isBlockUI, function(response)
		if response.resCode == GS_SUCCESS then
			self:getWorldPeace():clearCLubRankData()
			self:getWorldPeace():syncClubRankData(response.data)

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
		end
	end)
end

function WorldPeaceSystem:requestTaskInfo(callback, isBlockUI)
	self._wordService:requestTaskInfo({}, isBlockUI, function(response)
		if response.resCode == GS_SUCCESS then
			local mainPlayer = self:getMainPlayer()

			mainPlayer:setTask(response.data.task or {})
			mainPlayer:setMatchLv(response.data.matchLv)

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_WORLDPEACE_TASK_REFRESH))
			self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
		end
	end)
end

function WorldPeaceSystem:requestTaskReward(params, callback, isBlockUI)
	self._wordService:requestTaskReward(params, isBlockUI, function(response)
		if response.resCode == GS_SUCCESS then
			local mainPlayer = self:getMainPlayer()

			if response.data.player then
				mainPlayer:synchronize(response.data)
			end

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
		end
	end)
end

function WorldPeaceSystem:getBossRoleModelIdByBossId(bossId)
	return (ConfigReader:getDataByNameIdAndKey("ClubMapBoss", bossId, "Hero"))
end

function WorldPeaceSystem:requestInteractWithBoss(param, callback)
	self._wordService:requestInteractWithBoss(param, true, function(response)
		if response.resCode == GS_SUCCESS then
			local data = response.data

			if data then
				self:getWorldSwearChat():synchronize(data)
				self:dispatch(Event:new(EVT_WORDPEACE_SWEAR_GROUPINFO_REFRESH))

				local thisChatData = data.thisChat

				self:dispatch(Event:new(EVT_WORDPEACE_SWEAR_CHATBOSS_CONTENT_REFRESH, thisChatData))
			end

			if callback then
				callback(response.data)
			end
		end
	end)
end

function WorldPeaceSystem:requestInteractWithClub(param, callback)
	self._wordService:requestInteractWithClub(param, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response.data)
			end

			local data = response.data

			self:getWorldSwearChat():synchronize(data)
			self:dispatch(Event:new(EVT_WORDPEACE_SWEAR_GROUPINFO_REFRESH))

			local thisChatData = data.thisChat

			self:dispatch(Event:new(EVT_WORDPEACE_SWEAR_CHATBOSS_CONTENT_REFRESH, thisChatData))
		end
	end)
end

function WorldPeaceSystem:getRandomBossTotalTime()
	return ConfigReader:getDataByNameIdAndKey("Reset", "ClubMapBoss_Change", "ResetSystem").max
end

function WorldPeaceSystem:getGiftPhaseOneTotalTime()
	return ConfigReader:getDataByNameIdAndKey("Reset", "ClubMapBoss_Gift", "ResetSystem").max
end

function WorldPeaceSystem:getPrisePhaseOneTotalTime()
	return ConfigReader:getDataByNameIdAndKey("Reset", "ClubMapBoss_Prise", "ResetSystem").max
end

function WorldPeaceSystem:getPhaseTowTotalTime()
	return ConfigReader:getDataByNameIdAndKey("Reset", "ClubMapBoss_II", "ResetSystem").max
end

function WorldPeaceSystem:tryEnterSwearMain(callback)
	self._wordService:enterSwearMain({}, true, function(response)
		if callback then
			callback()
		end

		local data = response.data

		if data then
			self:getWorldSwearChat():synchronize(data)

			local view = self:getInjector():getInstance("WordPeaceSwearMainView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))
		end
	end)
end

function WorldPeaceSystem:chatWithBoss(param, callback)
	self._wordService:chatWithBoss(param, true, function(response)
		local data = response.data

		if data then
			self:getWorldSwearChat():synchronize(data)
			self:dispatch(Event:new(EVT_WORDPEACE_SWEAR_GROUPINFO_REFRESH))
		end
	end)
end

function WorldPeaceSystem:changeChatBoss(param, callback)
	self._wordService:changeChatBoss(param, true, function(response)
		local data = response.data

		if data then
			self:dispatch(Event:new(EVT_WORDPEACE_SWEAR_CHOSSBOSS_REFRESH))
			callback()
		end
	end)
end

function WorldPeaceSystem:getBossRewards(param, callback)
	self._wordService:getBossRewards(param, true, function(response)
		local data = response.data

		if data and data.rewardStatus then
			self:getWorldBoss():setRewardStatus(data.rewardStatus)
		end

		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceSystem:tryEnterWorldBossMain(callback)
	self._wordService:enterBossBattle({}, true, function(response)
		local data = response.data

		if data and data.playerData then
			data.player = data.playerData

			local status = data.status
			local resetData = self:resetWorldBosTeamStatus(data, status)

			if resetData.teamStatus then
				data.player.teamStatus = resetData.teamStatus
			end

			self:getWorldBoss():synchronize(data)
			self:getMainPlayer():synchronize(data)

			data.battleField = {
				bossData = {
					[data.bossConfigId] = {
						lv = 1,
						id = data.bossConfigId,
						hpr = data.bossReleaseHp,
						mhp = data.bossReleaseHp,
						index = data.bossIndex,
						aTeams = resetData.atkTeams
					}
				}
			}

			self:getBattlefield():synchronize(data)
			delayCallByTime(100, function()
				if callback then
					callback()
				end
			end)

			if status == WorldBossStatus.kFinish then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Error_90106")
				}))

				return
			end

			delayCallByTime(callback and 300 or 0, function()
				if status == WorldBossStatus.kInit then
					self:getWorldBoss():clearData()

					local view = self:getInjector():getInstance("WorldBossMatchView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
					}, data))
				else
					self:initWorldBossRankData(data.bossConfigId)
					self:createMatchPlayerBoll(data.bossConfigId)

					local view = self:getInjector():getInstance("WordBossBattleView")

					self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
						bossId = data.bossConfigId
					}))
				end
			end)
		end
	end)
end

function WorldPeaceSystem:startAttackWordBoss(param, isBlockUI, callback)
	self._wordService:startAttackWordBoss(param, isBlockUI, function(response)
		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceSystem:resetWorldBosTeamStatus(serverData, status)
	local limit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "WorldBossMin", "content")
	local data = {}

	data.teamStatus = {}
	data.atkTeams = {}

	local playerInfo = serverData.player
	local teamList = playerInfo.teamDataList
	local player = self:getInjector():getInstance("DevelopSystem"):getPlayer()
	local rate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBattleFloorHurt", "content")
	local bossCfg = ConfigReader:getRecordById("WorldBoss", serverData.bossConfigId)

	for k, v in pairs(teamList) do
		local heroIds = v.heroIds

		if limit <= #heroIds and status == WorldBossStatus.kContinue then
			local heroInfo = v.heroDataList[v.topHero]

			data.teamStatus[k] = serverData.bossConfigId
			data.atkTeams[v.teamKey] = {
				def = 0,
				gId = "3",
				sp = 1,
				isMyth = true,
				spCount = 1,
				nickName = player:getNickName(),
				teamKey = v.teamKey,
				atk = math.max(heroInfo.atk - bossCfg.Def, heroInfo.atk * rate),
				hpr = heroInfo.hp,
				heroId = v.topHero,
				rid = player:getRid(),
				st = v.st,
				ra = v.ra,
				cPos = playerInfo.cPos,
				mPhase = playerInfo.mPhase
			}
		else
			data.teamStatus[k] = "REST"
		end
	end

	return data
end

function WorldPeaceSystem:initWorldBossRankData(bossId)
	local worldBoss = self:getWorldBoss()
	local rankMap = worldBoss:getRankMap()
	local attackTime = worldBoss:getLastAttackTime()
	local curTime = self._gameServerAgent:remoteTimeMillis()
	local lastClientCalHurt = worldBoss:getLastClientCalHurt()
	local time = 0

	time = table.nums(rankMap) > 0 and curTime - lastClientCalHurt or curTime - attackTime

	local cd = ConfigReader:getDataByNameIdAndKey("ConfigValue", "WorldBossBattleCD", "content")
	local attackTimes = math.ceil(time * 0.001 / cd)

	if time < 1 or attackTimes == 0 then
		return
	end

	local rate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBattleFloorHurt", "content")
	local bossCfg = ConfigReader:getRecordById("WorldBoss", bossId)
	local matchPlayers = self:getWorldBoss():getMatchedPlayers()

	for i, player in pairs(matchPlayers) do
		local teamList = player.teamDataList
		local hurt = 0

		for k, teamInfo in pairs(teamList) do
			local heroInfo = teamInfo.heroDataList[teamInfo.topHero]
			local atk = math.max(heroInfo.atk - bossCfg.Def, heroInfo.atk * rate)

			hurt = hurt + atk
		end

		hurt = hurt * attackTimes

		local rateList = {
			0.8,
			0.9,
			1,
			1.1,
			1.2,
			1.3,
			1.5,
			1.6,
			1.7
		}
		local rate = rateList[math.random(1, #rateList)]

		if rankMap[player.rid] then
			if not rankMap[player.rid].hurt then
				local initHurt = 0

				rankMap[player.rid] = {
					rid = player.rid,
					nickName = player.nickName,
					hurt = hurt * rate + initHurt
				}
			end
		end
	end

	local boss = self:getBattlefield():getBossById(bossId)
	local index = boss:getIndex() + 1
	local bloodCfg = bossCfg.DmgReward
	local hurt = 0

	for i = 1, index do
		hurt = hurt + bloodCfg[i].Blood
	end

	local releaseHp = boss:getHpr()

	hurt = hurt - releaseHp

	local player = self._developSystem:getPlayer()

	rankMap[player:getRid()] = {
		rid = player:getRid(),
		nickName = player:getNickName(),
		hurt = hurt
	}
end

function WorldPeaceSystem:createMatchPlayerBoll(bossId)
	local matchBollList = self:getWorldBoss():getMatchBollList()

	if #matchBollList > 0 then
		return
	end

	local matchPlayers = self:getWorldBoss():getMatchedPlayers()
	local rate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBattleFloorHurt", "content")
	local bossCfg = ConfigReader:getRecordById("WorldBoss", bossId)

	for i, player in pairs(matchPlayers) do
		local teamList = player.teamDataList
		local count = 0
		local bollList = {}

		for k, teamInfo in pairs(teamList) do
			count = count + 1

			local heroInfo = teamInfo.heroDataList[teamInfo.topHero]
			local debugData = {
				def = 0,
				gId = "3",
				sp = 1,
				isMyth = false,
				spCount = 1,
				nickName = player.nickName,
				teamKey = teamInfo.teamKey,
				atk = math.max(heroInfo.atk - bossCfg.Def, heroInfo.atk * rate),
				heroId = teamInfo.topHero,
				hpr = heroInfo.hp,
				rid = player.rid,
				st = teamInfo.st,
				ra = teamInfo.ra
			}
			local boll = Boll:new(teamInfo.teamKey)

			boll:synchronize(debugData)
			boll:setIsProtect(false)

			bollList[#bollList + 1] = boll
		end

		matchBollList[#matchBollList + 1] = bollList
	end
end

function WorldPeaceSystem:getWorldBoss()
	self._worldBoss = self._worldBoss or WorldBoss:new()

	return self._worldBoss
end

function WorldPeaceSystem:getWorldBossSpeed()
	local sp1 = ConfigReader:getDataByNameIdAndKey("ConfigValue", "WorldBossBattleRate1", "content")
	local sp2 = ConfigReader:getDataByNameIdAndKey("ConfigValue", "WorldBossBattleRate2", "content")

	return {
		1,
		sp1,
		sp2
	}
end

function WorldPeaceSystem:getWorldBossExtraRewardTime()
	local curTime = self._gameServerAgent:remoteTimestamp()
	local curDate = TimeUtil:remoteDate("*t", curTime)
	local timeConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "WorldBossExtra", "content")
	local timeList = {}

	for i, v in pairs(timeConfig) do
		local startT = self:remoteTime(curDate, v.start)
		local endT = self:remoteTime(curDate, v["end"])

		timeList[#timeList + 1] = {
			startT = startT,
			endT = endT
		}
	end

	table.sort(timeList, function(a, b)
		return a.startT < b.startT
	end)

	return timeList
end

function WorldPeaceSystem:isWorldBossExtraRewardTime(time)
	local timeList = self:getWorldBossExtraRewardTime()
	local attackTime = self:getWorldBoss():getLastAttackTime()

	time = time or attackTime * 0.001

	for i, v in pairs(timeList) do
		if time > v.startT and time < v.endT then
			return true, v
		elseif time < v.startT then
			return false, v
		end
	end

	return false, timeList[1]
end

function WorldPeaceSystem:isBattleTime()
	local worldBoss = self:getWorldBoss()
	local startAttackTime = worldBoss:getLastAttackTime() * 0.001
	local curTime = self._gameServerAgent:remoteTimestamp()
	local challengeTime = ConfigReader:getRecordById("ConfigValue", "WorldBoss_ChallengeTime").content

	if curTime < challengeTime + startAttackTime then
		return true
	end

	return false
end

function WorldPeaceSystem:doReset()
	local systemKeeper = self:getSystemKeeper()
	local unlock, tips = systemKeeper:isUnlock("WorldBoss")

	if unlock then
		self._wordService:enterBossBattle({}, false, function(response)
			local data = response.data

			if data then
				if data.playerData then
					data.player = data.playerData

					self:getWorldBoss():synchronize(data)
				end

				self:dispatch(Event:new(EVT_WORLDBOSS_REFRESH))
			end
		end)
	end
end
