-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/controller/battlemgr/MiracleHeroBuffMgr.lua

module("logic.extensions.miraclehero.controller.battlemgr.MiracleHeroBuffMgr", package.seeall)

local MiracleHeroBuffMgr = class("MiracleHeroBuffMgr")

function MiracleHeroBuffMgr:ctor()
	self._buffMap = {}
	self._buffIndex = 1
	self._buffPool = {}
end

function MiracleHeroBuffMgr:initData(activityId)
	self._buffMap = {}
	self._activityId = activityId
	self._buffIndex = 1
end

function MiracleHeroBuffMgr:getBuff(buffId)
	return self._buffMap[buffId]
end

function MiracleHeroBuffMgr:getPetBuffMos(petId)
	local petMo = MiracleHeroUnitMgr.instance:getPet(petId)
	local list = {}

	for i, v in ipairs(petMo.buffList) do
		local buffMo = self:getBuff(v)

		table.insert(list, buffMo)
	end

	return list
end

function MiracleHeroBuffMgr:addBuff(petId, buffMo)
	local petMo = MiracleHeroUnitMgr.instance:getPet(petId)
	local isFind = false

	if not isFind then
		buffMo.targetId = petId
		buffMo.buffId = self._buffIndex
		self._buffMap[self._buffIndex] = buffMo

		buffMo:onAddBuffBefore()
		table.insert(petMo.buffList, self._buffIndex)
		buffMo:onAddBuff()

		self._buffIndex = self._buffIndex + 1
	end
end

function MiracleHeroBuffMgr:createBuffMo(buffCfg)
	local buffMo

	local function resetFunc()
		return
	end

	local function disposeFunc()
		return
	end

	self._buffPool[buffCfg.buffClazz] = self._buffPool[buffCfg.buffClazz] or ObjectPool.New(5, nil, disposeFunc, resetFunc)

	if self._buffPool[buffCfg.buffClazz] then
		buffMo = self._buffPool[buffCfg.buffClazz]:fetchObject()
	end

	if not buffMo then
		if buffCfg.buffClazz == "PropertyChange" then
			buffMo = MiracleHeroPropertyBuffMo.New()
		elseif buffCfg.buffClazz == "ExtCritical" then
			buffMo = MiracleHeroExtCriticalBuffMo.New()
		elseif buffCfg.buffClazz == "AttackRate" then
			buffMo = MiracleHeroAttackRateBuffMo.New()
		elseif buffCfg.buffClazz == "DefendRate" then
			buffMo = MiracleHeroDefendRateBuffMo.New()
		elseif buffCfg.buffClazz == "State" then
			buffMo = MiracleHeroStateBuffMo.New()
		end
	end

	if buffMo then
		buffMo:initData(buffCfg.id, buffCfg.buffParams, buffCfg.effectTimes)
	end

	return buffMo
end

function MiracleHeroBuffMgr:reduceAllBuffTier(tier)
	local reduceTier = tier or 1
	local clearBuffList = {}

	for i, buffMo in pairs(self._buffMap) do
		buffMo.tier = math.max(buffMo.tier - reduceTier, 0)

		if buffMo.tier <= 0 then
			table.insert(clearBuffList, buffMo.buffId)
		end
	end

	local changeReportMos = {}

	for i, buffId in ipairs(clearBuffList) do
		local buffMo = self._buffMap[buffId]
		local petMo = MiracleHeroUnitMgr.instance:getPet(buffMo.targetId)

		if petMo then
			local hpRate = 0
			local reportMo
			local beforeCurHp = 0
			local beforeMaxHp = 0

			if buffMo.buffType == MiracleHeroBuffType.PropertyChange and (buffMo.proertyType == GameEnum.AttrType.Hp or buffMo.proertyType == GameEnum.AttrType.HpRate) then
				hpRate = petMo.curHp / petMo:getMaxHp()
				reportMo = changeReportMos[buffMo.targetId] or MiracleHeroRoundMgr.instance:getNewReportMo()
				reportMo.petId = buffMo.targetId

				table.insert(reportMo.buffIds, buffId)

				beforeCurHp = petMo.curHp
				beforeMaxHp = petMo:getMaxHp()
			end

			buffMo:onRemoveBefore()

			local targetBuffIndex = 0

			for i, v in ipairs(petMo.buffList) do
				if v == buffId then
					targetBuffIndex = i

					break
				end
			end

			if targetBuffIndex ~= 0 then
				table.remove(petMo.buffList, targetBuffIndex)
			end

			buffMo:onRemoveBuff()

			if buffMo.buffType == MiracleHeroBuffType.PropertyChange and (buffMo.proertyType == GameEnum.AttrType.Hp or buffMo.proertyType == GameEnum.AttrType.HpRate) then
				local buffInfo = {
					buffId = buffId,
					changeHp = petMo.curHp - beforeCurHp,
					afterChangeHp = petMo.curHp,
					changeMaxHp = petMo:getMaxHp() - beforeMaxHp,
					afterChangeMaxHp = petMo:getMaxHp()
				}

				table.insert(reportMo.effectHpBuffIds, buffInfo)

				changeReportMos[buffMo.targetId] = reportMo
			end
		end

		self._buffPool[buffMo.buffType]:returnObject(buffMo)

		self._buffMap[buffId] = nil
	end

	return changeReportMos
end

MiracleHeroBuffMgr.instance = MiracleHeroBuffMgr.New()

return MiracleHeroBuffMgr
