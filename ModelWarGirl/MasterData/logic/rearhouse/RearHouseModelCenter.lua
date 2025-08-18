-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\RearHouse\\RearHouseModelCenter.lua

local ResRearHouseSceneConfig = require("ClientData/ResRearHouseSceneConfig")
local ResHero = require("ClientData/ResHero")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResRearHouse = require("ClientData/ResRearHouse")
local ResItem = require("ClientData/ResItem")
local ResRearHouseLayer = require("ClientData/ResRearHouseLayer")
local ResRearHouseLevelConfig = require("ClientData/ResRearHouseLevelConfig")
local ResRearHouseInitWallConfig = require("ClientData/ResRearHouseInitWallConfig")
local ResColor = require("ClientData/ResColor")
local RearHouseModelCenter = {}
local self = RearHouseModelCenter
local DEFAULT_ZONE_NAME = "Wall1"
local COLOR = {
	LOW_LEVEL = utils.getUnityColor(ResColor.LVGONGMING),
	NORMAL = utils.getUnityColor(ResColor.WHITE),
	SENCOND_PHASE = utils.getUnityColor(ResColor.LVGONGM2)
}

function RearHouseModelCenter.init(dragCenter)
	self.dragCenter = dragCenter
	self.occupyInfoMap = {}

	self.initModelData()
end

function RearHouseModelCenter.initModelData(...)
	if self.allModelData == nil then
		self.createAllModelData()
	end
end

function RearHouseModelCenter.createAllModelData(...)
	self.rearHouseData = {}

	for mid, data in pairs(ResRearHouse) do
		self.rearHouseData[data.type_id] = self.rearHouseData[data.type_id] or {}
		self.rearHouseData[data.type_id][data.model_id] = data
	end

	self.allModelData = {}

	for mid, data in pairs(ResRearHouse) do
		local info = self.createData(data.type_id, data.model_id)

		self.allModelData[data.model_id] = info
	end

	if not IS_EDITOR then
		return
	end

	for mid, info in pairs(ResHero) do
		if ClientUtils.isTimeConfigPassed(info.valid_time_id) then
			local modelId = info.model

			if self.allModelData[modelId] == nil then
				-- block empty
			end

			local skinData = ResItemHeroSkin[mid]

			if skinData then
				for _, data in ipairs(skinData) do
					modelId = data.model_id

					if self.allModelData[modelId] == nil then
						-- block empty
					end
				end
			end
		end
	end
end

function RearHouseModelCenter.createData(typeId, modelId)
	local data = {}

	data.count = 0
	data.totalCount = 0

	local modelData = {}
	local resData = self.rearHouseData[typeId]

	data.typeId = typeId
	data.modelId = modelId
	modelData.baseInfo = resData[modelId] or resData[11101]
	modelData.name = modelData.baseInfo.model_name

	if ResItem[modelId] and ResItem[modelId].name then
		modelData.name = ResItem[modelId].name
	end

	modelData.typeInfo = ResRearHouseLayer[typeId]
	data.modelData = modelData

	self.parseInfo(modelData)

	return data
end

function RearHouseModelCenter.parseHelp(list, data)
	if data and data ~= "" then
		for _, d in ipairs(data) do
			if d ~= "" then
				local t = utils.splitString(d, ",")
				local r = Vector2(tonumber(t[1]), tonumber(t[2]))

				table.insert(list, r)
			end
		end
	end
end

function RearHouseModelCenter.parseInfo(modelData)
	local rangeData = {}
	local posData = {}

	modelData.configPosOffset = Vector2.zero

	local _posOffset = modelData.baseInfo.pos_offset

	if _posOffset then
		modelData.configPosOffset = Vector2(_posOffset[1] or 0, _posOffset[2] or 0)
	end

	local range = modelData.baseInfo.range_info
	local _data = utils.splitString(range, "|")
	local data = utils.splitString(_data[1], ";")

	self.parseHelp(rangeData, data)

	local avalibleNum = #rangeData

	if _data[2] ~= nil then
		data = utils.splitString(_data[2], ";")

		self.parseHelp(rangeData, data)
	end

	local pos = modelData.baseInfo.pos_info
	local data = utils.splitString(pos, ";")

	self.parseHelp(posData, data)

	modelData.rangeData = rangeData
	modelData.posData = posData
	modelData.avalibleNum = avalibleNum

	local boundsInfo = {}

	boundsInfo.left = 0
	boundsInfo.right = 0
	boundsInfo.down = 0

	if #rangeData == #posData then
		if true or modelData.baseInfo.type_id == 8 then
			for i, range in ipairs(rangeData) do
				boundsInfo.right = math.max(boundsInfo.right, posData[i].x + range.x)
				boundsInfo.down = math.max(boundsInfo.down, posData[i].y + range.y)
			end
		else
			boundsInfo.right = rangeData[1].x
			boundsInfo.down = rangeData[1].y
		end

		modelData.boundsInfo = boundsInfo
	end
end

function RearHouseModelCenter.getData(modelId, initData, gid)
	local typeId

	if gid then
		typeId = Const.REARHOUSE_TYPE_HERO
	else
		typeId = self.getTypeId(modelId)
	end

	return {
		typeId = typeId,
		modelId = modelId,
		initData = initData,
		gid = gid
	}
end

function RearHouseModelCenter.getTypeId(modelId)
	for mid, data in pairs(ResRearHouse) do
		if mid == modelId then
			return data.type_id
		end
	end

	if self.allModelData[modelId] then
		return self.allModelData[modelId].typeId
	end

	return 99
end

function RearHouseModelCenter._getModelInfo(typeId, modelId)
	local data = self.allModelData[modelId]

	if data == nil then
		data = self.createData(typeId, modelId)
		self.allModelData[modelId] = data

		if typeId == Const.REARHOUSE_TYPE_HERO then
			-- block empty
		end
	end

	return utils.copyTable(data)
end

function RearHouseModelCenter.getModelData(...)
	return self.modelData
end

function RearHouseModelCenter.getPutedMap(exceptWallName)
	local map = {}
	local data = self.getCurShowData()

	exceptWallName = exceptWallName or self.dragCenter.getCurWallName()

	for i, info in ipairs(data.part_data.part) do
		if self.dragCenter.getZoneName(info.pos.area) ~= exceptWallName then
			if not map[info.id] then
				map[info.id] = {
					num = 1,
					[info.pos.area] = 1
				}
			elseif not map[info.id][info.pos.area] then
				map[info.id][info.pos.area] = 1
				map[info.id].num = map[info.id].num + 1
			else
				map[info.id][info.pos.area] = map[info.id][info.pos.area] + 1
				map[info.id].num = map[info.id].num + 1
			end
		end
	end

	for i, info in ipairs(data.hero_data.hero) do
		if self.dragCenter.getZoneName(info.pos.area) ~= exceptWallName then
			if not map[info.gid] then
				map[info.gid] = {
					num = 1,
					[info.pos.area] = 1
				}
			elseif not map[info.gid][info.pos.area] then
				map[info.gid][info.pos.area] = 1
				map[info.gid].num = map[info.gid].num + 1
			else
				map[info.gid][info.pos.area] = map[info.gid][info.pos.area] + 1
				map[info.gid].num = map[info.gid].num + 1
			end
		end
	end

	return map
end

function RearHouseModelCenter.refreshModelDataCountInfo(...)
	if self.checkMode == Const.REARHOUSE_CREATE_MODE.VISIT then
		return
	end

	local map = self.getPutedMap()

	for typeId, datas in pairs(self.getModelData()) do
		for i, data in ipairs(datas) do
			if typeId == Const.REARHOUSE_TYPE_HERO then
				data.count = data.totalCount - (map[data.hero.gid] and map[data.hero.gid].num or 0)
			else
				data.count = data.totalCount - (map[data.modelId] and map[data.modelId].num or 0)
			end
		end
	end
end

function RearHouseModelCenter.getPutedNum(typeId, wallIndex)
	wallIndex = wallIndex or self.dragCenter.getCurZoneId()

	local data = self.getCurShowData()
	local num = 0

	if typeId == Const.REARHOUSE_TYPE_HERO then
		for i, heroInfo in ipairs(data.hero_data.hero) do
			if heroInfo.pos.area == wallIndex then
				num = num + 1
			end
		end
	else
		for i, partInfo in ipairs(data.part_data.part) do
			local info = ResRearHouse[partInfo.id]

			if partInfo.pos.area == wallIndex and info and info.type_id == typeId then
				num = num + 1
			end
		end
	end

	return num
end

function RearHouseModelCenter.createModelData(...)
	self.modelData = {}

	for typeId, info in pairs(ResRearHouseLayer) do
		self.modelData[typeId] = {}
	end

	if self.checkMode == Const.REARHOUSE_CREATE_MODE.MINE then
		local itemDic = {}
		local ownItems = CurAvatar:getItemsByStype(Const.ITEM_DICT_REAR_HOUSE)

		for i, item in ipairs(ownItems) do
			itemDic[item.id] = item.num
		end

		for typeId, info in ipairs(ResRearHouseLayer) do
			local resData = self.rearHouseData[typeId] or {}

			if typeId == Const.REARHOUSE_TYPE_HERO then
				for gid, hero in pairs(CurAvatar.heroDic) do
					local showModelId = hero:getShowModelId()
					local data = self._getMyOwnModelInfo(typeId, showModelId)

					if data.hero ~= nil then
						data = utils.copyTable(data)
					end

					data.count = 1
					data.totalCount = 1
					data.modelData.name = hero.name
					data.heroIconPath = hero:getIconPath()
					data.hero = hero

					table.insert(self.modelData[typeId], data)
				end
			else
				for modelId, num in pairs(itemDic) do
					if self.rearHouseData[typeId] and self.rearHouseData[typeId][modelId] then
						local data = self._getMyOwnModelInfo(typeId, modelId)

						data.count = num or 0
						data.totalCount = data.count

						table.insert(self.modelData[typeId], data)
					end
				end
			end
		end
	elseif self.checkMode == Const.REARHOUSE_CREATE_MODE.VISIT then
		local houseData = self.getCurShowData()

		for typeId, info in ipairs(ResRearHouseLayer) do
			local resData = self.rearHouseData[typeId] or {}

			if typeId == Const.REARHOUSE_TYPE_HERO then
				for _, hero in ipairs(houseData.hero_data.hero) do
					local showModelId, baseId = self._getModelIdAndBaseId(hero)
					local data = self._getMyOwnModelInfo(typeId, showModelId)

					if data.hero ~= nil then
						data = utils.copyTable(data)
					end

					data.count = math.huge
					data.totalCount = math.huge
					data.baseId = baseId

					table.insert(self.modelData[typeId], data)
				end
			else
				local repeatMap = {}

				for _, part in ipairs(houseData.part_data.part) do
					local modelId = part.id

					if self.rearHouseData[typeId] and self.rearHouseData[typeId][modelId] then
						local data = self._getMyOwnModelInfo(typeId, modelId)

						data.count = math.huge
						data.totalCount = data.count

						if repeatMap[modelId] == nil then
							table.insert(self.modelData[typeId], data)

							repeatMap[modelId] = true
						end
					end
				end
			end
		end
	end

	self._sortModelData()
end

function RearHouseModelCenter._getModelIdAndBaseId(houseHero)
	if ResHero[houseHero.id] then
		local _hero = BaseObject.GetObject(houseHero.id)

		_hero:setSkin(houseHero.skin)
		_hero:setBase(houseHero.base)

		return _hero:getShowModelId(), _hero:getShowBaseModelId()
	else
		return houseHero.id
	end
end

function RearHouseModelCenter._sortModelData(...)
	if self.modelData then
		for typeId, data in pairs(self.modelData) do
			if typeId ~= Const.REARHOUSE_TYPE_HERO then
				table.sort(data, self._sortFunc)
			end
		end
	end
end

function RearHouseModelCenter._sortFunc(v1, v2)
	local item1, item2 = ResItem[v1.modelId], ResItem[v2.modelId]

	if item1.quality == item2.quality then
		return v1.modelId < v2.modelId
	else
		return item1.quality > item2.quality
	end
end

function RearHouseModelCenter._getMyOwnModelInfo(typeId, modelId)
	if self.modelData == nil then
		return self._getModelInfo(typeId, modelId)
	end

	local data = self.modelData[typeId]

	if data then
		for i, info in ipairs(data) do
			if info.modelId == modelId then
				return info
			end
		end
	end

	return self._getModelInfo(typeId, modelId)
end

function RearHouseModelCenter.getOccupyInfo(modelId, isTurn)
	local info = self.occupyInfoMap[modelId]
	local typeId = self.allModelData[modelId].typeId

	if info == nil then
		info = self._getOccupyInfo(typeId, modelId)
		self.occupyInfoMap[modelId] = info
	end

	if info then
		if typeId == Const.REARHOUSE_TYPE_SHELF then
			if isTurn == true then
				return info.turnInfo
			else
				return info.normalInfo
			end
		else
			return info.normalInfo
		end
	end
end

function RearHouseModelCenter._getOccupyInfo(typeId, modelId)
	local data = self.allModelData[modelId].modelData
	local posData = data.posData or {}
	local rangeData = data.rangeData or {}
	local boundsInfo = data.boundsInfo or {}
	local info = {}

	info.normalInfo = {}
	info.turnInfo = {}

	for idx, pos in ipairs(posData) do
		local range = rangeData[idx]

		for i = 1, range.y do
			for j = 1, range.x do
				table.insert(info.turnInfo, {
					rowOffset = pos.y + i - 1,
					colOffset = boundsInfo.right - pos.x - range.x + j - 1
				})
				table.insert(info.normalInfo, {
					rowOffset = pos.y + i - 1,
					colOffset = pos.x + j - 1
				})
			end
		end
	end

	return info
end

function RearHouseModelCenter.dataReady(houseData, checkMode, withoutCheck)
	self.houseData = houseData

	if self.houseData.level == 0 then
		self.houseData.level = 1
	end

	self.checkMode = checkMode or Const.REARHOUSE_CREATE_MODE.VISIT

	self.createModelData()
end

function RearHouseModelCenter.getCurShowData(...)
	if self.checkMode == Const.REARHOUSE_CREATE_MODE.MINE then
		return CurAvatar.rearHouseData
	end

	return self.houseData
end

function RearHouseModelCenter.refreshOpArea(...)
	local houseData = self.getCurShowData()

	self.dragCenter.refreshOpArea(houseData.level)
end

function RearHouseModelCenter.changeWall(withoutCheck)
	self.delAllObj(true, true)
	self:refreshModelDataCountInfo()
	self.resetLoad(Functor(self.initCreate, withoutCheck))
end

function RearHouseModelCenter.initCreate(withoutCheck)
	if withoutCheck or not Const.REARHOUSE_LOAD_CONFIG.LOADEND.PART then
		self._createPart()
		self.createInitWallObjs()
	end

	if withoutCheck or not Const.REARHOUSE_LOAD_CONFIG.LOADEND.HERO then
		self._createHero()
		self.createStageHeros()
	end
end

function RearHouseModelCenter.createWhenLoadend(...)
	local function func(...)
		if Const.REARHOUSE_LOAD_CONFIG.LOADEND.PART then
			self._createPart()
			self.createInitWallObjs()
		end

		if Const.REARHOUSE_LOAD_CONFIG.LOADEND.HERO then
			self._createHero()
			self.createStageHeros()
		end
	end

	self.resetLoad(func)
end

function RearHouseModelCenter._createPart(...)
	local houseData = self.getCurShowData()

	if houseData.part_data then
		local tempData = {}

		for _, part in ipairs(houseData.part_data.part) do
			local wallName = self.dragCenter.getZoneName(part.pos.area)

			if wallName == self.dragCenter.getCurWallName() then
				local initData = {}

				initData.angle = part.pos.angle
				initData.zone = wallName
				initData.pos = part.pos.pos
				initData.checkInit = true

				table.insert(tempData, self.getData(part.id, initData))
			end
		end

		self.checkObj(tempData)
	end
end

function RearHouseModelCenter._createHero()
	local houseData = self.getCurShowData()

	if houseData.hero_data then
		local tempData = {}

		for _, hero in ipairs(houseData.hero_data.hero) do
			local wallName = self.dragCenter.getZoneName(hero.pos.area)

			if wallName == self.dragCenter.getCurWallName() then
				local initData = {}

				initData.angle = hero.pos.angle
				initData.zone = wallName
				initData.pos = hero.pos.pos
				initData.checkInit = true

				local modelId = self._getModelIdAndBaseId(hero)

				if self.checkMode == Const.REARHOUSE_CREATE_MODE.MINE then
					local heroData = CurAvatar.heroDic[hero.gid]

					if heroData then
						modelId = heroData:getShowModelId()
					end
				end

				table.insert(tempData, self.getData(modelId, initData, hero.gid))
			end
		end

		self.checkObj(tempData)
	end
end

function RearHouseModelCenter.createStageHeros()
	self.levelData = {}

	if self.checkMode == Const.REARHOUSE_CREATE_MODE.VISIT then
		self.dragCenter.getCurZone():hideStageRoot()

		return
	end

	if CurAvatar:isCrystalOpened() == false then
		return
	end

	if self.dragCenter.getCurWallName() ~= DEFAULT_ZONE_NAME then
		return
	end

	local heros = {}
	local heroData = CurAvatar.crystalData.slot
	local rearHouseHero = CurAvatar.rearHouseData.hero_data
	local isNeedSpecailSave = false
	local data = CurAvatar.crystalData.priests

	for i = 1, math.min(5, #data) do
		table.insert(heros, CurAvatar.heroDic[data[i].hero])
	end

	local tempData = {}

	table.sort(heros, function(v1, v2)
		if v1.level == v2.level then
			if v1.star == v2.star then
				if v1.step == v2.step then
					return v1.id > v2.id
				else
					return v1.step > v2.step
				end
			else
				return v1.star > v2.star
			end
		else
			return v1.level > v2.level
		end
	end)

	local color
	local lowLevel = 99999

	for i, hero in ipairs(heros) do
		local initData = {
			isStage = true,
			angle = 0,
			checkInit = true,
			pos = 0,
			zone = DEFAULT_ZONE_NAME
		}
		local modelId = hero:getShowModelId()
		local data = self.getData(modelId, initData, hero.gid)

		table.insert(tempData, data)

		if lowLevel > hero.level then
			lowLevel = hero.level
		end
	end

	for i, hero in ipairs(heros) do
		if CurAvatar:isCrystalSecondPartNew() then
			color = COLOR.SENCOND_PHASE
		elseif hero.level == lowLevel then
			color = COLOR.LOW_LEVEL
		else
			color = COLOR.NORMAL
		end

		table.insert(self.levelData, {
			level = hero.level,
			color = color
		})
	end

	CurAvatar:onRefreshCrystalLevel()

	local datas = self.checkObj(tempData)

	if isNeedSpecailSave then
		for i, data in ipairs(datas) do
			local area = self.getZoneId(data.initData.zone)
			local hero = data.putData.hero
			local id = hero.id
			local data = self.dragCenter.zones[self.dragCenter.getCurWallName()]:wrapSaveData(data.initData.pos, data.initData.angle, area, id, hero)

			table.insert(CurAvatar.rearHouseData.hero_data.hero, data)
		end
	end
end

function RearHouseModelCenter.checkObj(tempData)
	local tempObjs = {}
	local checkNumMap = {}

	for index, _data in ipairs(tempData) do
		local typeId = _data.typeId
		local modelId = _data.modelId
		local initData = _data.initData
		local gid = _data.gid

		for i, data in ipairs(self.modelData[typeId] or {}) do
			if data.modelId == modelId then
				if checkNumMap[modelId] == nil then
					checkNumMap[modelId] = data.count
				end

				if checkNumMap[modelId] > 0 or gid then
					local putData = {}

					if gid then
						putData.data = data

						if data.hero then
							if data.hero.gid == gid then
								putData.hero = data.hero

								if initData.isStage then
									initData.pos = self.dragCenter.getCurZone():getStagePos(index, data.modelData.rangeData[1])
								end

								table.insert(tempObjs, {
									putData = putData,
									initData = initData
								})
							end
						else
							table.insert(tempObjs, {
								putData = putData,
								initData = initData
							})
						end
					else
						putData.data = data

						table.insert(tempObjs, {
							putData = putData,
							initData = initData
						})

						checkNumMap[modelId] = checkNumMap[modelId] - 1
					end
				end
			end
		end
	end

	self.addObjFinal(tempObjs)

	return tempObjs
end

function RearHouseModelCenter.startCreatePreview(presetId)
	self.checkMode = Const.REARHOUSE_CREATE_MODE.PREVIEW

	self.delAllObj(true)
	self.resetLoad(Functor(self._createPreview, presetId))
end

function RearHouseModelCenter._createPreview(presetId)
	local groupId = presetId or ResRearHouseMiscConfig[1].init_group_id

	if not groupId or groupId <= 0 then
		return
	end

	local configData = ResRearHouseSceneConfig[groupId]

	if not configData then
		return
	end

	local tempData = {}

	for i, data in pairs(configData) do
		local initData = {}

		initData.angle = data.angle
		initData.zone = data.zone_name
		initData.pos = data.pos_index
		initData.checkInit = true
		initData.isPreView = true

		table.insert(tempData, self.getData(data.model_id, initData))
	end

	self.addObjForPreview(tempData)
end

function RearHouseModelCenter.createInitWallObjs(...)
	local houseData = self.getCurShowData()
	local level = houseData.level

	if level == 0 then
		level = 1
	end

	local unlockIndex = self.dragCenter.getCurUnlockWall(self.dragCenter.getCurZoneId())
	local tempData = {}

	for i, data in ipairs(ResRearHouseInitWallConfig) do
		if unlockIndex < data.lock_id then
			local initData = {}

			initData.angle = 0
			initData.zone = self.dragCenter.getCurWallName()
			initData.pos = data.index
			initData.lock_id = data.lock_id
			initData.wall_offset = data.wall_offset
			initData.checkInit = true
			initData.initWall = true

			table.insert(tempData, self.getData(data.model_id, initData))
		end
	end

	self.addObjForPreview(tempData)
end

function RearHouseModelCenter.addObjForPreview(tempData)
	local tempObjs = {}

	for _, _data in ipairs(tempData) do
		local initData = _data.initData
		local putData = {}
		local data = self._getModelInfo(_data.typeId, _data.modelId)

		putData.data = data

		table.insert(tempObjs, {
			putData = putData,
			initData = initData
		})
	end

	self.addObjFinal(tempObjs)
end

function RearHouseModelCenter.addObjFinal(data)
	if #data > 0 then
		local zoneName = data[1].initData.zone

		if zoneName == nil then
			zoneName = self.dragCenter.getCurWallName()
		end

		local zone = self.dragCenter.zones[zoneName]

		for i = #data, 1, -1 do
			if zone:isPosValid(data[i].putData, data[i].initData) == false then
				table.remove(data, i)
			end
		end

		self.dragCenter.zones[zoneName]:addObj(data)
	end
end

function RearHouseModelCenter.delAllObj(isForceAll, isIncludeStage)
	local zone = self.dragCenter.getCurZone()

	if zone then
		zone:delAllObj(isForceAll, isIncludeStage)
	end

	self.dragCenter.hideLogos()
end

function RearHouseModelCenter.resetLoad(func)
	self.dragCenter.zones[self.dragCenter.getCurWallName()]:resetLoad(func)
end

function RearHouseModelCenter.refreshItems(...)
	if self.checkMode ~= Const.REARHOUSE_CREATE_MODE.MINE then
		return
	end

	if self.modelData then
		local itemDic = {}
		local ownItems = CurAvatar:getItemsByStype(Const.ITEM_DICT_REAR_HOUSE)

		for i, item in ipairs(ownItems) do
			itemDic[item.id] = item.num
		end

		for modelId, num in pairs(itemDic) do
			local info = ResRearHouse[modelId]

			if info then
				local typeId = info.type_id
				local items = self.modelData[typeId]
				local isFind = false

				for i, item in ipairs(items) do
					if item.modelId == modelId then
						item.count = num - item.totalCount + item.count
						item.totalCount = num
						isFind = true

						break
					end
				end

				if not isFind then
					local data = self._getMyOwnModelInfo(typeId, modelId)

					data.count = num
					data.totalCount = num

					table.insert(self.modelData[typeId], data)
				end
			end
		end

		for tid, items in pairs(self.modelData) do
			if tid ~= Const.REARHOUSE_TYPE_HERO then
				for i = #items, 1, -1 do
					if itemDic[items[i].modelId] == nil then
						table.remove(items, i)
					end
				end
			end
		end
	end

	self._sortModelData()
end

function RearHouseModelCenter:refreshHeroData(gid)
	if self.checkMode == Const.REARHOUSE_CREATE_MODE.MINE then
		local data = self:getModelData()

		if data then
			local heroDatas = data[Const.REARHOUSE_TYPE_HERO] or {}

			for i, heroData in ipairs(heroDatas) do
				if heroData.hero.gid == gid and CurAvatar.heroDic[gid] then
					heroData.hero = CurAvatar.heroDic[gid]

					local ui = UIManager.getUI("rearHouseEditDlg", nil, false)

					if ui then
						ui:refreshList()
					end

					break
				end
			end
		end
	end
end

function RearHouseModelCenter.isInMode(mode)
	return self.checkMode == mode
end

function RearHouseModelCenter.reset(...)
	return
end

function RearHouseModelCenter.destroy(...)
	self.dragCenter = nil
end

return RearHouseModelCenter
