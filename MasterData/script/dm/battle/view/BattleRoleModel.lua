-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattleRoleModel.lua

BattleRoleSkillAction = class("BattleRoleSkillAction", _G.DisposableObject)

BattleRoleSkillAction:has("_actId", {
	is = "r"
})
BattleRoleSkillAction:has("_state", {
	is = "rw"
})
BattleRoleSkillAction:has("_targets", {
	is = "r"
})
BattleRoleSkillAction:has("_behaviorNode", {
	is = "rw"
})
BattleRoleSkillAction:has("_isInSupering", {
	is = "rwb"
})

BattleRoleSkillState = {
	Perform = 2,
	End = 3,
	Begin = 1
}

function BattleRoleSkillAction:initialize(id)
	super.initialize(self)

	self._actId = id
	self._targets = {}
	self._hurtTargets = {}
end

function BattleRoleSkillAction:dispose()
	super.dispose(self)
end

function BattleRoleSkillAction:addFlagForRole(roleId, flag)
	if self._targets[roleId] == nil then
		self._targets[roleId] = {}
	end

	local target = self._targets[roleId]

	if table.indexof(target, flag) then
		return
	end

	target[#target + 1] = flag
end

function BattleRoleSkillAction:delFlagForRole(roleId, flag)
	local target = self._targets[roleId]

	if target == nil then
		return
	end

	local index = table.indexof(target, flag)

	if index then
		table.remove(target, index)
	end

	if #target == 0 then
		self._targets[roleId] = nil
	end
end

function BattleRoleSkillAction:hasFlagWithRole(roleId, flag)
	local target = self._targets[roleId]

	if target == nil then
		return false
	end

	local index = table.indexof(target, flag)

	if index then
		return true
	end

	return false
end

function BattleRoleSkillAction:addHurtData(roleId, eft, raw)
	self._hurtTargets[roleId] = self._hurtTargets[roleId] or {
		raw = 0,
		eft = 0
	}

	local hurtInfo = self._hurtTargets[roleId]

	hurtInfo.eft = hurtInfo.eft + eft
	hurtInfo.raw = hurtInfo.raw + raw
end

function BattleRoleSkillAction:getHurtData(roleId)
	self._hurtTargets[roleId] = nil

	return self._hurtTargets[roleId]
end

function BattleRoleSkillAction:clearTargets()
	self._targets = {}
end

BattleRoleModel = class("BattleRoleModel", DisposableObject)

BattleRoleModel:has("_hp", {
	is = "r"
})
BattleRoleModel:has("_rp", {
	is = "r"
})
BattleRoleModel:has("_star", {
	is = "rw"
})
BattleRoleModel:has("_cost", {
	is = "rw"
})
BattleRoleModel:has("_maxHp", {
	is = "rw"
})
BattleRoleModel:has("_maxRp", {
	is = "rw"
})
BattleRoleModel:has("_shield", {
	is = "rw"
})
BattleRoleModel:has("_roleId", {
	is = "rw"
})
BattleRoleModel:has("_cellId", {
	is = "rw"
})
BattleRoleModel:has("_modelId", {
	is = "rw"
})
BattleRoleModel:has("_genre", {
	is = "rw"
})
BattleRoleModel:has("_isProcessingBoss", {
	is = "rw"
})
BattleRoleModel:has("_context", {
	is = "r"
})
BattleRoleModel:has("_roleType", {
	is = "rw"
})
BattleRoleModel:has("_performAct", {
	is = "rw"
})
BattleRoleModel:has("_skillActions", {
	is = "r"
})
BattleRoleModel:has("_actFlags", {
	is = "r"
})
BattleRoleModel:has("_awakenLevel", {
	is = "rw"
})
BattleRoleModel:has("_modelScale", {
	is = "rw"
})
BattleRoleModel:has("_configId", {
	is = "rw"
})
BattleRoleModel:has("_isSummond", {
	is = "rw"
})
BattleRoleModel:has("_side", {
	is = "rw"
})
BattleRoleModel:has("_flags", {
	is = "rw"
})
BattleRoleModel:has("_isBattleField", {
	is = "rw"
})

function BattleRoleModel:initialize(context)
	super.initialize(self)

	self._context = context
	self._status = {}
	self._actFlags = {}
	self._skillActions = {}
	self._blockInfo = {}
end

function BattleRoleModel:dispose()
	super.dispose(self)
end

function BattleRoleModel:setModelId(modelId)
	self._modelId = modelId
	self._modelConfig = ConfigReader:getRecordById("RoleModel", modelId)
end

function BattleRoleModel:getModelConfig()
	return self._modelConfig
end

function BattleRoleModel:hasFlag(flag)
	for k, v in pairs(self._flags) do
		if v == flag then
			return true
		end
	end

	return false
end

function BattleRoleModel:setMaxHp(maxHp)
	self._orgMaxHp = self._orgMaxHp or maxHp
	self._maxHp = maxHp
end

function BattleRoleModel:getOrgMaxHp()
	return self._orgMaxHp or self._maxHp
end

function BattleRoleModel:setHp(hp)
	if not self._hp then
		local last = 0

		self._hp = hp

		local data = {
			hp = hp,
			diff = hp - last,
			roleId = self._roleId
		}

		self._context:dispatch(Event:new(EVT_Battle_Hp_Changed, data))
	end
end

function BattleRoleModel:setRp(rp)
	if not self._rp then
		local last = 0

		self._rp = rp

		local data = {
			rp = rp,
			diff = rp - last,
			roleId = self._roleId
		}

		self._context:dispatch(Event:new(EVT_Battle_Rp_Changed, data))
	end
end

function BattleRoleModel:updateMaxHp(maxHp, hp)
	self:setMaxHp(maxHp)

	if not self._hp then
		local last = 0

		self._hp = hp

		local data = {
			maxHp = maxHp,
			hp = hp,
			diff = hp - last,
			roleId = self._roleId
		}

		self._context:dispatch(Event:new(EVT_Battle_Hp_Changed, data))
	end
end

function BattleRoleModel:setShield(shield)
	self._shield = shield

	self._context:dispatch(Event:new(EVT_Battle_Shield_Changed))
end

function BattleRoleModel:setStatus(status, count)
	self._status[status] = count and count > 0 and true or nil
end

function BattleRoleModel:hasStatus(status)
	return self._status[status]
end

function BattleRoleModel:addBlockInfo(act)
	if act == nil then
		return
	end

	self._blockInfo[act] = true
end

function BattleRoleModel:getBlockInfo(act)
	return self._blockInfo[act]
end
