-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\RearHouse\\RearHouseCommon.lua

local ResColor = require("ClientData/ResColor")
local ResRearHouseMiscConfig = require("ClientData/ResRearHouseMiscConfig")
local ResRandClient = require("ClientData/ResRandClient")
local ResHousePrivilege = require("ClientData/ResHousePrivilege")
local ResRearHouseComfortable = require("ClientData/ResRearHouseComfortable")
local ResCrystalMisc = require("ClientData/ResCrystalMisc")
local ResRearHouse = require("ClientData/ResRearHouse")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResRearHouseLevelConfig = require("ClientData/ResRearHouseLevelConfig")
local ResRearHouseLayer = require("ClientData/ResRearHouseLayer")
local ResRearHouseGroup = require("ClientData/ResRearHouseGroup")
local RearHouseModelCenter = require("Logic/RearHouse/RearHouseModelCenter")
local ResRearHouseGroupEffect = require("ClientData/ResRearHouseGroupEffect")
local RearHouseCommon = {}
local self = RearHouseCommon

function RearHouseCommon.getColorByStep(step)
	if step <= 3 then
		return ResColor.QUALITYBLUE
	elseif step <= 6 then
		return ResColor.QUALITYPURPLE
	elseif step <= 9 then
		return ResColor.RED04
	else
		return ResColor.RED
	end
end

function RearHouseCommon.getMyMaxStep(...)
	local step = 0

	for gid, hero in pairs(CurAvatar.heroDic) do
		step = math.max(hero.step, step)
	end

	return step
end

function RearHouseCommon.getDispatchMaxCount(...)
	return ResRearHouseMiscConfig[1].dispatch_max_count
end

function RearHouseCommon.getDispatchCriAward(...)
	local pInfo = self.getPrivilegeInfoNowWithType(Const.REARHOUSE_DISPATCH_CRI_AWARD)

	return self.getAwardData(pInfo.param)[1]
end

function RearHouseCommon.getAwardData(randId)
	local bonus = ResRandClient[randId] or {}
	local showIds = bonus.show_ids or {}
	local showNums = bonus.show_nums or {}
	local data = {}

	if #showIds > 0 then
		for i = 1, #showIds do
			table.insert(data, BaseObject.GetObject(showIds[i], showNums[i]))
		end
	end

	return data
end

function RearHouseCommon.getPrivilegeIdsWithoutDefaultNow(...)
	if self.defaultPids == nil then
		self.defaultPids = {}

		local ids = ResRearHouseComfortable[1].privilege_ids

		for _, id in ipairs(ids) do
			self.defaultPids[id] = true
		end
	end

	local data = {}
	local curIds = self.getPrivilegeIdsNow()

	for _, id in ipairs(curIds) do
		if self.defaultPids[id] == true then
			-- block empty
		else
			table.insert(data, id)
		end
	end

	return data
end

function RearHouseCommon.getPrivilegeIdsNow(...)
	if self.recordComfort == nil or self.recordComfort ~= CurAvatar.rearHouseData.award_comfort then
		self.recordComfort = CurAvatar.rearHouseData.award_comfort
		self.curPrivilegeIds = self.getComfortToPrivilegeIds(self.recordComfort)
	end

	return self.curPrivilegeIds or {}
end

function RearHouseCommon.getPrivilegeInfoNowWithType(typeId)
	local ids = self.getPrivilegeIdsNow()

	for _, id in ipairs(ids) do
		local p = ResHousePrivilege[id]

		if p and p.type == typeId then
			return p
		end
	end
end

function RearHouseCommon.getComfortToPrivilegeIds(comfort)
	local comfortInfo = self.getComfortableData(comfort)
	local info = ResRearHouseComfortable[comfortInfo.curPart]

	return info.privilege_ids
end

function RearHouseCommon.isMaxCleanToday(...)
	local pInfo = self.getPrivilegeInfoNowWithType(Const.REARHOUSE_CLEAN_TIMES)

	return pInfo.param <= self.getTodayCleanTimes()
end

function RearHouseCommon.getMaxCleanTimes(...)
	local pInfo = self.getPrivilegeInfoNowWithType(Const.REARHOUSE_CLEAN_TIMES)

	return pInfo.param
end

function RearHouseCommon.getDispatchFreeRefreshTimes(...)
	local pInfo = self.getPrivilegeInfoNowWithType(Const.REARHOUSE_DISPATCH_REFRESH_TIMES)

	return pInfo.param
end

function RearHouseCommon.getLeftCleanTimes(...)
	return self.getMaxCleanTimes() - self.getTodayCleanTimes()
end

function RearHouseCommon.getTodayCleanTimes(...)
	if CurAvatar.rearHouseData.sweep_times == 0 then
		return 0
	end

	if ClientUtils.getServerTimeTodayStart() > CurAvatar.rearHouseData.sweep_tick then
		CurAvatar.rearHouseData.sweep_times = 0
	end

	return CurAvatar.rearHouseData.sweep_times
end

function RearHouseCommon.isCleanUnlock(...)
	local level = ResRearHouseMiscConfig[1].clean_unlock_lv

	return level <= CurAvatar.rearHouseData.level, level
end

function RearHouseCommon.getCleanAward(isAll)
	local pInfo = self.getPrivilegeInfoNowWithType(Const.REARHOUSE_CLEAN_AWARD)
	local randId = pInfo.param
	local item = self.getAwardData(randId)[1]

	if isAll then
		item.num = item.num * self.getLeftCleanTimes()
	end

	return item
end

function RearHouseCommon.isShopUnlock(...)
	local level = ResRearHouseMiscConfig[1].shop_unlock_lv

	return level <= CurAvatar.rearHouseData.level, level
end

function RearHouseCommon.isDispatchUnlock(...)
	local level = ResRearHouseMiscConfig[1].dispatch_unlock_lv

	return level <= CurAvatar.rearHouseData.level, level
end

function RearHouseCommon.isHouseShareUnlock(...)
	return CurAvatar.rearHouseData.level > 1
end

function RearHouseCommon.getRandHero(...)
	local gids = self.getAllHeroGidInRearHouse()
	local randIdx = math.random(#gids)

	return CurAvatar.heroDic[gids[randIdx]]
end

function RearHouseCommon.getAllHeroGidInRearHouse()
	local gids = {}
	local heroData = CurAvatar.rearHouseData.hero_data.hero

	for _, info in ipairs(heroData) do
		table.insert(gids, info.gid)
	end

	if CurAvatar:isCrystalOpened() == true then
		for _, info in ipairs(CurAvatar.crystalData.priests) do
			table.insert(gids, info.hero)
		end
	end

	return gids
end

function RearHouseCommon.getComfortableData(curComfort)
	local curPart, nextPart, isMax = -1, -1, false
	local count = #ResRearHouseComfortable

	for i = 1, count do
		local data = ResRearHouseComfortable[i]

		isMax = i == count

		if curComfort < (data.comfortable_num or 0) then
			curPart = math.max(1, i - 1)
			nextPart = i

			break
		end
	end

	if curPart == -1 and isMax == true then
		curPart = count
	end

	return {
		curPart = curPart,
		nextPart = nextPart,
		isMax = isMax
	}
end

function RearHouseCommon.getNewPrivilegeIdsByComfort(lowComfort, highComfort)
	local lowIds = self.getComfortToPrivilegeIds(lowComfort)
	local highIds = self.getComfortToPrivilegeIds(highComfort)

	return self._getNewPrivilegeIds(lowIds, highIds)
end

function RearHouseCommon.getNewPrivilegeIdsByComfortId(lowPart, highPart)
	local lowIds = ResRearHouseComfortable[lowPart].privilege_ids
	local highIds = ResRearHouseComfortable[highPart].privilege_ids

	return self._getNewPrivilegeIds(lowIds, highIds)
end

function RearHouseCommon._getNewPrivilegeIds(preIds, afterIds)
	local newIds = {}
	local isFind = false

	for _, highId in ipairs(afterIds) do
		isFind = false

		for _, lowId in ipairs(preIds) do
			if lowId == highId then
				isFind = true

				break
			end
		end

		if isFind == false then
			table.insert(newIds, highId)
		end
	end

	return newIds
end

function RearHouseCommon.isNewPrivilege(newComfort)
	newComfort = math.min(ResRearHouseComfortable[#ResRearHouseComfortable].comfortable_num, newComfort)

	local newIds = self.getComfortToPrivilegeIds(newComfort)
	local maxIds = self.getPrivilegeIdsNow()
	local ids = self._getNewPrivilegeIds(maxIds, newIds)

	return #ids > 0
end

function RearHouseCommon.getDispathDailyCount(...)
	local info = self.getPrivilegeInfoNowWithType(Const.REARHOUSE_DISPATCH_NUM)

	return info.param
end

function RearHouseCommon.isQuickDispatchOpen(...)
	local info = self.getPrivilegeInfoNowWithType(Const.REARHOUSE_QUICK_DISPATCH)

	return info ~= nil
end

function RearHouseCommon.getDispatchSingleCost(...)
	return ResRearHouseMiscConfig[1].dispatch_refresh_cost
end

function RearHouseCommon.getMaxCrystalLevel(...)
	local count = 0
	local limit = ResCrystalMisc[1].star_limit

	for gid, hero in pairs(CurAvatar.heroDic) do
		if limit <= hero.star then
			count = count + 1
		end
	end

	local calcuLevel = count * ResCrystalMisc[1].level_limit_add + ResCrystalMisc[1].maxLevel

	return math.min(calcuLevel, ResCrystalMisc[1].level_limit_max)
end

function RearHouseCommon.isMaxCrystalLevel(showLevel)
	return showLevel >= self.getMaxCrystalLevel()
end

function RearHouseCommon._getDispatchReqData(id, heros)
	local data = {}

	data.id = id
	data.hero_gids = {}

	for _, hero in ipairs(heros) do
		table.insert(data.hero_gids, hero.gid)
	end

	return data
end

function RearHouseCommon.getDispatchReqData(id, heros)
	return {
		self._getDispatchReqData(id, heros)
	}
end

function RearHouseCommon.getInTaskGidsMap(...)
	local map = {}

	for _, task in ipairs(CurAvatar.dispatchTasks) do
		local heroInfo = task:getInTaskHeroInfos()

		for _, info in ipairs(heroInfo) do
			map[info.use_gid] = true
		end
	end

	return map
end

function RearHouseCommon.getQuickDispatchReqData(...)
	local allHeros = {}

	for k, v in pairs(CurAvatar.heroDic) do
		table.insert(allHeros, v)
	end

	table.sort(allHeros, self._sortByStep)

	local allTasks = self.getSortedTasks()
	local num = 0
	local usedMap = {}
	local partUsedList
	local reqData = {}
	local preUsedMap = self.getInTaskGidsMap()

	for _, task in ipairs(allTasks) do
		if task.isLock == false and task.isNew == true then
			partUsedList = {}

			for _, hero in ipairs(allHeros) do
				if preUsedMap[hero.gid] ~= true and usedMap[hero.gid] ~= true and task:isHeroLimit(hero) == false then
					table.insert(partUsedList, hero)

					if #partUsedList == task.require_num then
						break
					end
				end
			end

			if #partUsedList == task.require_num then
				for _, hero in ipairs(partUsedList) do
					usedMap[hero.gid] = true
				end

				table.insert(reqData, self._getDispatchReqData(task.data.id, partUsedList))
			end
		end
	end

	return reqData
end

function RearHouseCommon.isNewTaskCanDo(newTasks, preUsedGidMap)
	if #newTasks == 0 then
		return false
	end

	local availableHeros = {}
	local preUsedMap = preUsedGidMap or self.getInTaskGidsMap()

	for k, v in pairs(CurAvatar.heroDic) do
		if preUsedMap[k] ~= true then
			table.insert(availableHeros, v)
		end
	end

	if #availableHeros == 0 then
		return false
	end

	local num = 0

	for _, task in ipairs(newTasks) do
		num = 0

		for _, hero in ipairs(availableHeros) do
			if task:isHeroLimit(hero) == false then
				num = num + 1

				if num == task.require_num then
					return true
				end
			end
		end
	end

	return false
end

function RearHouseCommon.setIsHouseShareEnter(b)
	self.isHouseShareEnter = b
end

function RearHouseCommon.getIsHouseShareEnter()
	return self.isHouseShareEnter
end

function RearHouseCommon._sortByStep(v1, v2)
	return v1.step < v2.step
end

function RearHouseCommon.getSortedTasks(...)
	local tasks = utils.copyTable(CurAvatar.dispatchTasks)

	table.sort(tasks, self._sortTaskByStar)

	return tasks
end

function RearHouseCommon._sortTaskByStar(v1, v2)
	return v1.star > v2.star
end

function RearHouseCommon.isNeedSpecialAni(modelId)
	local data = ResRearHouse[modelId]

	if data then
		return data.special_ani ~= nil
	else
		return false
	end
end

function RearHouseCommon.getCleanDesc(modelId)
	local data = ResRearHouse[modelId]

	if data then
		return data.clean_desc
	else
		return ResClientNotice[249].notice or ""
	end
end

function RearHouseCommon.getCrystalNum(houseLevel)
	local info = ResRearHouseLevelConfig[houseLevel]

	if info then
		local num = 0

		for i, _num in ipairs(info.part_limit[5].limit) do
			num = num + _num
		end

		if CurAvatar:isCrystalSecondPartNew() then
			num = num + (ResCrystalMisc[1].level_limit_add or 0)
		elseif CurAvatar:isCrystalOpened() then
			num = num + 5
		end

		return num
	end

	return 0
end

function RearHouseCommon.getPutIdAndNum(...)
	local map = {}

	if CurAvatar.rearHouseData then
		for i, partData in ipairs(CurAvatar.rearHouseData.part_data.part) do
			map[partData.id] = map[partData.id] or 0
			map[partData.id] = map[partData.id] + 1
		end
	end

	return map
end

function RearHouseCommon.refreshHouseItemFrozenNum(...)
	local items = CurAvatar:getItemsByStype(Const.ITEM_DICT_REAR_HOUSE)
	local putMap = self.getPutIdAndNum()

	for i, item in ipairs(items or {}) do
		item:setFrozenNum(putMap[item.id] or 0)
	end
end

function RearHouseCommon.getLimitNumByType(typeId, wallIndex)
	local data = ResRearHouseLevelConfig[CurAvatar.rearHouseData.level]

	if wallIndex then
		return data.part_limit[typeId].limit[wallIndex] or 0
	else
		local num = 0

		for i, n in ipairs(data.part_limit[typeId].limit) do
			num = num + n
		end

		return num
	end
end

function RearHouseCommon.getPutNumByType(typeId, wallIndex)
	local count = 0

	if typeId == Const.REARHOUSE_TYPE_HERO then
		return #CurAvatar.rearHouseData.hero_data.hero
	elseif self.isWeightType(typeId) then
		return self.getPutWeight(wallIndex)
	else
		for i, partData in ipairs(CurAvatar.rearHouseData.part_data.part) do
			local info = ResRearHouse[partData.id]

			if info and info.type_id == typeId and (not wallIndex or wallIndex == partData.pos.area) then
				count = count + 1
			end
		end

		return count
	end
end

function RearHouseCommon.getPutWeight(wallIndex)
	local count = 0

	for i, partData in ipairs(CurAvatar.rearHouseData.part_data.part) do
		local info = ResRearHouse[partData.id]

		if info and self.isWeightType(info.type_id) then
			if wallIndex then
				if wallIndex == partData.pos.area then
					count = count + (info.weight or 0)
				end
			else
				count = count + (info.weight or 0)
			end
		end
	end

	return count
end

function RearHouseCommon.getNameAndLimitNumByType(typeId, wallIndex)
	if typeId == nil then
		return
	end

	local info = ResRearHouseLayer[typeId]
	local putNum = self.getPutNumByType(typeId, wallIndex)
	local limitNum

	if self.isWeightType(typeId) then
		limitNum = self.getTotalWeightByLevel(CurAvatar.rearHouseData.level, wallIndex)
	else
		limitNum = self.getLimitNumByType(typeId, wallIndex)
	end

	return info.type_name, limitNum - putNum
end

function RearHouseCommon.isHouseItem(id)
	if id == nil then
		return false
	end

	return ResRearHouse[id] ~= nil
end

function RearHouseCommon.isPart1Max(...)
	return CurAvatar.rearHouseData.level == ResRearHouseMiscConfig[1].level1_part_max
end

function RearHouseCommon.getCurUnlockWall(wallIndex)
	local houseData = RearHouseModelCenter.getCurShowData()

	if not houseData then
		return 0
	end

	local unlockLevel = self.getNextWallUnlockLevel(wallIndex)

	unlockLevel = math.min(houseData.level, unlockLevel)

	local info = ResRearHouseLevelConfig[unlockLevel]

	if info then
		return info.unlock_wall
	else
		return 0
	end
end

function RearHouseCommon.isWeightType(typeId)
	return ResRearHouseLayer[typeId].is_weight_type == 1
end

function RearHouseCommon.getFurnitureInfo(mid)
	if mid == nil then
		return
	end

	return ResRearHouse[mid]
end

function RearHouseCommon.getLevelUpNumInfo(...)
	local data = {}

	for i, layer in ipairs(ResRearHouseLayer) do
		if self.isWeightType(i) == false and i ~= Const.REARHOUSE_TYPE_PARTS then
			table.insert(data, i)
		end
	end

	return data
end

function RearHouseCommon.getTotalWeightByLevel(level, wallIndex)
	if level > #ResRearHouseLevelConfig then
		level = #ResRearHouseMiscConfig
	end

	local weight = 0
	local data = ResRearHouseLevelConfig[level]

	for i, info in ipairs(ResRearHouseLayer) do
		if self.isWeightType(i) then
			if wallIndex then
				weight = weight + (data.part_limit[i].limit[wallIndex] or 0)
			else
				for _, num in ipairs(data.part_limit[i].limit) do
					weight = weight + num
				end
			end
		end
	end

	return weight
end

function RearHouseCommon.getRandVisitLv(...)
	return ResRearHouseMiscConfig[1].rand_visit_lv
end

function RearHouseCommon.getFurniturePutedMap(houseData)
	if houseData == nil then
		houseData = CurAvatar.rearHouseData
	end

	local map = {}

	if houseData then
		for _, partInfo in ipairs(houseData.part_data.part) do
			map[partInfo.id] = true
		end
	end

	return map
end

function RearHouseCommon.getAddAttrDescs(preData, newData)
	local data = {}

	if preData == nil or newData == nil then
		return data
	end

	local houseAttrMap = self:getAttrMap()
	local newtMap = {}
	local _info

	for i, partInfo in ipairs(newData) do
		_info = houseAttrMap[partInfo.id]

		if _info then
			newtMap[_info] = (newtMap[_info] or 0) + 1
		end
	end

	local preMap = {}

	for i, partInfo in ipairs(preData) do
		_info = houseAttrMap[partInfo.id]

		if _info then
			preMap[_info] = (preMap[_info] or 0) + 1
		end
	end

	for info, num in pairs(newtMap) do
		local preNum = preMap[info] or 0

		if preNum == 0 or preNum < num then
			local effectInfo = ResRearHouseGroupEffect[info.group_id]

			if effectInfo then
				for _, e in ipairs(effectInfo.buff_effect) do
					if preNum < e.num and num >= e.num then
						local strs = utils.splitString(e.desc, "|")

						for _, str in ipairs(strs) do
							if str ~= "" then
								table.insert(data, {
									info = info,
									desc = str
								})
							end
						end
					end
				end
			end
		end
	end

	return data
end

function RearHouseCommon.getWallUnlockLevel(wallIndex)
	if not wallIndex or wallIndex == 1 then
		return 1
	elseif ResRearHouseMiscConfig[1].other_wall_unlock_lv[wallIndex - 1] then
		return ResRearHouseMiscConfig[1].other_wall_unlock_lv[wallIndex - 1]
	else
		return #ResRearHouseLevelConfig
	end
end

function RearHouseCommon.getNextWallUnlockLevel(wallIndex)
	wallIndex = wallIndex or 1
	wallIndex = wallIndex + 1

	if ResRearHouseMiscConfig[1].other_wall_unlock_lv[wallIndex - 1] then
		return math.min(ResRearHouseMiscConfig[1].other_wall_unlock_lv[wallIndex - 1] - 1, #ResRearHouseLevelConfig)
	else
		return #ResRearHouseLevelConfig
	end
end

function RearHouseCommon.canPut(mid)
	local info = ResRearHouse[mid]

	if info then
		for i = 1, Const.REARHOUSE_WALL_NUM do
			if CurAvatar.rearHouseData.level >= self.getWallUnlockLevel(i) then
				if self.isWeightType(info.type_id) then
					local totalWeight = self.getTotalWeightByLevel(CurAvatar.rearHouseData.level, i)
					local putedWeight = self.getPutNumByType(info.type_id, i)

					if totalWeight - putedWeight >= (info.weight or 0) then
						return true, i
					end
				else
					local totalNum = self.getLimitNumByType(info.type_id, i)
					local putedNum = self.getPutNumByType(info.type_id, i)

					if totalNum - putedNum >= 1 then
						return true, i
					end
				end
			end
		end
	end
end

function RearHouseCommon.isAttrFurniturePuted(...)
	local houseData = RearHouseModelCenter.getCurShowData()

	if houseData == nil then
		houseData = CurAvatar.rearHouseData
	end

	local houseAttrMap = self.getAttrMap()

	for _, partInfo in ipairs(houseData.part_data.part or {}) do
		local info = houseAttrMap[partInfo.id]

		if info then
			return true
		end
	end

	return false
end

function RearHouseCommon.getAttrMap(...)
	if self.houseAttrMap == nil then
		self.houseAttrMap = {}

		for mid, houseInfo in pairs(ResRearHouse) do
			if houseInfo.groupid then
				local info = ResRearHouseGroup[houseInfo.groupid]

				if info then
					info.model_ids = info.model_ids or {}

					table.insert(info.model_ids, mid)

					self.houseAttrMap[mid] = info
				end
			end
		end
	end

	return self.houseAttrMap
end

function RearHouseCommon.getAllSingleAttrInfos(...)
	local houseAttrMap = self.getAttrMap()
	local data = {}

	for mid, info in pairs(houseAttrMap) do
		if #info.model_ids == 1 then
			table.insert(data, info)
		end
	end

	return data
end

function RearHouseCommon.getCurSingleAttrInfos(...)
	local data = {}
	local houseData = RearHouseModelCenter.getCurShowData()

	if houseData == nil then
		houseData = CurAvatar.rearHouseData
	end

	local houseAttrMap = self.getAttrMap()
	local repeatMap = {}

	for _, partInfo in ipairs(houseData.part_data.part or {}) do
		local info = houseAttrMap[partInfo.id]

		if info and #info.model_ids == 1 and info.single_group then
			repeatMap[info.single_group] = true
		end
	end

	for i, info in ipairs(ResRearHouseGroup) do
		if info.single_group and repeatMap[info.single_group] then
			data[info.single_group] = data[info.single_group] or {}

			table.insert(data[info.single_group], info)
		end
	end

	return data
end

function RearHouseCommon.getCurSuitAttrInfos()
	local data = {}
	local houseData = RearHouseModelCenter.getCurShowData()

	if houseData == nil then
		houseData = CurAvatar.rearHouseData
	end

	local houseAttrMap = self.getAttrMap()
	local repeatMap = {}

	for _, partInfo in ipairs(houseData.part_data.part or {}) do
		local info = houseAttrMap[partInfo.id]

		if info and #info.model_ids > 1 and not repeatMap[info] then
			table.insert(data, info)

			repeatMap[info] = true
		end
	end

	return data
end

function RearHouseCommon.getAttrInfoByMid(mid)
	if mid == nil then
		return
	end

	local houseAttrMap = self.getAttrMap()

	return houseAttrMap[mid]
end

function RearHouseCommon.isSingleFurniture(mid)
	local info = self.getAttrInfoByMid(mid)

	if info then
		return #info.model_ids == 1
	end
end

function RearHouseCommon.isAttrFurniture(mid)
	if mid == nil then
		return
	end

	local houseAttrMap = self.getAttrMap()

	return houseAttrMap[mid] ~= nil
end

function RearHouseCommon.getSingleAttrIconAndDescs(attrInfo)
	if attrInfo == nil then
		return
	end

	local effectInfos = ResRearHouseGroupEffect[attrInfo.group_id]
	local strs, iconPath

	if effectInfos and effectInfos.buff_effect[1] then
		local attr = effectInfos.buff_effect[1]

		strs = utils.splitString(attr.desc, "|")

		if attr.career then
			iconPath = UIConst.getHeroCareerIconPath(attr.career[1])
		elseif attr.game_group then
			iconPath = UIConst.getHeroGroupTeamIconPath(attr.game_group[1])
		end
	end

	return iconPath, strs
end

function RearHouseCommon.getSuitAttrDescs(attrInfo)
	if attrInfo == nil then
		return
	end

	local effectInfos = ResRearHouseGroupEffect[attrInfo.group_id]

	return effectInfos.buff_effect
end

function RearHouseCommon.isRoomUnlock(wallIndex, level)
	return level >= self.getWallUnlockLevel(wallIndex)
end

function RearHouseCommon.getNextRoomId(curWallIndex, level)
	if curWallIndex == Const.REARHOUSE_WALL_NUM then
		return 1
	end

	if self.isRoomUnlock(curWallIndex + 1, level) then
		return curWallIndex + 1
	end

	return 1
end

function RearHouseCommon.getUnlockRoomNum(level)
	for i = Const.REARHOUSE_WALL_NUM, 1, -1 do
		if self.isRoomUnlock(i, level) then
			return i
		end
	end

	return 1
end

function RearHouseCommon.getComfortByMid(mid)
	local info = ResRearHouse[mid]

	if info then
		return info.comfortable or 0
	end

	return 0
end

return RearHouseCommon
