-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/model/MainPlayer.lua

MainPlayer = class("MainPlayer", objectlua.Object)

MainPlayer:has("_id", {
	is = "rw"
})
MainPlayer:has("_masterCureTimes", {
	is = "rw"
})
MainPlayer:has("_lastHeroCureTime", {
	is = "rw"
})
MainPlayer:has("_lastCalCureTime", {
	is = "rw"
})
MainPlayer:has("_seasonId", {
	is = "rw"
})
MainPlayer:has("_masterData", {
	is = "rw"
})
MainPlayer:has("_teamDataList", {
	is = "rw"
})
MainPlayer:has("_heroCureTime", {
	is = "rw"
})
MainPlayer:has("_rid", {
	is = "rw"
})
MainPlayer:has("_groupId", {
	is = "rw"
})
MainPlayer:has("_groupInfo", {
	is = "rw"
})
MainPlayer:has("_teamStatus", {
	is = "rw"
})
MainPlayer:has("_heroCombat", {
	is = "rw"
})
MainPlayer:has("_lastAttendBattleTime", {
	is = "rw"
})
MainPlayer:has("_lastMasterCureTime", {
	is = "rw"
})
MainPlayer:has("_teamLastAttackTime", {
	is = "rw"
})
MainPlayer:has("_cPos", {
	is = "rw"
})
MainPlayer:has("_mPhase", {
	is = "rw"
})
MainPlayer:has("_teamLastRecallTime", {
	is = "rw"
})
MainPlayer:has("_team2Dmg", {
	is = "rw"
})
MainPlayer:has("_calRewardsDmg", {
	is = "rw"
})
MainPlayer:has("_rewardIds", {
	is = "rw"
})
MainPlayer:has("_task", {
	is = "rw"
})
MainPlayer:has("_matchLv", {
	is = "rw"
})

function MainPlayer:initialize(id)
	super.initialize(self)

	self._id = id
	self._matchLv = 1
	self._lastCalCureTime = {}
	self._teamDataList = {}
	self._heroCureTime = {}
	self._teamStatus = {}
	self._heroCombat = {}
	self._teamLastRecallTime = {}
	self._task = {}
end

function MainPlayer:synchronizeGInfo(groupName)
	if groupName then
		for k, v in pairs(groupName) do
			if v.gId == self._groupId then
				self._groupInfo = {
					gIndex = v.gIndex,
					gName = v.gName,
					gId = v.gId,
					gIcon = v.headImg
				}

				break
			end
		end
	end
end

function MainPlayer:synchronize(_data)
	if not _data.player then
		if _data.player.id then
			self._id = _data.player.id
		end

		if _data.player.teamLastRecallTime then
			self._teamLastRecallTime = _data.player.teamLastRecallTime
		end

		if _data.player.groupId then
			self._groupId = _data.player.groupId
		end

		if _data.player.masterCureTimes then
			self._masterCureTimes = _data.player.masterCureTimes
		end

		if _data.player.lastHeroCureTime then
			self._lastHeroCureTime = _data.player.lastHeroCureTime
		end

		for k, v in pairs(_data.player.lastCalCureTime or {}) do
			self._lastCalCureTime[k] = v
		end

		if _data.player.seasonId then
			self._seasonId = _data.player.seasonId
		end

		if _data.player.mPhase then
			self._mPhase = _data.player.mPhase
		end

		if _data.player.masterData then
			self._masterData = _data.player.masterData
		end

		if _data.player.cPos then
			self._cPos = _data.player.cPos
		end

		if _data.player.teamDataList then
			self._teamDataList = {}
		end

		for k, v in pairs(_data.player.teamDataList or {}) do
			local heroIds = v.heroIds
			local heroDataList = {}

			for k, heroId in pairs(heroIds) do
				heroDataList[heroId] = {
					maxHp = v.heroDataList[v.topHero].maxHp,
					hp = v.heroDataList[v.topHero].hp,
					def = v.heroDataList[v.topHero].def,
					atk = v.heroDataList[v.topHero].atk
				}
			end

			v.heroDataList = heroDataList
			self._teamDataList[k] = v
		end

		for k, v in pairs(_data.player.heroCureTime or {}) do
			self._heroCureTime[k] = v
		end

		if _data.player.rid then
			self._rid = _data.player.rid
		end

		if _data.player.calRewardsDmg then
			self._calRewardsDmg = _data.player.calRewardsDmg
		end

		if _data.player.team2Dmg then
			self._team2Dmg = _data.player.team2Dmg
		end

		if _data.player.rewardIds then
			self._rewardIds = _data.player.rewardIds
		end

		local isDirtyServerData = false

		if _data.player.teamLastAttackTime then
			self._teamLastAttackTime = _data.player.teamLastAttackTime
		end

		for k, v in pairs(_data.player.teamStatus or {}) do
			if _data.battleField and _data.player.teamLastAttackTime[k] then
				local pusStamp = _data.battleField.timeStamp

				if pusStamp >= _data.player.teamLastAttackTime[k] then
					self._teamStatus[k] = v
				else
					print("dirty server push--->>>>", os.date("%Y-%m-%d %H:%M:%S", pusStamp / 1000), "服务器推送时间", pusStamp)
					print("dirty server push--->>>>", os.date("%Y-%m-%d %H:%M:%S", _data.player.teamLastAttackTime[k] / 1000), k, _data.player.teamLastAttackTime[k])

					local state = self._teamStatus[k]

					print("dirty server push--->>>>", state)

					if state == "REST" then
						for bossId, boss in pairs(_data.battleField.bossData) do
							for index, boll in pairs(boss.aTeams) do
								if boll.teamKey == k then
									print("dirty server push--->>>>", #_data.battleField.bossData[bossId].aTeams)
									table.remove(_data.battleField.bossData[bossId].aTeams, index)
									print("dirty server push--->>>>", "remove dirty bool from ateam")
									print("dirty server push--->>>>", #_data.battleField.bossData[bossId].aTeams)
									print("dirty server push--->>>> force remove")

									isDirtyServerData = true
								end
							end
						end
					elseif state ~= nil then
						local bossId = state
						local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
						local player = developSystem:getPlayer()
						local heroInfo = self._teamDataList[k].heroDataList[self._teamDataList[k].topHero]
						local mockData = {
							sp = 1,
							isMyth = true,
							hpr = 1,
							gId = self._groupId,
							def = heroInfo.def,
							nickName = player:getNickName(),
							teamKey = k,
							atk = heroInfo.atk,
							heroId = self._teamDataList[k].topHero
						}

						print("dirty server push--->>>>", #_data.battleField.bossData[bossId].aTeams)

						if _data.player.indef then
							table.insert(_data.battleField.bossData[bossId].dTeams, 1, mockData)
						else
							table.insert(_data.battleField.bossData[bossId].aTeams, 1, mockData)
						end

						print("dirty server push--->>>>", #_data.battleField.bossData[bossId].aTeams)
						print("dirty server push--->>>> force add", _data.player.indef and "def" or "atk")

						isDirtyServerData = true
					end
				end
			else
				self._teamStatus[k] = v
			end
		end

		for k, v in pairs(_data.heroCombat or _data.player.heroCombat or {}) do
			self._heroCombat[k] = v
		end

		if _data.player.lastAttendBattleTime then
			self._lastAttendBattleTime = _data.player.lastAttendBattleTime
		end

		if _data.player.lastMasterCureTime then
			self._lastMasterCureTime = _data.player.lastMasterCureTime
		end

		if _data.player.task then
			self._task = _data.player.task
		end

		return isDirtyServerData
	end
end

function MainPlayer:getClubMapActionCD()
	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapActionCD", "content")
end

function MainPlayer:getTask()
	local list = {}

	for k, v in pairs(self._task) do
		v.percent = v.current / v.target
		list[#list + 1] = v
	end

	table.sort(list, function(a, b)
		if a.taskStatus ~= b.taskStatus then
			return kTaskStatusPriorityMap[a.taskStatus] < kTaskStatusPriorityMap[b.taskStatus]
		else
			if a.percent ~= b.percent then
				return a.percent > b.percent
			end

			local aConfig = ConfigReader:getRecordById("ClubMapTask", a.taskId)
			local bConfig = ConfigReader:getRecordById("ClubMapTask", b.taskId)

			return aConfig.sequence < bConfig.sequence
		end
	end)

	return list
end
