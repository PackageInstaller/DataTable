-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/controller/DevelopSystem.lua

require("dm.gameplay.develop.model.Player")
require("dm.gameplay.develop.controller.BagSystem")
require("dm.gameplay.develop.controller.HeroSystem")
require("dm.gameplay.develop.controller.MasterSystem")
require("dm.gameplay.develop.controller.EquipSystem")
require("dm.gameplay.activity.controller.ActivitySystem")
require("dm.gameplay.develop.controller.KernelSystem")
require("dm.gameplay.tsoul.controller.TSoulSystem")

DevelopSystem = class("DevelopSystem", legs.Actor)

DevelopSystem:has("_developService", {
	is = "r"
}):injectWith("DevelopService")
DevelopSystem:has("_serverOpenTime", {
	is = "rw"
})
DevelopSystem:has("_serverMergeTime", {
	is = "rw"
})
DevelopSystem:has("_timeZone", {
	is = "rw"
})
DevelopSystem:has("_serverFirstDayEndTime", {
	is = "rw"
})
DevelopSystem:has("_bagSystem", {
	is = "r"
})
DevelopSystem:has("_kerenlSystem", {
	is = "r"
})
DevelopSystem:has("_heroSystem", {
	is = "r"
})
DevelopSystem:has("_player", {
	is = "r"
})
DevelopSystem:has("_masterSystem", {
	is = "r"
})
DevelopSystem:has("_equipSystem", {
	is = "r"
})
DevelopSystem:has("_tSoulSystem", {
	is = "r"
})
DevelopSystem:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")
DevelopSystem:has("_mazeSystem", {
	is = "r"
}):injectWith("MazeSystem")
DevelopSystem:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
DevelopSystem:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")
DevelopSystem:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
DevelopSystem:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
DevelopSystem:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")
DevelopSystem:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
DevelopSystem:has("_arenaSystem", {
	is = "r"
}):injectWith("ArenaSystem")
DevelopSystem:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")
DevelopSystem:has("_crusadeSystem", {
	is = "r"
}):injectWith("CrusadeSystem")
DevelopSystem:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
DevelopSystem:has("_dreamSystem", {
	is = "r"
}):injectWith("DreamChallengeSystem")
DevelopSystem:has("_cooperateBossSystem", {
	is = "r"
}):injectWith("CooperateBossSystem")
DevelopSystem:has("_dreamHouseSystem", {
	is = "r"
}):injectWith("DreamHouseSystem")
DevelopSystem:has("_mazeTowerSystem", {
	is = "r"
}):injectWith("MazeTowerSystem")

function DevelopSystem:initialize()
	super.initialize(self)

	self._player = Player:new()
	self._playerLevelUpData = {}
	self._serverOpenTime = 0
	self._serverIp = ""
	self._serverPort = 0
	self._serverMergeTime = 0
	self._serverFirstDayEndTime = 0

	self:initSystem()
end

function DevelopSystem:initSystem()
	self._bagSystem = BagSystem:new(self)
	self._heroSystem = HeroSystem:new(self)
	self._masterSystem = MasterSystem:new(self)
	self._equipSystem = EquipSystem:new(self)
	self._kerenlSystem = KernelSystem:new(self)
	self._tSoulSystem = TSoulSystem:new(self)
end

function DevelopSystem:userInject(injector)
	injector:injectInto(self._player)
	injector:injectInto(self._bagSystem)
	injector:injectInto(self._heroSystem)
	injector:injectInto(self._masterSystem)
	injector:injectInto(self._equipSystem)
	injector:injectInto(self._tSoulSystem)
	injector:injectInto(self._kerenlSystem)
end

function DevelopSystem:syncPlayer(data, isDiff)
	if not data then
		return
	end

	local playerLevelUpData = self:getPlayerLevelUpData()

	self._player:synchronizeInfoDiff(data)

	if data.effectCenter then
		self:getPlayer()._effectCenter:syncData(data.effectCenter)
		self._buildingSystem:checkBuildingEffect(data.effectCenter, isDiff)
	end

	if data.bag and data.bag.items then
		self._bagSystem:showTips(data.bag.items)
		self:getBag():synchronize(data.bag.items, isDiff)
		self._heroSystem:syncHeroShowIds()
		self._bagSystem:synchronize(data.bag.items, isDiff)
	end

	if data.bag and data.bag.del then
		self._bagSystem:delItems(data.bag.del)
	end

	if data.lockItem then
		self:getBag():synchronizeLockItems(data.lockItem)
		self._bagSystem:synchronize(data.lockItem)
	end

	if data.shops then
		self._shopSystem:sync(data.shops)
	end

	if data.packShopItems then
		self._shopSystem:syncPackage(data.packShopItems)
	end

	if data.surfaceShop then
		self._shopSystem:syncSurface(data.surfaceShop)
	end

	if data.equips then
		self:getPlayer():getEquipList():synchronize(data.equips)
	end

	if data.tSouls then
		self:getPlayer():getTSoulList():synchronize(data.tSouls)
	end

	if data.composeTimes then
		self._bagSystem:setComposeTimes(data.composeTimes)
	end

	if data.urCount then
		self._bagSystem:setURCount(data.urCount)
	end

	if data.urEquipStat then
		self._bagSystem:setUREquipState(data.urEquipStat)
	end

	if data.msgCard then
		self._gallerySystem:getPartyManage():syncMessageData(data.msgCard)
	end

	if data.cultivation or data.level then
		self:synCultivation(data)
	end

	if data.clubId then
		local clubId = data.clubId
		local clubInfo = self:getPlayer():getClub():getInfo()

		clubInfo:setClubId(clubId)
	end

	if data.brideOutSide then
		local worldPeaceSystem = DmGame:getInstance()._injector:getInstance("WorldPeaceSystem")

		worldPeaceSystem:getWorldSwearChat():synchronizeOtherInfo(data.brideOutSide)
		self:dispatch(Event:new(EVT_WORDPEACE_SWEAR_CHATBOSS_TIME_REFRESH))
	end

	if data.playerClub then
		local clubData = data.playerClub
		local clubInfo = self:getPlayer():getClub():getInfo()

		if clubData.sendClubMailCount then
			clubInfo:setSendMailCount(clubData.sendClubMailCount.value)
		end

		if clubData.welcomeMsg then
			clubInfo:setWelcomeMsg(clubData.welcomeMsg)
		end

		if clubData.selfEditWelMsg then
			clubInfo:setSelfEditWelMsg(clubData.selfEditWelMsg or "")
		end

		if clubData.welcomeIndex then
			clubInfo:setWelcomeIndex(clubData.welcomeIndex)
		end

		if clubData.donateCount and clubData.donateCount.value then
			self:getPlayer():getClub():setCurDonateCount(clubData.donateCount.value)
		end

		if clubData.lastJoinTime then
			clubInfo:setLastJoinTime(clubData.lastJoinTime)
		end

		if clubData.joinedClubCount then
			clubInfo:setJoinedClubCount(clubData.joinedClubCount)
		end

		self:getPlayer():getClub():syncClubBossBasicInfo(clubData)
	end

	if data.timeRecord then
		self:getPlayer():getBag():synTimeRecords(data.timeRecord)
	end

	if data.todayOnlineTime then
		self:getPlayer():setTodayOnlineTime(data.todayOnlineTime)
	end

	if data.friendInfo then
		local friendSystem = self:getInjector():getInstance(FriendSystem)

		friendSystem:getFriendModel():syncFriendInfo(data.friendInfo)
	end

	if data.clubVillageChange then
		self:getPlayer():getClub():setClubVillageChangeCount(data.clubVillageChange)
	end

	if data.vipLevel then
		local rechargeAndVipSystem = self:getInjector():getInstance(RechargeAndVipSystem)

		rechargeAndVipSystem:syncVipCanGetRewards()
	end

	if data.mallInfo then
		local rechargeAndVipSystem = self:getInjector():getInstance(RechargeAndVipSystem)

		rechargeAndVipSystem:synchronizeRechargeAndVipInfo(data.mallInfo)
	end

	if data.privilegeInfo then
		local rechargeAndVipSystem = self:getInjector():getInstance(RechargeAndVipSystem)

		rechargeAndVipSystem:synchronizeRechargeAndVipInfo(data.privilegeInfo)
	end

	if data.drawInfo then
		local recruitSystem = self:getInjector():getInstance(RecruitSystem)

		recruitSystem:sync(data.drawInfo, self._player)
	end

	if data.checkin then
		local monthSignInSystem = self:getInjector():getInstance(MonthSignInSystem)

		monthSignInSystem:getMonthSignModel():synchronize(data.checkin)
	end

	if data.activities and data.activities.activityMap then
		local activitySystem = self:getInjector():getInstance(ActivitySystem)

		activitySystem:getActivityList():synchronize(data.activities.activityMap)
		activitySystem:checkActivityState()
		activitySystem:checkPassActivityData()
		activitySystem:checkClubBossSummerActivityData()
		self._cooperateBossSystem:synchronize(data.activities.activityMap)
	end

	if data.spStages then
		local spStageSystem = self:getInjector():getInstance(SpStageSystem)

		spStageSystem:synchronize(data.spStages)
	end

	if data.practice and data.practice.stageMaps then
		local stagePracticeSystem = self:getInjector():getInstance(StagePracticeSystem)

		stagePracticeSystem:synchronize(data.practice.stageMaps)
	end

	if data.kernels then
		self._kerenlSystem:synchronize(data.kernels)
	end

	if data.galleryPartyReward then
		self._gallerySystem:getPartyManage():syncRewardData(data.galleryPartyReward)
	end

	if data.galleryMemoryMap then
		self._gallerySystem:getPartyManage():syncMemoryData(data.galleryMemoryMap)
	end

	if data.galleryPhotos then
		self._gallerySystem:getPartyManage():syncAlbumData(data.galleryPhotos)
	end

	if data.galleryData then
		self._gallerySystem:getPartyManage():syncGalleryData(data.galleryData)
	end

	if data.pansLab then
		self._mazeSystem:syncMazeData(data.pansLab)
	end

	if data.taskCenter then
		self._taskSystem:synchronizeTask(data.taskCenter)
	end

	if data.achievementCenter then
		self._taskSystem:synchronizeAchieveTask(data.achievementCenter)
	end

	if data.worldMap then
		if data.worldMap.bag and data.worldMap.bag.items then
			self._exploreSystem:showTips(data.worldMap.bag.items)
		end

		if data.worldMap.equipsReward then
			self._exploreSystem:showEquipTips(data.worldMap.equipsReward)
		end

		self._player:getExplore():synchronize(data.worldMap, self:getLevel())
	end

	if data.storyPoints then
		self:getPlayer():syncStoryPoint(data.storyPoints)
	end

	if data.stagePractice then
		self:getPlayer():syncStagePractice(data.stagePractice)
	end

	if data.stages then
		self._stageSystem:syncStages(data.stages, self:getPlayer())
		self:dispatch(Event:new(EVT_STAGE_SYNC))
	end

	if data.stagePresents then
		self._stageSystem:syncStagePresents(data.stagePresents)
	end

	if data.heroStoryMaps then
		self._stageSystem:syncHeroStory(data.heroStoryMaps)
	end

	if data.villageData then
		self._buildingSystem:synchronize(data.villageData)
	end

	if data.unlockSurfaces then
		self._surfaceSystem:synchronize(data.unlockSurfaces)
	end

	if data.playerArena and data.playerArena.battleReports then
		self._arenaSystem:getArena():synchronizeReportData(data.playerArena.battleReports)
	end

	if data.towerStages then
		self._towerSystem:synchronize(data.towerStages)
	end

	if data.playerCrusade then
		self._crusadeSystem:synchronize(data.playerCrusade)
	end

	if data.rankRewards then
		self._rankSystem:synchronizeRankRewards(data.rankRewards)
	end

	if data.dreamChallenge then
		self._dreamSystem:synchronize(data.dreamChallenge)
	end

	if data.house then
		self._dreamHouseSystem:synchronize(data.house)
	end

	if data.mazeTower then
		self._mazeTowerSystem:synchronize(data.mazeTower)
	end

	self:dispatch(Event:new(EVT_PLAYER_SYNCHRONIZED))
	self:checkPlayerLevelUp(playerLevelUpData)
end

function DevelopSystem:syncDeleteData(data)
	data = data.player

	if data and data.effectCenter then
		self:getPlayer()._effectCenter:delete(data.effectCenter)
	end

	if data and data.bag then
		self._bagSystem:deleteItems(data.bag)
	end

	if data and data.checkin then
		local monthSignInSystem = self:getInjector():getInstance(MonthSignInSystem)

		monthSignInSystem:getMonthSignModel():syncDelateData(data.checkin)
	end

	if data and data.activities and data.activities.activityMap then
		local activitySystem = self:getInjector():getInstance("ActivitySystem")

		activitySystem:deleteActivity(data.activities.activityMap)
		self:dispatch(Event:new(EVT_ACTIVITY_RESET))
	end

	if data and data.playerClub and data.playerClub.playerBSInfo then
		local clubBashenSystem = self:getInjector():getInstance(ClubBashenSystem)

		clubBashenSystem:syncDelateData(data.playerClub.playerBSInfo)
	end

	if data and data.mallInfo and data.mallInfo.monthCards then
		local rechargeAndVipSystem = self:getInjector():getInstance(RechargeAndVipSystem)

		rechargeAndVipSystem:delMonthCards(data.mallInfo.monthCards)
	end

	if data and data.cultivation then
		self:getPlayer():getMasterList():synchronizeDelEquipKernel(data.cultivation.masters)
	end

	if data and data.kernels then
		self._kerenlSystem:synchronizeDel(data.kernels)
	end

	if data and data.pansLab then
		self._mazeSystem:syncMazeDelfData(data.pansLab)
	end

	if data and data.worldMap then
		self._player:getExplore():synchronizeDel(data.worldMap)
	end

	if data and data.galleryData then
		self._gallerySystem:getPartyManage():syncGalleryDelData(data.galleryData)
	end

	if data and data.cultivation and data.cultivation.heroes then
		self:getPlayer():getHeroList():synchronizeDelEquip(data.cultivation.heroes)
	end

	if data and data.equips then
		self:getPlayer():getEquipList():deleteEquip(data.equips)
	end

	if data and data.tSouls then
		self:getPlayer():getTSoulList():deleteTSoul(data.tSouls)
	end

	if data and data.towerStages then
		self._towerSystem:deleteTower(data.towerStages)
	end

	if data and data.playerCrusade then
		self._crusadeSystem:delete(data.playerCrusade)
	end

	if data and data.dreamChallenge then
		self._dreamSystem:delete(data.dreamChallenge)
	end

	if data then
		self._taskSystem:getTaskListModel():updateDelTasks(data)
	end

	if data and data.drawInfo then
		local recruitSystem = self:getInjector():getInstance(RecruitSystem)

		recruitSystem:sync(data.drawInfo, self._player)
	end

	if data and data.house then
		self._dreamHouseSystem:delete(data.house)
	end

	if data and data.chessArena then
		self:getPlayer():deleteNewArenaReward(data.chessArena)
	end

	if data and data.pushGift then
		self:getPlayer():deletePushGift(data.pushGift)
	end
end

function DevelopSystem:synCultivation(data)
	local cultivation = data.cultivation

	if not cultivation then
		return
	end

	if not cultivation then
		return
	end

	if cultivation.heroes then
		self:getPlayer():getHeroList():synchronize(cultivation.heroes)
		self._heroSystem:syncHeroShowIds()
	end

	if cultivation.masters or data.level then
		self:getPlayer():getMasterList():synchronize(cultivation.masters, self)
	end

	if cultivation.masterAura then
		self:getPlayer():getMasterAura():synchronize(cultivation)
	end

	if cultivation.emblems then
		self:getPlayer():getMasterEmblemList():synchronize(cultivation.emblems, self)
	end

	if cultivation.teams then
		self:getPlayer():getTeamList():synchronize(cultivation.teams)
	end

	if cultivation.spTeams then
		self:getPlayer():getTeamList():synchronizeSpTeams(cultivation.spTeams)
	end

	if cultivation.teamTypes then
		self:getPlayer():getTeamList():synchronizeTeamTypes(cultivation.teamTypes)
	end
end

function DevelopSystem:getTeamByType(stageType)
	local teamId = self:getStageTeamIds()[stageType]

	return self:getPlayer():getTeamList():getTeam(teamId)
end

function DevelopSystem:getStageTeamById(index)
	return self:getPlayer():getTeamList():getTeam(index)
end

function DevelopSystem:getAllTeams()
	return self:getPlayer():getTeamList():getAllTeams()
end

function DevelopSystem:getSpTeamByType(stageType)
	return self:getPlayer():getTeamList():getSpTeam(stageType)
end

function DevelopSystem:getAllUnlockTeams()
	local teamList = self:getAllTeams()
	local teamsShow = {}
	local teamUnlockConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Stage_Team_Unlock", "content")
	local playerLevel = self:getLevel()

	for i, v in ipairs(teamList) do
		if playerLevel >= teamUnlockConfig[i] then
			teamsShow[i] = v
		else
			break
		end
	end

	return teamsShow
end

function DevelopSystem:getStageTeamIds()
	return self:getPlayer():getTeamList():getStageTeamIds()
end

function DevelopSystem:getTeamBook()
	return self:getPlayer():getTeamList()
end

function DevelopSystem:getServerFirstDayEndTime()
	return self._serverFirstDayEndTime
end

function DevelopSystem:getCurServerTime()
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")

	return gameServerAgent:remoteTimestamp()
end

function DevelopSystem:checkPlayerLevelUp(preData)
	local oldData = self._playerLevelUpData.curData

	if oldData and self._playerLevelUpData.preData then
		self._playerLevelUpData.preData.enery = oldData.enery
		self._playerLevelUpData.preData.criRate = oldData.criRate
		self._playerLevelUpData.preData.suckBoodRate = oldData.suckBoodRate
	end

	self._playerLevelUpData.curData = self:getPlayerLevelUpData()

	if not self._playerLevelUpData.preData then
		self._playerLevelUpData.preData = preData
	else
		local preLevel = self._playerLevelUpData.preData.level

		if preLevel < 1 then
			self._playerLevelUpData.preData = preData
		end
	end

	if self:getLevelupBackup() then
		self:dispatch(Event:new(EVT_SYSTEM_LEVELUP))
	end
end

function DevelopSystem:getPlayerLevelUpData()
	local curTabType = 1
	local teamList = self:getAllUnlockTeams()
	local masterId

	if teamList and next(teamList) and teamList[curTabType] then
		local curTeam = teamList[curTabType]

		masterId = curTeam:getMasterId()
	end

	if not masterId then
		return nil
	end

	return {
		level = self:getLevel(),
		enery = self:getEnergy(),
		eneryLimt = self:getEnergyLimit(),
		criRate = self:getMonsterProperty(masterId, "Hero_SkillAttrName_CRITRATE"),
		suckBoodRate = self:getMonsterProperty(masterId, "Hero_SkillAttrName_ABSORPTION")
	}
end

local showLvUpCache = {}

function DevelopSystem:popPlayerLvlUpView(info)
	for i = table.nums(showLvUpCache), 1, -1 do
		if showLvUpCache[i].mediator then
			showLvUpCache[i].mediator:close()
			table.remove(showLvUpCache, i)
		end
	end

	local preData = self._playerLevelUpData.preData
	local curData = self._playerLevelUpData.curData

	if not preData then
		return
	end

	local preLevel = preData.level
	local curLevel = curData.level

	if preLevel < 1 or curLevel <= preLevel then
		return
	end

	local delegate
	local view = self:getInjector():getInstance("PlayerLevelUpTipView")

	table.insert(showLvUpCache, view)
	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, self._playerLevelUpData, (info and info.callBack or nil) and {
		willClose = function(self)
			info.callBack()
		end
	}))

	self._playerLevelUpData.preData = nil
	self._playerLevelUpTipViewShowSta = true

	if SDKHelper and SDKHelper:isEnableSdk() then
		local player = self:getPlayer()

		SDKHelper:reportUpLevel({
			roleName = tostring(player:getNickName()),
			roleId = tostring(player:getRid()),
			roleLevel = tostring(player:getLevel()),
			vipLevel = tostring(player:getVipLevel()),
			roleCombat = checkint(player:getCombat()),
			ip = tostring(self._serverIp),
			port = tostring(self._serverPort),
			serverName = tostring(self._serverName),
			createTime = tostring(player:getCreateTime()),
			serverId = tostring(self._serverId)
		})
	end

	return true
end

function DevelopSystem:getLevelupBackup()
	local preData = self._playerLevelUpData.preData
	local curData = self._playerLevelUpData.curData

	if not preData then
		return false
	end

	local preLevel = preData.level
	local curLevel = curData.level

	if preLevel < 1 or curLevel <= preLevel then
		return false
	end

	return true
end

function DevelopSystem:getPlayerLvUpViewShowSta()
	return self._playerLevelUpTipViewShowSta
end

function DevelopSystem:getBag()
	return self:getPlayer():getBag()
end

function DevelopSystem:getEquipList()
	return self:getPlayer():getEquipList()
end

function DevelopSystem:getHeroList()
	return self:getPlayer():getHeroList()
end

function DevelopSystem:getUid()
	return self:getPlayer():getUid()
end

function DevelopSystem:getRid()
	return self:getPlayer():getRid()
end

function DevelopSystem:getLevel()
	return self:getPlayer():getLevel()
end

function DevelopSystem:getVipLevel()
	return self:getPlayer():getVipLevel()
end

function DevelopSystem:getheadId()
	return self:getPlayer():getHeadId()
end

function DevelopSystem:getNickName()
	return self:getPlayer():getNickName()
end

function DevelopSystem:getGolds()
	return self._bagSystem:getItemCount(CurrencyIdKind.kGold)
end

function DevelopSystem:getDiamonds()
	return self._bagSystem:getDiamond()
end

function DevelopSystem:getCrystal()
	return self._bagSystem:getItemCount(CurrencyIdKind.kCrystal)
end

function DevelopSystem:getHonor()
	return self._bagSystem:getItemCount(CurrencyIdKind.kHonor)
end

function DevelopSystem:getTrial()
	return self._bagSystem:getItemCount(CurrencyIdKind.kTrial)
end

function DevelopSystem:getMasterCultivate()
	return self:getPlayer():getMasterCultivate()
end

function DevelopSystem:getBuildingCostEffValue()
	return self._buildingSystem:getBuildingCostBuf()
end

function DevelopSystem:getBuildingCardEffValue()
	return self._buildingSystem:getBuildingCardBuf()
end

function DevelopSystem:getExplore()
	return self:getPlayer():getExplore()
end

function DevelopSystem:getStageArenaStage()
	return self:getPlayer():getPlayerStageArena()
end

function DevelopSystem:getEnergy()
	return self._bagSystem:getItemCount(CurrencyIdKind.kPower)
end

function DevelopSystem:getEnergyLimit()
	local config = ConfigReader:getRecordById("LevelConfig", tostring(self:getLevel()))

	if config then
		return config.ActionPointLimit
	end

	return 0
end

function DevelopSystem:getMonsterProperty(monsterId, propertyName)
	local monsterInfo = self._masterSystem:getMasterProperty(monsterId)
	local monsterProperty = monsterInfo[propertyName]

	return monsterProperty.attrNum
end

function DevelopSystem:getMonsterProperty1(monsterId, propertyName)
	local monsterInfo = self._masterSystem:getMasterProperty(monsterId)

	return monsterInfo[propertyName].attrNum
end

function DevelopSystem:getCombat()
	return self:getPlayer():getCombat()
end

function DevelopSystem:setRid(rid)
	self:getPlayer():setRid(rid)
end

function DevelopSystem:setServerInfo(id, ip, port, serverName)
	self._serverId = id
	self._serverIp = ip
	self._serverPort = port
	self._serverName = serverName
end

function DevelopSystem:getServerId()
	return self._serverId
end

function DevelopSystem:getServerIp()
	return self._serverIp
end

function DevelopSystem:getServerPort()
	return self._serverPort
end

function DevelopSystem:getServerName()
	return self._serverName
end

function DevelopSystem:getServerOpenDay()
	local curServerTime = self:getCurServerTime()
	local openDate = TimeUtil:remoteDate("*t", self._serverOpenTime)
	local openTime = TimeUtil:timeByRemoteDate({
		hour = 5,
		min = 0,
		sec = 0,
		year = openDate.year,
		month = openDate.month,
		day = openDate.day
	})

	return math.ceil((curServerTime - openTime) / 86400)
end

function DevelopSystem:enterType(params, callback)
	self._developService:enterType(params, false, callback)
end

function DevelopSystem:guideLog(params, callback)
	self._developService:guideLog(params, false, callback)
end

function DevelopSystem:requstNotEnoughItem(sceneId, itemId, callback)
	local params = {
		sceneId = sceneId,
		itmeId = itemId
	}

	self._developService:requstNotEnoughItem(params, true, callback)
end

function DevelopSystem:getPushPackageData()
	local pushPackageTimeList = self:getPushGiftTimeList()
	local pushPackageList = self._shopSystem:getPushPackgeData()
	local curTime = self:getCurServerTime()
	local list = {}

	for i, package in ipairs(pushPackageList) do
		local id = package:getId()

		if pushPackageTimeList[id] and curTime < pushPackageTimeList[id] then
			list[#list + 1] = package
		end
	end

	return list
end

function DevelopSystem:setPushViewOpen(vis)
	self._pushPackageViewOpen = vis
end

function DevelopSystem:showPushPackageView(pushData)
	dump(pushData, "DevelopSystem:showPushPackageView")

	local data = self:getPushPackageData()

	if not next(data) then
		return
	end

	if self._pushPackageViewOpen then
		self:dispatch(Event:new(EVT_REFRESH_PUSH_PACAKGE))

		return
	end

	local view = self:getInjector():getInstance("ShopPushPackageView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 200
	}, pushData))
end

function DevelopSystem:getPushSceneIds()
	return (self:getPlayer():getPushGiftListScene())
end

function DevelopSystem:getPushGiftTimeList()
	local curTime = self:getCurServerTime()
	local list = {}
	local data = self:getPlayer():getPushGiftList()

	for k, v in pairs(data) do
		if curTime < v then
			list[k] = v
		end
	end

	return list
end
