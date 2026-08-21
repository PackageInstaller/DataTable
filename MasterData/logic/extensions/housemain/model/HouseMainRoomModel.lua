-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/model/HouseMainRoomModel.lua

module("logic.extensions.housemain.model.HouseMainRoomModel", package.seeall)

local M = class("HouseMainRoomModel", BaseModel)

function M:ctor()
	M.super.ctor(self)

	self._unlockZones = {}
	self._backLogNum = {}
	self._harvestNum = {}
end

function M:onInit()
	self._foucsRoomId = nil

	local cfgZoneLst = HouseConfig.instance:getConfigList(ConfigName.HouseZone)

	self._roomIds = {}
	self._roomAngles = {}

	for _, zoneCo in pairs(cfgZoneLst or {}) do
		local roomId = zoneCo.id

		if roomId < 2000 then
			local roomType = zoneCo.roomType

			if not self._roomIds[roomType] then
				self._roomIds[roomType] = {}
			end

			table.insert(self._roomIds[roomType], roomId)
		end

		local ring = math.floor((roomId - 1000) / 100)

		if not self._roomAngles[ring] then
			self._roomAngles[ring] = {}
		end

		self._roomAngles[ring][roomId] = zoneCo.angle
	end

	local cfgWorkerLst = HouseConfig.instance:getConfigList(ConfigName.HouseWorker)

	self._roomWorkerNum = {}
	self._roomJopCodeLst = {}

	for _, workerCo in pairs(cfgWorkerLst or {}) do
		local zoneId = workerCo.zoneId
		local jobCode = workerCo.jobCode

		if not self._roomWorkerNum[zoneId] then
			self._roomWorkerNum[zoneId] = 0
		end

		self._roomWorkerNum[zoneId] = self._roomWorkerNum[zoneId] + 1

		if not self._roomJopCodeLst[zoneId] then
			self._roomJopCodeLst[zoneId] = {}
		end

		table.insert(self._roomJopCodeLst[zoneId], jobCode)
	end

	for keyStr, valInt in pairs(HouseMainEnum.HarvestTyp) do
		self._harvestNum[valInt] = 0
	end

	self._harvestNum[HouseMainEnum.HarvestTyp.HoldReport] = ContainmentModel.instance:getHasReportRoomCount()

	for keyStr, valInt in pairs(HouseMainEnum.BackLogTyp) do
		self._backLogNum[valInt] = 0
	end

	self._backLogNum[HouseMainEnum.BackLogTyp.failReportNum] = ContainmentReportModel.instance:getAllUnReadFailReportCount()
	self._isInit = true
	self._cfgSpAtmos = {}

	local cfgLst = LivingFacilitiesConfig.instance:getConfigList(ConfigName.HouseAtmosLevel)

	for i, v in ipairs(cfgLst or {}) do
		if not self._cfgSpAtmos[v.type] then
			self._cfgSpAtmos[v.type] = {}
		end

		self._cfgSpAtmos[v.type][v.level] = v.rankNum
	end
end

function M:onLiveUnlockZonesRefresh(unlockZones)
	if unlockZones and #unlockZones > 0 then
		for i, zoneId in ipairs(unlockZones) do
			self._unlockZones[zoneId] = 1
		end
	end
end

function M:getRoomUnlock(roomId)
	return self._unlockZones[roomId] ~= nil
end

function M:onReset()
	self._isInit = nil
	self._foucsRoomId = nil
	self._unlockZones = {}
end

function M:_checkInit()
	if self._isInit == nil then
		self:onInit()

		return false
	end

	return true
end

function M:getFocusRoomId()
	return self._foucsRoomId
end

function M:setFocusRoomId(cfgRoomId)
	self._foucsRoomId = cfgRoomId
end

function M:setBackLogNum(typ, num)
	if typ == HouseMainEnum.BackLogTyp.tradePriceChange and self:getIgnoreTradePriceChange() then
		num = 0
	end

	self._backLogNum[typ] = num

	GlobalDispatcher:dispatchEvent(EventType.HOUSE_BACKLOG_NUM_CHANGE)
end

function M:getBackLogTypNum(typ)
	self:_checkInit()

	local num = self._backLogNum[typ] or 0

	if typ == HouseMainEnum.BackLogTyp.tradePriceChange and self:getIgnoreTradePriceChange() then
		num = 0
	end

	return num
end

function M:setTradeGoodsRefreshTime(time)
	if not self._tradeLastRefreshTime then
		self._tradeLastRefreshTime = 0
	end

	if self._tradeLastRefreshTime > 0 and self._tradeLastRefreshTime ~= time then
		self:setBackLogNum(HouseMainEnum.BackLogTyp.tradePriceChange, 1)
	end

	self._tradeLastRefreshTime = time
end

function M:setIgnoreTradePriceChange(ignore)
	self._ignorePriceChange = ignore

	GlobalDispatcher:dispatchEvent(EventType.HOUSE_BACKLOG_NUM_CHANGE)
end

function M:getIgnoreTradePriceChange()
	return self._ignorePriceChange
end

function M:setHarvestNum(typ, num)
	self._harvestNum[typ] = num

	GlobalDispatcher:dispatchEvent(EventType.HOUSE_HARVEST_REPORT_NUM_CHANGE)
end

function M:getHarvestNum(typ)
	self:_checkInit()

	local num = self._harvestNum[typ] or 0

	return num
end

function M:getSpAtmosLevelCfg(atmosTyp)
	self:_checkInit()

	if not self._cfgSpAtmos[atmosTyp] then
		printError(string.format("house_atmosphere_level中无法找到[%d]的配置", atmosTyp))
	end

	return self._cfgSpAtmos[atmosTyp] or {}
end

function M:getRoomAngleLst(ringTyp)
	self:_checkInit()

	return self._roomAngles[ringTyp] or {}
end

function M:getBackLogNum()
	self:_checkInit()

	local num = 0

	for keyStr, valInt in pairs(HouseMainEnum.BackLogTyp) do
		num = num + self:getBackLogTypNum(valInt)
	end

	return num
end

function M:getCanGainReportNum()
	self:_checkInit()

	local num = 0

	for keyStr, valInt in pairs(HouseMainEnum.HarvestTyp) do
		num = num + self:getHarvestNum(valInt)
	end

	return num
end

function M:getRoomCount(roomTyp)
	self:_checkInit()

	return self._roomIds[roomTyp] and #self._roomIds[roomTyp] or 0
end

function M:getRoomIdsLst(roomTyp)
	self:_checkInit()

	return self._roomIds[roomTyp] or {}
end

function M:getRoomWorkerJobCount(roomId)
	self:_checkInit()

	return self._roomWorkerNum[roomId] or 0
end

function M:getRoomJobCodeLst(roomId)
	self:_checkInit()

	return self._roomJopCodeLst[roomId] or {}
end

function M:getRoomCurWorkingHeroNum(roomId)
	local num = 0

	self:_checkInit()

	local jobCodeLst = self:getRoomJobCodeLst(roomId)

	for _, jobCode in ipairs(jobCodeLst) do
		local heroId = HouseWorkerModel.instance:getCurrWorkingHero(jobCode)

		if heroId then
			num = num + 1
		end
	end

	return num
end

function M:getRoomOpenTyp(cfgRoomId)
	local roomTypDefine = HouseEnum.RoomType
	local openTypDefine = HouseMainEnum.RoomOpenTyp
	local openState = openTypDefine.UnOpen
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, cfgRoomId)
	local roomType = 0

	if roomCO then
		roomType = roomCO.roomType
	else
		printError(string.format("无法找到房间[%s]的house_zone配置", cfgRoomId))

		return HouseMainEnum.RoomOpenTyp.UnOpen
	end

	if roomType == roomTypDefine.Supervisor then
		openState = openTypDefine.OpenActive
	elseif roomType == roomTypDefine.Trading then
		openState = openTypDefine.OpenActive
	elseif roomType == roomTypDefine.Manufacturing then
		openState = openTypDefine.OpenActive
	elseif roomType == roomTypDefine.Shelter then
		local roomUnlock = self:getRoomUnlock(cfgRoomId)
		local roomActive = ContainmentModel.instance:getRoomInfoExist(cfgRoomId)

		if roomActive then
			openState = openTypDefine.OpenActive
		else
			openState = roomUnlock and openTypDefine.OpenUnActive or openTypDefine.OpenLock
		end
	elseif roomType == roomTypDefine.Living then
		local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(cfgRoomId)

		if zoneMo then
			local isUnLock = zoneMo:getIsUnlock()
			local isActive = zoneMo:getIsActive()

			if isUnLock then
				openState = isActive and openTypDefine.OpenActive or openTypDefine.OpenUnActive
			else
				openState = openTypDefine.OpenLock
			end
		else
			local unlockLv = HouseConfig.instance:getRoomUnlockLv(cfgRoomId)

			if unlockLv > 0 then
				openState = openTypDefine.OpenLock
			end
		end
	end

	return openState
end

function M:getRoomLvHint(roomId, roomType, roomOpenState)
	local hint

	if roomOpenState ~= HouseMainEnum.RoomOpenTyp.UnOpen then
		local lv = HouseMainUtil.getRoomLv(roomId)

		if checknumber(lv) > 0 then
			hint = string.format("Lv.<size=20>%s</size>", lv)
		end
	end

	return hint
end

function M:getRoomRoleNumHint(roomId)
	local roleNum = self:getRoomRoleNum(roomId)
	local roleMaxNum = self:getRoomRoleMaxNum(roomId)

	if roleMaxNum <= 0 then
		return ""
	end

	if roleNum <= 0 then
		return string.format("<color=#fc7171>%s</color>/%s", roleNum, roleMaxNum)
	else
		return string.format("%s/%s", roleNum, roleMaxNum)
	end
end

function M:getRoomRoleNum(roomId)
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)
	local roomType = 0

	if roomCO then
		roomType = roomCO.roomType
	else
		printError(string.format("无法找到房间[%s]的house_zone配置", roomId))

		return 0
	end

	local roleNum = 0

	if self:getRoomOpenTyp(roomId) == HouseMainEnum.RoomOpenTyp.OpenActive then
		roleNum = self:getRoomCurWorkingHeroNum(roomId)

		local roomTypDefine = HouseEnum.RoomType

		if roomType == roomTypDefine.Supervisor then
			-- block empty
		elseif roomType == roomTypDefine.Trading then
			-- block empty
		elseif roomType == roomTypDefine.Manufacturing then
			-- block empty
		elseif roomType == roomTypDefine.Shelter then
			roleNum = ContainmentModel.instance:getRoomHeroCount(roomId)
		elseif roomType == roomTypDefine.Living then
			local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(roomId)

			if zoneMo then
				roleNum = zoneMo:getInRoomHeroCount()
			end
		end
	end

	return roleNum
end

function M:getRoomRoleMaxNum(roomId)
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)
	local roomType = 0

	if roomCO then
		roomType = roomCO.roomType
	else
		printError(string.format("无法找到房间[%s]的house_zone配置", roomId))

		return 0
	end

	local roleMaxNum = 0

	if self:getRoomOpenTyp(roomId) == HouseMainEnum.RoomOpenTyp.OpenActive then
		roleMaxNum = self:getRoomWorkerJobCount(roomId)

		local roomTypDefine = HouseEnum.RoomType

		if roomType == roomTypDefine.Supervisor then
			-- block empty
		elseif roomType == roomTypDefine.Trading then
			-- block empty
		elseif roomType == roomTypDefine.Manufacturing then
			-- block empty
		elseif roomType == roomTypDefine.Shelter then
			-- block empty
		elseif roomType == roomTypDefine.Living then
			local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(roomId)

			if zoneMo then
				local zoneTyp = zoneMo:getType() or 0
				local cfg = LivingFacilitiesConfig.instance:getConfigByKey(ConfigName.HouseLiveRoom, zoneTyp)

				if cfg then
					roleMaxNum = cfg.heroCount
				else
					printError(string.format("无法找到[%s] typ[%d]的配置", ConfigName.HouseLiveRoom, zoneTyp))
				end
			end
		end
	end

	return roleMaxNum
end

function M:setJumpInfo(jumpInfo, info)
	if jumpInfo then
		self._houseJumpInfo = {
			jumpInfo = jumpInfo,
			otherParams = info
		}
	else
		self._houseJumpInfo = nil
	end
end

function M:getJumpInfo()
	return self._houseJumpInfo
end

M.instance = M.New()

return M
