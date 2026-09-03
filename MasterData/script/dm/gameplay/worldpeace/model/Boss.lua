-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/model/Boss.lua

Boss = class("Boss", objectlua.Object)

Boss:has("_ost", {
	is = "rw"
})
Boss:has("_lv", {
	is = "rw"
})
Boss:has("_dTeams", {
	is = "rw"
})
Boss:has("_aTeams", {
	is = "rw"
})
Boss:has("_camp", {
	is = "rw"
})
Boss:has("_def", {
	is = "rw"
})
Boss:has("_atk", {
	is = "rw"
})
Boss:has("_hpr", {
	is = "rw"
})
Boss:has("_config", {
	is = "rw"
})
Boss:has("_id", {
	is = "rw"
})
Boss:has("_gHurtMap", {
	is = "rw"
})
Boss:has("_mhp", {
	is = "rw"
})
Boss:has("_ownCamp", {
	is = "rw"
})
Boss:has("_groupName", {
	is = "rw"
})
Boss:has("_tag", {
	is = "rw"
})
Boss:has("_index", {
	is = "rw"
})
Boss:has("_aTeamNum", {
	is = "rw"
})
Boss:has("_dTeamNum", {
	is = "rw"
})

function Boss:initialize(id)
	super.initialize(self)

	self._id = id
	self._dTeams = {}
	self._aTeams = {}
	self._config = ConfigReader:getRecordById("ClubMapBoss", self._id)
end

function Boss:getATeamByKey(teamKey)
	return self._aTeams[teamKey]
end

function Boss:getDTeamByKey(teamKey)
	return self._dTeams[teamKey]
end

function Boss:synchronizeGIndex(data)
	for k, v in pairs(self._aTeams) do
		for k_, v_ in pairs(data or {}) do
			if v:getGId() == v_.gId then
				v:setGInfo(v_)
			end
		end
	end

	for k, v in pairs(self._dTeams) do
		for k_, v_ in pairs(data or {}) do
			if v:getGId() == v_.gId then
				v:setGInfo(v_)
			end
		end
	end

	self._groupName = data or {}
end

function Boss:synchronizeChildScale(basePhase)
	for k, v in pairs(self._aTeams) do
		if not v:getMPhase() or not basePhase then
			v:setScaleOffset(0)
		else
			local abs = v:getMPhase() - basePhase

			abs = abs > 0 and math.min(abs, 2) or math.max(abs, -2)

			v:setScaleOffset(abs * 0.08)
		end
	end

	for k, v in pairs(self._dTeams) do
		if not v:getMPhase() or not basePhase then
			v:setScaleOffset(0)
		else
			local abs = v:getMPhase() - basePhase

			abs = abs > 0 and math.min(abs, 2) or math.max(abs, -2)

			v:setScaleOffset(abs * 0.08)
		end
	end
end

function Boss:synchronizeTagInfo(tag)
	self._tag = tag
end

function Boss:synchronize(data)
	if data.ost then
		self._ost = data.ost
	end

	if data.aTeams then
		self._aTeams = {}

		for k, v in pairs(data.aTeams or {}) do
			self._aTeams[v.teamKey] = self._aTeams[v.teamKey] or Boll:new(v.teamKey)

			self._aTeams[v.teamKey]:synchronize(v)
			self._aTeams[v.teamKey]:setOrder(k)
			self._aTeams[v.teamKey]:setIsProtect(false)
		end
	end

	if data.dTeams then
		self._dTeams = {}

		for k, v in pairs(data.dTeams or {}) do
			self._dTeams[v.teamKey] = self._dTeams[v.teamKey] or Boll:new(v.teamKey)

			self._dTeams[v.teamKey]:synchronize(v)
			self._dTeams[v.teamKey]:setOrder(k)
			self._dTeams[v.teamKey]:setIsProtect(true)
		end
	end

	if data.camp then
		self._camp = data.camp
	end

	if data.def then
		self._def = data.def
	end

	if data.atk then
		self._atk = data.atk
	end

	if data.hpr then
		self._hpr = data.hpr
	end

	if data.gHurtMap then
		self._gHurtMap = data.gHurtMap
	end

	if data.mhp then
		self._mhp = data.mhp
	end

	if data.ownCamp then
		self._ownCamp = data.ownCamp
	end

	if data.lv then
		self._lv = data.lv
	end

	if data.index then
		self._index = data.index
	end

	if data.aTeamNum then
		self._aTeamNum = data.aTeamNum
	end

	if data.dTeamNum then
		self._dTeamNum = data.dTeamNum
	end
end

ClubBossStageOne = class("ClubBossStageOne", Boss)

ClubBossStageOne:has("_id", {
	is = "rw"
})
ClubBossStageOne:has("_curHp", {
	is = "rw"
})
ClubBossStageOne:has("_maxHp", {
	is = "rw"
})
ClubBossStageOne:has("_stage", {
	is = "rw"
})
ClubBossStageOne:has("_status", {
	is = "rw"
})
ClubBossStageOne:has("_rid", {
	is = "rw"
})
ClubBossStageOne:has("_rank", {
	is = "rw"
})
ClubBossStageOne:has("_ownerRank", {
	is = "rw"
})
ClubBossStageOne:has("_playerInfoMap", {
	is = "rw"
})
ClubBossStageOne:has("_hpRemain", {
	is = "rw"
})
ClubBossStageOne:has("_cur", {
	is = "rw"
})
ClubBossStageOne:has("_atkTimes", {
	is = "rw"
})
ClubBossStageOne:has("_twoStartTime", {
	is = "r"
})
ClubBossStageOne:has("_oneLastRecoverHpTime", {
	is = "r"
})
ClubBossStageOne:has("_pB", {
	is = "r"
})
ClubBossStageOne:has("_cB", {
	is = "r"
})
ClubBossStageOne:has("_enterBoss", {
	is = "rw"
})

local ClubBoss_Buff1 = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubBoss_Buff1", "content")
local ClubBoss_Buff2 = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubBoss_Buff2", "content")
local gameServerAgent = DmGame:getInstance()._injector:getInstance(GameServerAgent)

function ClubBossStageOne:initialize(id)
	super.initialize(self, id)

	self._id = id
	self._config = ConfigReader:getRecordById("ClubBoss", id)
	self._atkTimes = 0
	self._oneLastRecoverHpTime = 0
	self._twoStartTime = 0
	self._clubBoss = DmGame:getInstance()._injector:getInstance(ClubSystem):getClubBossNew()
	self._enterBoss = self._clubBoss:getBossById(self._id)
end

function ClubBossStageOne:synchronize(data)
	if data.atkTimes then
		self._atkTimes = data.atkTimes
	end

	if data.atk then
		self._atk = data.atk
	end

	if data.maxHp then
		self._maxHp = data.maxHp
	end

	if data.curHp then
		self._curHp = data.curHp
	end

	if data.playerInfoMap then
		self._playerInfoMap = data.playerInfoMap
	end

	if data.stage then
		self._stage = data.stage
	end

	if data.status then
		self._status = data.status
	end

	if data.rid then
		self._rid = data.rid
	end

	if data.rank then
		self._rank = data.rank
	end

	if data.ownerRank then
		self._ownerRank = data.ownerRank
	end

	if data.hpRemain then
		self._hpRemain = data.hpRemain
	end

	if data.aTeams then
		for k, v in pairs(data.aTeams or {}) do
			self._aTeams[k] = self._aTeams[k] or ClubBossBoll:new(k)

			self._aTeams[k]:synchronize(v)
		end
	end

	if data.twoStartTime then
		self._twoStartTime = data.twoStartTime
	end

	if data.oneLastRecoverHpTime then
		self._oneLastRecoverHpTime = data.oneLastRecoverHpTime
	end

	if data.pB then
		self._pB = data.pB
	end

	if data.cB then
		self._cB = data.cB
	end
end

function ClubBossStageOne:getHpr()
	if not self._curHp then
		return 0
	end

	return self._curHp / self._maxHp
end

function ClubBossStageOne:getBuffCd()
	return (self._stage == 1 or nil) and (self._config.ClubBoss_Buff1 or self._config.ClubBoss_Buff2)
end

function ClubBossStageOne:getBuffCdBeginTime()
	return (self._stage == 1 or nil) and (self._oneLastRecoverHpTime or self._twoStartTime)
end

function ClubBossStageOne:getBuffCdRecoverTimes()
	local buffCdBeginTime = self:getBuffCdBeginTime()

	if not buffCdBeginTime or buffCdBeginTime <= 0 then
		return 0
	end

	local times = buffCdBeginTime + self:getBuffCd().Time
	local curMills = gameServerAgent:remoteTimestamp()
	local recoverTimes = times - curMills

	recoverTimes = math.min(recoverTimes, self:getBuffCd().Time)
	recoverTimes = math.max(recoverTimes, 0)

	return recoverTimes
end

function ClubBossStageOne:getHpStage()
	local stageMaxHp, stageMaxCount = self._enterBoss:getHpStage(self._stage)

	return {
		stageMaxHp = stageMaxHp,
		stageMaxCount = stageMaxCount
	}
end

function ClubBossStageOne:getMyAtk()
	if self._stage == 1 then
		local var_15_0 = self._clubBoss:getOneAtk()

		if not var_15_0 then
			var_15_0 = self._clubBoss:getTwoAtk()

			local atk = var_15_0
			local pb = self._pB and self._pB[self._enterBoss:getRid()] or nil
			local add = 0

			if pb and pb.s == self._stage and pb.c == 0 then
				add = self._enterBoss:getBuffs()[ClubBossNewBuffType.KClub].buff[pb.s].Value
			end

			local cb = self._cB

			if cb and cb.s == self._stage and cb.c == 0 then
				add = add + self._enterBoss:getBuffs()[ClubBossNewBuffType.KMySelf].buff[cb.s].Value
			end

			atk = atk + atk * add

			return math.floor(atk)
		end
	end
end
