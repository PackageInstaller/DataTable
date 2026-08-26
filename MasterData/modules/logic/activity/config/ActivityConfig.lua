-- chunkname: @modules/logic/activity/config/ActivityConfig.lua

module("modules.logic.activity.config.ActivityConfig", package.seeall)

local ActivityConfig = class("ActivityConfig", BaseConfig)

function ActivityConfig:ctor()
	self._activityConfig = nil
	self._activityCenterConfig = nil
	self._norSignConfig = nil
	self._activityDungeonConfig = nil
	self._activityShowConfig = nil
	self.chapterId2ActId = {}
end

function ActivityConfig:reqConfigNames()
	return {
		"activity",
		"activity_center",
		"activity101",
		"activity_dungeon",
		"activity_show",
		"main_act_extra_display",
		"main_act_atmosphere",
		"activity_const",
		"activity_decoration"
	}
end

function ActivityConfig:onConfigLoaded(configName, configTable)
	if configName == "activity" then
		self:__init_activity(configTable)
	elseif configName == "activity_center" then
		self._activityCenterConfig = configTable
	elseif configName == "activity101" then
		self._norSignConfig = configTable
	elseif configName == "activity_dungeon" then
		self._activityDungeonConfig = configTable

		self:initActivityDungeon()
	elseif configName == "activity_show" then
		self._activityShowConfig = configTable
	elseif configName == "main_act_extra_display" then
		self:_initMainActExtraDisplay()
	elseif configName == "main_act_atmosphere" then
		self:_initMainActAtmosphere()
	end
end

local function _constCO(id)
	return lua_activity_const.configDict[id]
end

function ActivityConfig:_initMainActAtmosphere()
	local len = #lua_main_act_atmosphere.configList

	self._mainActAtmosphereConfig = lua_main_act_atmosphere.configList[len]
end

function ActivityConfig:getMainActAtmosphereConfig()
	return self._mainActAtmosphereConfig
end

function ActivityConfig:_initMainActExtraDisplay()
	self._mainActExtraDisplayList = {}

	for i, v in ipairs(lua_main_act_extra_display.configList) do
		if v.show == 1 then
			table.insert(self._mainActExtraDisplayList, v)
		end
	end

	table.sort(self._mainActExtraDisplayList, function(a, b)
		if a.sortId == b.sortId then
			return a.id < b.id
		end

		return a.sortId < b.sortId
	end)

	if not self._activityConfig then
		logError("ActivityConfig:_initMainActExtraDisplay activityConfig is nil")

		return
	end

	self._seasonActivityConfig = nil
	self._rougeActivityConfig = nil
	self._displayBindActivityList = {}

	local num = #lua_activity.configList

	for i = num, 1, -1 do
		local activityConfig = lua_activity.configList[i]

		if activityConfig.extraDisplayId > 0 and not self._displayBindActivityList[activityConfig.extraDisplayId] then
			self._displayBindActivityList[activityConfig.extraDisplayId] = activityConfig
		end
	end

	self._seasonActivityConfig = self._displayBindActivityList[ActivityEnum.MainViewActivityState.SeasonActivity]
	self._rougeActivityConfig = self._displayBindActivityList[ActivityEnum.MainViewActivityState.Rouge]

	if not self._seasonActivityConfig then
		logWarn("ActivityConfig:_initMainActExtraDisplay seasonActivityConfig is nil")

		return
	end

	if not self._rougeActivityConfig then
		logWarn("ActivityConfig:_initMainActExtraDisplay rougeActivityConfig is nil")

		return
	end
end

function ActivityConfig:getActivityByExtraDisplayId(extraDisplayId)
	return extraDisplayId and self._displayBindActivityList[extraDisplayId]
end

function ActivityConfig:getSesonActivityConfig()
	return self._seasonActivityConfig
end

function ActivityConfig:getRougeActivityConfig()
	return self._rougeActivityConfig
end

function ActivityConfig:getMainActExtraDisplayList()
	return self._mainActExtraDisplayList
end

function ActivityConfig:getActivityCo(id)
	if not self._activityConfig.configDict[id] then
		logError("前端活动配置表不存在活动:" .. tostring(id))
	end

	return self._activityConfig.configDict[id]
end

function ActivityConfig:getActivityCenterCo(id)
	if not self._activityCenterConfig.configDict[id] then
		logError("前端活动配置表不存在活动中心:" .. tostring(id))
	end

	return self._activityCenterConfig.configDict[id]
end

function ActivityConfig:getNorSignActivityCo(actId, day)
	return self._norSignConfig.configDict[actId][day]
end

function ActivityConfig:getNorSignActivityCos(actId)
	return self._norSignConfig.configDict[actId]
end

function ActivityConfig:initActivityDungeon()
	for _, activityDungeonCo in ipairs(self._activityDungeonConfig.configList) do
		self:addChapterId2ActId(activityDungeonCo.story1ChapterId, activityDungeonCo.id)
		self:addChapterId2ActId(activityDungeonCo.story2ChapterId, activityDungeonCo.id)
		self:addChapterId2ActId(activityDungeonCo.story3ChapterId, activityDungeonCo.id)
		self:addChapterId2ActId(activityDungeonCo.hardChapterId, activityDungeonCo.id)
	end
end

function ActivityConfig:addChapterId2ActId(chapterId, actId)
	if chapterId == 0 then
		return
	end

	if self.chapterId2ActId[chapterId] then
		logError(string.format("chapterId : %s multiple, exist actId : %s, current actId : %s", chapterId, self.chapterId2ActId[chapterId], actId))

		return
	end

	self.chapterId2ActId[chapterId] = actId
end

function ActivityConfig:getActIdByChapterId(chapterId)
	return self.chapterId2ActId[chapterId]
end

function ActivityConfig:getActivityDungeonConfig(actId)
	return self._activityDungeonConfig.configDict[actId]
end

function ActivityConfig:getChapterIdMode(chapterId)
	local actId = self:getActIdByChapterId(chapterId)

	if not actId then
		return VersionActivityDungeonBaseEnum.DungeonMode.None
	end

	local co = self:getActivityDungeonConfig(actId)

	if chapterId == co.story1ChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Story
	elseif chapterId == co.story2ChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Story2
	elseif chapterId == co.story3ChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Story3
	elseif chapterId == co.hardChapterId then
		return VersionActivityDungeonBaseEnum.DungeonMode.Hard
	else
		return VersionActivityDungeonBaseEnum.DungeonMode.None
	end
end

function ActivityConfig:getActivityShowTaskList(actId, taskId)
	return self._activityShowConfig.configDict[actId][taskId]
end

function ActivityConfig:getActivityShowTaskCount(actId)
	return self._activityShowConfig.configDict[actId]
end

function ActivityConfig:getActivityTabBgPathes(actId)
	local actCfg = self:getActivityCo(actId)
	local bgPathArrStr = actCfg.tabBgPath

	return (string.split(bgPathArrStr, "#"))
end

function ActivityConfig:getActivityTabButtonState(actId)
	local actCfg = self:getActivityCo(actId)
	local btnStateArrStr = actCfg.tabButton
	local btnStateArr = string.splitToNumber(btnStateArrStr, "#")
	local replayBtn = btnStateArr and btnStateArr[1] == 1
	local achivermentBtn = btnStateArr and btnStateArr[2] == 1
	local tabRemainTime = btnStateArr and btnStateArr[3] == 1

	return replayBtn, achivermentBtn, tabRemainTime
end

function ActivityConfig:getActivityEnterViewBgm(actId)
	local actCfg = self:getActivityCo(actId)

	return actCfg.tabBgmId
end

function ActivityConfig:isPermanent(actId)
	local actCfg = self:getActivityCo(actId)

	return actCfg.isRetroAcitivity == ActivityEnum.RetroType.Permanent
end

function ActivityConfig:getPermanentChildActList(actId)
	local result = {}

	if not self._belongPermanentActDict then
		self:_initBelongPermanentActDict()
	end

	result = self._belongPermanentActDict[actId] or result

	return result
end

function ActivityConfig:_initBelongPermanentActDict()
	self._belongPermanentActDict = {}

	for actId, cfg in pairs(self._activityConfig.configDict) do
		if self:isPermanent(actId) then
			local belongActId = cfg.permanentParentAcitivityId

			if belongActId ~= 0 then
				local dict = self._belongPermanentActDict[belongActId]

				if not dict then
					dict = {}
					self._belongPermanentActDict[belongActId] = dict
				end

				table.insert(dict, actId)
			end
		end
	end
end

function ActivityConfig:getActivityRedDotId(actId)
	local CO = self:getActivityCo(actId)

	return (CO or nil) and (CO.redDotId or 0)
end

function ActivityConfig:getActivityCenterRedDotId(actCenterId)
	local CO = self:getActivityCenterCo(actCenterId)

	return (CO or nil) and (CO.reddotid or 0)
end

function ActivityConfig:__init_activity(configTable)
	self._activityConfig = configTable
	self._typeId2ActivityCOList = {}

	for _, CO in ipairs(configTable.configList) do
		local typeId = CO.typeId

		self._typeId2ActivityCOList[typeId] = self._typeId2ActivityCOList[typeId] or {}

		table.insert(self._typeId2ActivityCOList[typeId], CO)
	end

	for _, COList in pairs(self._typeId2ActivityCOList) do
		table.sort(COList, function(a, b)
			return a.id > b.id
		end)
	end
end

function ActivityConfig:typeId2ActivityCOList(typeId)
	if not typeId then
		return {}
	end

	return self._typeId2ActivityCOList[typeId] or {}
end

function ActivityConfig:getConstAsNum(id, fallback)
	local CO = _constCO(id)

	if not CO then
		return fallback
	end

	return tonumber(CO.strValue) or fallback
end

function ActivityConfig:getConstAsNumList(id, delimiter, fallback)
	delimiter = delimiter or "#"

	local CO = _constCO(id)

	if not CO then
		return fallback
	end

	local strValue = CO.strValue

	if string.nilorempty(strValue) then
		return fallback
	end

	local numList = string.splitToNumber(strValue, delimiter)

	return numList or fallback
end

function ActivityConfig:isActIdInList(actId, actIdList)
	if not actIdList then
		return false
	end

	for _, id in ipairs(actIdList) do
		if id == actId then
			return true
		end
	end

	return false
end

ActivityConfig.instance = ActivityConfig.New()

return ActivityConfig
