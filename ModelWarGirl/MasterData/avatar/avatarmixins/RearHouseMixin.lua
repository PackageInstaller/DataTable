-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\RearHouseMixin.lua

local RearHouseDragCenter = require("Logic/RearHouse/RearHouseDragCenter")
local ResCrystalLevelLimit = require("ClientData/ResCrystalLevelLimit")
local ResRearHouseLevelConfig = require("ClientData/ResRearHouseLevelConfig")
local ResRearHouseMiscConfig = require("ClientData/ResRearHouseMiscConfig")
local ResCrystalLevelCost = require("ClientData/ResCrystalLevelCost")
local EventConst = require("EventConst")
local ResCrystalMisc = require("ClientData/ResCrystalMisc")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local DispatchTask = require("Logic/RearHouse/DispatchTask")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResHeroCrystalAchieve = require("ClientData/ResHeroCrystalAchieve")
local ResRearHouse = require("ClientData/ResRearHouse")
local ResCrystalAchieve = require("ClientData/ResCrystalAchieve")
local ResConditionLimit = require("ClientData/ResConditionLimit")
local UserData = require("Helper/UserData")
local RearHouseMixin = {}

function RearHouseMixin:initRearHouseMixin(baseData, syncData)
	self:initRearHouseData(syncData.other)
end

function RearHouseMixin:initCheckRearHouseMixin(...)
	self:getFavorInfo()
	self:checkRearHouseUpgradeHint()
	self:checkComfotableRedHint()
	self:checkCrystalUpHint()
	self:checkAllStepTowerCanBattle()
	self:checkCleanRedHint()
	self:checkDispatchRedHint()
	self:refreshRearHouseRed()

	self.slotOfRedHintUpgrade = Slot(self.checkRearHouseUpgradeHint, self)
	self.slotRefreshRearHouseRed = Slot(self.refreshRearHouseRed, self)

	EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfRedHintUpgrade)
	EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotRefreshRearHouseRed)

	if self.syncDataReady and self:isCrystalFirstPartOver() then
		BeginnerManager.CrystalSecondUnlock()
	end
end

function RearHouseMixin:destroyRearHouseMixin(...)
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfRedHintUpgrade)
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotRefreshRearHouseRed)
end

function RearHouseMixin:postinitRearHouseMixin(baseData, syncData)
	self:initHeroLoginInfo()
	self:_initRemindInfo()
	self:initCrystalAchieveData(syncData.other, syncData.bag)
	self:initCrystalHeroData()
end

function RearHouseMixin:rearHosueStartCheckNewItem(...)
	self.rearHouseNewItem = {}
end

function RearHouseMixin:isShowNew(id, isKeep)
	if self.rearHouseNewItem[id] then
		local flag = self.rearHouseNewItem[id] > 0

		if not isKeep then
			self.rearHouseNewItem[id] = 0
		end

		self:checkNewItem()

		return flag
	else
		return false
	end
end

function RearHouseMixin:haveNewItem()
	if self.rearHouseNewItem then
		for id, info in pairs(self.rearHouseNewItem) do
			if info > 0 then
				return true
			end
		end
	end

	return false
end

function RearHouseMixin:refreshRearHouseHero(gids)
	if self.rearHouseData then
		for _, gid in ipairs(gids) do
			for i, data in ipairs(self.rearHouseData.hero_data.hero) do
				if gid == data.gid then
					table.remove(self.rearHouseData.hero_data.hero, i)

					break
				end
			end
		end
	end
end

function RearHouseMixin:initRearHouseData(data)
	self.rearHouseData = data.house
	self.mainRoom = self.rearHouseData.main_room
	self.rearHouseCommentLimit = self.rearHouseData.comment_switch or 0
	self.houseShareTime = self.rearHouseData.share_time
	self.rearHouseState = data.house_misc
	self.dispatchData = data.house_dispatch

	self:initCrystalStepData(data.crystal)
	self:checkPutHero()
	self:initCrystalData(true)
	self:initDispatchTasks()
end

function RearHouseMixin:onNewDayRearHouse(...)
	self:_onNewDayClean()
	self:_onNewDayVisit()
	self:refreshDispatchTipTime(true)
end

function RearHouseMixin:initCrystalStepData(crystalData)
	self.crystalData = crystalData
	self.crystalStep = crystalData.step

	local oldLevel = self.crystalNewLevel

	self.crystalNewLevel = crystalData.crystal_level

	if self.syncDataReady and self:isCrystalFirstPartOver() then
		BeginnerManager.CrystalSecondUnlock()
	end

	if oldLevel and oldLevel < self.crystalNewLevel then
		self:changeCrystalHeroLevel()
	end
end

function RearHouseMixin:checkRearHouseUpgradeHint(limitId)
	if self.rearHouseConditionId == nil then
		local nextLevel = math.min(#ResRearHouseLevelConfig, self.rearHouseData.level + 1)
		local nextData = ResRearHouseLevelConfig[nextLevel]

		self.rearHouseConditionId = nextData.condition_limit
	end

	if limitId ~= nil and limitId ~= self.rearHouseConditionId then
		return
	end

	local nextLevel = math.min(#ResRearHouseLevelConfig, self.rearHouseData.level + 1)
	local nextData = ResRearHouseLevelConfig[nextLevel]

	self.rearHouseConditionId = nextData.condition_limit

	local conditonLimit = ConditionLimitManager.inLimitState(nextData.condition_limit)

	if conditonLimit then
		RedDotManager.setKeyState(UIConst.RD_HINT_REAR_HOUSE_UPGREAD_BTN, false)

		return
	end

	local costEnough = true

	for i, data in ipairs(nextData.resource_consume) do
		costEnough = costEnough and self:getItemNumById(data.id) >= data.num
	end

	if not costEnough then
		RedDotManager.setKeyState(UIConst.RD_HINT_REAR_HOUSE_UPGREAD_BTN, false)

		return
	end

	local partLimit = RearHouseCommon.isPart1Max()

	if partLimit then
		RedDotManager.setKeyState(UIConst.RD_HINT_REAR_HOUSE_UPGREAD_BTN, false)

		return
	end

	local result = self.rearHouseData.level < #ResRearHouseLevelConfig

	RedDotManager.setKeyState(UIConst.RD_HINT_REAR_HOUSE_UPGREAD_BTN, result)
end

function RearHouseMixin:checkNewItem(...)
	local result = self:haveNewItem()

	RedDotManager.setKeyState(UIConst.RD_HINT_REAR_HOUSE_NEW_ITEM, result)
end

function RearHouseMixin:checkPutHero(putCount, wallIndex)
	for i = 1, Const.REARHOUSE_WALL_NUM do
		local totalCount = utils.getTableElemCount(self.heroDic)
		local limitNum = RearHouseCommon.getLimitNumByType(Const.REARHOUSE_TYPE_HERO, i)
		local result = false

		if self:isCrystalOpened() then
			local count = 0
			local putedCount = 0

			if putCount then
				count = putCount

				if i == wallIndex then
					putedCount = putCount
				else
					for _, heroInfo in ipairs(self.rearHouseData.hero_data.hero) do
						if heroInfo.pos.area ~= i then
							putedCount = putedCount + 1
						end
					end
				end

				for _, heroInfo in ipairs(self.rearHouseData.hero_data.hero) do
					if heroInfo.pos.area ~= wallIndex then
						count = count + 1
					end
				end
			else
				for _, heroInfo in ipairs(self.rearHouseData.hero_data.hero) do
					if i == heroInfo.pos.area then
						putedCount = putedCount + 1
					end

					count = count + 1
				end
			end

			if putedCount < limitNum and totalCount - count - #self.crystalData.priests > 0 then
				result = true
			end
		end

		RedDotManager.setKeyState(UIConst["RD_HINT_REAR_HOUSE_EDIT" .. i], result)
	end
end

function RearHouseMixin:refreshHouseItemFrozenNum(...)
	RearHouseCommon.refreshHouseItemFrozenNum()
end

function RearHouseMixin:onHouseUpdateResp(succ)
	self.rearHouseData.part_data = RearHouseDragCenter.saveData.part_data
	self.rearHouseData.hero_data = RearHouseDragCenter.saveData.hero_data
	self.rearHouseState.saved = 1

	self:checkPutHero()
	self:refreshHouseItemFrozenNum()

	local ui = UIManager.getUI("rankMainDlg", nil, false)

	if ui and ui.typeRank == Const.RANK_TYPE_HOUSEFAVOR then
		ui:setVisible(false)
	end
end

function RearHouseMixin:refreshRearHouseHeros(isOpenTime)
	if self:isCrystalOpened() == false then
		return
	end

	local newData = {}
	local removeData = {}
	local isFind = false

	for i, hero in ipairs(self.rearHouseData.hero_data.hero) do
		isFind = false

		for j, data in ipairs(self.crystalData.slot) do
			if data.hero == hero.gid then
				isFind = true

				break
			end
		end

		if isFind then
			table.insert(newData, hero)
		else
			removeData[hero.gid] = true
		end
	end

	self.rearHouseData.hero_data.hero = newData

	if RearHouseDragCenter.inited then
		RearHouseDragCenter.refreshHeros(removeData, isOpenTime)
	end
end

function RearHouseMixin:onHouseLevelUpResp(level)
	self.rearHouseData.level = level

	if ResRearHouseMiscConfig[1].crystal_unlock_lv == level then
		self:refreshRearHouseHeros(true)
	end

	self:checkPutHero()
	self:checkDispatchRedHint()
	self:checkRearHouseUpgradeHint()

	local ui = UIManager.getUI("rearHouseMainDlg", nil, false)

	if ui then
		ui:refreshUI()
	end

	ui = UIManager.getUI("rearHouseLvUpDlg", nil, false)

	if ui then
		ui:onLevelUpSuccess()
		ui:refreshUI()
	end

	BeginnerManager.CheckRearHouseLevel()
	ConditionLimitManager.triggerHouseLevelCondition(level)
end

function RearHouseMixin:onHouseUnlockAwardGetResp()
	RearHouseDragCenter.initData()
end

function RearHouseMixin:getRearHouseLevelInfo(level)
	level = math.min(#ResRearHouseLevelConfig, level)

	local bigLv = ResRearHouseLevelConfig[level].level_part
	local count = 0
	local lastPartLevel = -1

	for i, info in ipairs(ResRearHouseLevelConfig) do
		if info.level_part == bigLv then
			if lastPartLevel == -1 then
				lastPartLevel = i - 1
			end

			count = count + 1
		end
	end

	local smallLv = level - lastPartLevel

	return {
		count = count,
		bigLv = bigLv,
		smallLv = smallLv
	}
end

function RearHouseMixin:checkGetRearHouseItem(item, oldValue)
	if self.rearHouseNewItem == nil then
		return
	end

	local obj = ResRearHouse[item.id]

	if obj then
		if oldValue < item.num then
			if self.rearHouseNewItem[item.id] == nil then
				self.rearHouseNewItem[obj.type_id] = (self.rearHouseNewItem[obj.type_id] or 0) + 1
				self.rearHouseNewItem[item.id] = 1
			end
		elseif item.num == 0 and self.rearHouseNewItem[item.id] ~= nil then
			self.rearHouseNewItem[obj.type_id] = (self.rearHouseNewItem[obj.type_id] or 0) - 1
			self.rearHouseNewItem[item.id] = 0
		end
	end

	self:checkNewItem()
end

function RearHouseMixin:checkRearHouseShopRefresh(item)
	if item and ResRearHouse[item.id] then
		local ui = UIManager.getUI("rearHouseShopDlg", nil, false)

		if ui then
			ui:refreshUI()
		end
	end
end

function RearHouseMixin:removeHeroFromHouse(gid)
	if gid == nil then
		return
	end

	local isFind = false
	local HeroData = utils.deepcopy(self.rearHouseData.hero_data)

	for i = #HeroData.hero, 1, -1 do
		if HeroData.hero[i].gid == gid then
			table.remove(HeroData.hero, i)

			isFind = true

			break
		end
	end

	if isFind == true then
		local partData = self.rearHouseData.part_data

		RearHouseDragCenter.saveData = {}
		RearHouseDragCenter.saveData.part_data = partData
		RearHouseDragCenter.saveData.hero_data = HeroData

		RPC.houseUpdate(HeroData, partData)
	end

	if self:isCrystalOpened() == true and self.crystalSlotDic[gid] then
		local data = {}

		for _, slotData in ipairs(self.crystalData.slot) do
			if slotData.hero == gid then
				-- block empty
			else
				table.insert(data, slotData.hero)
			end
		end

		RPC.crystalMsgSaveSympathizer(data)
	end

	CurAvatar:offAllEquipByGids({
		gid
	})
end

function RearHouseMixin:checkCrystalUpHint()
	RedDotManager.setKeyState(UIConst.RD_HINT_REAR_HOUSE_CRYSTLE_UP, self:crystalCanLevelUp())
	self:onRefreshCrystalSecondNew()
end

function RearHouseMixin:crystalCanLevelUp()
	if not self:isCrystalSecondPartNew() then
		return false
	end

	local costEnough = true

	if self.crystalNewLevel < self:getCrystalNewLevelMax() or self:overProficientMaxLimit() then
		local info = ResCrystalLevelCost[self.crystalNewLevel + 1]

		if info then
			for i = 1, #info.res_id do
				local own = self:getItemNumById(info.res_id[i])

				if own < (info.res_num[i] or 0) then
					costEnough = false

					break
				end
			end

			if costEnough and info.gold then
				local own = self:getItemNumById(Const.MONEY_ID_GOLD)

				if own < info.gold then
					costEnough = false
				end
			end
		else
			costEnough = false
		end
	else
		costEnough = false
	end

	return costEnough
end

function RearHouseMixin:initCrystalData(noRefreshHero)
	self.crystalPriestsDic = {}

	for _, priestsData in ipairs(self.crystalData.priests) do
		self.crystalPriestsDic[priestsData.hero] = priestsData
	end

	self.crystalSlotDic = {}

	for _, slotData in ipairs(self.crystalData.slot) do
		self.crystalSlotDic[slotData.hero] = slotData
	end

	if not noRefreshHero then
		self:initHeroCrystalInfo()
	end
end

function RearHouseMixin:onCrystalMsgNotify(crystal_data)
	self:initCrystalStepData(crystal_data)
	self:initCrystalData()
	self:refreshRearHouseHeros()
end

function RearHouseMixin:onCrystalMsgSlotNotify(slot_data)
	self.crystalData.slot = slot_data
	self.crystalSlotDic = {}

	for _, slotData in ipairs(self.crystalData.slot) do
		self.crystalSlotDic[slotData.hero] = slotData
	end

	self:initHeroCrystalInfo()
	self:refreshRearHouseHeros()
end

function RearHouseMixin:getCrystalNowCapacity()
	local capacity = 0

	for i, priestsData in ipairs(self.crystalData.priests) do
		local hero = self.heroDic[priestsData.hero]

		capacity = capacity + hero:getCapacity()
	end

	for i, priestsData in ipairs(self.crystalData.slot) do
		local hero = self.heroDic[priestsData.hero]

		capacity = capacity + hero:getCapacity()
	end

	return capacity
end

function RearHouseMixin:getNextCrystalCapacity()
	local capacity = 0

	for i, priestsData in ipairs(self.crystalData.priests) do
		local hero = self.heroDic[priestsData.hero]

		capacity = capacity + hero:getCapacity(1)
	end

	for i, priestsData in ipairs(self.crystalData.slot) do
		local hero = self.heroDic[priestsData.hero]

		capacity = capacity + hero:getCapacity(1)
	end

	return capacity
end

function RearHouseMixin:onCrystalMsgLevelNotify(level, max_level, crystal_level)
	self.crystalData.level = level
	self.crystalData.max_level = max_level
	self.crystalData.crystal_level = crystal_level

	local oldLevel = self.crystalNewLevel

	self:initCrystalStepData(self.crystalData)
	self:initHeroCrystalInfo()
	self:checkCrystalUpHint()
	self:checkRearHouseUpgradeHint()
	self:checkPetCanLevelUpRedHint()

	local ui = UIManager.getUI("rearHouseMainDlg", nil, false)

	if ui then
		ui:refreshUI()
	end

	ConditionLimitManager.triggerCrystalLevelCondition(max_level)
	ConditionLimitManager.triggerCrystalSecondLevelCondition(crystal_level)

	if self:isCrystalSecondPartNew() then
		self:checkCrystalAchiveNew()
		self:checkCrystalLevelAchiveNew()
		self:onRefreshCrystalLevel()

		if oldLevel ~= self.crystalNewLevel then
			local rearHouseCrystalDetailDlg = UIManager.tryGetUI("rearHouseCrystalDetailDlg")

			if rearHouseCrystalDetailDlg then
				rearHouseCrystalDetailDlg:onStarChanged(self.crystalNewLevel)
			end
		end
	end

	self:refreshApprenticeGraduteRed()
end

local function _sortPriests(a, b)
	return a.level < b.level
end

function RearHouseMixin:getCrystalPriestsMaxLv(heroLv)
	local maxLv = 1

	for id, limitInfo in ipairs(ResCrystalLevelLimit) do
		if heroLv then
			local priests = {}

			for i, priestsData in ipairs(self.crystalData.priests) do
				priests[i] = self.heroDic[priestsData.hero]
			end

			table.sort(priests, _sortPriests)

			if priests[2] then
				local diffLv = heroLv < priests[2].level and priests[2].level or self.crystalData.level

				if diffLv >= limitInfo.level then
					maxLv = limitInfo.level_max
				end
			else
				return heroLv
			end
		elseif self.crystalData.level >= limitInfo.level then
			maxLv = limitInfo.level_max
		end
	end

	return maxLv
end

function RearHouseMixin:getNextPriestsLvStep()
	for id, limitInfo in ipairs(ResCrystalLevelLimit) do
		if self.crystalData.level < limitInfo.level then
			return limitInfo
		end
	end

	return ResCrystalLevelLimit[#ResCrystalLevelLimit]
end

function RearHouseMixin:getHeroPriestsLvStep(hero)
	for i = #ResCrystalLevelLimit, 1, -1 do
		local limitInfo = ResCrystalLevelLimit[i]

		if hero.level >= limitInfo.level_max then
			if ResCrystalLevelLimit[i + 1] then
				return ResCrystalLevelLimit[i + 1]
			else
				return ResCrystalLevelLimit[#ResCrystalLevelLimit]
			end
		end
	end

	return ResCrystalLevelLimit[1]
end

function RearHouseMixin:isCrystalOpened(...)
	return ResRearHouseMiscConfig[1].crystal_unlock_lv <= self.rearHouseData.level
end

function RearHouseMixin:isCrystalFirstPartOver()
	return self:getCrystalMaxLevel() >= ResCrystalMisc[1].maxLevel
end

function RearHouseMixin:isCrystalSecondPartNew(...)
	return self.crystalStep == 2
end

function RearHouseMixin:getRearHouseLevel()
	return self.rearHouseData.level
end

function RearHouseMixin:getCrystalMaxLevel()
	return self.crystalData.max_level
end

function RearHouseMixin:onRefreshCrystalLevel()
	local state = GameFsm.getState(Const.STATE_MAIN_REAR_HOUSE)

	if state.newLevelDlg then
		state.newLevelDlg:onRefreshLevel()
	end
end

function RearHouseMixin:onRefreshCrystalSecondNew()
	local state = GameFsm.getState(Const.STATE_MAIN_REAR_HOUSE)

	if state.newLevelDlg then
		state.newLevelDlg:checkSecondNew()
	end

	local rearHouseCrystalDetailDlg = UIManager.tryGetUI("rearHouseCrystalDetailDlg")

	if rearHouseCrystalDetailDlg then
		rearHouseCrystalDetailDlg:tryAutoRefresh()
	end
end

function RearHouseMixin:onClickCrystalStage()
	if self:isCrystalSecondPartNew() then
		UIManager.getUI("rearHouseCrystalDetailDlg", true)

		local state = GameFsm.getState(Const.STATE_MAIN_REAR_HOUSE)

		if state.newLevelDlg then
			state.newLevelDlg:onClickCrystalStage()
		end
	end
end

function RearHouseMixin:onClickCrystalStageAchieve()
	if self:isCrystalSecondPartNew() then
		local rearHouseCrystalDetailDlg = UIManager.getUI("rearHouseCrystalDetailDlg", true)

		rearHouseCrystalDetailDlg:onClickLevelAward()
	end
end

function RearHouseMixin:getCrystalNewLevelMax()
	return math.floor(self:getTotalProficient() / 10) * 10 + 10
end

function RearHouseMixin:overProficientMaxLimit()
	return self:getTotalProficient() >= (ResCrystalMisc[1].proficient_limit_level or 1600)
end

function RearHouseMixin:_onNewDayClean(...)
	self.rearHouseData.sweep_times = 0

	self:checkCleanRedHint()

	local ui = UIManager.getUI("rearHouseMainDlg", nil, false)

	if ui then
		ui:refreshUI()
	end
end

function RearHouseMixin:onHouseSweepResp(times)
	self.rearHouseData.sweep_times = times
	self.rearHouseData.sweep_tick = ClientUtils.getServerTime()

	self:checkCleanRedHint()

	local ui = UIManager.getUI("rearHouseMainDlg", nil, false)

	if ui then
		ui:refreshUI()
	end
end

function RearHouseMixin:checkCleanRedHint(...)
	local result = not RearHouseCommon.isMaxCleanToday()
	local gids = RearHouseCommon.getAllHeroGidInRearHouse()

	result = result and #gids > 0

	RedDotManager.setKeyState(UIConst.RD_HINT_REAR_HOUSE_CLEAN, result)
end

function RearHouseMixin:onHouseComfortAwardGetResp(comfort)
	self.rearHouseData.award_comfort = comfort

	if self.showComfortAwardPanel == false then
		local ui = UIManager.getUI("rearHouseComfortableDlg", nil, false)

		if ui then
			ui:refreshUI()
		end
	end

	self:checkComfotableRedHint()
	self:checkCleanRedHint()

	local ui = UIManager.getUI("rearHouseMainDlg", nil, false)

	if ui then
		ui:refreshUI()
	end
end

function RearHouseMixin:checkComfotableRedHint(...)
	local maxData = RearHouseCommon.getComfortableData(self.rearHouseData.max_comfort)
	local awardData = RearHouseCommon.getComfortableData(self.rearHouseData.award_comfort)
	local result = maxData.curPart - awardData.curPart > 0

	RedDotManager.setKeyState(UIConst.RD_HINT_COMFORTABLE_AWARD, result)
end

function RearHouseMixin:onHouseDispatchStartResp(started_house_dispatch)
	for _, task in ipairs(started_house_dispatch) do
		local data, index = self:_findDispatchTask(task.id)

		if index then
			data:refreshData(task)
		end
	end

	local ui = UIManager.getUI("dispatchDlg", nil, false)

	if ui then
		ui:refreshList()
	end

	MsgManager.notice(Lang.get(1890))
	self:checkDispatchRedHint()
end

function RearHouseMixin:onHouseDispatchDoneResp(id, crit)
	local taskData = self:_onDispatchTaskDone(id)
	local ui = UIManager.getUI("dispatchDlg", nil, false)

	if ui then
		ui:refreshList()
	end

	if crit == 1 then
		UIManager.getUI("dispatchExtraAwardDlg", true):setData(taskData)
	end

	MsgManager.notice(Lang.get(1891))
	self:checkDispatchRedHint()
end

function RearHouseMixin:onHouseDispatchAllDoneResp(dispatch_done)
	local taskDatas = {}

	for i, task in ipairs(dispatch_done or {}) do
		local taskData = self:_onDispatchTaskDone(task.id)

		if task.crit == 1 then
			table.insert(taskDatas, taskData)
		end
	end

	local ui = UIManager.getUI("dispatchDlg", nil, false)

	if ui then
		ui:refreshList()
	end

	if #taskDatas > 0 then
		UIManager.getUI("dispatchExtraAwardDlg", true):setData(taskDatas[1], #taskDatas)
	end

	MsgManager.notice(Lang.get(1891))
	self:checkDispatchRedHint()
end

function RearHouseMixin:onHouseDispatchLockResp(id, lock)
	self:_onDispatchTaskLockChange(id, lock)
	self:checkDispatchRedHint()

	local ui = UIManager.getUI("dispatchInfoDlg", nil, false)

	if ui then
		ui:refreshUI()
	end

	if lock == 0 then
		MsgManager.notice(Lang.get(1892))
	else
		MsgManager.notice(Lang.get(1893))
	end
end

function RearHouseMixin:onHouseDispatchRefreshResp(house_dispatch)
	self.dispatchData = house_dispatch

	self:initDispatchTasks()
	self:checkDispatchRedHint()
	MsgManager.clientNotice(254)
end

function RearHouseMixin:onHouseDispatchDayRefreshNotify(house_dispatch)
	self.dispatchData = house_dispatch
	ClientUtils.record.dispatchNotEnoughTip = nil

	self:initDispatchTasks()
	self:checkDispatchRedHint()
end

function RearHouseMixin:onHouseDispatchAddNotify(add_dispatch)
	for _, data in ipairs(add_dispatch) do
		local task = DispatchTask(data)

		table.insert(self.dispatchTasks, task)
	end

	self:checkDispatchRedHint()
end

local MAX_TIME = 99999999999

function RearHouseMixin:checkDispatchRedHint(...)
	if RearHouseCommon.isDispatchUnlock() == false then
		RedDotManager.setKeyState(UIConst.RD_HINT_DISPATCH_AWARD, false)

		return
	end

	local result = false
	local newTasks = {}
	local minFinishTime = MAX_TIME

	for _, task in ipairs(self.dispatchTasks) do
		task:refreshState()

		if task.isDone == true then
			result = true

			break
		end

		if task.isDoing == true then
			minFinishTime = math.min(minFinishTime, task:getEndTime())
		elseif task.isNew and task.isLock == false then
			table.insert(newTasks, task)
		end
	end

	if result == false then
		if minFinishTime == MAX_TIME then
			-- block empty
		else
			self:_checkDispatchTimeDown(minFinishTime)
		end

		result = RearHouseCommon.isNewTaskCanDo(newTasks)
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_DISPATCH_AWARD, result)
end

function RearHouseMixin:_checkDispatchTimeDown(minFinishTime)
	ClientTimerManager.stopGlobalTimer("RearHouseDispatchFinish")

	local leftTime = math.max(0, minFinishTime - ClientUtils.getServerTime())

	ClientTimerManager.startGlobalTimer("RearHouseDispatchFinish", leftTime, Slot(self.checkDispatchRedHint, self))
end

function RearHouseMixin:initDispatchTasks(...)
	self.dispatchTasks = ClientUtils.record.dispatchTasks or {}

	local findMap = {}

	for i = #self.dispatchTasks, 1, -1 do
		local task = self.dispatchTasks[i]

		for _, data in ipairs(self.dispatchData.house_dispatch) do
			if data.id == task.data.id then
				findMap[data.id] = true

				task:refreshData(data)

				break
			end
		end

		if findMap[task.data.id] ~= true then
			table.remove(self.dispatchTasks, i)
		end
	end

	for _, data in ipairs(self.dispatchData.house_dispatch) do
		if findMap[data.id] == true then
			-- block empty
		else
			local t = DispatchTask(data)

			table.insert(self.dispatchTasks, t)
		end
	end

	ClientUtils.record.dispatchTasks = self.dispatchTasks

	local ui = UIManager.getUI("dispatchDlg", nil, false)

	if ui then
		ui:refreshUI()
	end

	local ui = UIManager.getUI("dispatchInfoDlg", nil, false)

	if ui then
		ui:refreshUI()
	end
end

function RearHouseMixin:_onDispatchTaskLockChange(id, lock)
	local data, index = self:_findDispatchTask(id)

	if index then
		data:setLockState(lock)
	end
end

function RearHouseMixin:_onDispatchTaskDone(id)
	local data, index = self:_findDispatchTask(id)

	if index then
		table.remove(self.dispatchTasks, index)
	end

	return data
end

function RearHouseMixin:_findDispatchTask(id)
	local data, index

	for i = #self.dispatchTasks, 1, -1 do
		data = self.dispatchTasks[i]

		if data.data.id == id then
			index = i

			break
		end
	end

	return data, index
end

function RearHouseMixin:_initRemindInfo(...)
	local remindTime = UserData.loadCommonDataInt("keyDispatchRefreshTip" .. self.uid)

	self.isShowDispatchRefreshTip = remindTime < ClientUtils.getServerTime()
end

function RearHouseMixin:refreshDispatchTipTime(isNewDay)
	local remindTime = 0

	if isNewDay == true then
		-- block empty
	else
		remindTime = ClientUtils.getServerTimeNextDay()
	end

	UserData.saveCommonDataInt("keyDispatchRefreshTip" .. self.uid, remindTime)

	self.isShowDispatchRefreshTip = remindTime < ClientUtils.getServerTime()
end

function RearHouseMixin:_onNewDayVisit(...)
	if self.rearHouseFavorInfo then
		self.rearHouseFavorInfo.favorToday = {}
	end
end

function RearHouseMixin:onHouseVisitResp(favor_num)
	if self.rearHouseVisitDataInvalid then
		self.rearHouseVisitDataInvalid = nil

		return
	end

	self.cachedRearHouseVisitFavorNum = favor_num

	self:checkReadyToVisit()
end

function RearHouseMixin:onHouseVisitNotify(house, uid)
	if house.level <= 1 then
		if self.cachedRearHouseVisitFavorNum then
			self.cachedRearHouseVisitFavorNum = nil
		else
			self.rearHouseVisitDataInvalid = true
		end

		MsgManager.notice(Lang.get(1894))

		return
	end

	self.cachedRearHouseVisitData = {}
	self.cachedRearHouseVisitData.house = house
	self.cachedRearHouseVisitData.uid = uid

	self:checkReadyToVisit()
end

function RearHouseMixin:checkReadyToVisit(...)
	if self.cachedRearHouseVisitFavorNum and self.cachedRearHouseVisitData then
		local ui = UIManager.getUI("chatDlg", nil, false)

		if ui then
			ui:setVisible(false)
		end

		local ui = UIManager.getUI("rankMainDlg", nil, false)

		if ui and ui.typeRank == Const.RANK_TYPE_HOUSEFAVOR then
			ui:setVisible(false)
		end

		self.cachedRearHouseVisitData.favorNum = self.cachedRearHouseVisitFavorNum

		RearHouseDragCenter.visit(self.cachedRearHouseVisitData)

		self.cachedRearHouseVisitData = nil
		self.cachedRearHouseVisitFavorNum = nil
	end
end

function RearHouseMixin:onHouseFavorHistoryResp(favored_num, favor_uid, favored_uid, favor_today)
	self.rearHouseFavorInfo = {}
	self.rearHouseFavorInfo.tick = Time.time
	self.rearHouseFavorInfo.favoredNum = favored_num
	self.rearHouseFavorInfo.favorUids = utils.copyTable(favor_uid)
	self.rearHouseFavorInfo.favoredUids = {}

	local map = {}
	local uid

	for i = #favored_uid, 1, -1 do
		uid = favored_uid[i]

		if not map[uid] then
			table.insert(self.rearHouseFavorInfo.favoredUids, 1, uid)

			map[uid] = true
		end
	end

	self.rearHouseFavorInfo.favorToday = {}

	for _, uid in ipairs(favor_today) do
		self.rearHouseFavorInfo.favorToday[uid] = true
	end

	local ui = UIManager.getUI("rearHouseMainDlg", nil, false)

	if ui then
		ui:refreshUI()
	end

	local ui = UIManager.getUI("rearHouseVisitChooseDlg", nil, false)

	if ui then
		ui:refreshFavoredUI()
		ui:refreshFavorUI()
	end
end

function RearHouseMixin:onHouseVisitRandomResp(uid)
	if uid == "" or uid == "0" or uid == self.uid then
		MsgManager.notice(Lang.get(1895))

		return
	end

	self.nextRearHouseRandVisitTime = Time.time + ResRearHouseMiscConfig[1].rand_visit_cd

	self:checkHouseVisitReq(uid)
end

function RearHouseMixin:onHouseVisitHistoryGetResp(uid)
	self.rearHouseVisitorInfo = {}
	self.rearHouseVisitorInfo.tick = Time.time
	self.rearHouseVisitorInfo.uids = uid

	local ui = UIManager.getUI("rearHouseVisitChooseDlg", nil, false)

	if ui then
		ui:refreshvisitorUI()
	end
end

function RearHouseMixin:onHouseFavorResp(succ, award)
	if award == 0 then
		MsgManager.notice(Lang.get(96102))
	else
		MsgManager.notice(Lang.get(96103))
	end

	if self.rearHouseFavorInfo and self.cachedRearHouseFavorUid then
		self.rearHouseFavorInfo.favorToday[self.cachedRearHouseFavorUid] = true

		local isFind = false

		for i, uid in ipairs(self.rearHouseFavorInfo.favorUids) do
			if uid == self.cachedRearHouseFavorUid then
				isFind = true

				break
			end
		end

		if not isFind then
			table.insert(self.rearHouseFavorInfo.favorUids, 1, self.cachedRearHouseFavorUid)
		end
	end

	local ui = UIManager.getUI("rearHouseVisitMainDlg", nil, false)

	if ui then
		ui:onFavorSuccess()
	end

	local chooseDlg = UIManager.getUI("rearHouseVisitChooseDlg", nil, false)

	if chooseDlg then
		chooseDlg:onFavorSuccess()
	end
end

function RearHouseMixin:isFavoredToday(_uid)
	if self.rearHouseFavorInfo then
		return self.rearHouseFavorInfo.favorToday[_uid] == true
	end

	return false
end

function RearHouseMixin:getVisitorInfo(...)
	if self.rearHouseVisitorInfo == nil or self.rearHouseVisitorInfo.tick + Const.REARHOUSE_VISIT_REFRESH_INTERVAL < Time.time then
		RPC.houseVisitHistoryGet()

		return
	end

	return self.rearHouseVisitorInfo
end

function RearHouseMixin:getFavorInfo()
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_YARD) then
		return
	end

	if self.rearHouseFavorInfo == nil or self.rearHouseFavorInfo.tick + Const.REARHOUSE_VISIT_REFRESH_INTERVAL < Time.time then
		RPC.houseFavorHistory()

		return
	end

	return self.rearHouseFavorInfo
end

function RearHouseMixin:isRHTodayCommentedByUid(uid)
	if self.rearHouseMyCommentInfo then
		for i, v in ipairs(self.rearHouseMyCommentInfo.commentData or {}) do
			if v.entry_id == uid then
				local timeTick = v.created

				if ClientUtils.isTickToday(timeTick) then
					return true
				end
			end
		end

		return false
	end

	return false
end

function RearHouseMixin:getMyRHCommentInfo(callBack)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_YARD) then
		return
	end

	if self.rearHouseMyCommentInfo == nil or self.rearHouseMyCommentInfo.tick + Const.REARHOUSE_COMMENT_REFRESH_INTERVAL < Time.time then
		self:GetRearHouseCommentNumHandler(self.uid)
		self:GetRearHouseCommentHandler(nil, nil, 20, nil, nil, nil, nil, nil, self.uid, callBack)

		return
	end

	return self.rearHouseMyCommentInfo
end

function RearHouseMixin:getRHCommentInfo(callBack)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_YARD) then
		return
	end

	if self.rearHouseCommentInfo == nil or self.rearHouseCommentInfo.tick + Const.REARHOUSE_COMMENT_REFRESH_INTERVAL < Time.time then
		self:GetRearHouseCommentHandler(self.uid, nil, 20, nil, nil, nil, nil, nil, nil, callBack)

		return
	end

	return self.rearHouseCommentInfo
end

function RearHouseMixin:getRearHouseCommentNum()
	return self.rearHouseMyCommentNum or 0
end

function RearHouseMixin:deleteRearHouseComment()
	if self.rearHouseCommentInfo and self.curDelCommentDataCache then
		for i, v in ipairs(self.rearHouseCommentInfo.commentData or {}) do
			if v.id == self.curDelCommentDataCache.commentId then
				table.remove(self.rearHouseCommentInfo.commentData, i)

				break
			end
		end

		self.curDelCommentDataCach = nil
	end
end

function RearHouseMixin:checkHouseVisitReq(uid, isHouseShareEnter)
	if self.rearHouseData.level <= 1 then
		MsgManager.notice(Lang.get(1898))

		return false
	end

	self.cachedRearHouseVisitData = nil
	self.cachedRearHouseVisitFavorNum = nil

	if uid == self.uid then
		if GameFsm.isInState(Const.STATE_MAIN_REAR_HOUSE) then
			RearHouseDragCenter.visit(nil, Const.REARHOUSE_CREATE_MODE.MINE)
			UIManager.getUI("rearHouseLoadingDlg", true)
		else
			if CurAvatar.rearHouseState.unlock_award == 0 then
				RPC.houseUnlockAwardGet()
			end

			GameFsm.translateState(Const.STATE_MAIN_REAR_HOUSE)
		end
	else
		local bIsHouseShareEnter = isHouseShareEnter or false

		RearHouseCommon.setIsHouseShareEnter(bIsHouseShareEnter)
		RPC.houseVisit(uid)
	end

	return true
end

Const.CRYSTAL_TYPE_HERO = 1
Const.CRYSTAL_TYPE_ARTIFACT = 2
Const.CRYSTAL_TYPE_RELIC = 3
Const.CRYSTAL_TYPE_SKIN = 4
Const.CRYSTAL_TYPE_FURNITURE = 5
Const.CRYSTAL_TYPE_HEADFRAME = 6

local ACHIEVE_CONFIG_DATA = {
	{
		"proficient",
		1,
		"_getCrystalAchieveHero"
	},
	{
		"artifact_bag",
		3,
		"_getCrystalAchieveArtifact"
	},
	{
		"bagRelics",
		2,
		"_getCrystalAchieveRelic"
	},
	{
		"hero_skin",
		3,
		"_getCrystalAchieveSkin"
	},
	{
		"furniture",
		3,
		"_getCrystalAchieveFurniture"
	},
	{
		"headFrameIds",
		2,
		"_getCrystalAchieveHead"
	}
}

function RearHouseMixin:initCrystalAchieveData(otherData, bagData)
	self.crystalLevelAchieve = ClientUtils.getBitsDictFromByteString(otherData.crystal.awards)
	self.crystalAchieveData = {}

	for cType, config in pairs(ACHIEVE_CONFIG_DATA) do
		local inputData

		if config[2] == 1 then
			inputData = otherData[config[1]]
		elseif config[2] == 3 then
			inputData = bagData[config[1]]
		else
			inputData = self[config[1]]
		end

		self.crystalAchieveData[cType] = self[config[3]](self, inputData)
	end

	self:checkCrystalAchiveNew()
	self:checkCrystalLevelAchiveNew()
end

function RearHouseMixin:_getCrystalAchieveHero(proficient)
	local achiData = {}

	for _, groupData in ipairs(proficient.group) do
		for _, oneItem in ipairs(groupData.item) do
			local key = oneItem.resid
			local progress = oneItem.score
			local award = ClientUtils.getBitsDictFromByteString(oneItem.collect_awarded)

			achiData[key] = {
				progress,
				award
			}
		end
	end

	for _, oneItem in ipairs(proficient.ur.item) do
		local key = oneItem.resid
		local progress = oneItem.score
		local award = ClientUtils.getBitsDictFromByteString(oneItem.collect_awarded)

		achiData[key] = {
			progress,
			award
		}
	end

	return achiData
end

function RearHouseMixin:_getCrystalAchieveArtifact(artifactBag)
	local achiData = {}

	for _, info in ipairs(artifactBag.artifact_achieve) do
		local key = info.resid
		local progress = info.max_level
		local award = ClientUtils.getBitsDictFromByteString(info.collect_award)

		achiData[key] = {
			progress,
			award
		}
	end

	return achiData
end

function RearHouseMixin:_getCrystalAchieveRelic(bagRelics)
	local achiData = {}

	for relicId, relic in pairs(bagRelics) do
		local key = relicId
		local progress = relic.enhanceLevel
		local award = ClientUtils.getBitsDictFromByteString(relic._serverData.collect_award)

		achiData[key] = {
			progress,
			award
		}
	end

	return achiData
end

function RearHouseMixin:_getCrystalAchieveSkin(heroSkin)
	local achiData = {}

	for idx, data in ipairs(heroSkin.data) do
		local heroId = data.id
		local award = ClientUtils.getBitsDictFromByteString(data.collect_award)

		for skinId, _ in pairs(ClientUtils.getBitsDictFromByteString(data.skin)) do
			if ResItemHeroSkin[heroId] and ResItemHeroSkin[heroId][skinId] and ResItemHeroSkin[heroId][skinId].itemId then
				local key = ResItemHeroSkin[heroId][skinId].itemId
				local progress = 1

				if award[skinId] then
					achiData[key] = {
						progress,
						{
							true
						}
					}
				else
					achiData[key] = {
						progress,
						{}
					}
				end
			end
		end
	end

	return achiData
end

function RearHouseMixin:_getCrystalAchieveFurniture(furniture)
	local achiData = {}

	for _, fInfo in pairs(furniture.furniture) do
		local key = fInfo.item_id
		local progress = 1
		local award = ClientUtils.getBitsDictFromByteString(fInfo.collect_award)

		achiData[key] = {
			progress,
			award
		}
	end

	return achiData
end

function RearHouseMixin:_getCrystalAchieveHead(headFrameIds)
	local achiData = {}

	for headId, headInfo in pairs(headFrameIds) do
		local key = headId
		local progress = 1
		local award = ClientUtils.getBitsDictFromByteString(headInfo.achiAward)

		achiData[key] = {
			progress,
			award
		}
	end

	return achiData
end

function RearHouseMixin:checkCrystalLevelAchiveNew()
	if self:isCrystalSecondPartNew() and Const.ENABLE_CRYSTAL_LEVEL_ACHIEVE then
		for index, aData in ipairs(ResHeroCrystalAchieve) do
			if aData.need_level <= self.crystalNewLevel and aData.award and not self.crystalLevelAchieve[index] then
				RedDotManager.setKeyState(UIConst.RD_HINT_REAR_HOUSE_LEVEL_ACHIEVE, true)

				return
			elseif aData.need_level > self.crystalNewLevel then
				break
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_REAR_HOUSE_LEVEL_ACHIEVE, false)
end

function RearHouseMixin:checkCrystalAchiveNew()
	RedDotManager.setKeyState(UIConst.RD_HINT_REAR_HOUSE_ACHIEVE, self:_checkCrystalAchiveNew())
	self:onRefreshCrystalSecondNew()
end

function RearHouseMixin:_checkCrystalAchiveNew()
	if self:isCrystalSecondPartNew() then
		for cType, cInfo in pairs(ResCrystalAchieve) do
			local typeInfo = self.crystalAchieveData[cType]

			if typeInfo then
				for key, allInfo in pairs(cInfo) do
					local keyInfo = typeInfo[key]

					if keyInfo then
						local nowProgress = keyInfo[1]
						local nowGot = keyInfo[2]

						for id, aData in pairs(allInfo) do
							if (not aData.valid_time_id or ClientUtils.isTimeConfigPassed(aData.valid_time_id)) and nowProgress >= aData.progress and not nowGot[id] then
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

function RearHouseMixin:getCrystalAchieveState(achData)
	local aType = achData.type
	local key = achData.item_id
	local id = achData.index
	local needProgress = achData.progress

	if self.crystalAchieveData[aType] and self.crystalAchieveData[aType][key] then
		if self.crystalAchieveData[aType][key][2][id] then
			return Const.ACT_ACHIEVE_STATE_GOT
		elseif needProgress <= self.crystalAchieveData[aType][key][1] then
			return Const.ACT_ACHIEVE_STATE_ENOUGH
		else
			return Const.ACT_ACHIEVE_STATE_NOT_ENOUGH
		end
	end

	return Const.ACT_ACHIEVE_STATE_NOT_ENOUGH
end

function RearHouseMixin:onCollectAchieveProgressNotify(type, item_id, process)
	if self.crystalAchieveData[type] then
		local oldValue = self.crystalAchieveData[type][item_id]

		if oldValue then
			self.crystalAchieveData[type][item_id] = {
				process,
				oldValue[2]
			}
		else
			self.crystalAchieveData[type][item_id] = {
				process,
				{}
			}
		end

		self:checkCrystalAchiveNew()
		self:onRefreshCrystalAchieveDlg()
	end
end

function RearHouseMixin:onRefreshCrystalAchieveDlg()
	local rearHouseCrystalAchieveDlg = UIManager.tryGetUI("rearHouseCrystalAchieveDlg")

	if rearHouseCrystalAchieveDlg then
		rearHouseCrystalAchieveDlg:onRefreshCrystalAchieveDlg()
	end
end

function RearHouseMixin:onCollectAchieveGetAwardResp(data)
	for _, info in ipairs(data) do
		if self.crystalAchieveData[info.type] and self.crystalAchieveData[info.type][info.item_id] then
			self.crystalAchieveData[info.type][info.item_id][2][info.index] = true
		end
	end

	self:checkCrystalAchiveNew()
	self:onRefreshCrystalAchieveDlg()
end

function RearHouseMixin:onCrystalMsgGetAwardResp(ids)
	local allIds = {}

	for _, id in ipairs(ids) do
		self.crystalLevelAchieve[id] = true
		allIds[id] = true
	end

	self:checkCrystalLevelAchiveNew()

	local heroCrystalAchieveDlg = UIManager.tryGetUI("heroCrystalAchieveDlg")

	if heroCrystalAchieveDlg then
		heroCrystalAchieveDlg:onCrystalMsgGetAwardResp(allIds)
	end

	local state = GameFsm.getState(Const.STATE_MAIN_REAR_HOUSE)

	if state.newLevelDlg then
		state.newLevelDlg:checkSecondNew()
	end
end

function RearHouseMixin:initCrystalHeroData()
	if self:isCrystalSecondPartNew() then
		for _, hero in pairs(self.heroDic) do
			hero:setCrystalStoryData(self.crystalNewLevel, self.heroStoryStateDic[hero.id])
		end
	end
end

function RearHouseMixin:changeCrystalHeroLevel()
	for _, hero in pairs(self.heroDic) do
		hero:setCrystalStoryData(self.crystalNewLevel)
	end
end

function RearHouseMixin:checkRearHousePopularityOpen()
	local check = Const.TEAM_PATCH_OPEN and not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_REARHOUSE_POPULARITY_AWARD)

	return check
end

function RearHouseMixin:refreshRearHouseRed()
	local check = false

	if self:checkRearHousePopularityOpen() then
		local achieveIdList = ResRearHouseMiscConfig[1].popularity_achieve_id_list

		for _, achieveId in pairs(achieveIdList) do
			local isQuality = CurAvatar.achieveQualify[achieveId]
			local isGot = CurAvatar.achieveAwardGot[achieveId]

			if isQuality and not isGot then
				check = true

				break
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_REAR_HOUSE_POPULARITY_AWARD, check)
end

function RearHouseMixin:onHouseMainRoomSetResp(room_id)
	self.mainRoom = room_id

	MsgManager.notice(string.format(Lang.get(96104), room_id))

	local ui = UIManager.getUI("rearHouseMainDlg", nil, false)

	if ui then
		ui:refreshUI()
	end
end

function RearHouseMixin:onHouseCommentSwitchSetResp(comment_switch)
	self.rearHouseCommentLimit = comment_switch
end

function RearHouseMixin:isLimitFriendComment()
	if self.rearHouseCommentLimit then
		return self.rearHouseCommentLimit == 1
	end

	return false
end

return RearHouseMixin
