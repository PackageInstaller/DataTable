-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/model/FightModel.lua

module("frameworkext.gm.model.FightModel", package.seeall)

local FightModel = class("FightModel", BaseModel)

FightModel.TYPE_MY = 0
FightModel.TYPE_ENEMY = 1
FightModel.EVENT_IDX_UPDATE = "event_idx_update"
FightModel.EVENT_SUMMON_UPDATE = "event_summon_update"
FightModel.FmtSaveKeyPre = "FmtSaveKeyPre"
FightModel.FmtMasterSaveKeyPre = "FmtMaterSaveKeyPre"

function FightModel:ctor()
	self:_resetData()
end

function FightModel:onInit()
	self:_resetData()
end

function FightModel:onReset()
	self:_resetData()
end

function FightModel:_resetData()
	self._ourArr = {}
	self._enemyArr = {}
	self._masterDatas = {}
end

function FightModel:getData(type, idx, skinId)
	local tbl
	local creep = (type == FightModel.TYPE_MY and self._ourArr or self._enemyArr)[idx]

	if creep == nil then
		creep = self:createEmptyData(idx, 0)

		self:setData(type, idx, creep)
	end

	if skinId ~= nil then
		if checknumber(skinId) <= 0 then
			creep.curFace = ""
			creep.raceId = 0
		else
			local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

			if cfg then
				creep.curFace = checknumber(skinId) .. ""
				creep.raceId = checknumber(cfg.raceId)
			end
		end
	end

	return creep
end

function FightModel:changeIdxA2B(aType, aIdx, bType, bIdx)
	local ca = self:getData(aType, aIdx)
	local cb = self:getData(bType, bIdx)

	ca.creepsId = bIdx % FightModel.CREEPS_ID_LIMIT
	ca.posId = bIdx
	cb.creepsId = aIdx % FightModel.CREEPS_ID_LIMIT
	cb.posId = aIdx

	self:setData(aType, aIdx, cb)
	self:setData(bType, bIdx, ca)
end

function FightModel:setData(type, idx, creep)
	local tbl

	;(type == FightModel.TYPE_MY and self._ourArr or self._enemyArr)[idx] = creep
end

FightModel.CREEPS_ID_LIMIT = 1000
FightModel.RACEID_LIMIT = 100000

function FightModel:createEmptyData(idx, raceId)
	raceId = raceId or 0

	local creep = GMExtension_pb.PM_CustomCreeps()

	return self:clearCreepData(creep, idx, raceId)
end

function FightModel:clearCreepData(creep, idx, raceId)
	raceId = raceId or 0
	creep.creepsId = idx % FightModel.CREEPS_ID_LIMIT
	creep.name = ""
	creep.level = 100
	creep.posId = idx
	creep.raceId = raceId
	creep.curFace = raceId .. ""
	creep.summonMasterId = ""
	creep.summonedCreepsId = ""
	creep.talentLevel = 0
	creep.awakenLv = 0
	creep.equipment = ""
	creep.runeSuit = ""
	creep.extProperties = ""
	creep.onlyUseExtProperties = false
	creep.extBuffs = ""
	creep.curHp = ""
	creep.maxHp = ""
	creep.myPetId = -1

	return creep
end

function FightModel:setCreeName(type, idx, name)
	local creep = self:getData(type, idx)

	creep.name = name
end

function FightModel:setCreeRaceId(type, idx, raceId)
	local creep = self:getData(type, idx)

	creep.raceId = raceId
end

function FightModel:setCreeFaceId(type, idx, curFace)
	local creep = self:getData(type, idx)

	creep.curFace = checknumber(curFace) > 0 and curFace .. "" or creep.raceId .. ""
end

function FightModel:setCreeLevel(type, idx, lvl)
	local creep = self:getData(type, idx)

	creep.level = lvl
end

function FightModel:setCreeGenius(type, idx, gen)
	local creep = self:getData(type, idx)

	creep.talentLevel = checknumber(gen)
end

function FightModel:setCreeStargod(type, idx, val)
	local creep = self:getData(type, idx)

	creep.runeSuit = val
end

function FightModel:onJuexingChange(type, idx, val)
	local creep = self:getData(type, idx)

	creep.awakenLv = checknumber(val)
end

function FightModel:setCreeEquip(type, idx, val)
	local creep = self:getData(type, idx)

	creep.equipment = val
end

function FightModel:setSkillLvl(type, idx, val)
	local creep = self:getData(type, idx)
	local arr = string.splitToNumber(val, "#")

	creep.normalSkillLv = checknumber(arr[1])
	creep.ultimateSkillLv = checknumber(arr[2])
	creep.passiveSkillLv = checknumber(arr[3])
	creep.psychicedNormalSkillLv = checknumber(arr[4])
	creep.psychicedUltimateSkillLv = checknumber(arr[5])
end

function FightModel:setContractSkill(type, idx, val)
	local creep = self:getData(type, idx)

	creep.contractSkillId = checknumber(val)
end

function FightModel:setCreeExt(type, idx, val)
	local creep = self:getData(type, idx)

	creep.extProperties = val
end

function FightModel:setCreeBuff(type, idx, val)
	local creep = self:getData(type, idx)

	creep.extBuffs = val
end

function FightModel:loadCacheFmt()
	self._ourArr = self:_loadCacheFmt(FightModel.TYPE_MY)
	self._enemyArr = self:_loadCacheFmt(FightModel.TYPE_ENEMY)

	self:_loadCacheMasters()
end

function FightModel:_loadCacheMasters()
	self._masterDatas[FightModel.TYPE_MY] = self:_loadCacheMaster(FightModel.TYPE_MY)
	self._masterDatas[FightModel.TYPE_ENEMY] = self:_loadCacheMaster(FightModel.TYPE_ENEMY)
end

function FightModel:_loadCacheMaster(type)
	local key = string.format("%s@%s", FightModel.FmtMasterSaveKeyPre, type)
	local data = {
		spiritInvocationPetId = 0,
		heavenAwakenMasterId = 0,
		heavenAwakenSummonPetId = 0
	}
	local str = GameUtil.getUserData(key)

	if str then
		local temp = GameUtil.jsonToTable(str)

		if temp then
			data.heavenAwakenMasterId = temp.heavenAwakenMasterId
			data.heavenAwakenSummonPetId = temp.heavenAwakenSummonPetId
			data.spiritInvocationPetId = temp.spiritInvocationPetId or 0
		end
	end

	return data
end

function FightModel:_loadCacheFmt(type)
	local list = {}

	for i = -9, 9 do
		local key = string.format("%s@%s@%s", FightModel.FmtSaveKeyPre, type, i)
		local str = GameUtil.getUserData(key)

		if str then
			list[i] = self:_getPosData(i, str)
		end
	end

	return list
end

function FightModel:_getPosData(pos, str)
	local data = GameUtil.jsonToTable(str)
	local creep = self:createEmptyData(pos, data.raceId)

	creep.normalSkillLv = data.normalSkillLv
	creep.ultimateSkillLv = data.ultimateSkillLv
	creep.passiveSkillLv = data.passiveSkillLv
	creep.psychicedNormalSkillLv = data.psychicedNormalSkillLv
	creep.psychicedUltimateSkillLv = data.psychicedUltimateSkillLv
	creep.level = data.level
	creep.curFace = data.curFace
	creep.extBuffs = data.extBuffs or ""
	creep.extProperties = data.extProperties or ""
	creep.equipment = data.equipment or ""
	creep.awakenLv = data.awakenLv or 0
	creep.contractSkillId = data.contractSkillId or 0
	creep.runeSuit = data.runeSuit or ""
	creep.onlyUseExtProperties = checkbool(data.onlyUseExtProperties)
	creep.talentLevel = data.talentLevel or 0
	creep.summonMasterId = data.summonMasterId or ""
	creep.summonedCreepsId = data.summonedCreepsId or ""
	creep.elementalMasterId = data.elementalMasterId or ""
	creep.elementalTargetId = data.elementalTargetId or ""
	creep.carriedMasterId = data.carriedMasterId or 0
	creep.carriedPetId = data.carriedPetId or 0
	creep.oracleMasterId = data.oracleMasterId or 0
	creep.oraclePetId = data.oraclePetId or 0
	creep.myPetId = data.myPetId or 0
	creep.bookSpiritRaceId = data.bookSpiritRaceId or 0

	return creep
end

function FightModel:saveFmt()
	self:_saveFmt(self._ourArr, FightModel.TYPE_MY)
	self:_saveFmt(self._enemyArr, FightModel.TYPE_ENEMY)
	FloatWordMgr.instance:show("保存成功")
end

function FightModel:_saveFmt(list, type)
	for k, v in pairs(list) do
		local data = self:_savePosData(v)
		local key = string.format("%s@%s@%s", FightModel.FmtSaveKeyPre, type, k)

		GameUtil.saveUserData(key, GameUtil.jsonToString(data))
	end
end

function FightModel:_savePosData(v)
	if v.raceId == 0 then
		v.summonedCreepsId = ""
		v.summonMasterId = ""
		v.carriedMasterId = 0
		v.carriedPetId = 0
		v.oracleMasterId = 0
		v.oraclePetId = 0
		v.bookSpiritRaceId = 0
		v.elementalMasterId = ""
		v.elementalTargetId = ""
	end

	local var_29_0 = {}

	var_29_0.curFace = v.curFace or 0
	var_29_0.raceId = v.raceId or 0
	var_29_0.level = v.level or 0
	var_29_0.normalSkillLv = v.normalSkillLv or 0
	var_29_0.ultimateSkillLv = v.ultimateSkillLv or 0
	var_29_0.passiveSkillLv = v.passiveSkillLv or 0
	var_29_0.psychicedNormalSkillLv = v.psychicedNormalSkillLv or 0
	var_29_0.psychicedUltimateSkillLv = v.psychicedUltimateSkillLv or 0
	var_29_0.extBuffs = v.extBuffs or ""
	var_29_0.extProperties = v.extProperties or ""
	var_29_0.awakenLv = v.awakenLv or 0
	var_29_0.contractSkillId = v.contractSkillId or 0
	var_29_0.runeSuit = v.runeSuit or ""
	var_29_0.onlyUseExtProperties = checkbool(v.onlyUseExtProperties)
	var_29_0.talentLevel = v.talentLevel or 0
	var_29_0.equipment = v.equipment or ""
	var_29_0.summonMasterId = v.summonMasterId or ""
	var_29_0.summonedCreepsId = v.summonedCreepsId or ""
	var_29_0.elementalMasterId = v.elementalMasterId or ""
	var_29_0.elementalTargetId = v.elementalTargetId or ""
	var_29_0.carriedMasterId = v.carriedMasterId or 0
	var_29_0.carriedPetId = v.carriedPetId or 0
	var_29_0.oracleMasterId = v.oracleMasterId or 0
	var_29_0.oraclePetId = v.oraclePetId or 0
	var_29_0.bookSpiritRaceId = v.bookSpiritRaceId or 0
	var_29_0.myPetId = v.myPetId

	return var_29_0
end

function FightModel:clearFmt()
	self:onReset()
	FloatWordMgr.instance:show("清理成功")
end

function FightModel:saveMasterData(type, customMaster)
	local data = self._masterDatas[type]

	if not data then
		data = {}
		self._masterDatas[type] = data
	end

	data.heavenAwakenMasterId = checknumber(customMaster.heavenAwakenMasterId)
	data.heavenAwakenSummonPetId = checknumber(customMaster.heavenAwakenSummonPetId)
	data.spiritInvocationPetId = checknumber(customMaster.spiritInvocationPetId)

	local key = string.format("%s@%s", FightModel.FmtMasterSaveKeyPre, type)

	GameUtil.saveUserData(key, GameUtil.jsonToString(data))
end

function FightModel:getMasterData(type)
	return self._masterDatas[type]
end

function FightModel:exportFormation()
	local ourArr = {}
	local enemyArr = {}

	for k, v in pairs(self._ourArr) do
		local data = self:_savePosData(v)
		local key = string.format("%s@%s@%s", FightModel.FmtSaveKeyPre, FightModel.TYPE_MY, k)

		ourArr[key] = GameUtil.jsonToString(data)
	end

	for k, v in pairs(self._enemyArr) do
		local data = self:_savePosData(v)
		local key = string.format("%s@%s@%s", FightModel.FmtSaveKeyPre, FightModel.TYPE_ENEMY, k)

		enemyArr[key] = GameUtil.jsonToString(data)
	end

	local data = {
		masterDatas = self._masterDatas,
		ourArr = ourArr,
		enemyArr = enemyArr
	}

	return GameUtil.jsonToString(data)
end

function FightModel:importFormation(str)
	if string.nilorempty(str) then
		printError("不能输入空字符串")

		return
	end

	local data = GameUtil.jsonToTable(str)

	if data then
		self._ourArr = {}
		self._enemyArr = {}
		self._masterDatas = {}

		for k, v in pairs(data.ourArr) do
			local keys = string.split(k, "@")
			local idx = checknumber(keys[3])

			self._ourArr[idx] = self:_getPosData(idx, v)
		end

		for k, v in pairs(data.enemyArr) do
			local keys = string.split(k, "@")
			local idx = checknumber(keys[3])

			self._enemyArr[idx] = self:_getPosData(idx, v)
		end

		for k, v in pairs(data.masterDatas) do
			self._masterDatas[checknumber(k)] = v
		end
	end
end

FightModel.instance = FightModel.New()

return FightModel
