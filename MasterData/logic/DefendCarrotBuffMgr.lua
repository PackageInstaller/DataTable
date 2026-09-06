-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/buff/DefendCarrotBuffMgr.lua

module("logic.extensions.defendcarrot.model.buff.DefendCarrotBuffMgr", package.seeall)

local DefendCarrotBuffMgr = class("DefendCarrotBuffMgr")

DefendCarrotBuffMgr.BUFF_TYPE_ADD = 1
DefendCarrotBuffMgr.BUFF_TYPE_COVER = 2
DefendCarrotBuffMgr.BUFF_TYPE_STACK = 3
DefendCarrotBuffMgr.BUFF_TYPE_EXCLUSIVE = 4
DefendCarrotBuffMgr.TRIGGER_STAGE_CREATE = 1
DefendCarrotBuffMgr.TRIGGER_STAGE_ATTACK = 2
DefendCarrotBuffMgr.TRIGGER_STAGE_HIT = 3
DefendCarrotBuffMgr.TRIGGER_STAGE_BEHIT = 4
DefendCarrotBuffMgr.TRIGGER_STAGE_DAMAGE_BF = 5
DefendCarrotBuffMgr.TRIGGER_STAGE_DAMAGE_AF = 6
DefendCarrotBuffMgr.TRIGGER_STAGE_CAUSE_DAMAGE_BF = 7
DefendCarrotBuffMgr.TRIGGER_STAGE_CAUSE_DAMAGE_AF = 8
DefendCarrotBuffMgr.TRIGGER_Fixed_Interval = 9

function DefendCarrotBuffMgr:ctor()
	self._buffObjPool = {}
	self._buffTriggerParamMap = {}
end

function DefendCarrotBuffMgr:getTriggerParam(paramStr)
	self._buffTriggerParamMap[paramStr] = self._buffTriggerParamMap[paramStr] or string.split(paramStr, "#")

	return self._buffTriggerParamMap[paramStr]
end

function DefendCarrotBuffMgr:addBuffToUnitByBuffId(unit, buffId)
	if unit == nil then
		return
	end

	local buffCfg = DefendCarrotConfig.instance:getBuffCfg(buffId)

	if buffCfg then
		local targetType = buffCfg.targetType

		if GameUtil.isEmptyString(targetType) then
			self:addBuffToUnit(unit, buffCfg.createType, buffCfg)
		else
			local unitType = unit:getType()

			if targetType == unitType then
				self:addBuffToUnit(unit, buffCfg.createType, buffCfg)
			end
		end
	end
end

function DefendCarrotBuffMgr:getOrCreateBuff(unit, name, buffCfgId, triggerStage, cfg)
	local buff = self:getBuffInPool(name)

	if buff then
		buff:initData(unit, buffCfgId, triggerStage, cfg)
	end

	return buff
end

function DefendCarrotBuffMgr:addBuffToUnit(unit, buffType, cfg)
	if unit == nil or cfg == nil then
		return
	end

	if buffType == DefendCarrotBuffMgr.BUFF_TYPE_ADD then
		local buff = self:getOrCreateBuff(unit, cfg.triggerDone, cfg.buffId, cfg.triggerPhase, cfg)

		table.insert(unit.buffList, buff)
	elseif buffType == DefendCarrotBuffMgr.BUFF_TYPE_COVER then
		local buff = self:getOrCreateBuff(unit, cfg.triggerDone, cfg.buffId, cfg.triggerPhase, cfg)

		for i, v in ipairs(unit.buffList) do
			if v.buffCfgId == cfg.buffId then
				if cfg.triggerPhase == DefendCarrotBuffMgr.TRIGGER_STAGE_CREATE then
					return
				end

				unit.buffList[i] = buff

				return
			end
		end

		table.insert(unit.buffList, buff)
	elseif buffType == DefendCarrotBuffMgr.BUFF_TYPE_STACK then
		for i, v in ipairs(unit.buffList) do
			if v.buffCfgId == cfg.buffId then
				v:addLayerCount()

				return
			end
		end

		local buff = self:getOrCreateBuff(unit, cfg.triggerDone, cfg.buffId, cfg.triggerPhase, cfg)

		table.insert(unit.buffList, buff)
	elseif buffType == DefendCarrotBuffMgr.BUFF_TYPE_EXCLUSIVE then
		for i, v in ipairs(unit.buffList) do
			if v.buffCfgId == cfg.buffId then
				return
			end
		end

		local buff = self:getOrCreateBuff(unit, cfg.triggerDone, cfg.buffId, cfg.triggerPhase, cfg)

		table.insert(unit.buffList, buff)
	end
end

function DefendCarrotBuffMgr:getBuffInPool(buffName)
	if self._buffObjPool[buffName] == nil then
		local function createFuncBuff()
			return (self:_createBuff(buffName))
		end

		local function disposeFuncBuff(buff)
			return
		end

		local function resetFuncBuff(buff)
			return
		end

		self._buffObjPool[buffName] = ObjectPool.New(20, createFuncBuff, disposeFuncBuff, resetFuncBuff)
	end

	return (self._buffObjPool[buffName]:fetchObject())
end

function DefendCarrotBuffMgr:_createBuff(name)
	local buff

	if name == "new_buff" then
		buff = DefendCarrotNewBuffBuff.New(name)
	elseif name == "add_state" then
		buff = DefendCarrotCreateStatusBuff.New(name)
	elseif name == "penetrate" then
		buff = DefendCarrotPenetrateBuff.New(name)
	elseif name == "add_bullet_count" then
		buff = DefendCarrotAddBulletCountBuff.New(name)
	elseif name == "scheduled_recycling" then
		buff = DefendCarrotTimedDestructionBuff.New(name)
	elseif name == "increase_radius" then
		buff = DefendCarrotIncreaseRadiusBuff.New(name)
	elseif name == "change_attr" then
		buff = DefendCarrotChangeAttrBuff.New(name)
	elseif name == "bullet_bounce" then
		buff = DefendCarrotBulletBounceBuff.New(name)
	elseif name == "explosive_bullet" then
		buff = DefendCarrotExplosiveBulletBuff.New(name)
	elseif name == "slow_down_state" then
		buff = DefendCarrotSlowStateBuff.New(name)
	elseif name == "burning_state" then
		buff = DefendCarrotBurnBuff.New(name)
	elseif name == "frozen_state" then
		buff = DefendCarrotFrozenStateBuff.New(name)
	elseif name == "attack_count_trigger" then
		buff = DefendCarrotAttackCountTriggerBuff.New(name)
	else
		printError("DefendCarrotBuffMgr:_createBuff not find buff by name:" .. tostring(name))
	end

	return buff
end

function DefendCarrotBuffMgr:disposeBuff(buff)
	if self._buffObjPool and self._buffObjPool[buff.buffName] then
		self._buffObjPool[buff.buffName]:returnObject(buff)
	end
end

function DefendCarrotBuffMgr:onAdd(unit, target)
	for i, v in ipairs(unit.buffList) do
		if v:getIsAdded() == false then
			v:onAdd(target)
		end
	end

	for i, v in ipairs(unit.buffList) do
		v:setIsAdded()
	end
end

function DefendCarrotBuffMgr:onAttack(unit, target)
	for i, v in ipairs(unit.buffList) do
		v:onAttack(target)
	end
end

function DefendCarrotBuffMgr:onHit(unit, target)
	for i, v in ipairs(unit.buffList) do
		v:onHit(target)
	end
end

function DefendCarrotBuffMgr:onBeHit(unit, target)
	for i, v in ipairs(unit.buffList) do
		v:onBeHit(target)
	end
end

function DefendCarrotBuffMgr:onBeforeDoDamage(unit, target)
	for i, v in ipairs(unit.buffList) do
		v:onBeforeDoDamage(target)
	end
end

function DefendCarrotBuffMgr:onAfterDoDamage(unit, target, damValue)
	for i, v in ipairs(unit.buffList) do
		v:onAfterDoDamage(target, damValue)
	end
end

function DefendCarrotBuffMgr:onBeforeBeDamage(unit, target, damValue)
	for i, v in ipairs(unit.buffList) do
		v:onBeforeBeDamage(target, damValue)
	end
end

function DefendCarrotBuffMgr:onAfterBeDamage(unit, target, damValue)
	for i, v in ipairs(unit.buffList) do
		v:onAfterBeDamage(target, damValue)
	end
end

function DefendCarrotBuffMgr:onUpdate(unit, deltaTime)
	for i, v in ipairs(unit.buffList) do
		v:onUpdate(deltaTime)
	end
end

DefendCarrotBuffMgr.instance = DefendCarrotBuffMgr.New()

return DefendCarrotBuffMgr
