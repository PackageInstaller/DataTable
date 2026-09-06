-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessdelicacy/config/GoddessDelicacyConfig.lua

module("logic.extensions.goddessdelicacy.config.GoddessDelicacyConfig", package.seeall)

local GoddessDelicacyConfig = class("GoddessDelicacyConfig", BaseConfig)

function GoddessDelicacyConfig:onInit()
	GoddessDelicacyConfig.super.onInit(self)

	self._activityCfgs = nil
	self._notesFoodCfgs = nil
	self._notesDishCfgs = nil
	self._notesProgCfgs = nil
end

function GoddessDelicacyConfig:getNames()
	return {
		"food_notes_activity",
		"food_notes_food",
		"food_notes_dish",
		"food_notes_progress_prize",
		"food_notes_common"
	}
end

function GoddessDelicacyConfig:handleConfig(name, content)
	if name == "food_notes_activity" then
		self._activityCfgs = content
	elseif name == "food_notes_food" then
		self._notesFoodCfgs = content
	elseif name == "food_notes_dish" then
		self._notesDishCfgs = content
	elseif name == "food_notes_progress_prize" then
		self._notesProgCfgs = content
	elseif name == "food_notes_common" then
		self._food_notes_common = content
	end
end

function GoddessDelicacyConfig:getGoddessActivityCfg(actId)
	if checknumber(actId) <= 0 or self._activityCfgs == nil then
		return nil
	end

	return self._activityCfgs[actId]
end

function GoddessDelicacyConfig:getNotesFoodCfg(actId, foodId)
	if checknumber(actId) < 1 or self._notesFoodCfgs == nil then
		return nil
	end

	local list = self._notesFoodCfgs[actId]

	if list == nil or list[foodId] == nil then
		return nil
	end

	return list[foodId]
end

function GoddessDelicacyConfig:getNotesDishAllCfgs(actId)
	if checknumber(actId) < 1 or self._notesDishCfgs == nil then
		return nil
	end

	return self._notesDishCfgs[actId]
end

function GoddessDelicacyConfig:getNotesDishCfg(actId, dishId)
	local list = self:getNotesDishAllCfgs(actId)

	if list == nil or list[dishId] == nil then
		return nil
	end

	return list[dishId]
end

function GoddessDelicacyConfig:getNotesProgressCfg(actId)
	if checknumber(actId) <= 0 or self._notesProgCfgs == nil then
		return nil
	end

	return self._notesProgCfgs[actId]
end

function GoddessDelicacyConfig:getOpenActivityId()
	if self._activityCfgs == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.GoddessDelicacy)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item.activityId
		end
	end

	return -3
end

function GoddessDelicacyConfig:getCommonValue(key, isToNumber)
	local str = ""

	if self._food_notes_common and self._food_notes_common[key] then
		str = self._food_notes_common[key].value
	end

	if isToNumber then
		str = checknumber(str)
	end

	return str
end

GoddessDelicacyConfig.instance = GoddessDelicacyConfig.New()

return GoddessDelicacyConfig
