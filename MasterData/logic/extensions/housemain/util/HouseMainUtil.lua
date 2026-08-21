-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/util/HouseMainUtil.lua

module("logic.extensions.housemain.util.HouseMainUtil", package.seeall)

local HouseMainUtil = {}

function HouseMainUtil.canFocusRoomById(cfgRoomId)
	local openTypDefine = HouseMainEnum.RoomOpenTyp
	local roomOpenTyp = HouseMainRoomModel.instance:getRoomOpenTyp(cfgRoomId)

	if roomOpenTyp == openTypDefine.UnOpen then
		printWarn(string.format("房间[%d]未开放", cfgRoomId))

		return false
	elseif roomOpenTyp == openTypDefine.OpenLock then
		printWarn(string.format("房间[%d]未解锁", cfgRoomId))

		return false
	elseif roomOpenTyp == openTypDefine.OpenActive then
		printWarn(string.format("房间[%d]已激活", cfgRoomId))

		return true
	end

	printWarn(string.format("房间[%d]未激活", cfgRoomId))

	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, cfgRoomId)

	if roomCO == nil then
		printError(string.format("无法找到[%s],zoneId[%d]的配置", ConfigName.HouseZone, cfgRoomId))

		return false
	end

	local canFocus = false
	local roomTyp = HouseEnum.RoomType
	local roomUnlock = HouseMainRoomModel.instance:getRoomUnlock(cfgRoomId)

	if roomCO.roomType == roomTyp.Supervisor then
		canFocus = true
	elseif roomCO.roomType == roomTyp.Trading then
		canFocus = true
	elseif roomCO.roomType == roomTyp.Manufacturing then
		canFocus = true
	elseif roomCO.roomType == roomTyp.Shelter then
		HouseMainUtil.tryActiveZone(cfgRoomId, true)
	elseif roomCO.roomType == roomTyp.Living then
		HouseMainUtil.tryActiveZone(cfgRoomId, true, function()
			ViewMgr.instance:open(ViewName.LivingExchangeFacilityTips)
		end)
	else
		printError(string.format("尚未定义roomTyp[%d]未激活的处理场景"))
	end

	return canFocus
end

function HouseMainUtil.tryActiveZone(cfgRoomId, focus, callBackFunc, callBackHandler)
	ToolTipsMgr.showHouseRoomActiveTips(cfgRoomId, focus, callBackFunc, callBackHandler)
end

function HouseMainUtil.getActiveZoneCostStr(cfgRoomId)
	local str = ""
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, cfgRoomId)

	if roomCO then
		local cost = roomCO.activeCost
		local costTable = {}

		for i, item in ipairs(cost or {}) do
			local co = BackpackConfig.instance:getItemInfoByItemId(item.id)

			table.insert(costTable, string.format("%d个%s", item.num, co.name))
		end

		if #costTable > 0 then
			str = table.concat(costTable, "、")
		end
	else
		printError(string.format("无法找到[%s],zoneId[%d]的配置", ConfigName.HouseZone, cfgRoomId))
	end

	return str
end

function HouseMainUtil.changAtmosphereIcon(img, typ)
	if img then
		local mark = HouseExtension_pb.Atmosphere
		local iconName = ""

		iconName = typ == mark.ECOLOGY and "room_atmosphere_1" or typ == mark.SCIENCE and "room_atmosphere_2" or typ == mark.AMUSEMENT and "room_atmosphere_3" or typ == mark.LIVE and "room_atmosphere_4" or typ == mark.HOUSE_INSPIRATION and "room_atmosphere_5" or typ == mark.NORMAL and "room_atmosphere_6" or "room_atmosphere_4"

		IconLoader.setSprite(img, IconType.DynSpriteAtlas_Room, iconName)
	end
end

function HouseMainUtil.changeAtmosphereRoomIcon(img, roomId)
	if img then
		local rectTr = img.gameObject:GetComponent(UIComponentType.RectTransform)
		local width = RectTransformUtils.GetWidth(rectTr)
		local height = RectTransformUtils.GetHeight(rectTr)
		local fullPath = HouseController.instance:getRoomPicPath(roomId)
		local succeed = SpaceXFileUtil.SetImageSpriteByIO(img, fullPath, width, height)

		return succeed
	end

	return false
end

function HouseMainUtil.getSpAtmosphereLv(atmosTyp, atmosVal)
	local returnLevel = 1
	local cfgLst = HouseMainRoomModel.instance:getSpAtmosLevelCfg(atmosTyp)

	for level, rankNum in ipairs(cfgLst) do
		if rankNum <= atmosVal and returnLevel <= level then
			returnLevel = level
		end
	end

	return returnLevel
end

function HouseMainUtil.getNormalAtmosphereLv()
	local atmospheres = LivingFacilitiesZoneModel.instance:getAtmospheres()
	local val = 0
	local atmosLv = 1

	for key, AtmosphereNO in ipairs(atmospheres or {}) do
		local typ = AtmosphereNO.atmosphereType

		if typ == HouseExtension_pb.Atmosphere.NORMAL then
			val = AtmosphereNO.value

			break
		end
	end

	local cfgAtmos = LivingFacilitiesConfig.instance:getConfigList(ConfigName.HouseAtmosphere)

	for key, value in ipairs(cfgAtmos or {}) do
		if val >= value.rankNum then
			atmosLv = value.level
		else
			break
		end
	end

	return atmosLv
end

function HouseMainUtil.getRoomName(cfgRoomId)
	local roomName
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, cfgRoomId)

	if roomCO then
		roomName = roomCO.defaultName

		local roomTypDefine = HouseEnum.RoomType
		local roomType = roomCO.roomType

		if roomType == roomTypDefine.Shelter then
			roomName = ContainmentModel.instance:getRoomName(cfgRoomId)
		elseif roomType == roomTypDefine.Living then
			local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(cfgRoomId)

			if zoneMo then
				local liveZoneTyp = zoneMo:getType() or 0

				if liveZoneTyp > 0 then
					roomName = zoneMo:getName() or ""

					if string.nilorempty(roomName) then
						local cfgLiveRoomTyp = LivingFacilitiesConfig.instance:getConfigByKey(ConfigName.HouseLiveRoom, liveZoneTyp)

						if cfgLiveRoomTyp then
							roomName = cfgLiveRoomTyp.name
						else
							printError(string.format("room[%s].[%s]无法找到[%s]的配置", cfgRoomId, ConfigName.HouseLiveRoom, liveZoneTyp))
						end
					end
				end
			end
		end
	else
		printError(string.format("[%s]无法找到[%s]的配置", ConfigName.HouseZone, cfgRoomId))
	end

	return roomName
end

function HouseMainUtil.getRoomLv(roomId)
	local lv = 0
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)

	if roomId == HouseEnum.SUPERVISOR_ROOM_ID then
		lv = SupervisorModel.instance:getSupervisorLv()
	elseif roomId == HouseEnum.MANUFACTURE_ROOM_ID then
		lv = ManufactureModel.instance:getLv()
	elseif roomId == HouseEnum.TRADING_ROOM_ID then
		local mo = TradingModel.instance:getTradePostMo()

		lv = mo:getLevel()
	elseif roomCO.roomType == HouseEnum.RoomType.Shelter then
		local mo = ContainmentModel.instance:getProtomerInfo(roomId)

		if mo then
			lv = mo:getModuleUpGradeCount()
		end
	elseif roomCO.roomType == HouseEnum.RoomType.Living then
		local mo = LivingFacilitiesZoneModel.instance:getZoneById(roomId)

		if mo then
			lv = mo:getAtmosphereLevel()
		end
	end

	return lv
end

function HouseMainUtil.canRoomActive(roomId)
	local canActive = false
	local openType = HouseMainRoomModel.instance:getRoomOpenTyp(roomId)

	if openType == HouseMainEnum.RoomOpenTyp.OpenUnActive then
		local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)
		local costEnough = true

		for _, costInfo in ipairs(roomCO.activeCost or {}) do
			local ownCount = ItemModel.instance:getItemCountByItemId(costInfo.id)

			if ownCount < costInfo.num then
				costEnough = false

				break
			end
		end

		canActive = costEnough
	end

	return canActive
end

function HouseMainUtil.canRoomUpgradeLv(roomId)
	local canUpgrade = false
	local roomTypeDefine = HouseEnum.RoomType
	local openType = HouseMainRoomModel.instance:getRoomOpenTyp(roomId)

	if openType == HouseMainEnum.RoomOpenTyp.OpenActive then
		local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)
		local roomType = roomCO.roomType

		if roomType == roomTypeDefine.Supervisor then
			canUpgrade = SupervisorModel.instance:canUpgradeLv()
		elseif roomType == roomTypeDefine.Manufacturing then
			canUpgrade = ManufactureModel.instance:canUpgradeLv()
		elseif roomType == roomTypeDefine.Trading then
			canUpgrade = TradingModel.instance:canUpgradeLv()
		elseif roomType == roomTypeDefine.Shelter then
			canUpgrade = ContainmentModel.instance:getRoomProtomerCanLvUp(roomId)
		end
	end

	return canUpgrade
end

function HouseMainUtil.isRoomNotSetting(roomId)
	local isNotSetting = false
	local roomTypeDefine = HouseEnum.RoomType
	local openType = HouseMainRoomModel.instance:getRoomOpenTyp(roomId)

	if openType == HouseMainEnum.RoomOpenTyp.OpenActive then
		local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)
		local roomType = roomCO.roomType

		if roomType == roomTypeDefine.Shelter then
			local protomerId = ContainmentModel.instance:getProtomerId(roomId)

			isNotSetting = protomerId <= 0
		elseif roomType == roomTypeDefine.Living then
			local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(roomId)

			isNotSetting = zoneMo:getType() <= 0
		end
	end

	return isNotSetting
end

function HouseMainUtil.getRoomUnlockLv(roomId)
	local function _getRoomType(id)
		local cfg = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, id)

		return cfg.roomType, cfg.size
	end

	local targetRoomType, targetRoomSize = _getRoomType(roomId)
	local unlockOrder = SupervisorConfig.instance:getZoneUnlockOrder()
	local unlockIdx = 0

	for _, unlockId in ipairs(unlockOrder) do
		local roomType, roomSize = _getRoomType(unlockId)

		if roomType == targetRoomType and roomSize == targetRoomSize then
			unlockIdx = unlockIdx + 1
		end

		if unlockId == roomId then
			break
		end
	end

	local cfgList = SupervisorConfig.instance:getConfigList(ConfigName.HouseManager)

	for _, cfg in ipairs(cfgList) do
		local unlockCount = cfg.holdRoomCount

		if targetRoomType == HouseEnum.RoomType.Living then
			unlockCount = cfg.bigZoneCount

			if targetRoomSize == HouseEnum.RoomSize.Small then
				unlockCount = cfg.smallZoneCount
			end
		end

		if unlockIdx <= unlockCount then
			return cfg.level
		end
	end

	return 0
end

return HouseMainUtil
