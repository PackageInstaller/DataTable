-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/model/BattleField.lua

WolrdBattleField = class("WolrdBattleField", objectlua.Object)

WolrdBattleField:has("_bossList", {
	is = "rw"
})
WolrdBattleField:has("_groupNameMap", {
	is = "rw"
})
WolrdBattleField:has("_bossChangeList", {
	is = "rw"
})
WolrdBattleField:has("_groupPointMap", {
	is = "rw"
})
WolrdBattleField:has("_groupBossTime", {
	is = "rw"
})
WolrdBattleField:has("_id", {
	is = "rw"
})
WolrdBattleField:has("_dieQueques", {
	is = "rw"
})
WolrdBattleField:has("_dieRemoveQueques", {
	is = "rw"
})
WolrdBattleField:has("_group", {
	is = "rw"
})
WolrdBattleField:has("_playerLog", {
	is = "rw"
})

function WolrdBattleField:initialize(id)
	super.initialize(self)

	self._id = id
	self._bossList = {}
	self._dieQueques = {}
	self._dieRemoveQueques = {}
	self._playerLog = {}
	self._group = {}
	self._clubMapRemanisTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapRemanisTime", "content")

	local keys = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBossLib", "content")

	for k, v in pairs(keys) do
		self._bossList[v] = Boss:new(v)
	end
end

function WolrdBattleField:collect(data)
	local newBollInfo = {}

	for k, v in pairs(data.bossData) do
		for k_, v_ in pairs(v.dTeams) do
			newBollInfo[v_.teamKey] = {
				bolldata = v_,
				bossId = k
			}
		end

		for k_, v_ in pairs(v.aTeams) do
			newBollInfo[v_.teamKey] = {
				bolldata = v_,
				bossId = k
			}
		end
	end

	local oldBollInfo = {}

	for k, v in pairs(self._bossList) do
		for k_, v_ in pairs(v._dTeams) do
			oldBollInfo[v_._teamKey] = {
				bolldata = v_,
				bossId = k
			}
		end

		for k_, v_ in pairs(v._aTeams) do
			oldBollInfo[v_._teamKey] = {
				bolldata = v_,
				bossId = k
			}
		end
	end

	local removeInfos = {}

	for k, v in pairs(oldBollInfo) do
		if not newBollInfo[k] then
			removeInfos[k] = oldBollInfo[k]
		end
	end

	self:pushDiedUnitQueque(removeInfos, data)

	return removeInfos
end

function WolrdBattleField:pushDiedUnitQueque(dieInfos, data)
	for k, v in pairs(dieInfos) do
		if not self._dieQueques[k .. "__shadow__" .. v.bossId] then
			local isRealDeath = false

			for k_, v_ in pairs(data.bossData[v.bossId].dieTeams or {}) do
				if v_.teamKey == v.bolldata:getTeamKey() then
					isRealDeath = true
				end
			end

			if not v.bolldata:getIsMyth() and isRealDeath and not v.bolldata:getIsProtect() then
				self._dieQueques[k .. "__shadow__" .. v.bossId] = {
					bolldata = v.bolldata,
					keepTime = self._clubMapRemanisTime,
					bossId = v.bossId
				}
			end
		end
	end
end

function WolrdBattleField:step(dt)
	for k, v in pairs(self._dieQueques) do
		v.keepTime = v.keepTime - dt

		if v.keepTime <= 0 then
			self._dieRemoveQueques[k] = v
			self._dieQueques[k] = nil
		end
	end
end

function WolrdBattleField:clear()
	for k, v in pairs(self._bossList) do
		v._dTeams = {}
		v._aTeams = {}
	end
end

function WolrdBattleField:synchronize(_data)
	local data = _data.battleField
	local group = _data.group

	if group then
		self._group = _data.group or {}
	end

	if data.groupPointMap then
		self._groupPointMap = data.groupPointMap
	end

	if data.bossChangeList then
		self._bossChangeList = data.bossChangeList
	end

	if _data.playerLog then
		self._playerLog = _data.playerLog
	end

	if data.groupBossTime then
		self._groupBossTime = data.groupBossTime
	end

	if data.groupName then
		self._groupNameMap = data.groupName

		table.sort(data.groupName, function(a, b)
			return a.gId < b.gId
		end)

		for k, v in pairs(data.groupName) do
			self._groupNameMap[k] = {
				gIndex = k,
				gName = v.name,
				gId = v.gId,
				gIcon = v.headImg
			}
		end
	end

	for k, v in pairs(data.bossData or {}) do
		self._bossList[k]:synchronize(v)
		self._bossList[k]:synchronizeGIndex(self._groupNameMap)
		self._bossList[k]:synchronizeTagInfo(nil)
		self._bossList[k]:synchronizeChildScale(_data.player.mPhase)
	end

	for k, v in pairs(self._group.bossTag or {}) do
		self._bossList[v]:synchronizeTagInfo(k)
	end

	self:synchronizeOtherInfo(_data.player)
end

function WolrdBattleField:synchronizeOtherInfo(playerInfo)
	for k, v in pairs(self._bossList) do
		for k_, v_ in pairs(v:getDTeams()) do
			if playerInfo.teamDataList[v_:getTeamKey()] then
				v_:setIsMyth(true)
			end
		end

		for k_, v_ in pairs(v:getATeams()) do
			if playerInfo.teamDataList[v_:getTeamKey()] then
				v_:setIsMyth(true)
			end
		end
	end
end

function WolrdBattleField:getBossById(bossId)
	return self._bossList[bossId]
end

WolrdBattleCLubStageOneField = class("WolrdBattleCLubStageOneField", WolrdBattleField)

function WolrdBattleCLubStageOneField:initialize(id, bossId)
	super.initialize(self)

	self._id = id
	self._bossList = {}

	if bossId then
		self._bossList[v] = Boss:new(bossId)
	end
end
