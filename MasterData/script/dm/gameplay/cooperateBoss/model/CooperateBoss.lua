-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/cooperateBoss/model/CooperateBoss.lua

CooperateBoss = class("CooperateBoss", objectlua.Object, _M)

CooperateBoss:has("_id", {
	is = "rw"
})
CooperateBoss:has("_hotTime", {
	is = "rw"
})
CooperateBoss:has("_startTime", {
	is = "rw"
})
CooperateBoss:has("_endTime", {
	is = "rw"
})
CooperateBoss:has("_config", {
	is = "rw"
})
CooperateBoss:has("_isTodayOpen", {
	is = "rw"
})
CooperateBoss:has("_dailyReset", {
	is = "rw"
})
CooperateBoss:has("_bossFightTimes", {
	is = "rw"
})
CooperateBoss:has("_boughtBossFightTimes", {
	is = "rw"
})
CooperateBoss:has("_tokenRewardBossLst", {
	is = "rw"
})
CooperateBoss:has("_invitedBossIdMap", {
	is = "rw"
})
CooperateBoss:has("_battleRecordLst", {
	is = "rw"
})
CooperateBoss:has("_mineBoss", {
	is = "rw"
})
CooperateBoss:has("_rewardState", {
	is = "rw"
})
CooperateBoss:has("_activitySystem", {
	is = "rw"
})

function CooperateBoss:initialize()
	super.initialize(self)

	self._id = "0"
	self._hotTime = 0
	self._startTime = 0
	self._endTime = 0
	self._isTodayOpen = false
	self._dailyReset = false
	self._bossFightTimes = nil
	self._boughtBossFightTimes = nil
	self._tokenRewardBossLst = nil
	self._invitedBossIdMap = {}
	self._battleRecordLst = {}
	self._mineBoss = {}
	self._rewardState = false
end

function CooperateBoss:dispose()
	super.dispose(self)
end

function CooperateBoss:delete(data)
	return
end

function CooperateBoss:synchronizeFromActivity(data)
	if not data then
		return
	end

	for id, actData in pairs(data) do
		local config = ConfigReader:getRecordById("Activity", id)

		if config and config.Type == "COOPERATEBOSS" then
			if actData and actData.activityId then
				self._id = actData.activityId
				self._config = config
			end

			if actData and actData.startTS then
				self._hotTime = actData.startTS / 1000
			end

			if actData and actData.timeStamp and actData.timeStamp.openTs then
				self._startTime = actData.timeStamp.openTs / 1000
			end

			if actData and actData.timeStamp and actData.timeStamp.finishTs then
				self._endTime = actData.timeStamp.finishTs / 1000
			end

			if actData and actData.timeStamp and actData.timeStamp.dailyReset then
				self._dailyReset = actData.timeStamp.dailyReset
			end

			if actData and actData.todayOpen then
				self._isTodayOpen = actData.todayOpen
			end

			if actData and actData.boughtBossFightTimes then
				self._boughtBossFightTimes = actData.boughtBossFightTimes
			end

			if actData and actData.tokenRewardBossLst then
				self._tokenRewardBossLst = actData.tokenRewardBossLst
			end

			if actData and actData.bossFightTimes then
				self._bossFightTimes = actData.bossFightTimes
			end

			if actData and actData.battleRecordLst then
				for i = 1, #actData.battleRecordLst do
					table.insert(self._battleRecordLst, actData.battleRecordLst[i])
				end
			end

			if data and data.mineBoss then
				self:setMineBoss(data.mineBoss)
			end

			if actData and actData.rewardState ~= nil then
				self._rewardState = actData.rewardState
			end
		end
	end
end

function CooperateBoss:setInvitedBossIdMap(data)
	self._invitedBossIdMap = data
end

function CooperateBoss:getSortInvitedBossIdMap()
	table.sort(self._invitedBossIdMap, function(a, b)
		return a.invitedTime < b.invitedTime
	end)

	return self._invitedBossIdMap
end

function CooperateBoss:removeBossData(data)
	if self._mineBoss and self._mineBoss.bossId and data.bossId == self._mineBoss.bossId then
		self:resetMineBoss()
	end
end

function CooperateBoss:setMineBoss(data)
	self._mineBoss = data or {}
end

function CooperateBoss:resetMineBoss()
	self._mineBoss = {}
end

function CooperateBoss:getType()
	return self._config.Type
end

function CooperateBoss:getUI()
	return "CooperateBossMainView"
end

function CooperateBoss:getShowTab()
	return ActivityShowTab.kNotShow
end

function CooperateBoss:getActivityComplexUI()
	return self._config.UI
end

function CooperateBoss:getBossLiveTime(conId)
	local congfigId = conId or self._mineBoss.confId
	local bossConfig = ConfigReader:getRecordById("CooperateBossMain", congfigId)

	return tonumber(bossConfig.Time)
end

function CooperateBoss:getBossEndTime()
	return tonumber(self._mineBoss.bossCreateTime) + self:getBossLiveTime()
end

function CooperateBoss:getRoleModelName(conId)
	local congfigId = conId or self._mineBoss.confId
	local bossBattle = ConfigReader:getDataByNameIdAndKey("CooperateBossMain", congfigId, "BossBattle")
	local nameKey = ConfigReader:getDataByNameIdAndKey("CooperateBossBattle", bossBattle, "Name")

	return Strings:get(nameKey)
end

function CooperateBoss:getRoleModelId(conId)
	local congfigId = conId or self._mineBoss.confId

	return (ConfigReader:getDataByNameIdAndKey("CooperateBossMain", congfigId, "RoleModel"))
end

function CooperateBoss:getBossLevel()
	return self._mineBoss.lv or 20
end

function CooperateBoss:getFightNumMax()
	local resetSystem = ConfigReader:getRecordById("Reset", "CooperateBoss").ResetSystem

	return resetSystem.max
end
