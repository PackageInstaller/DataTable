-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/SystemKeeper.lua

SystemKeeper = class("SystemKeeper", legs.Actor)
UnlockAnimView = {
	kHome = "HOME",
	kStage = "STAGE"
}

function SystemKeeper:initialize()
	super.initialize(self)

	self._configNote = {}
	self._levelUnlockCache = {}
	self._blockUnlockCache = {}

	self:_readConfig()
end

function SystemKeeper:isUnlock(sysName, info)
	if sysName == nil then
		return true
	end

	local config = ConfigReader:getRecordById("UnlockSystem", sysName)

	if config == nil then
		return true
	end

	local condition = config.Condition

	if condition.LEVEL then
		if not condition.LEVEL then
			local unLockLevel = 0
			local isOpen, blockStr
			local storyInfoTab = {}

			if condition.STAGE then
				if info then
					if not info.pointId then
						local pointId = condition.STAGE
						local openState, str = self:checkStagePointLock(pointId, info)

						blockStr = str
						isOpen = openState
					end
				end
			elseif condition.STORY then
				if info then
					if not info.pointId then
						local pointId = condition.STORY
						local openState, _tab = self:checkStoryPointLock(pointId, info)

						storyInfoTab = _tab
						isOpen = openState
					end
				end
			else
				isOpen = self:isConditionReached(condition, info)
			end

			local lockTip

			return isOpen, Strings:get(config.Tip, {
				uLevel = condition.LEVEL,
				Stage = blockStr,
				num = storyInfoTab.mapIndex,
				Name = storyInfoTab.pointName,
				uClubLevel = condition.CLUBLEVEL,
				serverDay = condition.SERVER,
				leaderNum = condition.LEADER
			}), unLockLevel
		end
	end
end

function SystemKeeper:isUnlockByCondition(condition, info)
	if condition.LEVEL then
		if not condition.LEVEL then
			local unLockLevel = 0
			local isOpen, blockStr
			local storyInfoTab = {}

			if condition.STAGE then
				if info then
					if not info.pointId then
						local pointId = condition.STAGE
						local openState, str = self:checkStagePointLock(pointId, info)

						blockStr = str
						isOpen = openState
					end
				end
			elseif condition.ELITESTAGE then
				if info then
					if not info.pointId then
						local pointId = condition.ELITESTAGE
						local openState, str = self:checkStagePointLock(pointId, info)

						blockStr = str
						isOpen = openState
					end
				end
			elseif condition.STORY then
				if info then
					if not info.pointId then
						local pointId = condition.STORY
						local openState, _tab = self:checkStoryPointLock(pointId, info)

						storyInfoTab = _tab
						isOpen = openState
					end
				end
			else
				isOpen = self:isConditionReached(condition, info)
			end

			local tip = ""

			if condition.STAGE then
				tip = "Unlock_Shop_Stage_Tips"
			elseif condition.ELITESTAGE then
				tip = "Unlock_Shop_Stage_Tips"
			elseif condition.STORY then
				tip = "Unlock_Story_Tips"
			elseif condition.LEVEL then
				tip = "Unlock_Shop_Level_Tips"
			elseif condition.VIP then
				-- block empty
			elseif condition.CLUBLEVEL then
				-- block empty
			end

			local lockTip

			return isOpen, Strings:get(tip, {
				uLevel = condition.LEVEL,
				Stage = blockStr,
				num = storyInfoTab.mapIndex,
				Name = storyInfoTab.pointName,
				serverDay = condition.SERVER
			}), unLockLevel
		end
	end
end

function SystemKeeper:isConditionReached(condition, info)
	local isOpen = true

	if condition.STAGE then
		if info then
			if not info.pointId then
				do
					local pointId = condition.STAGE
					local openState, str = self:checkStagePointLock(pointId, info)

					isOpen = openState
				end

				if condition.LEVEL then
					local player = self:getInjector():getInstance(DevelopSystem):getPlayer()

					if info then
						if not info.level then
							local level = player:getLevel()

							if level < condition.LEVEL then
								isOpen = false
							end
						end
					end
				end

				if condition.VIP then
					local player = self:getInjector():getInstance(DevelopSystem):getPlayer()

					if info then
						if not info.vipLevel then
							local level = player:getVipLevel()

							if level < condition.VIP then
								isOpen = false
							end
						end
					end
				end

				if condition.CLUBLEVEL then
					local clubSystem = self:getInjector():getInstance(ClubSystem)
					local clubInfo = clubSystem:getClubInfoOj()

					if info then
						if not info.clubLevel then
							local level = clubInfo:getLevel()

							if level < condition.CLUBLEVEL then
								isOpen = false
							end
						end
					end
				end

				if condition.STORY then
					if info then
						if not info.pointId then
							do
								local pointId = condition.STORY

								isOpen = self:checkStoryPointLock(pointId)
							end

							if condition.SERVER then
								local developSystem = self:getInjector():getInstance(DevelopSystem)
								local openServerDay = developSystem:getServerOpenDay()

								if openServerDay < condition.SERVER then
									isOpen = false
								end
							end

							if condition.LEADER then
								local player = self:getInjector():getInstance(DevelopSystem):getPlayer()
								local masters = player:getMasterList():getAllMaster()

								if table.nums(masters) < condition.LEADER then
									isOpen = false
								end
							end
						end
					end
				end
			end
		end
	end

	return isOpen
end

local stageTypeStr = {
	NORMAL = Strings:get("Stage_Main"),
	ELITE = Strings:get("Stage_Elite")
}

function SystemKeeper:checkStagePointLock(pointId, info)
	local isOpen = true
	local blockStr = ""
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local pointCfg = ConfigReader:getRecordById("BlockPoint", pointId)

	if pointCfg then
		local stageType = pointCfg.Type
		local stage = stageSystem:getStage(stageType)

		if stage then
			local mapId = pointCfg.Map
			local map = stage:getMapById(mapId)

			if map then
				local point = map:getPointById(pointId)

				if point then
					if not point:isPass() then
						isOpen = false
					end

					blockStr = stageTypeStr[stageType] .. map:getIndex() .. "-" .. point:getIndex()

					if info and info.hidePointName == false then
						blockStr = stageTypeStr[stageType] .. map:getIndex() .. "-" .. point:getIndex()
					end
				end
			end
		end
	end

	return isOpen, blockStr
end

local storyTypeStr = {
	NORMAL = Strings:get("Common_Story"),
	ELITE = Strings:get("Elite_Story")
}

function SystemKeeper:checkStoryPointLock(pointId)
	local isOpen = true
	local tab = {}
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local point = stageSystem:getPointById(pointId)

	if point and point:isPass() then
		isOpen = true
	else
		isOpen = false

		local map = point:getOwner()

		tab.mapIndex = map:getIndex()
		tab.pointName = point:getName()
	end

	return isOpen, tab
end

function SystemKeeper:canShow(sysName, info)
	if not sysName then
		return false
	end

	local config = ConfigReader:getRecordById("UnlockSystem", sysName)

	if not config then
		return false
	end

	local condition = config.ShowCondition

	return self:isConditionReached(condition, info)
end

function SystemKeeper:getUnlockSystemsByLevel(level)
	if level then
		return self._levelUnlockCache[level]
	end
end

function SystemKeeper:_readConfig()
	local keyList = ConfigReader:getKeysOfTable("UnlockSystem")

	for _, key in pairs(keyList) do
		if key ~= "$" then
			local config = ConfigReader:getRecordById("UnlockSystem", key)

			self._configNote[key] = config

			local condition = config.Condition

			if not config.IsPlay then
				if condition and tonumber(config.IsPlay) == 1 then
					if condition.LEVEL then
						local level = condition.LEVEL

						self._levelUnlockCache[level] = self._levelUnlockCache[level] or {}

						local configArr = self._levelUnlockCache[level]

						configArr[#configArr + 1] = config
					elseif condition.STAGE then
						local block = condition.STAGE

						self._blockUnlockCache[block] = self._blockUnlockCache[block] or {}

						local configArr = self._blockUnlockCache[block]

						configArr[#configArr + 1] = config
					end
				end
			end
		end
	end
end

function SystemKeeper:getUnlockSystemsAboutStage(stage)
	if stage then
		return self._blockUnlockCache[stage]
	end
end

function SystemKeeper:clearCacheSystem(type)
	if self._systemCache[type] then
		if #self._systemCache[type] == 1 then
			self._systemCache[type] = nil

			return
		end

		local cache = {}

		table.deepcopy(self._systemCache[type], cache)

		self._systemCache[type] = {}

		for i = 2, #cache do
			self._systemCache[type][#self._systemCache[type] + 1] = cache[i]
		end
	end
end

function SystemKeeper:getUnlockSystemsByType(type)
	if not self._systemCache then
		return
	end

	return self._systemCache[type]
end

function SystemKeeper:cacheLevelAndStage()
	for k, value in pairs(UnlockAnimView) do
		local type = value

		self._levelCache = self._levelCache or {}

		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local curLevel = developSystem:getPlayer():getLevel()
		local stageSystem = self:getInjector():getInstance(StageSystem)

		self._levelCache[type] = self._levelCache[type] or {}
		self._levelCache[type].level = curLevel
		self._levelCache[type].pointId = stageSystem:getLastPassStagePointId(StageType.kNormal)
	end
end

function SystemKeeper:backupUnlockSystem()
	if not self._levelCache then
		self:cacheLevelAndStage()
	end

	for k, value in pairs(UnlockAnimView) do
		local type = value

		if not self._levelCache[type] then
			self._systemCache = self._systemCache or {}

			local developSystem = self:getInjector():getInstance(DevelopSystem)
			local curLevel = developSystem:getPlayer():getLevel()

			if curLevel ~= self._levelCache[type].level then
				for i = self._levelCache[type].level + 1, curLevel do
					local data = self:getUnlockSystemsByLevel(i)

					if data then
						for _, value in pairs(data) do
							if value.UnlockAnima == type then
								self._systemCache[type] = self._systemCache[type] or {}
								self._systemCache[type][#self._systemCache[type] + 1] = value
							end
						end
					end
				end
			end

			local stageSystem = self:getInjector():getInstance(StageSystem)
			local pointId = stageSystem:getLastPassStagePointId(StageType.kNormal)

			if pointId and pointId ~= self._levelCache[type].pointId then
				local data = self:getUnlockSystemsAboutStage(pointId)

				if data then
					for _, value in pairs(data) do
						if value.UnlockAnima == type then
							self._systemCache[type] = self._systemCache[type] or {}
							self._systemCache[type][#self._systemCache[type] + 1] = value
						end
					end
				end
			end
		end
	end

	self:cacheLevelAndStage()
end

function SystemKeeper:getResourceBannerIds(type)
	return (ConfigReader:requireDataByNameIdAndKey("UnlockSystem", type, "ResourcesBanner"))
end

function SystemKeeper:getUnlockLevel(sysName)
	if sysName == nil then
		return 0
	end

	local config = ConfigReader:getRecordById("UnlockSystem", sysName)

	if config == nil then
		return 0
	end

	local condition = config.Condition

	if condition.LEVEL then
		return condition.LEVEL
	end

	return 0
end

function SystemKeeper:getBattleSpeedOpen(name)
	local battleSpeed_Availible = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Availible", "content") or {}

	if name then
		for k, v in pairs(battleSpeed_Availible) do
			if v == name then
				return true
			end
		end
	end

	return false
end
