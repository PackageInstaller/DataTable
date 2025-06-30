-- chunkname: @IQIGame\\Module\\HomeLand\\HomeLandLuaModule.lua

HomeLandLuaModule = {
	BUILDING_TYPE_PROCESS = 8,
	isCreatingCastle = false,
	BUILDING_TYPE_MANUFACTURING = 2,
	cameraSize = 34,
	BUILDING_TYPE_WORK = 6,
	isCreate = false,
	currentEnterRoomID = 0,
	isVisitHome = false,
	BUILDING_TYPE_PRODUCTION = 1,
	BUILDING_TYPE_KITCHEN = 5,
	BUILDING_TYPE_PLANT = 3,
	isCanSave = 0,
	BUILDING_TYPE_RETURN_GIFT = 7,
	BUILDING_TYPE_DUTY_EDITION = 4,
	homeLandBuildingDic = {},
	homeLandRoomDic = {},
	unlockSuit = {},
	homeLandRoles = {},
	harvestLandEffect = {},
	putDecorateIds = {}
}

local HomeLandBuildingData = require("IQIGame.Module.HomeLand.HomeLandBuildingData")
local HomeLandPlantData = require("IQIGame.Module.HomeLand.HomeLandPlantData")
local HomeLandDormData = require("IQIGame.Module.HomeLand.HomeLandDormData")

function HomeLandLuaModule.CheckUnlockRoom(roomID)
	if HomeLandLuaModule.GetRoomDataByID(roomID) ~= nil then
		return false
	end

	local cfgInfo = CfgHomeLandRoomTable[roomID]
	local isUnlock = ConditionModule.Check(cfgInfo.ConditionId)
	local ample = true

	for i = 1, #cfgInfo.OpenCost, 2 do
		local needItemID = cfgInfo.OpenCost[i]
		local needNum = cfgInfo.OpenCost[i + 1]
		local haveNum = WarehouseModule.GetItemNumByCfgID(needItemID)

		if ample == true then
			ample = needNum <= haveNum
		end
	end

	return isUnlock and ample
end

function HomeLandLuaModule.CheckUnLockRoomRed()
	local allRooms = HomeLandLuaModule.GetHomeLandDorms()
	local isCanLock = false

	for i = 1, #allRooms do
		local dormData = allRooms[i]

		if not dormData.isUnlock then
			isCanLock = HomeLandLuaModule.CheckUnlockRoom(dormData.roomID)

			if isCanLock then
				return isCanLock
			end
		end
	end

	return isCanLock
end

function HomeLandLuaModule.ReloadHome(home)
	HomeLandLuaModule.homeLandBaseInfo = home.baseInfo
	HomeLandLuaModule.homeLandRoomDic = home.rooms
	HomeLandLuaModule.homeLandRoles = home.roles
	HomeLandLuaModule.unlockSuit = home.unlockSuit
	HomeLandLuaModule.homeLandBuildingDic = {}

	for i, v in pairs(home.buildings) do
		local buildingData = HomeLandBuildingData.New()

		buildingData:Init(v)
		table.insert(HomeLandLuaModule.homeLandBuildingDic, buildingData)
	end

	CookingModule.ReloadCookBook(home.unlockCookBook)
	HomeLandManufactureMould.ReloadManufactureItem(home.unlockManufactureItem)
	HomeLandProcessMould.Reload()
	PushMessageModule.CheckHomeLandPushMessage()
end

function HomeLandLuaModule.GetBuildingDataByID(buildingId)
	if HomeLandLuaModule.homeLandBuildingDic ~= nil then
		for k, v in pairs(HomeLandLuaModule.homeLandBuildingDic) do
			if v.cfgBuildingID == buildingId then
				return v
			end
		end
	end

	return nil
end

function HomeLandLuaModule.GetRoomDataByID(cid)
	if HomeLandLuaModule.homeLandRoomDic then
		for k, v in pairs(HomeLandLuaModule.homeLandRoomDic) do
			if v.cid == cid then
				return v
			end
		end
	end

	return nil
end

function HomeLandLuaModule.IsInTable(id, table)
	for i, v in pairs(table) do
		if id == v then
			return true
		end
	end

	return false
end

function HomeLandLuaModule.UpdateBuilding(building)
	if building ~= nil then
		local buildingData = HomeLandLuaModule.GetBuildingDataByID(building.cid)
		local index = table.indexOf(HomeLandLuaModule.homeLandBuildingDic, buildingData)

		if index ~= -1 then
			HomeLandLuaModule.homeLandBuildingDic[index]:Init(building)
		else
			local buildingData = HomeLandBuildingData.New()

			buildingData:Init(building)
			table.insert(HomeLandLuaModule.homeLandBuildingDic, buildingData)
		end

		HomelandModule.Instance:UpdateBuildingPOD(building)
		EventDispatcher.Dispatch(EventID.HomeLandQuickHarvestEvent)
		HomeLandProcessMould.UpdateProcess()
		CookingModule.UpdateCookBook()
	end
end

function HomeLandLuaModule.UpdatePlantData(buildingCid, land)
	local buildingData = HomeLandLuaModule.GetBuildingDataByID(buildingCid)

	if buildingData ~= nil then
		local bdIndex = table.indexOf(HomeLandLuaModule.homeLandBuildingDic, buildingData)
		local plantData = buildingData:GetPlantData(land.cid)

		if plantData ~= nil then
			local index = table.indexOf(buildingData.plantDataTab, plantData)

			plantData:Init(buildingCid, land)

			buildingData.plantDataTab[index] = plantData
		else
			plantData = HomeLandPlantData.New()

			plantData:Init(buildingCid, land)
			table.insert(buildingData.plantDataTab, plantData)
		end

		HomeLandLuaModule.homeLandBuildingDic[bdIndex] = buildingData
	end

	EventDispatcher.Dispatch(EventID.HomeLandQuickHarvestEvent)
	HomelandModule.Instance:UpdatePlantPOD(buildingCid, land)
	EventDispatcher.Dispatch(EventID.UpdateHomeLandOverview)
end

function HomeLandLuaModule.UpdateRoom(room)
	if room ~= nil then
		local roomData = HomeLandLuaModule.GetRoomDataByID(room.cid)
		local index = table.indexOf(HomeLandLuaModule.homeLandRoomDic, roomData)

		if index ~= -1 then
			HomeLandLuaModule.homeLandRoomDic[index] = room
		else
			HomeLandLuaModule.homeLandRoomDic[#HomeLandLuaModule.homeLandRoomDic + 1] = room

			HomelandModule.Instance:UpdateRoomPOD(room)
			HomeLandLuaModule.UnlockRoomResult(room.cid)
		end

		EventDispatcher.Dispatch(EventID.HomeLandUpdateRoom, room.cid)
	end
end

function HomeLandLuaModule.OnNoticeGetItem(itemAwards)
	local addItems = {}

	for i, v in pairs(itemAwards) do
		table.insert(addItems, {
			cid = v.cid,
			num = v.num,
			tag = v.tag
		})
	end

	if #addItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, addItems)
	end
end

function HomeLandLuaModule.OnClickFunDecorationEvent(sender, args)
	if HomeLandLuaModule.isVisitHome then
		return
	end

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		HomeLandLuaModule.cameraPosition = UnityEngine.Camera.main.transform.position
		HomeLandLuaModule.cameraSize = UnityEngine.Camera.main.orthographicSize
	end

	local decorate = CfgHomeLandDecorateTable[args.Cid]
	local HomeLandBuildingData = HomeLandLuaModule.GetBuildingDataByID(decorate.FunctionBuilding)

	if HomeLandBuildingData ~= nil then
		if HomeLandBuildingData.cfgBuilding.Type == HomeLandLuaModule.BUILDING_TYPE_PRODUCTION then
			UIModule.Open(Constant.UIControllerName.HomeLandAlchemyUI, Constant.UILayer.UI, {
				HomeLandBuildingData,
				decorate
			})
		elseif HomeLandBuildingData.cfgBuilding.Type == HomeLandLuaModule.BUILDING_TYPE_MANUFACTURING then
			UIModule.Open(Constant.UIControllerName.HomeLandManufactureUI, Constant.UILayer.UI, {
				HomeLandBuildingData,
				decorate
			})
		elseif HomeLandBuildingData.cfgBuilding.Type == HomeLandLuaModule.BUILDING_TYPE_PLANT then
			local pd = HomeLandBuildingData:GetPlantDataByDecorateCid(decorate.Id)

			if pd then
				UIModule.Open(Constant.UIControllerName.HomeLandPlantUI, Constant.UILayer.UI, {
					HomeLandBuildingData
				})
			else
				UIModule.Open(Constant.UIControllerName.HomeLandUnlockFieldUI, Constant.UILayer.UI, decorate.Id)
			end
		elseif HomeLandBuildingData.cfgBuilding.Type == HomeLandLuaModule.BUILDING_TYPE_DUTY_EDITION then
			UIModule.Open(Constant.UIControllerName.HomeLandGirlChooseUI, Constant.UILayer.UI)
		elseif HomeLandBuildingData.cfgBuilding.Type == HomeLandLuaModule.BUILDING_TYPE_KITCHEN then
			UIModule.Open(Constant.UIControllerName.HomeLandCookingUI, Constant.UILayer.UI, {
				HomeLandBuildingData,
				decorate
			})
		elseif HomeLandBuildingData.cfgBuilding.Type == HomeLandLuaModule.BUILDING_TYPE_WORK then
			HLWorkModule.decorate = decorate

			UIModule.Open(Constant.UIControllerName.HomeLandWorkListUI, Constant.UILayer.UI, {
				HomeLandBuildingData.cfgBuildingID,
				decorate
			})
		elseif HomeLandBuildingData.cfgBuilding.Type == HomeLandLuaModule.BUILDING_TYPE_RETURN_GIFT then
			UIModule.Open(Constant.UIControllerName.HomeLandGirlRewardUI, Constant.UILayer.UI)
		elseif HomeLandBuildingData.cfgBuilding.Type == HomeLandLuaModule.BUILDING_TYPE_PROCESS then
			UIModule.Open(Constant.UIControllerName.HomeLandMakeItemListUI, Constant.UILayer.UI, {
				HomeLandBuildingData,
				decorate
			})
		end
	end
end

function HomeLandLuaModule.OnHarvestEvent(sender, args)
	HomeLandLuaModule.HarvestLand(args.BuildingCid, args.LandCid)
end

function HomeLandLuaModule.OnDailyActionRecord(sender, args)
	net_home.recordDailyAction(args.ActionId)
end

function HomeLandLuaModule.OnTriggerDialog(sender, args)
	if args.Type == 1 then
		net_home.triggerPlot(args.Cid)
	elseif args.Type == 2 then
		local soulId = CfgSoulNewStoryTable[args.Cid].SoulId

		MemoryNewModule.currentSoulID = soulId

		MemoryNewModule.RequestGetSoulNewStory(soulId)
		MemoryNewModule.ExperienceNewStoryChapter(args.Cid, 1)
	end
end

function HomeLandLuaModule.GetHomeLandComfortLv()
	local lv = 1
	local cfgComfortData = HomeLandLuaModule.GetCfgHomeLandComfort(HomeLandLuaModule.homeLandBaseInfo.currentComfort)

	if cfgComfortData then
		lv = cfgComfortData.Level
	end

	return lv
end

function HomeLandLuaModule.GetHomeLandDormitoryComfortLv(comfort)
	local tab = {}

	for i, v in pairsCfg(CfgCheckInSoulMoodReduceEffectTable) do
		table.insert(tab, v)
	end

	table.sort(tab, function(a, b)
		return a.level > b.level
	end)

	for i = 1, #tab do
		local cfg = tab[i]

		if comfort >= cfg.ComfortNum[1] and comfort < cfg.ComfortNum[2] then
			return cfg.level
		end
	end

	return 1
end

function HomeLandLuaModule.GetCfgHomeLandComfort(interVal)
	local tab = {}

	for i, v in pairsCfg(CfgHomeLandComfortTable) do
		table.insert(tab, v)
	end

	table.sort(tab, function(a, b)
		return a.Level > b.Level
	end)

	for i = 1, #tab do
		local cfg = tab[i]

		if interVal >= cfg.ComfortInterval then
			return cfg
		end
	end

	return nil
end

function HomeLandLuaModule.GetHomeLandDorms()
	local tab = {}

	for i, v in pairsCfg(CfgHomeLandRoomTable) do
		if v.CastleIndex == 2 then
			local roomData = HomeLandLuaModule.GetRoomDataByID(v.Id)
			local isUnlock = roomData ~= nil
			local roles = HomeLandLuaModule.GetDormRoles(v.Id)
			local foreignShow = false

			if roomData then
				foreignShow = roomData.foreignShow
			end

			local dormData = HomeLandDormData.New()

			dormData:Init(v.Id, isUnlock, roles, foreignShow)
			table.insert(tab, dormData)
		end
	end

	table.sort(tab, function(a, b)
		return a.roomID < b.roomID
	end)

	return tab
end

function HomeLandLuaModule.GetDormRoles(roomID)
	local tab = {}

	if HomeLandLuaModule.homeLandRoles ~= nil then
		for k, v in pairs(HomeLandLuaModule.homeLandRoles) do
			if v.belongRoom == roomID then
				table.insert(tab, v.roleCid)
			end
		end
	end

	return tab
end

function HomeLandLuaModule.BackGiftNum()
	local num = 0

	if HomeLandLuaModule.homeLandRoles ~= nil then
		for k, v in pairs(HomeLandLuaModule.homeLandRoles) do
			if v.letters then
				num = num + #v.letters
			end
		end
	end

	return num
end

function HomeLandLuaModule.GetRewardState(cid)
	local state = 1
	local cfgData = CfgHomeLandComfortTable[cid]

	if table.indexOf(HomeLandLuaModule.homeLandBaseInfo.alreadyReward, cid) ~= -1 then
		state = 3
	else
		local needNum = cfgData.ComfortInterval

		if needNum <= HomeLandLuaModule.homeLandBaseInfo.maxComfort then
			state = 2
		end
	end

	return state
end

function HomeLandLuaModule.PlayHarvestLandEffect(buildingCid, landCid)
	local buildingData = HomeLandLuaModule.GetBuildingDataByID(buildingCid)

	if buildingData ~= nil then
		local plantData = buildingData:GetPlantData(landCid)
		local decorateCid = plantData.decorateCid

		if table.indexOf(HomeLandLuaModule.harvestLandEffect, decorateCid) == -1 then
			table.insert(HomeLandLuaModule.harvestLandEffect, decorateCid)

			local decorate = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room19/Objects/decorate_" .. decorateCid)

			if decorate then
				local entityTransform = decorate.transform:GetChild(0)
				local plantEntity = entityTransform:Find("PlantEntityObj"):GetChild(0).gameObject
				local skeletonAnimation = plantEntity:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

				if skeletonAnimation then
					skeletonAnimation:ClearState()

					skeletonAnimation.AnimationName = nil

					skeletonAnimation.state:SetEmptyAnimation(0, 0)
					skeletonAnimation.state:SetAnimation(0, "death", false)

					local StopAnimationTimer = Timer.New(function()
						local pos = table.indexOf(HomeLandLuaModule.harvestLandEffect, decorateCid)

						table.remove(HomeLandLuaModule.harvestLandEffect, pos)

						skeletonAnimation.AnimationName = nil

						skeletonAnimation.state:SetEmptyAnimation(0, 0)
						net_home.harvestLand(buildingCid, landCid)
					end, 1)

					StopAnimationTimer:Start()
				end
			end
		end
	end
end

function HomeLandLuaModule.GetDecorateIds(roomId)
	return HomelandModule.Instance:getDecorateIds(roomId)
end

function HomeLandLuaModule.GetDecorateNumByCid(cid)
	return HomelandModule.Instance:GetDecorateNumByCid(cid)
end

function HomeLandLuaModule.GetRoomRewardByID(cid)
	local state = 1
	local roomPOD = HomeLandLuaModule.GetRoomDataByID(cid)

	if roomPOD then
		local cfgRoom = CfgHomeLandRoomTable[cid]

		if roomPOD.receiveComfortAwards then
			state = 3
		elseif roomPOD.comfort >= cfgRoom.ComfortNeed then
			state = 2
		end
	end

	return state
end

function HomeLandLuaModule.AddDecorate(roomId, decorate)
	if HomeLandLuaModule.putDecorateIds[decorate.cid] == nil then
		HomeLandLuaModule.putDecorateIds[decorate.cid] = -1
	else
		HomeLandLuaModule.putDecorateIds[decorate.cid] = HomeLandLuaModule.putDecorateIds[decorate.cid] - 1
	end

	local decorates = HomelandModule.Instance:AddDecorate(roomId, decorate)

	for i, v in pairs(decorates) do
		if HomeLandLuaModule.putDecorateIds[v] == nil then
			HomeLandLuaModule.putDecorateIds[v] = 1
		else
			HomeLandLuaModule.putDecorateIds[v] = HomeLandLuaModule.putDecorateIds[v] + 1
		end
	end

	EventDispatcher.Dispatch(EventID.PutDecorateUpdateItem, roomId)
end

function HomeLandLuaModule.RemoveDecorate(roomId, id)
	local decorate = HomelandModule.Instance:RemoveDecorate(roomId, id)

	for i, v in pairs(decorate) do
		if HomeLandLuaModule.putDecorateIds[v] == nil then
			HomeLandLuaModule.putDecorateIds[v] = 1
		else
			HomeLandLuaModule.putDecorateIds[v] = HomeLandLuaModule.putDecorateIds[v] + 1
		end
	end

	EventDispatcher.Dispatch(EventID.PutDecorateUpdateItem, roomId)
end

function HomeLandLuaModule.ClearDecorate(roomId)
	local decorate = HomelandModule.Instance:RemoveDecorate(roomId, -1)

	for i, v in pairs(decorate) do
		if HomeLandLuaModule.putDecorateIds[v] == nil then
			HomeLandLuaModule.putDecorateIds[v] = 1
		else
			HomeLandLuaModule.putDecorateIds[v] = HomeLandLuaModule.putDecorateIds[v] + 1
		end
	end

	EventDispatcher.Dispatch(EventID.PutDecorateUpdateItem, roomId)
end

function HomeLandLuaModule.QuicklyPut(roomID, decorates)
	for i, v in pairs(decorates) do
		if HomeLandLuaModule.putDecorateIds[v.cid] == nil then
			HomeLandLuaModule.putDecorateIds[v.cid] = -1
		else
			HomeLandLuaModule.putDecorateIds[v.cid] = HomeLandLuaModule.putDecorateIds[v.cid] - 1
		end
	end

	local decorate = HomelandModule.Instance:QuicklyPut(roomID, decorates)

	for i, v in pairs(decorate) do
		if HomeLandLuaModule.putDecorateIds[v] == nil then
			HomeLandLuaModule.putDecorateIds[v] = 1
		else
			HomeLandLuaModule.putDecorateIds[v] = HomeLandLuaModule.putDecorateIds[v] + 1
		end
	end

	EventDispatcher.Dispatch(EventID.PutDecorateUpdateItem, roomID)
	HomeLandLuaModule.SaveRoomDecorate(roomID)
end

function HomeLandLuaModule.GetPutDecorateIdNum(cid)
	local num = 0

	if HomeLandLuaModule.putDecorateIds[cid] ~= nil then
		num = HomeLandLuaModule.putDecorateIds[cid]
	end

	return num
end

function HomeLandLuaModule.GetQuickLayoutByThemeID(themeID)
	local canLayout = false
	local decorateTab = {}
	local tab = {}
	local cfgTab
	local num = 0

	for i, v in pairsCfg(CfgHomeLandDecorateSuitTable) do
		if v.SuitId == themeID then
			cfgTab = v

			break
		end
	end

	for i = 1, #cfgTab.FurnitureIDList, 3 do
		local id = cfgTab.FurnitureIDList[i]
		local x = cfgTab.FurnitureIDList[i + 1]
		local y = cfgTab.FurnitureIDList[i + 2]
		local decoratePOD = {}

		decoratePOD.cid = id
		decoratePOD.x = x
		decoratePOD.y = y

		local cfgDecorate = CfgHomeLandDecorateTable[id]
		local haveNum = WarehouseModule.GetItemNumByCfgID(cfgDecorate.Item)

		if tab[id] == nil then
			tab[id] = 0
		else
			tab[id] = tab[id] + 1
		end

		if haveNum > tab[id] then
			table.insert(decorateTab, decoratePOD)

			if tab[id] == 0 then
				num = num + 1
			end
		end
	end

	canLayout = num >= cfgTab.QuickLayoutNum

	return canLayout, decorateTab
end

function HomeLandLuaModule.SummonSoul(roomID)
	HomelandModule.Instance:SummonSoul(roomID)
end

function HomeLandLuaModule.GetDormRoleByCid(roleCid)
	if HomeLandLuaModule.homeLandRoles ~= nil then
		for k, v in pairs(HomeLandLuaModule.homeLandRoles) do
			if v.roleCid == roleCid then
				return v
			end
		end
	end

	return nil
end

function HomeLandLuaModule.EnterHome()
	if HomeLandLuaModule.isCreatingCastle then
		return
	end

	net_home.enterHome()
end

function HomeLandLuaModule.ExitHome()
	HomeLandLuaModule.Shutdown()
	net_home.exitHome()
	SceneManager.ChangeScene(SceneID.MainCity)
end

function HomeLandLuaModule.HarvestBuilding(buildingCid)
	net_home.harvestBuilding(buildingCid)
end

function HomeLandLuaModule.HarvestLand(buildingCid, landCid)
	if landCid == -1 then
		net_home.harvestLand(buildingCid, -1)
	else
		HomeLandLuaModule.PlayHarvestLandEffect(buildingCid, landCid)
	end
end

function HomeLandLuaModule.Plant(buildingCid, landCid, seedCid)
	local buildData = HomeLandLuaModule.GetBuildingDataByID(buildingCid)
	local plantData = buildData:GetPlantData(landCid)

	if plantData ~= nil and plantData.landPOD.status ~= 1 then
		NoticeModule.ShowNotice(21042001)

		return
	end

	net_home.plant(buildingCid, landCid, seedCid)
end

function HomeLandLuaModule.CompletePlant(buildingCid, landCid, time)
	local buildData = HomeLandLuaModule.GetBuildingDataByID(buildingCid)
	local plantData = buildData:GetPlantData(landCid)

	if plantData ~= nil and (plantData.landPOD.status == Constant.HomelandPlantType.landStatusIdle or plantData.landPOD.status == Constant.HomelandPlantType.landStatusMature) then
		return
	end

	net_home.completePlant(buildingCid, landCid, time)
end

function HomeLandLuaModule.CancelPlant(buildingCid, landCid)
	net_home.cancelPlant(buildingCid, landCid)
end

function HomeLandLuaModule.UpdateBuildingLv(buildingCid)
	net_home.updateBuildingLv(buildingCid)
end

function HomeLandLuaModule.UnlockRoom(roomID)
	net_home.unlockRoom(roomID)
end

function HomeLandLuaModule.ChangeSuit(roomCid, suitCid)
	net_home.changeSuit(roomCid, suitCid)
end

function HomeLandLuaModule.UnlockSuit(suitCid)
	net_home.unlockSuit(suitCid)
end

function HomeLandLuaModule.VisitHome(targetServerId, targetPid)
	if PlayerModule.InMaze then
		NoticeModule.ShowNotice(21042036)

		return
	end

	if HomeLandLuaModule.isCreatingCastle then
		return
	end

	net_home.visitHome(targetServerId, targetPid)
end

function HomeLandLuaModule.Cook(buildingCid, queueId, cookCombinationCid, num)
	net_home.cook(buildingCid, queueId, cookCombinationCid, num)
end

function HomeLandLuaModule.CancelCook(buildingCid, queueId)
	net_home.cancelCook(buildingCid, queueId)
end

function HomeLandLuaModule.RewardCook(buildingCid, queueId)
	net_home.rewardCook(buildingCid, queueId)
end

function HomeLandLuaModule.CompleteCook(buildingCid, queueId, time)
	net_home.completeCook(buildingCid, queueId, time)
end

function HomeLandLuaModule.GetCookBookRewards(cid)
	net_home.getCookBookRewards(cid)
end

function HomeLandLuaModule.ChangeRoomName(cid, name)
	net_home.changeRoomName(cid, name)
end

function HomeLandLuaModule.EnterRoom(roomCid, homeLandRoleCid)
	net_home.enterRoom(roomCid, homeLandRoleCid)
end

function HomeLandLuaModule.SwitchRoomShow(roomCid)
	net_home.switchRoomShow(roomCid)
end

function HomeLandLuaModule.ReceiveComfortLvAwards(cid)
	net_home.receiveComfortLvAwards(cid)
end

function HomeLandLuaModule.ReceiveComfortAwards(cid)
	net_home.receiveComfortAwards(cid)
end

function HomeLandLuaModule.SaveRoomDecorate(roomId)
	local decorates = HomelandModule.Instance:GetRoomDecorates(roomId)

	net_home.saveRoomDecorate(roomId, decorates)

	if GameEntry.Base.DevMode then
		local str = ""

		for i, v in pairs(decorates) do
			str = str .. v.cid .. "|" .. v.x .. "|" .. v.y
		end

		log(str)
	end
end

function HomeLandLuaModule.ReceiveLetter(roleCid, letterCid)
	net_home.receiveLetter(roleCid, letterCid)
end

function HomeLandLuaModule.DecomposeDecorate(decorateCid, num)
	net_home.decomposeDecorate(decorateCid, num)
end

function HomeLandLuaModule.UnlockLand(buildingCid, landCid)
	net_home.unlockLand(buildingCid, landCid)
end

function HomeLandLuaModule.DecomposeDecorateResult(decorateCid, num)
	local itemShows = {}
	local cfgDecorate = CfgHomeLandDecorateTable[decorateCid]

	for i = 1, #cfgDecorate.ExchangeItem, 2 do
		local itemShowPOD = {}

		itemShowPOD.cid = cfgDecorate.ExchangeItem[i]
		itemShowPOD.num = cfgDecorate.ExchangeItem[i + 1] * num

		table.insert(itemShows, itemShowPOD)
	end

	if itemShows ~= nil then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShows)
	end
end

function HomeLandLuaModule.UnlockLandResult(landPOD)
	HomeLandLuaModule.UpdatePlantData(Constant.HomelandBuildType.BuildPlant, landPOD)

	if PlayerModule.CurrSceneID == SceneID.Home then
		UIModule.Open(Constant.UIControllerName.HomeLandUnlockLandSpineEffectUI, Constant.UILayer.UI)
	end
end

function HomeLandLuaModule.SaveRoomDecorateResult(roomId)
	HomeLandLuaModule.putDecorateIds = {}

	EventDispatcher.Dispatch(EventID.SaveRoomDecorateResultEvent, roomId)
end

function HomeLandLuaModule.NotifyUnlockCookBook(cookBookId)
	NoticeModule.NotifyClientEffectNotice(Constant.ClientEffectTypeID.CUSTOM_TYPE_UNLOCK_COOK, {
		cookBookId
	})
	CookingModule.UpdateUnlockCookBook(cookBookId)
end

function HomeLandLuaModule.RewardCookResult(building, itemAward, cookBookIds)
	HomeLandLuaModule.UpdateBuilding(building)
	EventDispatcher.Dispatch(EventID.UpdateCookingEvent, building.cid)

	if itemAward ~= nil then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemAward)
	end
end

function HomeLandLuaModule.CancelCookResult(building)
	HomeLandLuaModule.UpdateBuilding(building)
	EventDispatcher.Dispatch(EventID.UpdateCookingEvent, building.cid)
end

function HomeLandLuaModule.CookResult(building)
	HomeLandLuaModule.UpdateBuilding(building)
	EventDispatcher.Dispatch(EventID.UpdateCookingEvent, building.cid)
end

function HomeLandLuaModule.CompleteCookResult(building)
	HomeLandLuaModule.UpdateBuilding(building)
	EventDispatcher.Dispatch(EventID.UpdateCookingEvent, building.cid)
end

function HomeLandLuaModule.GetCookBookRewardsResult(cid, itemShows)
	CookingModule.UpdateUnlockCookBook(cid, true)

	if itemShows ~= nil then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShows)
	end
end

function HomeLandLuaModule.VisitHomeResult(targetPid, home)
	HomeLandLuaModule.EnterHomeResult(home, true, targetPid)
end

function HomeLandLuaModule.EnterHomeResult(home, isVisitHome, targetPid)
	if HomeLandLuaModule.isCreatingCastle then
		return
	end

	HomeLandLuaModule.isCreatingCastle = true
	HomeLandLuaModule.isVisitHome = isVisitHome
	HomeLandLuaModule.targetPid = targetPid

	for i, v in pairs(home.buildings) do
		for j, land in pairs(v.lands) do
			land.buildCid = v.cid
		end
	end

	HomeLandLuaModule.ReloadHome(home)
	FurnitureLotteryModule.Reload(home.activationDecorates)

	if isVisitHome then
		HomeLandVisitMould.ReloadTreasureChest(home.visitTreasureChest)
	end

	GameEntry.LuaEvent:Subscribe(HomelandClickFunctionDecorationEventArgs.EventId, HomeLandLuaModule.OnClickFunDecorationEvent)
	GameEntry.LuaEvent:Subscribe(HomelandHarvestEventArgs.EventId, HomeLandLuaModule.OnHarvestEvent)
	GameEntry.LuaEvent:Subscribe(HomelandDailyActionRecordEventArgs.EventId, HomeLandLuaModule.OnDailyActionRecord)
	GameEntry.LuaEvent:Subscribe(HomelandTriggerDialogEventArgs.EventId, HomeLandLuaModule.OnTriggerDialog)
	GameEntry.LuaEvent:Subscribe(HomelandCastleCreatedEventArgs.EventId, HomeLandLuaModule.OnHomelandCastleCreated)
	HomelandModule.Instance:EnterHomeLand(home, isVisitHome)
end

function HomeLandLuaModule.Shutdown()
	HomeLandLuaModule.isCreate = false
	HomeLandLuaModule.isCreatingCastle = false
	HomeLandLuaModule.putDecorateIds = {}

	GameEntry.LuaEvent:Unsubscribe(HomelandClickFunctionDecorationEventArgs.EventId, HomeLandLuaModule.OnClickFunDecorationEvent)
	GameEntry.LuaEvent:Unsubscribe(HomelandHarvestEventArgs.EventId, HomeLandLuaModule.OnHarvestEvent)
	GameEntry.LuaEvent:Unsubscribe(HomelandDailyActionRecordEventArgs.EventId, HomeLandLuaModule.OnDailyActionRecord)
	GameEntry.LuaEvent:Unsubscribe(HomelandTriggerDialogEventArgs.EventId, HomeLandLuaModule.OnTriggerDialog)
	GameEntry.LuaEvent:Unsubscribe(HomelandCastleCreatedEventArgs.EventId, HomeLandLuaModule.OnHomelandCastleCreated)
	HomeLandVisitMould.Shutdown()
	HomeLandManufactureMould.Shutdown()
	CookingModule.Shutdown()
end

function HomeLandLuaModule.OnHomelandCastleCreated()
	HomeLandLuaModule.isCreatingCastle = false
	HomeLandLuaModule.isCreate = true
end

function HomeLandLuaModule.HarvestBuildingResult(building, itemAwards)
	HomeLandLuaModule.UpdateBuilding(building)

	if itemAwards ~= nil then
		HomeLandLuaModule.OnNoticeGetItem(itemAwards)
	end

	EventDispatcher.Dispatch(EventID.HomeUpdateBuildingEvent, building.cid)
	EventDispatcher.Dispatch(EventID.UpdateHomeLandOverview)
end

function HomeLandLuaModule.HarvestLandResult(buildingCid, land, itemAwards)
	if itemAwards ~= nil then
		HomeLandLuaModule.OnNoticeGetItem(itemAwards)
	end

	for i, v in pairs(land) do
		HomeLandLuaModule.UpdatePlantData(buildingCid, v)
	end

	EventDispatcher.Dispatch(EventID.HomeLandUpdatePlantEvent, buildingCid, land)
end

function HomeLandLuaModule.PlantResult(buildingCid, land)
	HomeLandLuaModule.UpdatePlantData(buildingCid, land)
	EventDispatcher.Dispatch(EventID.HomeLandUpdatePlantEvent, buildingCid, {
		land
	})
end

function HomeLandLuaModule.CompletePlantResult(buildingCid, land)
	HomeLandLuaModule.UpdatePlantData(buildingCid, land)
	EventDispatcher.Dispatch(EventID.HomeLandUpdatePlantEvent, buildingCid, {
		land
	})
end

function HomeLandLuaModule.CancelPlantResult(buildingCid, land)
	HomeLandLuaModule.UpdatePlantData(buildingCid, land)
	EventDispatcher.Dispatch(EventID.HomeLandUpdatePlantEvent, buildingCid, {
		land
	})
end

function HomeLandLuaModule.UpdateBuildingLvResult(code)
	return
end

function HomeLandLuaModule.NotifyUpdateBasicHome(basicHome)
	local lastComfort = 0

	if HomeLandLuaModule.homeLandBaseInfo then
		lastComfort = HomeLandLuaModule.homeLandBaseInfo.currentComfort
	end

	local comfort = basicHome.currentComfort - lastComfort
	local str = ""

	if comfort > 0 then
		str = "+" .. comfort
	else
		str = tostring(comfort)
	end

	if comfort ~= 0 then
		NoticeModule.ShowNoticeByType(1, HomeLandRoomUIApi:GetString("TextTip", str))
	end

	HomeLandLuaModule.homeLandBaseInfo = basicHome

	EventDispatcher.Dispatch(EventID.HomeLandUpdateBaseInfo)
end

function HomeLandLuaModule.NotifyUpdateLand(buildingCid, lands)
	for i, v in pairs(lands) do
		HomeLandLuaModule.UpdatePlantData(buildingCid, v)
	end

	EventDispatcher.Dispatch(EventID.HomeLandUpdatePlantEvent, buildingCid, lands)
end

function HomeLandLuaModule.NotifyUpdateBuilding(building)
	HomeLandLuaModule.UpdateBuilding(building)
	EventDispatcher.Dispatch(EventID.HomeUpdateBuildingEvent, building.cid)

	local cfgBuild = CfgHomeLandBuildingTable[building.cid]

	if cfgBuild.Id == Constant.HomelandBuildType.BuildCooking then
		EventDispatcher.Dispatch(EventID.UpdateCookingEvent, building.cid)
	elseif cfgBuild.Id == Constant.HomelandBuildType.BuildManufacture then
		EventDispatcher.Dispatch(EventID.HomeLandManufactureResultEvent, building.cid)
	elseif cfgBuild.Id == Constant.HomelandBuildType.BuildWork then
		EventDispatcher.Dispatch(EventID.HomeLandUpdateBuildWork, building.cid)
	end
end

function HomeLandLuaModule.NotifyUpdateRoom(room)
	HomeLandLuaModule.UpdateRoom(room)
end

function HomeLandLuaModule.NotifyUnlockManufactureItem(manufactureItemCid)
	HomeLandManufactureMould.UpdateManufactureItem(manufactureItemCid)
	EventDispatcher.Dispatch(EventID.HomeUpdateBuildingEvent)
end

function HomeLandLuaModule.UnlockRoomResult(cid)
	EventDispatcher.Dispatch(EventID.HomelandUnlockRoomEvent, cid)

	if PlayerModule.CurrSceneID == SceneID.Home then
		for i = 1, #HomeLandLuaModule.homeLandRoomDic do
			if HomeLandLuaModule.homeLandRoomDic[i].cid == cid then
				UIModule.Open(Constant.UIControllerName.HomeLandSpineEffectUI, Constant.UILayer.UI, HomeLandLuaModule.homeLandRoomDic[i])

				break
			end
		end
	end
end

function HomeLandLuaModule.ChangeSuitResult(room)
	local roomData = HomeLandLuaModule.GetRoomDataByID(room.cid)

	if roomData ~= nil then
		local index = table.indexOf(HomeLandLuaModule.homeLandRoomDic, roomData)

		HomeLandLuaModule.homeLandRoomDic[index] = room

		HomelandModule.Instance:UpdateRoomPOD(room)
		EventDispatcher.Dispatch(EventID.HomelandChangeThemeEvent, room.cid)
		UIModule.Open(Constant.UIControllerName.HomeLandSpineEffectUI, Constant.UILayer.UI, room)
	end
end

function HomeLandLuaModule.UnlockSuitResult(suitCid)
	if table.indexOf(HomeLandLuaModule.unlockSuit, suitCid) == -1 then
		table.insert(HomeLandLuaModule.unlockSuit, suitCid)
	end

	EventDispatcher.Dispatch(EventID.HomelandUnlockThemeEvent)
end

function HomeLandLuaModule.NotifyUnlockSuit(ids)
	if HomeLandLuaModule.unlockSuit == nil then
		HomeLandLuaModule.unlockSuit = {}
	end

	for i, v in pairs(ids) do
		if table.indexOf(HomeLandLuaModule.unlockSuit, v) == -1 then
			table.insert(HomeLandLuaModule.unlockSuit, v)
		end
	end

	EventDispatcher.Dispatch(EventID.HomelandUnlockThemeEvent)
end

function HomeLandLuaModule.ChangeRoomNameResult(room)
	local roomData = HomeLandLuaModule.GetRoomDataByID(room.cid)

	if roomData ~= nil then
		local index = table.indexOf(HomeLandLuaModule.homeLandRoomDic, roomData)

		HomeLandLuaModule.homeLandRoomDic[index] = room

		EventDispatcher.Dispatch(EventID.HomeLandUpdateRoom, room.cid)
	end
end

function HomeLandLuaModule.EnterRoomResult(room)
	return
end

function HomeLandLuaModule.SwitchRoomShowResult(room)
	local roomData = HomeLandLuaModule.GetRoomDataByID(room.cid)

	if roomData ~= nil then
		local index = table.indexOf(HomeLandLuaModule.homeLandRoomDic, roomData)

		HomeLandLuaModule.homeLandRoomDic[index] = room

		EventDispatcher.Dispatch(EventID.HomeLandUpdateRoom, room.cid)
	end
end

function HomeLandLuaModule.NotifyHomeRole(roles)
	for i, v in pairs(roles) do
		if not HomeLandLuaModule.isVisitHome then
			HomelandModule.Instance:UpdateHomeRole(v)
		end

		for k, v1 in pairs(HomeLandLuaModule.homeLandRoles) do
			if v1.roleCid == v.roleCid then
				HomeLandLuaModule.homeLandRoles[k] = v
			end
		end
	end

	EventDispatcher.Dispatch(EventID.HomeLandUpdateRolesEvent)
end

function HomeLandLuaModule.ReceiveComfortLvAwardsResult(itemAwards)
	if itemAwards ~= nil then
		HomeLandLuaModule.OnNoticeGetItem(itemAwards)
	end
end

function HomeLandLuaModule.ReceiveComfortAwardsResult(roomId, itemAwards)
	local roomData = HomeLandLuaModule.GetRoomDataByID(roomId)

	if roomData ~= nil then
		local index = table.indexOf(HomeLandLuaModule.homeLandRoomDic, roomData)

		roomData.receiveComfortAwards = true
		HomeLandLuaModule.homeLandRoomDic[index] = roomData
	end

	if itemAwards ~= nil then
		HomeLandLuaModule.OnNoticeGetItem(itemAwards)
	end

	EventDispatcher.Dispatch(EventID.HomeLandGetRoomReward, roomId)
end

function HomeLandLuaModule.ReceiveLetterResult(roleCid, letterCid, getItems)
	for k, v in pairs(HomeLandLuaModule.homeLandRoles) do
		if v.roleCid == roleCid then
			local index = table.indexOf(v.letters, letterCid)

			if index ~= -1 then
				table.remove(v.letters, index)
			end
		end
	end

	if getItems ~= nil then
		HomeLandLuaModule.OnNoticeGetItem(getItems)
	end

	EventDispatcher.Dispatch(EventID.GetRebateGiftSuccess, roleCid, letterCid)
	EventDispatcher.Dispatch(EventID.UpdateHomeLandOverview)
end

function HomeLandLuaModule.ExitHomeResult()
	return
end

function HomeLandLuaModule.RecordDailyActionResult()
	return
end
