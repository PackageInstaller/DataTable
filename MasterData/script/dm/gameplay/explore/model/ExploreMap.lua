-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/model/ExploreMap.lua

require("dm.gameplay.develop.model.team.Team")

EVT_EXPLORE_ADD_OBJ = "EVT_EXPLORE_ADD_OBJ"
EVT_EXPLORE_REMOVE_OBJ = "EVT_EXPLORE_REMOVE_OBJ"
ExploreMap = class("ExploreMap", objectlua.Object)

ExploreMap:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")
ExploreMap:has("_id", {
	is = "rw"
})
ExploreMap:has("_firstEnter", {
	is = "rb"
})
ExploreMap:has("_x", {
	is = "r"
})
ExploreMap:has("_y", {
	is = "r"
})
ExploreMap:has("_heroPath", {
	is = "rw"
})
ExploreMap:has("_lastTime", {
	is = "r"
})
ExploreMap:has("_mapTasks", {
	is = "r"
})
ExploreMap:has("_mapTaskCount", {
	is = "r"
})
ExploreMap:has("_dpTasks", {
	is = "r"
})
ExploreMap:has("_dp", {
	is = "r"
})
ExploreMap:has("_gotReward", {
	is = "r"
})
ExploreMap:has("_mapObjects", {
	is = "r"
})
ExploreMap:has("_joinObjects", {
	is = "r"
})
ExploreMap:has("_mechanismOpen", {
	is = "r"
})
ExploreMap:has("_lock", {
	is = "rw"
})
ExploreMap:has("_lockTip", {
	is = "rw"
})
ExploreMap:has("_mainTask", {
	is = "rw"
})
ExploreMap:has("_guideMap", {
	is = "r"
})
ExploreMap:has("_buff", {
	is = "rw"
})
ExploreMap:has("_mapObjProgress", {
	is = "rw"
})
ExploreMap:has("_mapType", {
	is = "rw"
})
ExploreMap:has("_mapObjMechanisms", {
	is = "rw"
})
ExploreMap:has("_mapObjMechanismOpen", {
	is = "rw"
})
ExploreMap:has("_teams", {
	is = "rw"
})
ExploreMap:has("_currentTeamId", {
	is = "rw"
})
ExploreMap:has("_maxProgress", {
	is = "r"
})
ExploreMap:has("_curAutoId", {
	is = "r"
})
ExploreMap:has("_face", {
	is = "r"
})
ExploreMap:has("_direction", {
	is = "r"
})

local MapTeamSpacing = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MapTeamSpacing", "content")
local kDirection = {
	kRight = "Right",
	kDown = "Down",
	kLeft = "Left",
	kUp = "Up"
}
local kHeroOffset = {
	[kDirection.kLeft] = {
		-MapTeamSpacing,
		0
	},
	[kDirection.kRight] = {
		MapTeamSpacing,
		0
	},
	[kDirection.kUp] = {
		0,
		MapTeamSpacing
	},
	[kDirection.kDown] = {
		0,
		-MapTeamSpacing
	}
}
local kHeroPath = {
	[kDirection.kLeft] = {
		x = 10,
		y = 0
	},
	[kDirection.kRight] = {
		x = -10,
		y = 0
	},
	[kDirection.kUp] = {
		x = 0,
		y = -10
	},
	[kDirection.kDown] = {
		x = 0,
		y = 10
	}
}

function ExploreMap:initialize(id)
	super.initialize(self)

	self._id = ""
	self._mapObjects = {}
	self._joinObjects = {}
	self._lock = true
	self._lockTip = ""
	self._mainTask = nil
	self._buff = {}
	self._mapObjProgress = {}
	self._mapObjMechanisms = {}
	self._mapObjMechanismOpen = false
	self._mapType = ""
	self._currentTeamId = 1
	self._teams = {}
	self._mapProgressCache = nil
	self._maxProgress = 0
	self._faceDirection = 0
end

function ExploreMap:initConfig()
	self._config = ConfigReader:requireRecordById("MapPoint", self._id)
	self._autoKey = "ExploreAutoKey" .. self._id

	self:initGuideMap()
	self:initTeams()
	self:initMainTask()
end

function ExploreMap:initGuideMap()
	self._guideMap = {}

	for i, v in pairs(self:getMapGuideDesc()) do
		self._guideMap[tonumber(i)] = {
			currentNum = 0,
			id = i,
			desc = Strings:get(v.Desc),
			targetNum = v.Value
		}
	end
end

function ExploreMap:initTeams()
	for i = 1, self:getTeamNum() do
		local teamId = tonumber(i)

		self._teams[i] = Team:new({
			teamId = teamId
		})
	end
end

function ExploreMap:initMainTask()
	local taskConfig = ConfigReader:getRecordById("Task", self:getMapMainTask())

	if taskConfig ~= nil and taskConfig.Id ~= nil then
		local task = {}
		local taskModel = TaskModel:new()

		task.taskId = self:getMapMainTask()

		taskModel:synchronizeModel(task)

		local conditionList = taskModel:getCondition()
		local taskValues = {}

		for i, condition in pairs(conditionList) do
			taskValues[tostring(i - 1)] = {}
			taskValues[tostring(i - 1)].currentValue = 0
			taskValues[tostring(i - 1)].targetValue = condition.factor1[1]
		end

		taskModel:updateTaskValue(taskValues)

		self._mainTask = taskModel
	end
end

function ExploreMap:synchronize(data)
	for i, v in pairs(data) do
		if i == "mapObjects" then
			for id, info in pairs(v) do
				local object = self._mapObjects[id]

				if not object then
					object = self:getInjector():instantiate("ExploreObject", info.configId, id)

					object:synchronize(info)
					self:dispatch(Event:new(EVT_EXPLORE_ADD_OBJ, {
						mapKey = self._id,
						object = object
					}))
				else
					object:synchronize(info)
				end

				self._mapObjects[id] = object
			end
		elseif i == "progressMap" then
			self:syncProgressMap(v)
		elseif i == "guideMap" then
			self:syncGuideMap(v)
		elseif i == "mapTasks" then
			self:syncMapTasks(v)
		elseif i == "effectList" then
			self:syncEffectLists(v)
		elseif i == "mechanisms" then
			self:syncMechanisms(v)
		elseif i == "team" then
			self:syncTeam(v)
		elseif i == "joinObjects" then
			self._joinObjects = {}

			for index, value in pairs(v) do
				index = index + 1
				self._joinObjects[index] = value
			end
		else
			self["_" .. i] = v

			if self._mechanismOpen ~= nil then
				self:setMechanismOpen(self._mechanismOpen)
			end
		end
	end
end

function ExploreMap:synchronizeDel(data)
	if data.mapObjects then
		for id, info in pairs(data.mapObjects) do
			if self._mapObjects[id] then
				self:dispatch(Event:new(EVT_EXPLORE_REMOVE_OBJ, {
					mapKey = self._id,
					object = self._mapObjects[id]
				}))

				self._mapObjects[id] = nil
			end
		end
	end

	if data.progressMap then
		for id, info in pairs(data.progressMap) do
			if self._mapObjProgress[id] then
				self._mapObjProgress[id] = nil
			end
		end

		self._mapProgressCache = nil
	end
end

function ExploreMap:dispatch(event)
	local eventDispatcher = self:getEventDispatcher()

	if eventDispatcher ~= nil then
		return eventDispatcher:dispatchEvent(event)
	end
end

function ExploreMap:syncMapTasks(data)
	if data[self:getMapMainTask()] then
		local task = data[self:getMapMainTask()]

		if self._mainTask then
			self._mainTask:updateModel(task)
		else
			local taskConfig = ConfigReader:getRecordById("Task", self:getMapMainTask())

			if taskConfig ~= nil and taskConfig.Id ~= nil then
				task.taskId = self:getMapMainTask()

				local taskModel = TaskModel:new()

				taskModel:synchronizeModel(task)

				self._mainTask = taskModel
			end
		end
	end
end

function ExploreMap:syncEffectLists(data)
	for i, v in pairs(data) do
		local style = {}

		style.fontName = TTF_FONT_FZYH_R
		style.fontSize = 18

		if not self._buff[i] then
			local info = {}
			local id = v.configId
			local level = v.level
			local attrConfig = ConfigReader:getRecordById("SkillAttrEffect", id)

			if attrConfig then
				info.id = id
				info.name = Strings:get(attrConfig.Name)
				info.icon = attrConfig.Icon
				info.time = "TODO"
				info.desc = SkillPrototype:getAttrEffectDesc(id, level, style)
			end

			local specialConfig = ConfigReader:getRecordById("SkillSpecialEffect", id)

			if specialConfig then
				info.id = id
				info.name = Strings:get(specialConfig.Name)
				info.icon = specialConfig.Icon
				info.time = "TODO"
				info.desc = self:getSpecialEffectDesc(id, level, style)
			end

			self._buff[i] = info
		elseif v.level then
			local id = self._buff[i].id
			local level = v.level
			local time = self._buff[i].time
			local desc = self._buff[i].desc
			local attrConfig = ConfigReader:getRecordById("SkillAttrEffect", id)

			if attrConfig then
				time = "TODO"
				desc = SkillPrototype:getAttrEffectDesc(id, level, style)
			end

			local specialConfig = ConfigReader:getRecordById("SkillSpecialEffect", id)

			if specialConfig then
				time = "TODO"
				desc = self:getSpecialEffectDesc(id, level, style)
			end

			self._buff[i].desc = desc
			self._buff[i].time = time
		end
	end
end

function ExploreMap:syncProgressMap(data)
	for id, value in pairs(data) do
		self._mapObjProgress[id] = self._mapObjProgress[id] or value

		for key, v in pairs(value) do
			self._mapObjProgress[id][key] = v
		end
	end

	self._mapProgressCache = nil
end

function ExploreMap:syncGuideMap(data)
	for i, value in pairs(data) do
		self._guideMap[tonumber(i)].currentNum = value
	end

	for i, v in ipairs(self._guideMap) do
		self._guideMap[i].state = v.currentNum == v.targetNum
	end
end

function ExploreMap:syncTeam(data)
	if data.currentTeamId then
		self._currentTeamId = tonumber(data.currentTeamId)
	end

	if data.subTeams then
		for id, teamData in pairs(data.subTeams) do
			local teamId = tonumber(id)

			if self._teams[teamId] then
				self._teams[teamId]:synchronize(teamData)
			end
		end
	end
end

function ExploreMap:syncMechanisms(data)
	for k, v in pairs(data) do
		if self._mapObjMechanisms[k] == nil then
			self._mapObjMechanisms[k] = ExploreZombieHero:new()
		end

		self._mapObjMechanisms[k]:synchronizeZombie(v)
	end
end

function ExploreMap:setMechanismOpen(state)
	self._mapObjMechanismOpen = state
end

function ExploreMap:getMechanism(index)
	index = index or 0

	if self._mapObjMechanisms[tostring(index)] then
		return self._mapObjMechanisms[tostring(index)]
	end

	return {}
end

function ExploreMap:getCurrentGuide()
	for i, v in ipairs(self._guideMap) do
		if not self._guideMap[i].state then
			return self._guideMap[i]
		end
	end

	return self._guideMap[#self._guideMap]
end

function ExploreMap:getMapObjProgress()
	if self._mapProgressCache then
		return self._mapProgressCache
	end

	local totalProgress = {
		0,
		0
	}
	local progress = {}

	for i, v in pairs(self._mapObjProgress) do
		local id = v.configId
		local config = ConfigReader:requireRecordById("MapObject", id)
		local status = v.status
		local rateData = config.ExploreRate
		local type1 = rateData.Type1
		local type2 = rateData.Type2
		local rate = rateData.ExploreValue

		progress[type1] = progress[type1] or {
			progress = {
				0,
				0
			},
			items = {}
		}
		progress[type1].items[type2] = progress[type1].items[type2] or {
			targetNum = 0,
			status = false,
			currencyNum = 0,
			id = type2
		}
		progress[type1].progress[2] = progress[type1].progress[2] + 1
		progress[type1].items[type2].targetNum = progress[type1].items[type2].targetNum + 1
		progress[type1].items[type2].status = status
		totalProgress[2] = totalProgress[2] + rate

		if status == 2 then
			totalProgress[1] = totalProgress[1] + rate
			progress[type1].progress[1] = progress[type1].progress[1] + 1
			progress[type1].items[type2].currencyNum = progress[type1].items[type2].currencyNum + 1
		end
	end

	local pro = {}

	for type1, value in pairs(progress) do
		value.id = type1

		local itemsPro = {}
		local items = value.items

		for type2, item in pairs(items) do
			itemsPro[#itemsPro + 1] = item
		end

		table.sort(itemsPro, function(a, b)
			if a.status == b.status then
				return a.id < b.id
			end

			return a.status < b.status
		end)

		value.items = itemsPro
		pro[#pro + 1] = value
	end

	table.sort(pro, function(a, b)
		return a.id < b.id
	end)

	self._mapProgressCache = {
		pro,
		totalProgress
	}

	return self._mapProgressCache
end

function ExploreMap:getName()
	return Strings:get(self._config.Name)
end

function ExploreMap:getDesc()
	return Strings:get(self._config.Desc)
end

function ExploreMap:getPosition()
	return self._config.Position
end

function ExploreMap:getImg()
	return "asset/ui/explore/explorePointIcon/" .. self._config.Img .. ".png"
end

function ExploreMap:getMapMainTask()
	return self._config.MapMainTask
end

function ExploreMap:getShowReward()
	return self._config.ShowReward
end

function ExploreMap:getHeroEffect()
	return self._config.HeroEffect or {}
end

function ExploreMap:getHeroSpecialEffect()
	return self._config.HeroSpecialEffect or {}
end

function ExploreMap:getUnlockCondition()
	return self._config.UnlockCondition
end

function ExploreMap:getOpenType()
	return self._config.OpenType
end

function ExploreMap:getMapResource()
	return self._config.MapResource
end

function ExploreMap:getMapBlock()
	return self._config.MapBlock
end

function ExploreMap:getPlayerPos()
	return self._config.PlayerPos
end

function ExploreMap:getDPTask()
	return self._config.DPTask
end

function ExploreMap:getBGM()
	return self._config.BGM
end

function ExploreMap:getBGMAisac()
	return self._config.BGMAisac
end

function ExploreMap:getBGMAction()
	return self._config.BGMAction
end

function ExploreMap:getMapGuideDesc()
	return self._config.MapGuideDesc or {}
end

function ExploreMap:getObject()
	return self._config.Object
end

function ExploreMap:get()
	return self._config.RandomObject
end

function ExploreMap:getMatchFactor()
	return self._config.MatchFactor
end

function ExploreMap:getStrategyDesc()
	return self._config.StrategyDesc
end

function ExploreMap:getRecommendLv()
	return self._config.RecommendLv
end

function ExploreMap:getPointHead()
	return self._config.PointHead
end

function ExploreMap:getMapPic()
	return self._config.MapPic
end

function ExploreMap:getMapPicAction()
	return self._config.MapPicAction or {}
end

function ExploreMap:getTeamNum()
	return self._config.TeamNum or 0
end

function ExploreMap:getMapGuideReward()
	return self._config.MapGuideReward or {}
end

function ExploreMap:getNeedPower()
	return self._config.NeedPower
end

function ExploreMap:getMapAuto()
	return self._config.MapAuto
end

function ExploreMap:getWeekRecommend()
	return self._config.WeekRecommend
end

function ExploreMap:getUnlockAuto()
	return self._config.UnlockAuto
end

function ExploreMap:getDailyRewardShow()
	return self._config.DailyRewardShow
end

function ExploreMap:getFirstRewardPosition()
	return self._config.FirstRewardPosition
end

function ExploreMap:setAutoState(auto)
	cc.UserDefault:getInstance():setBoolForKey(self._autoKey, auto)
end

function ExploreMap:getAutoState()
	return cc.UserDefault:getInstance():getBoolForKey(self._autoKey)
end

function ExploreMap:getEffectHeroIds()
	local ids = {}

	for id, _ in pairs(self:getHeroEffect()) do
		ids[#ids + 1] = id
	end

	for id, _ in pairs(self:getHeroSpecialEffect()) do
		if not self:checkIsHas(ids, id) then
			ids[#ids + 1] = id
		end
	end

	return ids
end

function ExploreMap:checkIsHas(ids, id)
	for i = 1, #ids do
		if ids[i] == id then
			return true
		end
	end

	return false
end

function ExploreMap:isRoleTurn()
	return self._face == kDirection.kLeft
end

function ExploreMap:getHeroOffset()
	return kHeroOffset[self._direction]
end

function ExploreMap:getHeroDefaultPath()
	return kHeroPath[self._direction]
end

function ExploreMap:getEffectsById(heroId)
	local effectId = {}
	local spEffectId = {}

	if self:getHeroEffect() then
		for id, value in pairs(self:getHeroEffect()) do
			if id == heroId then
				effectId[#effectId + 1] = value
			end
		end
	end

	if self:getHeroSpecialEffect() then
		for id, value in pairs(self:getHeroSpecialEffect()) do
			if id == heroId then
				spEffectId[#spEffectId + 1] = value
			end
		end
	end

	return effectId, spEffectId
end

function ExploreMap:getEffectDescById(heroId, level, style)
	style = style or {}
	style.fontName = style.fontName or TTF_FONT_FZYH_R
	style.fontSize = style.fontSize or 18

	local effectIds, spEffectIds = self:getEffectsById(heroId)
	local descs = self:getEffectDescs(effectIds, spEffectIds, level, style)
	local str = ""

	for i = 1, #descs do
		str = str .. descs[i]

		if i ~= #descs then
			str = str .. Strings:get("EXPLORE_UI21", {
				fontName = TTF_FONT_FZYH_R
			})
		end
	end

	return str
end

function ExploreMap:getEffectDescs(effectIds, specialEffectIds, level, style)
	local subDescs = {}

	if effectIds then
		for i = 1, #effectIds do
			subDescs[#subDescs + 1] = SkillPrototype:getAttrEffectDesc(effectIds[i], level, style)
		end
	end

	if specialEffectIds then
		for i = 1, #specialEffectIds do
			subDescs[#subDescs + 1] = self:getSpecialEffectDesc(specialEffectIds[i], level, style)
		end
	end

	return subDescs
end

function ExploreMap:getSpecialEffectDesc(effectId, level, style)
	style = style or {}
	style.fontName = style.fontName or TTF_FONT_FZYH_R
	style.fontSize = style.fontSize or 18

	local effectConfig = ConfigReader:getRecordById("SkillSpecialEffect", effectId)
	local Parameter = effectConfig.Parameter
	local attrNum = 0

	for key, value in pairs(Parameter) do
		if type(value) == "string" then
			style[key] = Strings:get(SpecialEffectDesId[value])

			break
		end
	end

	if effectConfig then
		attrNum = SpecialEffectFormula:getAddNumByConfig(effectConfig, 1, level)
		attrNum = SpecialEffectFormula:changeAddNumForShow(effectConfig, 0, attrNum)
	end

	attrNum = "<font face='asset/font/CustomFont_FZYH_R.TTF' size='18' color='#AAF014'>" .. attrNum .. "</font>"

	local desc = Strings:get(effectConfig.Desc, style) .. attrNum
	local t = TextTemplate:new(desc)

	return t:stringify(effectConfig, SkillPrototype:getEffectDescFactorFunc(level))
end
