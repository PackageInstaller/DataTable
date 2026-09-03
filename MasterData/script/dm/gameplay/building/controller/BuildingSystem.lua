-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/controller/BuildingSystem.lua

BuildingSystem = class("BuildingSystem", Facade)

BuildingSystem:has("_buildingService", {
	is = "r"
}):injectWith("BuildingService")
BuildingSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
BuildingSystem:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
BuildingSystem:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
BuildingSystem:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
BuildingSystem:has("_customDataSystem", {
	is = "rw"
}):injectWith("CustomDataSystem")
BuildingSystem:has("_roomList", {
	is = "rw"
})
BuildingSystem:has("_mapShowType", {
	is = "rw"
})
BuildingSystem:has("_showRoomId", {
	is = "rw"
})
BuildingSystem:has("_operateInfo", {
	is = "rw"
})
BuildingSystem:has("_baseLevel", {
	is = "rw"
})
BuildingSystem:has("_usedWorkers", {
	is = "rw"
})
BuildingSystem:has("_buildingCollect", {
	is = "rw"
})
BuildingSystem:has("_workers", {
	is = "rw"
})
BuildingSystem:has("_bagWorldPos", {
	is = "rw"
})

local heroShowSortList = {
	Strings:get("Addition_Screen"),
	Strings:get("HEROS_UI30"),
	Strings:get("HEROS_UI5"),
	Strings:get("Force_Screen"),
	Strings:get("Building_UI_Haogan")
}
local SortExtend = {}

SortExtend[1] = {
	"SP",
	"SSR",
	"SR",
	"R"
}
SortExtend[2] = {
	GalleryPartyType.kWNSXJ,
	GalleryPartyType.kXD,
	GalleryPartyType.kBSNCT,
	GalleryPartyType.kDWH,
	GalleryPartyType.kMNJH,
	GalleryPartyType.kSSZS,
	GalleryPartyType.kUNKNOWN
}

function BuildingSystem:initialize()
	super.initialize(self)

	self._roomList = {}
	self._mapShowType = KBuildingMapShowType.kAll
	self._showRoomId = ""
	self._baseLevel = 0
	self._usedWorkers = 0
	self._buildingCollect = {}
	self._buildingLvUpFinishList = {}
	self._workers = {}
	self._buildingLvUpFinishShowSta = false
	self._costEffectBuffList = {}
	self._cardEffectBuffList = {}
	self._costEffectValue = 0
	self._cardEffectValue = 0
	self._cardHeroEffectValue = 0
	self._costHeroEffectValue = 0
	self._sortExtand = {}
	self._secondStore = {}
	self._rid = nil
	self._selfData = nil
	self._otherData = nil
end

function BuildingSystem:clearVars()
	self._roomList = {}
	self._usedWorkers = 0
	self._buildingCollect = {}
	self._baseLevel = 0
	self._usedWorkers = 0
	self._workers = {}
	self._secondStore = {}
end

function BuildingSystem:extendTable(t1, t2)
	for k, v in pairs(t1) do
		t2[k] = v
	end
end

function BuildingSystem:combin(update, org)
	for k, v in pairs(update.buildingCollect or {}) do
		org.buildingCollect[k] = v
	end

	for k, v in pairs(update.unlockedRooms or {}) do
		if org.unlockedRooms[k] then
			for k1, v1 in pairs(v.buildings or {}) do
				if org.unlockedRooms[k].buildings[k1] then
					self:extendTable(v1, org.unlockedRooms[k].buildings[k1])
				else
					org.unlockedRooms[k].buildings[k1] = v1
				end
			end

			if update.unlockedRooms[k].unlockedSurface then
				self:extendTable(update.unlockedRooms[k].unlockedSurface, org.unlockedRooms[k].unlockedSurface)
			end

			if update.unlockedRooms[k].lastHeroLove then
				org.unlockedRooms[k].lastHeroLove = update.unlockedRooms[k].lastHeroLove
			end

			if update.unlockedRooms[k].heroes then
				org.unlockedRooms[k].heroes = update.unlockedRooms[k].heroes
			end

			if update.unlockedRooms[k].comfortValue then
				org.unlockedRooms[k].comfortValue = update.unlockedRooms[k].comfortValue
			end

			if update.unlockedRooms[k].lastLoveMillis then
				org.unlockedRooms[k].lastLoveMillis = update.unlockedRooms[k].lastLoveMillis
			end

			if update.unlockedRooms[k].lastHeroLove then
				self:extendTable(update.unlockedRooms[k].lastHeroLove, org.unlockedRooms[k].lastHeroLove)
			end
		else
			org.unlockedRooms[k] = v
		end

		if v.placedBuildings then
			org.unlockedRooms[k].placedBuildings = v.placedBuildings
		end
	end

	for k, v in pairs(update.workers or {}) do
		org.workers[k] = v
	end

	if update.secondStore then
		org.secondStore = update.secondStore
	end

	if update.baseLevel then
		org.baseLevel = update.baseLevel
	end

	if update.usedWorkers then
		org.usedWorkers = update.usedWorkers
	end
end

function BuildingSystem:synchronize(data)
	self._selfData = self._selfData or data

	self:combin(data, self._selfData)
	self:_synchronize(data)
end

function BuildingSystem:_synchronize(data, playerInfo)
	if not data then
		return
	end

	self._rid = self._developSystem:getRid()

	if playerInfo and playerInfo.rid then
		self._rid = playerInfo.rid
	end

	self._heroSufaces = {}

	if playerInfo and playerInfo.heroSufaces then
		self._heroSufaces = playerInfo.heroSufaces
	end

	if data.buildingCollect then
		for k, v in pairs(data.buildingCollect) do
			self._buildingCollect[v] = true
		end
	end

	if data.baseLevel then
		self._baseLevel = data.baseLevel
	end

	if data.usedWorkers then
		self._usedWorkers = data.usedWorkers
	end

	if data.unlockedRooms then
		for k, v in pairs(data.unlockedRooms) do
			if self._roomList[k] == nil then
				self._roomList[k] = Room:new()

				self._roomList[k]:setId(k)

				self._roomList[k]._buildingSystem = self
			end

			self._roomList[k]:synchronize(v)
			self:resetRoomUsePos(k)
		end
	end

	if data.workers then
		for k, v in pairs(data.workers) do
			self._workers[k] = v.coolDownMills
		end
	end

	if data.secondStore then
		self._secondStore = data.secondStore
	end
end

function BuildingSystem:isSelfBuilding()
	return self._rid == self._developSystem:getRid()
end

function BuildingSystem:userInject()
	self:listenPush()
end

function BuildingSystem:listenPush()
	return
end

function BuildingSystem:dispose()
	super.dispose(self)
end

function BuildingSystem:getHeroSufaceMap()
	return self._heroSufaces or {}
end

function BuildingSystem:checkEnabled()
	local unlock, tips = self._systemKeeper:isUnlock("Village_Building")

	return unlock, tips
end

function BuildingSystem:checkGetExpEnable()
	local unlock, tips = self._systemKeeper:isUnlock("Village_Building")

	if unlock then
		local config = self:getBuildingConfig("ExpOre_Normal_1")
		local infoDes = self:getConditionDesInfo(config.Condition)

		infoDes.fontName = TTF_FONT_FZYH_M
		infoDes.fontSize = 18
		infoDes.fontColor = "#FFFFFF"
		unlock = self:isMeetCondition(config.Condition)
		tips = Strings:get(config.UnlockDescColor, infoDes)

		if unlock then
			local lastGetResTime = self:getBuildLastGetResTime()

			if lastGetResTime <= 0 then
				tips = Strings:get("Build_ResourceBuilding_Unlock")
				unlock = false
			end
		end
	end

	return unlock, tips
end

function BuildingSystem:tryEnter(data)
	self:clearVars()
	self:_synchronize(self._selfData)

	local unlock, tips = self:checkEnabled()

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))
	else
		local view = self:getInjector():getInstance("BuildingView")
		local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil)

		self:dispatch(event)
	end
end

function BuildingSystem:switchSelfBuild()
	self:clearVars()
	self:_synchronize(self._selfData)
end

function BuildingSystem:tryEnterOverview(data)
	self:clearVars()
	self:_synchronize(self._selfData)
	self:_tryEnterSubView("overview", data)
end

function BuildingSystem:tryEnterBuyDecorate(data)
	self:clearVars()
	self:_synchronize(self._selfData)

	local unlock, tips = self._systemKeeper:isUnlock("VillageShopDecorate")

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))

		return
	end

	self:_tryEnterSubView("buyDecorate", data)
end

function BuildingSystem:_tryEnterSubView(type, data)
	local roomId = data.roomId

	if not roomId then
		return
	end

	local unlock, tips = self:checkEnabled()

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))
	else
		local openSta, desStr = self:getRoomOpenSta(roomId)

		if not openSta and not self:canUnlockRoom(roomId) then
			self:dispatch(ShowTipEvent({
				duration = 0.5,
				tip = desStr
			}))

			return
		end

		local view = self:getInjector():getInstance("BuildingView")
		local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			t = type,
			roomId = roomId
		})

		self:dispatch(event)
	end
end

function BuildingSystem:tryEnterGetResView()
	self:clearVars()
	self:_synchronize(self._selfData)

	local view = self:getInjector():getInstance("BuildingOneKeyGetResView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view))
end

function BuildingSystem:tryEnterClubBuilding(data, info)
	self:clearVars()
	self:_synchronize(data, info)

	local unlock, tips = self:checkEnabled()

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))
	else
		local view = self:getInjector():getInstance("ClubBuildingView")
		local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			userInfo = info
		})

		self:dispatch(event)
	end
end

function BuildingSystem:checkByBuildLv(buildLv, buildId)
	if buildId and buildId ~= "" then
		local buildConfig = self:getBuildingConfig(buildId)

		if buildConfig then
			local roomId = buildConfig.Room

			if roomId and buildLv and buildLv ~= "" then
				local condition = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", buildLv, "BuildCondition")
				local level = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", buildLv, "Level")
				local conditionSta, meetList = self:isMeetConditions(condition)

				if conditionSta then
					return "build", true, level, {}
				elseif meetList.BaseLevel then
					local config = self:getBuildingConfig("MainCity")
					local mainBuildingLevel = config.BuildingLevel

					while mainBuildingLevel ~= nil and mainBuildingLevel ~= "" do
						local mainLvNow = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", mainBuildingLevel, "Level")

						if tonumber(meetList.BaseLevel) == tonumber(mainLvNow) then
							break
						else
							mainBuildingLevel = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", mainBuildingLevel, "NextBuilding")
						end
					end

					if mainBuildingLevel ~= nil and mainBuildingLevel ~= "" then
						local mainCondition = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", mainBuildingLevel, "BuildCondition")
						local mainLevel = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", mainBuildingLevel, "Level")
						local mainConditionSta, mainMeetList = self:isMeetConditions(mainCondition)

						if mainConditionSta then
							return "mainCity", true, mainLevel, {}
						else
							return "mainCity", false, mainLevel, mainMeetList
						end
					end

					return "build", false, level, meetList
				else
					return "build", false, level, meetList
				end
			end
		end
	end

	return false, ""
end

function BuildingSystem:getZorderByPos(roomId, roomPos)
	local zorder = 0

	if KBuilding_TiledMap_Zorder[roomId] then
		zorder = zorder - roomPos.x * 100 - roomPos.y
	end

	return zorder
end

function BuildingSystem:getBuildCenterPos(buildingId)
	local config = self:getBuildingConfig(buildingId)
	local space = config.Space
	local pos = cc.p(0, 0)

	pos.x = (space[1] - 1) * KBUILDING_Tiled_CELL_SIZE.width / 4 - (space[2] - 1) * KBUILDING_Tiled_CELL_SIZE.width / 4
	pos.y = KBUILDING_Tiled_CELL_SIZE.height / 2 + (space[1] - 1) * KBUILDING_Tiled_CELL_SIZE.height / 4 + (space[2] - 1) * KBUILDING_Tiled_CELL_SIZE.height / 4

	return pos
end

function BuildingSystem:getMapCellPos(row, col)
	local x = KBUILDING_MAP_CELL_SIZE.width * (col - 1)
	local y = KBUILDING_MAP_CELL_SIZE.height * (row - 1)

	return cc.p(x, y)
end

function BuildingSystem:getBuildCanTouchMove(buildingId)
	local config = self:getBuildingConfig(buildingId)

	if config and config.IsMoved == 1 then
		return true
	end

	return false
end

function BuildingSystem:getRoomOpenSta(roomId)
	local room = self:getRoom(roomId)

	if room then
		return true, ""
	end

	local des = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "ConditionDesc")
	local condition = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "Condition")
	local info = self:getConditionDesInfo(condition)

	return false, Strings:get(des, info)
end

function BuildingSystem:getConditionDesInfo(condition)
	local info = {}
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")

	info.Level = condition.Level
	info.BaseLevel = condition.BaseLevel

	if condition.Room then
		info.Room = Strings:get(ConfigReader:getDataByNameIdAndKey("VillageRoom", condition.Room, "Desc"))
	end

	if condition.Block then
		local sta, str = systemKeeper:checkStagePointLock(condition.Block)

		info.Block = str
	end

	if condition.Story then
		local stageSystem = self:getInjector():getInstance(StageSystem)
		local point = stageSystem:getPointById(condition.Story)

		if point then
			local map = point:getOwner()

			info.StoryNum = map:getIndex()
			info.StoryName = point:getName()
		end
	end

	return info
end

function BuildingSystem:getConditionsDesInfo(condition)
	local info = {}

	for k, v in pairs(condition) do
		local infoNew = self:getConditionDesInfo(v)

		for kk, vv in pairs(infoNew) do
			info[kk] = vv
		end
	end

	return info
end

function BuildingSystem:getRoom(roomId)
	if roomId then
		return self._roomList[roomId]
	end

	return nil
end

function BuildingSystem:getFristRoomId()
	local idList = self:getSortRoomIdList()

	return idList[1]
end

function BuildingSystem:getRoomCollectSta(roomId)
	local room = self:getRoom(roomId)

	if room then
		return room:getCollectSta()
	end

	return false
end

function BuildingSystem:getRoomLvUpSta(roomId)
	local room = self:getRoom(roomId)

	if room then
		return room:getRoomLvUpSta()
	end

	return false
end

function BuildingSystem:getRoomAllOutNum(roomId)
	local room = self:getRoom(roomId)

	if room then
		return room:getAllOutNum()
	end

	return 0
end

function BuildingSystem:getSpecialEffectSta(lvConfigId, buildConfigId)
	local outNum = 0
	local maxNum = 0
	local factorKeyList = {
		GoldOre = {
			"GoldOreProduction",
			"GoldStorage"
		},
		CrystalOre = {
			"CrystalOreProduction",
			"CrystalStorage"
		},
		ExpOre = {
			"ExpOreProduction",
			"ExpStorage"
		},
		Camp = {
			"DeckCost",
			""
		},
		CardAcademy = {
			"DeckCardNum",
			""
		}
	}
	local buildType = self:getBuildingConfig(buildConfigId).Type
	local outKey = factorKeyList[buildType][1]
	local maxKey = factorKeyList[buildType][2]
	local factorList = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", lvConfigId, "Factor1") or {}
	local level = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", lvConfigId, "Level")

	for k, v in pairs(factorList) do
		local factorParameter = ConfigReader:getDataByNameIdAndKey("SkillSpecialEffect", v, "Parameter")
		local factorType = factorParameter.type
		local value = factorParameter.value

		if factorType == outKey then
			outNum = value[level] or value[#value]
		end

		if factorType == maxKey then
			maxNum = value[level] or value[#value]
		end
	end

	return outNum, maxNum
end

function BuildingSystem:getBuildingSkinId(roomId, buildingId, id)
	local skinId
	local room = self:getRoom(roomId)

	if room then
		local building = room:getBuildingById(id)

		if building then
			skinId = building:getSkinId()
		end
	end

	if not skinId and buildingId then
		local config = self:getBuildingConfig(buildingId)

		skinId = config.DefaultSurface
	end

	return skinId
end

function BuildingSystem:getBuildingLevel(roomId, id)
	local lv
	local room = self:getRoom(roomId)

	if room then
		local building = room:getBuildingById(id)

		if building then
			lv = building:getLevel()
		end
	end

	return lv
end

function BuildingSystem:getBuildingActive(roomId, id)
	local sta = true
	local room = self:getRoom(roomId)

	if room then
		local building = room:getBuildingById(id)

		if building then
			sta = building:getActivated()
		end
	end

	return sta
end

function BuildingSystem:getBuildingRevert(roomId, id)
	local sta = false
	local room = self:getRoom(roomId)

	if room then
		local building = room:getBuildingById(id)

		if building then
			sta = building:getRevert()
		end
	end

	return sta
end

function BuildingSystem:getSortRoomIdList(sortKey, showType)
	local roomList = self:getRoomList()
	local roomIdList = {}

	for k, v in pairs(roomList) do
		roomIdList[#roomIdList + 1] = k
	end

	if #roomIdList > 1 then
		table.sort(roomIdList, function(a, b)
			local sortA = ConfigReader:getDataByNameIdAndKey("VillageRoom", a, sortKey or "Sort")
			local sortB = ConfigReader:getDataByNameIdAndKey("VillageRoom", b, sortKey or "Sort")

			if sortA < sortB then
				return true
			end

			return false
		end)
	end

	if showType == 2 then
		roomIdList[#roomIdList + 1] = kStoreRoomName
	end

	return roomIdList
end

function BuildingSystem:canUnlockRoom(roomId)
	local condition = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "Condition")

	return self:isMeetCondition(condition)
end

function BuildingSystem:isMeetConditions(condition)
	condition = condition or {}

	local notMeetList = {}
	local num = 0

	for k, v in pairs(condition) do
		local ismeet, list = self:isMeetCondition(v)

		if not ismeet then
			num = num + 1

			for _k, _v in pairs(list) do
				notMeetList[_k] = _v
			end
		end
	end

	if num > 0 then
		return false, notMeetList
	end

	return true, {}
end

function BuildingSystem:isMeetCondition(condition)
	condition = condition or {}

	local notMeetList = {}
	local num = 0

	for k, v in pairs(condition) do
		local ismeet = self:isMeetByKey(k, v)

		if not ismeet then
			num = num + 1
			notMeetList[k] = v
		end
	end

	if num > 0 then
		return false, notMeetList
	end

	return true, {}
end

function BuildingSystem:isMeetByKey(k, v)
	local ismeet = true

	if k == "Level" then
		if self._developSystem:getLevel() < tonumber(v) then
			ismeet = false
		end
	elseif k == "BaseLevel" then
		if self._baseLevel < tonumber(v) then
			ismeet = false
		end
	elseif k == "Room" then
		if not self:getRoomOpenSta(tostring(v)) then
			ismeet = false
		end
	elseif k == "Block" then
		local systemKeeper = self:getInjector():getInstance("SystemKeeper")
		local sta, str = systemKeeper:checkStagePointLock(tostring(v))

		if not sta then
			ismeet = false
		end
	elseif k == "Story" then
		local systemKeeper = self:getInjector():getInstance("SystemKeeper")
		local sta, str = systemKeeper:checkStoryPointLock(tostring(v))

		if not sta then
			ismeet = false
		end
	end

	return ismeet
end

function BuildingSystem:getRoomShow(roomId)
	local roomList = KBuilding_TiledMap_Room_Pos[roomId][3]
	local showSta = true

	for k, v in pairs(roomList) do
		if not self:getRoomOpenSta(v) then
			showSta = false

			break
		end
	end

	return showSta
end

function BuildingSystem:getBuildingData(roomId, id)
	local room = self:getRoom(roomId)

	if room then
		return room:getBuildingById(id)
	end

	return nil
end

function BuildingSystem:getBuildingPos(roomId, id)
	local buildingData = self:getBuildingData(roomId, id)

	if buildingData then
		return buildingData:getPos()
	end

	return nil
end

function BuildingSystem:getBuildingLvUpEndTime(roomId, id)
	local buildingData = self:getBuildingData(roomId, id)

	if buildingData then
		return buildingData:getFinishTime() or 0
	end

	return 0
end

function BuildingSystem:getBuildingQueueNum()
	local num = 0
	local timeNow = self._gameServerAgent:remoteTimestamp()

	for k, v in pairs(self._workers) do
		if timeNow > v / 1000 then
			num = num + 1
		end
	end

	return num
end

function BuildingSystem:getBuildingDecorate(roomId)
	if self._buildingDecorate == nil then
		self._buildingDecorate = {}

		local dataTable = ConfigReader:getDataTable("VillageDecorateBuilding")

		for k, v in pairs(dataTable) do
			if v.Unlook == 0 then
				local room = v.Room

				if not self._buildingDecorate[room] then
					local list = {}

					list[#list + 1] = k
					self._buildingDecorate[room] = list
				end
			end
		end

		for k, v in pairs(self._buildingDecorate) do
			table.sort(v, function(a, b)
				local sortA = self:getBuildingConfig(a).Sort
				local sortB = self:getBuildingConfig(b).Sort

				if sortA < sortB then
					return true
				end

				return false
			end)
		end
	end

	if not self._buildingDecorate[roomId] then
		local buildingList = {}
		local __buildingList = {}

		for i, id in pairs(buildingList) do
			local c = self:getBuildingConfig(id)
			local unlookItem = c.UnlookItem

			if not unlookItem or unlookItem == "" then
				__buildingList[#__buildingList + 1] = id
			else
				local bagSystem = self:getInjector():getInstance(DevelopSystem):getBagSystem()
				local count = bagSystem:getItemCount(unlookItem) or 0

				if count > 0 then
					__buildingList[#__buildingList + 1] = id
				end
			end
		end

		return self:sortBuildingBuyList(__buildingList, roomId)
	end
end

function BuildingSystem:getBuildingResource(roomId, ignoreSta)
	if self._buildingResource == nil then
		self._buildingResource = {}

		local dataTable = ConfigReader:getDataTable("VillageSystemBuilding")

		for k, v in pairs(dataTable) do
			local room = v.Room

			if not self._buildingResource[room] then
				self._buildingResource[room][#self._buildingResource[room] + 1] = k
				self._buildingResource[room] = self._buildingResource[room]
			end
		end

		for k, v in pairs(self._buildingResource) do
			table.sort(v, function(a, b)
				local sortA = self:getBuildingConfig(a).Sort
				local sortB = self:getBuildingConfig(b).Sort

				if sortA < sortB then
					return true
				end

				return false
			end)
		end
	end

	if not self._buildingResource[roomId] then
		local buildingList = {}

		if ignoreSta then
			return buildingList
		else
			return self:sortBuildingBuyList(buildingList, roomId)
		end
	end
end

function BuildingSystem:sortBuildingBuyList(buildingList, roomId)
	local listOne = {}

	if #buildingList > 0 then
		local listTwo = {}
		local listThree = {}
		local room = self:getRoom(roomId)

		for k, v in pairs(buildingList) do
			local config = self:getBuildingConfig(v)
			local ownNum = room:getOwnNum(v)

			if not config.Amount then
				local condition = config.Condition
				local conditionSta = self:isMeetCondition(condition)

				if config.Amount <= ownNum then
					listThree[#listThree + 1] = v
				elseif not conditionSta then
					listTwo[#listTwo + 1] = v
				else
					listOne[#listOne + 1] = v
				end
			end
		end

		for k, v in pairs(listTwo) do
			listOne[#listOne + 1] = v
		end

		for k, v in pairs(listThree) do
			listOne[#listOne + 1] = v
		end
	end

	return listOne
end

function BuildingSystem:getBuildingRecycleList(roomId)
	local room = self:getRoom(roomId)

	if room then
		local list = room:getRecycleList()

		table.sort(list, function(a, b)
			local configA = self:getBuildingData(roomId, a)._configId
			local configB = self:getBuildingData(roomId, b)._configId
			local sortA = self:getBuildingConfig(configA).Sort
			local sortB = self:getBuildingConfig(configB).Sort

			if sortA < sortB then
				return true
			end

			return false
		end)

		return list
	elseif roomId == kStoreRoomName then
		local list = {}

		for room, v in pairs(self._secondStore) do
			if not self:getRoomOpenSta(room) then
				for name, _ in pairs(v) do
					table.insert(list, name)
				end
			end
		end

		return list
	end

	return {}
end

function BuildingSystem:tiledPosToRoomPos(roomId, pos)
	local area = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "Area")
	local newPos = cc.p(0, 0)

	newPos.x = area[1] - pos.y
	newPos.y = area[2] - pos.x

	return newPos
end

function BuildingSystem:roomPosToTiledPos(roomId, pos)
	local area = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "Area")
	local newPos = cc.p(0, 0)

	newPos.y = area[1] - pos.x
	newPos.x = area[2] - pos.y

	return newPos
end

function BuildingSystem:resetRoomUsePos(roomId)
	local room = self:getRoom(roomId)

	if room then
		room:resetUsePos()
	end
end

function BuildingSystem:getBuildingCanChangeToPos(roomId, buildingId, pos, outPos, revert)
	local room = self:getRoom(roomId)

	if room then
		local useList = room._usePos

		outPos = outPos or {}

		local area = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "Area")
		local posList = self:getBuildingPosList(buildingId, pos, revert)

		for k, v in pairs(posList) do
			local key = v.x .. "_" .. v.y

			if useList[key] and not outPos[key] or v.x < 0 or v.x > area[1] or v.y < 0 or v.y > area[2] then
				return false
			end
		end

		return true
	end

	return false
end

function BuildingSystem:getBuildingInRoomSta(roomId, buildingId, pos, revert)
	local room = self:getRoom(roomId)

	if room then
		local area = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "Area")
		local posList = self:getBuildingPosList(buildingId, pos, revert)

		for k, v in pairs(posList) do
			if v.x < 0 or v.x > area[1] or v.y < 0 or v.y > area[2] then
				return false
			end
		end

		return true
	end

	return false
end

function BuildingSystem:getBuildingPutPos(roomId, buildingId, initial, revert)
	local room = self:getRoom(roomId)

	if room then
		local area = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "Area")
		local useList = room._usePos

		if initial then
			local ownNum = room:getOwnNum(buildingId)
			local config = self:getBuildingConfig(buildingId)
			local initialPosition = config.InitialPosition

			if initialPosition and initialPosition[ownNum + 1] then
				local posC = initialPosition[ownNum + 1]
				local pos = cc.p(posC[1], posC[2])
				local posList = self:getBuildingPosList(buildingId, pos, revert)
				local canPut = true

				for k, v in pairs(posList) do
					local posNow = cc.p(v.x, v.y)
					local key = posNow.x .. "_" .. posNow.y

					if useList[key] or posNow.x < 0 or posNow.x > area[1] or posNow.y < 0 or posNow.y > area[2] then
						canPut = false

						break
					end
				end

				if canPut then
					return pos
				end
			end
		end

		local posList = self:getBuildingPosList(buildingId, cc.p(0, 0), revert)

		for y = 0, area[2] do
			for x = 0, area[1] do
				local canPut = true

				for k, v in pairs(posList) do
					local posNow = cc.p(v.x + x, v.y + y)
					local key = posNow.x .. "_" .. posNow.y

					if useList[key] or posNow.x < 0 or posNow.x > area[1] or posNow.y < 0 or posNow.y > area[2] then
						canPut = false

						break
					end
				end

				if canPut then
					local posPut = posList[1]

					posPut.x = posPut.x + x
					posPut.y = posPut.y + y

					return posPut
				end
			end
		end
	end

	return nil
end

function BuildingSystem:getBuildingConfig(buildingId)
	local config = ConfigReader:getRecordById("VillageSystemBuilding", buildingId)

	config = config or ConfigReader:getRecordById("VillageDecorateBuilding", buildingId)

	return config
end

function BuildingSystem:getTimeText(time)
	local h = math.floor(time / 3600)
	local m = math.floor((time - h * 3600) / 60)
	local s = math.floor(time - h * 3600 - m * 60)
	local t = ""
	local unit = string.format("%02d:%02d:%02d", h, m, s)

	if h > 0 then
		t = string.format("%02d", h) .. "时"
	elseif m > 0 then
		t = string.format("%02d", m) .. "分"
	elseif s > 0 then
		t = string.format("%02d", s) .. "秒"
	end

	if t == "" then
		t = "00秒"
	end

	return t, unit
end

function BuildingSystem:getBuildingPosList(buildingId, pos, revert)
	local posList = {}
	local config = self:getBuildingConfig(buildingId)
	local space = config.Space
	local width = space[1]
	local height = space[2]

	if revert then
		width = space[2]
		height = space[1]
	end

	for x = 0, width - 1 do
		for y = 0, height - 1 do
			posList[#posList + 1] = cc.p(pos.x + x, pos.y + y)
		end
	end

	return posList
end

function BuildingSystem:getBuildingWidth(buildingId)
	local config = self:getBuildingConfig(buildingId)
	local space = config.Space

	return cc.size(space[1], space[2])
end

function BuildingSystem:getIdByRoomIdAndPos(roomId, pos)
	local room = self:getRoom(roomId)

	if room then
		return room:getIdByPos(pos)
	end

	return nil
end

function BuildingSystem:getMapBuildingPosList(roomId, id)
	local building = self:getBuildingData(roomId, id)
	local usePos = {}

	if building then
		local posList = building:getUsePos()

		for i = 1, #posList do
			local pos = posList[i]
			local key = pos.x .. "_" .. pos.y

			usePos[key] = true
		end
	end

	return usePos
end

function BuildingSystem:getBuildingShowInAll(buildingId)
	local config = self:getBuildingConfig(buildingId)

	if config and config.ProspectShow == 0 then
		return true
	end

	return false
end

function BuildingSystem:getPreBuildingSta(preBuilding)
	for k, v in pairs(preBuilding) do
		if not self._buildingCollect[v] then
			return false
		end
	end

	return true
end

function BuildingSystem:getLvUpImmediatelyNum(roomId, id)
	local cost = 9999999
	local buildingData = self:getBuildingData(roomId, id)

	if buildingData then
		local endTime = buildingData._finishTime
		local timeNow = self._gameServerAgent:remoteTimestamp()
		local freeTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Village_FreeCompleteTime", "content")

		if freeTime >= endTime - timeNow then
			cost = 0
		else
			local nextBuilding = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", buildingData._levelConfigId, "NextBuilding")

			if nextBuilding then
				local diamond = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", nextBuilding, "UpgradeTimeDiamond") or 0
				local UpgradeTime = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", nextBuilding, "UpgradeTime") or 0

				cost = self:buildingTimeToDiamond(math.floor(endTime - timeNow), UpgradeTime, diamond)
			end
		end
	end

	return cost
end

function BuildingSystem:buildingTimeToDiamond(endTime, sumTime, diamond)
	if diamond <= 0 or endTime <= 0 or sumTime <= 0 then
		return 0
	end

	local cost = math.floor(endTime / sumTime * diamond)
	local num = cost % 10

	cost = num < 5 and cost - num + 5 or cost - num + 10

	return cost
end

function BuildingSystem:addLvUpSucInfo(info)
	self._buildingLvUpFinishList[#self._buildingLvUpFinishList + 1] = info

	self:showLvUpSucView()
end

function BuildingSystem:getAllComfort()
	local num = 0

	for k, v in pairs(self._roomList) do
		num = num + v._comfortValue
	end

	return num
end

function BuildingSystem:getRoomComfort(roomId)
	return (self._roomList[roomId] or nil) and self._roomList[roomId]._comfortValue
end

function BuildingSystem:getRoomAddLove(roomId)
	local num = 0

	if self._roomList[roomId] then
		local village_RoomHeroLove = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Village_RoomHeroLove", "content")
		local comfort = self:getRoomComfort(roomId)

		num = math.floor(comfort * village_RoomHeroLove)
	end

	return num
end

function BuildingSystem:getComfortAtt()
	local attInfo = {}
	local player = self._developSystem._player
	local effectCenter = player._effectCenter

	attInfo.ATK = math.floor(effectCenter:getBuildComfortEffectById("ATK"))
	attInfo.DEF = math.floor(effectCenter:getBuildComfortEffectById("DEF"))
	attInfo.HP = math.floor(effectCenter:getBuildComfortEffectById("HP"))
	attInfo.SPEED = math.floor(effectCenter:getBuildComfortEffectById("SPEED"))

	return attInfo
end

function BuildingSystem:judgeResouseType(t)
	if t == KBuildingType.kGoldOre or t == KBuildingType.kCrystalOre or t == KBuildingType.kExpOre or t == KBuildingType.kCamp then
		return true
	end

	return false
end

function BuildingSystem:showLvUpSucView()
	if self._buildingLvUpFinishShowSta then
		return
	end

	local info = self._buildingLvUpFinishList[1]

	if info then
		table.remove(self._buildingLvUpFinishList, 1)

		local view = self:getInjector():getInstance("BuildingLvUpSucView")
		local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
			remainLastView = true,
			maskOpacity = 0
		}, info)

		self:dispatch(event)
	end
end

function BuildingSystem:getBuildingCanLvUp(roomId, id)
	if self:getBuildingQueueNum() <= 0 then
		return false
	end

	local building = self:getBuildingData(roomId, id)

	if building and building._activated and building._status == KBuildingStatus.kNone and building._type ~= KBuildingType.kDecorate then
		local levelConfigId = building._levelConfigId
		local lvConfig = ConfigReader:getRecordById("VillageBuildingLevel", levelConfigId)

		if lvConfig.NextBuilding and lvConfig.NextBuilding ~= "" then
			local buildCondition = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", lvConfig.NextBuilding, "BuildCondition") or {}
			local lvSta = self:isMeetConditions(buildCondition)

			if lvSta then
				local preBuildingSta = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", lvConfig.NextBuilding, "PreBuilding") or {}
				local preSta = self:getPreBuildingSta(preBuildingSta)

				if preSta then
					local upgradeCost = ConfigReader:getDataByNameIdAndKey("VillageBuildingLevel", lvConfig.NextBuilding, "UpgradeCost") or {}

					for k, v in pairs(upgradeCost) do
						local canbuild = CurrencySystem:checkEnoughCurrency(self, v.type, v.amount, {
							type = "none"
						})

						if not canbuild then
							return false
						end
					end

					return true
				end
			end
		end
	end

	return false
end

function BuildingSystem:getHeroCanEvent(heroId)
	local gallerySystem = self._developSystem._gallerySystem
	local afkMaps = gallerySystem:getPartyManage()._afkMaps

	if not afkMaps[heroId] then
		return false
	end

	for k, v in pairs(self._roomList) do
		if not v._heroList then
			for kk, vv in pairs(v._heroList) do
				if vv == heroId then
					return true
				end
			end
		end
	end

	return false
end

function BuildingSystem:getPutHeroList()
	local restHeros = {}
	local _restHeros = {}
	local workHeros = {}

	for k, v in pairs(self._roomList) do
		for kk, vv in pairs(v._heroList) do
			workHeros[vv] = true
		end
	end

	local layingList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Village_NotLayingList", "content") or {}
	local canUseList = {}

	for k, v in pairs(layingList) do
		canUseList[v] = true
	end

	local heros = self:getDevelopSystem():getHeroList():getHeros()

	for k, v in pairs(heros) do
		if not canUseList[v:getId()] and self:chooseHero(v:getId()) then
			if not workHeros[v:getId()] then
				restHeros[#restHeros + 1] = v:getId()
			else
				_restHeros[#_restHeros + 1] = v:getId()
			end
		end
	end

	return self:getSortExtendIds(restHeros), self:getSortExtendIds(_restHeros)
end

function BuildingSystem:getHeroPutRoomId(id)
	for k, v in pairs(self._roomList) do
		for kk, vv in pairs(v._heroList) do
			if vv == id then
				return k
			end
		end
	end

	return nil
end

function BuildingSystem:tryEnterAfkGift(heroId, showType)
	local heroSystem = self._developSystem:getHeroSystem()

	if heroId and heroSystem:getHeroById(heroId) and self:getHeroCanEvent(heroId) then
		AudioEngine:getInstance():stopEffectsByType(AudioType.CVEffect)

		if showType == 2 then
			local view = self:getInjector():getInstance("HeroInteractionView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
				heroId = heroId
			}))
		else
			local view = self:getInjector():getInstance("BuildingAfkGiftView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
				canSetBoardHero = false,
				id = heroId,
				type = showType
			}))
		end
	end
end

function BuildingSystem:clearAllHeroPutInfo()
	for k, v in pairs(self._roomList) do
		v._heroPosList = {}

		for kk, vv in pairs(v._buildingList) do
			vv._putHeroList = {}
			vv._putHeroPosList = {}
		end
	end
end

function BuildingSystem:clearAllAddLove()
	for k, v in pairs(self._selfData.unlockedRooms or {}) do
		v.lastHeroLove = {}
	end

	for k, v in pairs(self._roomList or {}) do
		v._lastHeroLove = {}
	end
end

function BuildingSystem:checkBuildingEffect(data, isDiff)
	if data.managers.BattleConfigEffManager then
		local effects = data.managers.BattleConfigEffManager.effects

		if effects then
			if effects.DeckCost then
				local costValueList = effects.DeckCost.ALL

				if costValueList then
					for k, v in pairs(costValueList) do
						local buffKey = string.split(k, "_")[1]

						if buffKey == "VILLAGE" or buffKey == "VILLAGEHERO" then
							self._costEffectBuffList[k] = v.value
						end
					end
				end
			end

			if effects.DeckCardNum then
				local cardGroupNumLimit = effects.DeckCardNum.ALL

				if cardGroupNumLimit then
					local resultCardNum = 0

					for k, v in pairs(cardGroupNumLimit) do
						local buffKey = string.split(k, "_")[1]

						if buffKey == "VILLAGE" or buffKey == "VILLAGEHERO" then
							resultCardNum = resultCardNum + v.value
							self._cardEffectBuffList[k] = v.value
						end
					end

					if self._cardEffectValue ~= resultCardNum and isDiff then
						self._customDataSystem:setValue(PrefixType.kGlobal, "StageTeamRed", "1")
					end
				end
			end

			self:resetCostAndCardBuff()
		end
	end
end

function BuildingSystem:syncDeleteBuff(del)
	if del and del.player and del.player.effectCenter then
		local data = del.player.effectCenter

		if data.managers and data.managers.BattleConfigEffManager and data.managers.BattleConfigEffManager.effects then
			local effects = data.managers.BattleConfigEffManager.effects

			if effects.DeckCost then
				local costValueList = effects.DeckCost.ALL

				if costValueList then
					for k, v in pairs(costValueList) do
						local buffKey = string.split(k, "_")[1]

						if buffKey == "VILLAGE" or buffKey == "VILLAGEHERO" then
							self._costEffectBuffList[k] = nil
						end
					end
				end
			end

			if effects.DeckCardNum then
				local cardGroupNumLimit = effects.DeckCardNum.ALL

				if cardGroupNumLimit then
					for k, v in pairs(cardGroupNumLimit) do
						local buffKey = string.split(k, "_")[1]

						if buffKey == "VILLAGE" or buffKey == "VILLAGEHERO" then
							self._cardEffectBuffList[k] = nil
						end
					end
				end
			end

			self:resetCostAndCardBuff()
		end
	end
end

function BuildingSystem:resetCostAndCardBuff()
	local result = 0
	local heroResult = 0

	for k, v in pairs(self._costEffectBuffList) do
		local buffKey = string.split(k, "_")[1]

		result = result + v

		if buffKey == "VILLAGEHERO" then
			heroResult = heroResult + v
		end
	end

	self._costEffectValue = result
	self._costHeroEffectValue = heroResult

	local resultCardNum = 0
	local heroResultCardNum = 0

	for k, v in pairs(self._cardEffectBuffList) do
		resultCardNum = resultCardNum + v

		local buffKey = string.split(k, "_")[1]

		if buffKey == "VILLAGEHERO" then
			heroResultCardNum = heroResultCardNum + v
		end
	end

	self._cardEffectValue = resultCardNum
	self._cardHeroEffectValue = heroResultCardNum
end

function BuildingSystem:getBuildingCostBuf()
	return self._costEffectValue or 0
end

function BuildingSystem:getBuildingBuildCostBuf()
	if not self._costEffectValue then
		if not self._costHeroEffectValue then
			local heroBuff = 0

			return self._costEffectValue - heroBuff
		end
	end
end

function BuildingSystem:getBuildingHeroCostBuf()
	return self._costHeroEffectValue or 0
end

function BuildingSystem:getBuildingCardBuf()
	return self._cardEffectValue or 0
end

function BuildingSystem:getBuildingBuildCardBuf()
	if not self._cardEffectValue then
		if not self._cardHeroEffectValue then
			local heroBuff = 0

			return self._cardEffectValue - heroBuff
		end
	end
end

function BuildingSystem:getBuildingHeroCardBuf()
	return self._cardHeroEffectValue or 0
end

local SortExtendFunc = {
	{
		func = function(sortExtendType, hero)
			return hero:getRarity() == 16 - sortExtendType
		end
	},
	{
		func = function(sortExtendType, hero)
			return hero:getParty() == sortExtendType
		end
	}
}

function BuildingSystem:setSortExtand(sortType, sortExtendType)
	if sortType == 0 then
		for i, v in ipairs(SortExtend) do
			self._sortExtand[i] = {}
		end

		return
	end

	self._sortExtand[sortType] = self._sortExtand[sortType] or {}

	if self:isSortExtendTypeExist(sortType, sortExtendType) then
		for i = 1, #self._sortExtand[sortType] do
			local v = self._sortExtand[sortType][i]

			if v == sortExtendType then
				table.remove(self._sortExtand[sortType], i)

				break
			end
		end
	else
		self._sortExtand[sortType][#self._sortExtand[sortType] + 1] = sortExtendType
	end
end

function BuildingSystem:isSortExtendTypeExist(sortType, sortExtendType)
	for i = 1, #self._sortExtand[sortType] do
		local v = self._sortExtand[sortType][i]

		if v == sortExtendType then
			return true
		end
	end

	return false
end

function BuildingSystem:getSortExtendIds(ids)
	local list = {}

	for k = 1, #ids do
		list[#list + 1] = ids[k]
	end

	return list
end

function BuildingSystem:chooseHero(heroId)
	local heroSystem = self:getDevelopSystem():getHeroSystem()
	local checkMark = 0

	for sortType, sortExtend in ipairs(self._sortExtand) do
		if sortExtend and #sortExtend > 0 then
			for i = 1, #sortExtend do
				if SortExtendFunc[sortType] and SortExtendFunc[sortType].func(sortExtend[i], heroSystem:getHeroById(heroId)) then
					checkMark = checkMark + 1

					break
				end
			end
		elseif sortExtend and #sortExtend == 0 then
			checkMark = checkMark + 1
		end
	end

	if checkMark == #self._sortExtand then
		return true
	end

	return false
end

function BuildingSystem:checkHasExtend()
	for i, v in ipairs(self._sortExtand) do
		if v and #v > 0 then
			return true
		end
	end

	return false
end

function BuildingSystem:getSortNum()
	return #heroShowSortList
end

function BuildingSystem:getSortTypeStr(index)
	return heroShowSortList[index]
end

function BuildingSystem:getSortExtendNum()
	return #SortExtend
end

function BuildingSystem:getSortExtendMaxNum()
	return #SortExtend[2]
end

function BuildingSystem:getSortExtandParam(index)
	return SortExtend[index]
end

function BuildingSystem:getSortExtandStr(index)
	local str = {
		Strings:get("HEROS_UI30"),
		Strings:get("Force_Screen")
	}

	return str[index]
end

function BuildingSystem:sortHeroes(list, type, recommendIds, roomId)
	local heroSystem = self._developSystem:getHeroSystem()

	if type == 1 then
		table.sort(list, function(_a, _b)
			local a = heroSystem:getHeroInfoById(_a.id or _a)
			local b = heroSystem:getHeroInfoById(_b.id or _b)
			local buffA, _ = self:getBuildPutHeroAddBuff(roomId, {
				a.id
			})
			local buffB, __ = self:getBuildPutHeroAddBuff(roomId, {
				b.id
			})

			if buffA == buffB then
				if a.quality == b.quality then
					if a.level == b.level then
						if a.rareity == b.rareity then
							if a.cost == b.cost then
								if a.star == b.star then
									if a.combat == b.combat then
										return a.id > b.id
									end

									return a.combat > b.combat
								end

								return a.star > b.star
							end

							return a.cost < b.cost
						end

						return a.rareity > b.rareity
					end

					return a.level > b.level
				end

				return a.quality > b.quality
			end

			return buffB < buffA
		end)
	else
		local typeNew = type

		if type == 3 then
			typeNew = 4
		elseif type == 4 then
			typeNew = 7
		elseif type == 5 then
			typeNew = 6
		end

		heroSystem:sortHeroes(list, typeNew)
	end
end

function BuildingSystem:getBuildCanTurn(buildId)
	local config = self:getBuildingConfig(buildId)

	if config and config.Turn == 1 then
		return true
	end

	return false
end

function BuildingSystem:getBuildResourceScale()
	local roomId = self:getShowRoomId()

	if roomId and roomId ~= "" then
		return 1
	end

	return self._buildResouseMaxScale or 1
end

function BuildingSystem:resetBuildResouseMaxScale(minScale)
	self._buildResouseMaxScale = KBUILDING_MAP_INROOM_SCALE / minScale
end

function BuildingSystem:getCostBuildLvOrBuildSta()
	return self:getBuildLvOrBuildSta(KBuildingType.kCamp)
end

function BuildingSystem:getBuildLvOrBuildSta(buildType)
	local roomList = self:getRoomList()

	for k, v in pairs(roomList) do
		if self:getRoomBuildLvOrBuildSta(buildType, k) then
			return true
		end
	end

	return false
end

function BuildingSystem:getRoomBuildLvOrBuildSta(buildType, roomId)
	local room = self:getRoom(roomId)

	if room then
		local buildList = room._buildingList

		for kk, vv in pairs(buildList) do
			if (buildType == nil and vv._type ~= KBuildingType.kDecorate or vv._type == KBuildingType.kCamp) and self:getBuildingCanLvUp(roomId, vv._id) then
				return true
			end
		end

		local buildingList = self:getBuildingResource(roomId, false)

		for index, configId in pairs(buildingList) do
			if self:getBuildingBuildSta(configId, roomId, buildType) then
				return true
			end
		end
	end

	return false
end

function BuildingSystem:getBuildingBuildSta(configId, roomId, buildType)
	local room = self:getRoom(roomId)

	if room then
		local config = self:getBuildingConfig(configId)

		if buildType == nil or config.Type == KBuildingType.kCamp then
			local ownNum = room:getOwnNum(config.Id)

			if not config.Amount then
				if ownNum < config.Amount then
					local buildingLevel = config.BuildingLevel
					local configLevel = ConfigReader:getRecordById("VillageBuildingLevel", buildingLevel)

					if not config.Condition then
						local condition = {}
						local conditionSta = self:isMeetCondition(condition)

						if conditionSta then
							local upgradeCost = configLevel.UpgradeCost
							local costSta = true

							for k, v in pairs(upgradeCost) do
								local count = self._developSystem:getBagSystem():getItemCount(v.type)

								if count < v.amount then
									costSta = false
								end
							end

							if costSta then
								return true
							end
						end
					end
				end
			end
		end
	end

	return false
end

function BuildingSystem:getBuildQueueCostByTime(sec)
	local freeTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Village_FreeCompleteTime", "content")

	if sec <= freeTime then
		return 0
	end

	local hour = math.floor(sec / 3600)
	local min = (sec - hour * 3600) / 60
	local village_CD2Diamond = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Village_CD2Diamond", "content") or {}

	if not village_CD2Diamond.base then
		local base = 0

		if not village_CD2Diamond.time then
			local timeList = {}

			local function getHourCost(h)
				local index = -1
				local costH = 0

				for k, v in pairs(timeList) do
					if index < tonumber(k) and h > tonumber(k) then
						index = tonumber(k)
						costH = v
					end
				end

				return costH
			end

			local hourCost = 0

			for h = 1, hour do
				hourCost = hourCost + getHourCost(h)
			end

			local minCost = 0

			if min > 0 then
				local cost = getHourCost(hour + 1)

				minCost = cost / 60 * min
			end

			return math.ceil(base + hourCost + minCost)
		end
	end
end

function BuildingSystem:getBuildPutHeroAddBuffLv(roomId, heroList)
	if not self:isSelfBuilding() then
		return 0
	end

	local room = self:getRoom(roomId)

	if room then
		local heroSystem = self._developSystem:getHeroSystem()
		local putEffectValue = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "PutEffectValue") or {}
		local buffLv = 0

		for _, heroId in pairs(heroList) do
			local heroInfo = heroSystem:getHeroById(heroId)
			local heroBuffLv = 0
			local star = heroInfo:getStar()
			local party = heroInfo:getParty()
			local rarity = heroInfo:getRarity()

			if putEffectValue[tostring(rarity)] then
				heroBuffLv = heroBuffLv + (putEffectValue[tostring(rarity)][star] or 0)
			end

			local partyConfig = putEffectValue.party

			if partyConfig then
				local partyConfigId = partyConfig.id

				if partyConfigId and partyConfigId == party then
					heroBuffLv = heroBuffLv + (partyConfig[tostring(rarity)] or 0)
				end
			end

			buffLv = buffLv + heroBuffLv
		end

		return buffLv
	end

	return 0
end

function BuildingSystem:getBuildPutHeroAddBuff(roomId, heroList)
	local room = self:getRoom(roomId)

	if room then
		local buffLv = self:getBuildPutHeroAddBuffLv(roomId, heroList)

		return self:getAddBuffByBuffLv(roomId, buffLv)
	end

	return 0, ""
end

function BuildingSystem:getAddBuffByBuffLv(roomId, buffLv)
	local putEffect = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "PutEffect")
	local putEffectType = putEffect.type
	local putEffectId = putEffect.id

	if putEffectType and putEffectId then
		local effectConfig = ConfigReader:getRecordById(putEffectType, putEffectId)
		local attrNum = 0

		if putEffectType == "SkillSpecialEffect" then
			attrNum = SpecialEffectFormula:getAddNumByConfig(effectConfig, 1, buffLv)
		elseif putEffectType == "SkillAttrEffect" then
			attrNum = SkillAttribute:getAddNumByConfig(effectConfig, 1, buffLv)
		end

		return attrNum, effectConfig.Parameter and effectConfig.Parameter.type == "DeckCost" and attrNum or attrNum * 100 .. "%"
	end

	return 0, ""
end

function BuildingSystem:getRoomMaxBuffLv(roomId)
	local putEffectValue = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "PutEffectValue") or {}
	local maxRarity = "14"

	if putEffectValue[maxRarity] then
		if not putEffectValue[maxRarity][#putEffectValue[maxRarity]] then
			local buffLv = 0

			if putEffectValue.party and putEffectValue.party[maxRarity] then
				buffLv = buffLv + putEffectValue.party[maxRarity]
			end

			return buffLv
		end
	end
end

function BuildingSystem:getRoomParty(roomId)
	local putEffectValue = ConfigReader:getDataByNameIdAndKey("VillageRoom", roomId, "PutEffectValue") or {}

	if putEffectValue and putEffectValue.party then
		return putEffectValue.party.id
	end

	return nil
end

function BuildingSystem:getBuyResGetNum(configId)
	local getNum = 0
	local config = ConfigReader:getDataByNameIdAndKey("ConfigValue", configId, "content")

	if not config.base then
		if not config.buildType then
			local buildType = ""

			if not config.rewardTime then
				local rewardTime = 0

				getNum = getNum + config.base

				local roomList = self:getRoomList()

				for _, room in pairs(roomList) do
					local buildingList = room._buildingList

					for __, build in pairs(buildingList) do
						if build._type == buildType and build.getOutput then
							local outNum, limitNum = self:getSpecialEffectSta(build._levelConfigId, build._configId)

							getNum = getNum + outNum
						end
					end
				end

				return rewardTime * getNum
			end
		end
	end
end

function BuildingSystem:getAllBuildOutAndRes()
	local outList = {}
	local resList = {}
	local resNoLimitList = {}

	outList[KBuildingType.kGoldOre] = 0
	outList[KBuildingType.kCrystalOre] = 0
	outList[KBuildingType.kExpOre] = 0
	resList[KBuildingType.kGoldOre] = 0
	resList[KBuildingType.kCrystalOre] = 0
	resList[KBuildingType.kExpOre] = 0
	resNoLimitList[KBuildingType.kGoldOre] = 0
	resNoLimitList[KBuildingType.kCrystalOre] = 0
	resNoLimitList[KBuildingType.kExpOre] = 0

	local roomList = self:getRoomList() or {}

	for roomId, room in pairs(roomList) do
		local buildingList = room._buildingList

		for id, build in pairs(buildingList) do
			if outList[build._type] ~= nil then
				outList[build._type] = outList[build._type] + build:getOutput()
			end

			if resList[build._type] ~= nil then
				resList[build._type] = resList[build._type] + build:getResouseNum()
			end

			if resNoLimitList[build._type] ~= nil then
				resNoLimitList[build._type] = resNoLimitList[build._type] + build:getResouseNumNoLimit()
			end
		end
	end

	return outList, resList, resNoLimitList
end

function BuildingSystem:getAllExpBuildResSta()
	local roomList = self:getRoomList() or {}

	for roomId, room in pairs(roomList) do
		local buildingList = room._buildingList

		for id, build in pairs(buildingList) do
			if build._type == KBuildingType.kExpOre and build:getResouseNum() > 0 then
				return true
			end
		end
	end

	return false
end

function BuildingSystem:getBuildLastGetResTime()
	local timeMax = 0
	local timeNow = self._gameServerAgent:remoteTimestamp()
	local roomList = self:getRoomList() or {}

	for roomId, room in pairs(roomList) do
		local buildingList = room._buildingList

		for id, build in pairs(buildingList) do
			if build._type and (build._type == KBuildingType.kGoldOre or build._type == KBuildingType.kCrystalOre or build._type == KBuildingType.kExpOre) then
				local resSec = build._resSec

				if resSec > 0 then
					local time = timeNow - resSec

					if timeMax < time then
						timeMax = time
					end
				end
			end
		end
	end

	return timeMax
end

function BuildingSystem:sendPutHeroes(params, blockUI, callfun)
	local roomId = params.roomId

	self._buildingService:putHeroes(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callfun then
				callfun()
			end

			self:dispatch(Event:new(BUILDING_PUTHEROS_SUCCESS, {
				roomId = roomId
			}))
		end
	end)
end

function BuildingSystem:sendRecycleBuilding(params, blockUI, callfun)
	local roomId = params.roomId
	local id = params.buildId

	self._buildingService:recycleBuilding(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callfun then
				callfun()
			end

			self:dispatch(Event:new(BUILDING_RECYCLE_SUC, {
				roomId = roomId,
				id = id
			}))
		end
	end)
end

function BuildingSystem:sendUnlockRoom(roomId, blockUI, callfun)
	local params = {}

	params.roomId = roomId

	self._buildingService:unLockRoom(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callfun then
				callfun()
			end

			self:dispatch(Event:new(BUILDING_UNLOCK_ROOM_SUCCESS, {
				roomId = roomId
			}))
		end
	end)
end

function BuildingSystem:sendBuyBuilding(params, blockUI, callfun)
	local roomId = params.roomId
	local buildingId = params.buildConfigId

	self._buildingService:buyBuilding(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callfun then
				callfun()
			end

			self:dispatch(Event:new(BUILDING_BUY_BUILDING_SUC, {
				roomId = roomId
			}))

			local buildConfig = self:getBuildingConfig(buildingId)
			local info = {}

			info.roomId = roomId
			info.buildingId = buildingId
			info.showType = 2
			info.levelConfigId = buildConfig.BuildingLevel
			info.costEffectValue = self._stageSystem:getCostInit() + self:getBuildingCostBuf()
			info.cardEffectValue = self._stageSystem:getPlayerInit() + self:getBuildingBuildCardBuf()

			self:addLvUpSucInfo(info)
		end
	end)
end

function BuildingSystem:sendMoveBuilding(params, blockUI, callfun)
	local roomId = params.roomId

	self._buildingService:moveBuilding(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callfun then
				callfun()
			end

			self:dispatch(Event:new(BUILDING_MOVE_BUILDING_SUC, {
				roomId = roomId
			}))
		end
	end)
end

function BuildingSystem:sendActivateBuilding(params, blockUI, callfun)
	local roomId = params.roomId
	local id = params.buildId

	self._buildingService:activateBuilding(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callfun then
				callfun()
			end

			self:dispatch(Event:new(BUILDING_ACTIVATE_BUILDING_SUC, {
				roomId = roomId,
				id = id
			}))
		end
	end)
end

function BuildingSystem:sendBuildingLvUp(params, blockUI, callfun)
	local roomId = params.roomId
	local id = params.buildId

	self._buildingService:levelUpBuilding(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callfun then
				callfun()
			end

			local buildingData = self:getBuildingData(roomId, id)

			if buildingData then
				buildingData:setFinishAnimTime(self._gameServerAgent:remoteTimestamp() + KBUILDING_BUILD_ANIM_PLAY_TIME)

				local info = {}

				info.roomId = roomId
				info.id = id
				info.buildingId = buildingData._configId
				info.showType = 1
				info.level = buildingData._level
				info.levelConfigId = buildingData._levelConfigId
				info.costEffectValue = self._stageSystem:getCostInit() + self:getBuildingCostBuf()
				info.cardEffectValue = self._stageSystem:getPlayerInit() + self:getBuildingBuildCardBuf()

				self:addLvUpSucInfo(info)
			end

			self:dispatch(Event:new(BUILDING_LVUP_BUILDING_SUC, {
				roomId = roomId,
				id = id
			}))
		end
	end)
end

function BuildingSystem:sendBuildingLvUpFinish(params, blockUI, callfun)
	local roomId = params.roomId
	local id = params.buildId

	self._buildingService:levelUpBuildingFinish(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callfun then
				callfun()
			end

			self:dispatch(Event:new(BUILDING_LVUP_FINISH_BUILDING_SUC, {
				roomId = roomId,
				id = id
			}))

			local buildingData = self:getBuildingData(roomId, id)

			if buildingData then
				local info = {}

				info.roomId = roomId
				info.id = id
				info.buildingId = buildingData._configId
				info.showType = 1
				info.level = buildingData._level

				self:addLvUpSucInfo(info)
			end
		end
	end)
end

function BuildingSystem:sendBuildingLvUpCanel(params, blockUI, callfun)
	local roomId = params.roomId
	local id = params.buildId

	self._buildingService:levelUpBuildingCanel(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callfun then
				callfun()
			end

			self:dispatch(Event:new(BUILDING_LVUP_CANEL_BUILDING_SUC, {
				roomId = roomId,
				id = id
			}))
		end
	end)
end

function BuildingSystem:sendWarehouseToMap(params, blockUI, callfun)
	local roomId = params.roomId

	self._buildingService:moveBuilding(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callfun then
				callfun()
			end

			self:dispatch(Event:new(BUILDING_WAREHOUSE_TO_MAP_SUC, {
				roomId = roomId
			}))
		end
	end)
end

function BuildingSystem:sendSubOrcLevelUp(params, blockUI, callfun)
	self._buildingService:levelUpSubOrc(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callfun then
				callfun()
			end

			self:dispatch(Event:new(SUBORC_LVUP_BUILDING_SUC, {
				roomId = params.roomId,
				buildId = params.buildId,
				subId = params.subId
			}))
		end
	end)
end

function BuildingSystem:sendSubOrcFinishLevelUp(params, blockUI, callfun)
	self._buildingService:finishLevelUpSubOrc(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callfun then
				callfun()
			end

			self:dispatch(Event:new(SUBORC_LVUP_FINISH_BUILDING_SUC, {
				roomId = params.roomId,
				buildId = params.buildId,
				subId = params.subId
			}))

			local buildingData = self:getBuildingData(params.roomId, params.buildId)
			local info = {}

			info.roomId = params.roomId
			info.id = params.buildId
			info.subId = params.subId
			info.buildingId = buildingData._configId
			info.showType = 1
			info.levelConfigId = buildingData._levelConfigId

			self:addLvUpSucInfo(info)
		end
	end)
end

function BuildingSystem:sendSubOrcCancelLevelUp(params, blockUI, callfun)
	self._buildingService:cancelLevelUpSubOrc(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callfun then
				callfun()
			end

			self:dispatch(Event:new(SUBORC_LVUP_CANEL_BUILDING_SUC, {
				roomId = params.roomId,
				buildId = params.buildId,
				subId = params.subId
			}))
		end
	end)
end

function BuildingSystem:sendBuyNPlaceSystemBuilding(params, blockUI, callfun)
	local roomId = params.roomId
	local buildingId = params.buildConfigId

	self._buildingService:sendBuyNPlaceSystemBuilding(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callfun then
				callfun()
			end

			self:dispatch(Event:new(BUILDING_BUY_BUILDING_SUC, {
				roomId = roomId
			}))

			local buildConfig = self:getBuildingConfig(buildingId)
			local info = {}

			info.roomId = roomId
			info.buildingId = buildingId
			info.showType = 2
			info.levelConfigId = buildConfig.BuildingLevel
			info.costEffectValue = self._stageSystem:getCostInit() + self:getBuildingCostBuf()
			info.cardEffectValue = self._stageSystem:getPlayerInit() + self:getBuildingBuildCardBuf()

			self:addLvUpSucInfo(info)
		end
	end)
end

function BuildingSystem:sendGetHeroLove(blockUI, callfun)
	if not self:isSelfBuilding() then
		return
	end

	local roomList = {}
	local sendSta = false

	local function getNumber(t)
		local count = 0

		for k, v in pairs(t) do
			count = count + 1
		end

		return count
	end

	for k, v in pairs(self._roomList) do
		local lastHeroLove = v._lastHeroLove

		if lastHeroLove and getNumber(lastHeroLove) > 0 then
			local info = {}

			info.roomId = k
			info.heroList = {}
			roomList[#roomList + 1] = info

			for kk, vv in pairs(lastHeroLove) do
				info.heroList[kk] = vv
			end

			sendSta = true
		end
	end

	if sendSta then
		self._buildingService:getHeroLove({}, blockUI, function(response)
			if response.resCode == GS_SUCCESS then
				self:clearAllAddLove()

				if callfun then
					callfun()
				end

				local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
				local popCount = scene:getPopupViewCount()

				if popCount > 0 then
					scene:popView()
				end

				local view = self:getInjector():getInstance("BuildingLoveAddView")
				local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, {
					roomList = roomList
				})

				self:dispatch(event)
			end
		end)
	end
end

function BuildingSystem:getHeroLoveSendSta()
	local sendSta = false

	for k, v in pairs(self._roomList) do
		local info = {}

		for kk, vv in pairs(v._lastHeroLove) do
			info[kk] = vv
			sendSta = true
		end
	end

	return sendSta
end

function BuildingSystem:sendOneKeyCollectRes(place, isHomeView, callBack, items)
	if not isHomeView and not self:isSelfBuilding() then
		return
	end

	local rewardIdList = {}
	local var_161_0 = self._developSystem:getBagSystem():getItemCount("IR_Gold")

	var_161_0 = var_161_0 or 0
	rewardIdList.IR_Gold = var_161_0

	local var_161_1 = self._developSystem:getBagSystem():getItemCount("IR_Crystal")

	var_161_1 = var_161_1 or 0
	rewardIdList.IR_Crystal = var_161_1

	local expList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ExpChargeItem", "content")

	for _, id in pairs(expList) do
		local var_161_2 = self._developSystem:getBagSystem():getItemCount(id)

		var_161_2 = var_161_2 or 0
		rewardIdList[id] = var_161_2
	end

	local params = {
		items = items or {}
	}

	self._buildingService:sendOneKeyCollectRes(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			local allRewards = {}

			for id, num in pairs(rewardIdList) do
				if not self._developSystem:getBagSystem():getItemCount(id) then
					local numNow = 0

					if num < numNow then
						local data = {}

						data.amount = numNow - num
						data.code = id
						data.type = 2
						allRewards[#allRewards + 1] = data
					end
				end
			end

			if #allRewards > 0 then
				local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
				local topView = scene:getTopView()
				local topViewName = scene:getTopViewName()

				if topViewName == "BuildingView" then
					performWithDelay(topView, function()
						local view = self:getInjector():getInstance("getRewardView")

						self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
							maskOpacity = 0
						}, {
							rewards = allRewards
						}))
					end, 3)
				elseif isHomeView then
					callBack(allRewards)
				else
					local view = self:getInjector():getInstance("getRewardView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						maskOpacity = 0
					}, {
						rewards = allRewards
					}))
				end
			end

			local rewards = {}
			local expList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ExpChargeItem", "content")
			local expIdList = {}

			for _, id in pairs(expList) do
				expIdList[id] = true
			end

			for k, v in pairs(response.data) do
				if (k == "IR_Gold" or k == "IR_Crystal" or expIdList[k]) and v > 0 then
					local data = {}

					data.amount = v
					data.code = k
					data.type = 2
					rewards[#rewards + 1] = data
				end
			end

			local roomResList = {}
			local detail = response.data.detail

			if detail then
				for _, getData in pairs(detail) do
					local roomId = getData.roomId
					local buildingId = getData.buildingId
					local itemId = getData.itemId
					local amount = getData.amount

					if expIdList[itemId] and amount > 0 then
						local prototype = ItemPrototype:new(itemId)
						local exp = prototype:getReward() and prototype:getReward()[1].amount or 1

						amount = amount * exp
					end

					if amount and amount > 0 then
						roomResList[roomId] = roomResList[roomId] or {}
						roomResList[roomId][buildingId] = roomResList[roomId][buildingId] or 0
						roomResList[roomId][buildingId] = roomResList[roomId][buildingId] + amount
					end
				end
			end

			self:dispatch(Event:new(BUILDING_COLLECT_RESOUSE_SUC, {
				roomResList = roomResList,
				rewards = rewards,
				place = place
			}))
		end
	end)
end

function BuildingSystem:sendclearWorkerCD(params, blockUI, callfun)
	self._buildingService:sendclearWorkerCD(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callfun then
				callfun()
			end

			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Building_Finish_Tips")
			}))
			self:dispatch(Event:new(SUBORC_CLEAR_WORKERS_CD_SUC))
		end
	end)
end

function BuildingSystem:sendRefreshAfkEvent()
	self._buildingService:sendRefreshAfkEvent({}, true, function(response)
		return
	end)
end
