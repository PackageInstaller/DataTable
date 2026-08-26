-- chunkname: @modules/logic/activity/controller/Act101VersionSummonController.lua

module("modules.logic.activity.controller.Act101VersionSummonController", package.seeall)

local Act101VersionSummonController = class("Act101VersionSummonController", BaseController)

function Act101VersionSummonController:onInit()
	self:reInit()
end

function Act101VersionSummonController:reInit()
	self:markDirty()
end

function Act101VersionSummonController:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self, LuaEventSystem.High)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self, LuaEventSystem.Low)
end

function Act101VersionSummonController:_onDailyRefresh()
	self:markDirty()
end

function Act101VersionSummonController:_onRefreshActivityState()
	MainController.instance:dispatchEvent(MainEvent.OnRefreshSummonTuziRed)
end

function Act101VersionSummonController:actId()
	local actIdList = ActivityType101Config.instance:getVersionSummonActIdList()

	if self._actId == nil then
		for _, actId in ipairs(actIdList) do
			if ActivityType101Model.instance:isOpen(actId) then
				self._actId = actId

				break
			end
		end
	end

	self._actId = self._actId or actIdList[1]

	return self._actId or 13734
end

function Act101VersionSummonController:isOpen()
	local actId = self:actId()
	local bOpened = ActivityType101Model.instance:isOpen(actId)

	self:markDirty()

	return bOpened
end

function Act101VersionSummonController:isCliamable()
	if not self:isOpen() then
		return false
	end

	return ActivityType101Model.instance:isType101RewardCouldGetAnyOne(self:actId())
end

function Act101VersionSummonController:isCliamed()
	if not self:isOpen() then
		return false
	end

	return not self:isCliamable()
end

function Act101VersionSummonController:_saveInt(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function Act101VersionSummonController:_getInt(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

local kPrefix_Act101VersionSummonLooked = "Act101VersionSummonLooked|"

function Act101VersionSummonController:_getPrefsKey_Act101VersionSummonLooked()
	return kPrefix_Act101VersionSummonLooked .. tostring(self:actId())
end

function Act101VersionSummonController:saveTakeALookSummon(bLooked)
	if self:getSavedTakeALookSummon() == bLooked then
		return
	end

	local key = self:_getPrefsKey_Act101VersionSummonLooked()

	self:_saveInt(key, bLooked and 1 or 0)

	if bLooked then
		self:markDirty()
	end
end

function Act101VersionSummonController:getSavedTakeALookSummon()
	local key = self:_getPrefsKey_Act101VersionSummonLooked()
	local value = self:_getInt(key, 0)

	return value ~= 0
end

function Act101VersionSummonController:markDirty()
	self._actId = nil
end

Act101VersionSummonController.instance = Act101VersionSummonController.New()

return Act101VersionSummonController
