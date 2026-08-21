-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/model/RogueJudgeModel.lua

module("logic.extensions.roguelike.flow.model.RogueJudgeModel", package.seeall)

local M = class("RogueJudgeModel", AbstractGlobalReusable)
local kTakeDamage = "AttackDamage"
local kReduceDiceWall = "ReduceDiceWall"
local kAddDiceWall = "AddDiceWall"
local kReduceSan = "ReduceSan"
local kReduceCoin = "ReduceCoin"
local kAddDicePattern = "AddDiceFace"
local kShield2Attack = "Shield2Attack"
local kShield2ReduceDiceWall = "Shield2ReduceDiceWall"
local kShield2Coin = "Shield2Coin"
local kAttack2Hurt = "Attack2Hurt"
local kRecoveryHurt = "RecoveryHurt"
local kShield2Hurt = "Shield2Hurt"
local kAddCardEntryNext = "AddCardEntryNext"

M.RoleActionType = {
	TakeDamage = kTakeDamage,
	ReduceDiceWall = kReduceDiceWall,
	AddDiceWall = kAddDiceWall,
	ReduceSan = kReduceSan,
	ReduceCoin = kReduceCoin,
	AddDicePattern = kAddDicePattern,
	Shield2Attack = kShield2Attack,
	Shield2ReduceDiceWall = kShield2ReduceDiceWall,
	Shield2Coin = kShield2Coin,
	Attack2Hurt = kAttack2Hurt,
	RecoveryHurt = kRecoveryHurt,
	Shield2Hurt = kShield2Hurt,
	AddCardEntryNext = kAddCardEntryNext
}
M.RoleCardEntry = {
	DICE_SACRIFICE = "DICE_SACRIFICE",
	THROW_RESULT = "THROW_RESULT",
	DICE_SUCCESS = "DICE_SUCCESS",
	MAKE_SHIELD = "MAKE_SHIELD",
	DICE_BLEED = "DICE_BLEED",
	DICE_TRANCE = "DICE_TRANCE",
	MAKE_BATTER = "MAKE_BATTER",
	GET_EFFECT_ID = "GET_EFFECT_ID",
	DICE_ECLIPSE = "DICE_ECLIPSE",
	MAKE_DAMAGE = "MAKE_DAMAGE"
}

function M:ctor()
	self._roleSelectActionId = nil
end

function M:reset()
	return
end

function M:setRoleDiceWall(diceWall)
	self._roleDiceWall = diceWall
end

function M:addRoleDiceWall(offset)
	local addOffset = offset ~= nil and offset or 1

	self._roleDiceWall = self._roleDiceWall or 0
	self._roleDiceWall = self._roleDiceWall + addOffset
end

function M:getRoleDiceWall()
	if not self._roleDiceWall then
		local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

		self._roleDiceWall = judgeArchive and judgeArchive.roleWall or 0
	end

	return self._roleDiceWall or 0
end

function M:setRoleSelectAction(actionId, actionIndex)
	self._roleSelectActionId = actionId
	self._roleSelectActionIndex = actionIndex
end

function M:getCurEntries()
	return self:getSelectCardEntries(self:getRoleSelectAction(), RogueMgr.instance:getModel():getCurRoleMo(), self:getRoleSelectActionIndex())
end

function M:getSelectCardEntries(cardId, _roleProp, index)
	local roleProp = _roleProp or RogueMgr.instance:getModel():getCurRoleMo()
	local cardNo = roleProp:getCardNo(cardId or self:getRoleSelectAction(), index)
	local cardCo = RoguelikeConfig.instance:getRoleActionById(cardId or self:getRoleSelectAction())
	local entries = {}

	if cardNo then
		local slotCount = RoguelikeUtil.instance:getCardSlotCount(roleProp:getPropertyLevel(cardCo.attr))
		local typeCount = 0

		for k, v in ipairs(cardNo.entry) do
			local co = RoguelikeConfig.instance:getCardEntryById(v)

			if co.type ~= 2 and typeCount < slotCount then
				table.insert(entries, v)

				typeCount = typeCount + 1
			elseif co.type == 2 then
				table.insert(entries, v)
			end
		end
	else
		printError("角色卡牌找不到", cardId)
	end

	local tempEntries = {}
	local continueEntries = {}
	local stateMgr = RogueMgr.instance:getRogueFlow().stateMgr
	local roleIndex = RogueMgr.instance:getModel():getCurRoleIndex()

	for k, v in pairs(stateMgr:getClientNextCardEntries()) do
		if roleProp:getRoleIndex() == roleIndex then
			table.insert(entries, v)
			table.insert(tempEntries, v)
		end
	end

	for k, v in pairs(stateMgr:getContinueEntries()) do
		table.insert(entries, v)
		table.insert(continueEntries, v)
	end

	return entries, tempEntries, continueEntries
end

function M:getRoleSelectAction()
	return self._roleSelectActionId or 0
end

function M:getRoleSelectActionCo()
	local actionCo = RoguelikeConfig.instance:getRoleActionById(self._roleSelectActionId)

	return actionCo
end

function M:getRoleSelectActionIndex()
	return self._roleSelectActionIndex or 1
end

function M:getRoleSelectActionProp()
	local actionCo = RoguelikeConfig.instance:getRoleActionById(self._roleSelectActionId)

	if actionCo then
		return actionCo.attr
	else
		printError("找不到行动配置", self._roleSelectActionId)
	end

	return 1
end

function M:getRoleActionIsDiceWall()
	local result, param = self:getRoleActionAndEffect(kAddDiceWall)

	return result, param
end

function M:getRoleActionIsTakeDamage()
	local result, param = self:getRoleActionAndEffect(kTakeDamage)

	return result, param
end

function M:getRoleActionIsReduceDiceWall()
	local result, param = self:getRoleActionAndEffect(kReduceDiceWall)

	return result, param
end

function M:getRoleActionIsAddSan()
	local result, param = self:getRoleActionAndEffect(kReduceSan)

	return result, param
end

function M:getRoleActionIsAddCoin()
	local result, param = self:getRoleActionAndEffect(kReduceCoin)

	return result, param
end

function M:getRoleActionIsAddPattern()
	local result, param = self:getRoleActionAndEffect(kAddDicePattern)

	return result, param
end

function M:getMonsterActionIsTakeDamage()
	local result, param = self:getMonsterActionAndEffect(kTakeDamage)

	return result, param
end

function M:getMonsterActionIsDiceWall()
	local result, param = self:getMonsterActionAndEffect(kAddDiceWall)

	return result, param
end

function M:getMonsterActionIsReduceSan()
	local result, param = self:getMonsterActionAndEffect(kReduceSan)

	return result, param
end

function M:getMonsterActionIsReduceCoin()
	local result, param = self:getMonsterActionAndEffect(kReduceCoin)

	return result, param
end

function M:getRoleActionEffectId()
	local actionCo = RoguelikeConfig.instance:getRoleActionById(self._roleSelectActionId)

	if actionCo then
		return actionCo.effect
	end

	return 0
end

function M:getRoleActionEffectDesc()
	local actionCo = RoguelikeConfig.instance:getRoleActionById(self._roleSelectActionId)
	local desc = ""

	if actionCo then
		for k, v in pairs(actionCo.effect) do
			local effectCO = RoguelikeConfig.instance:getEffectById(v)

			if effectCO then
				desc = desc .. " " .. effectCO.description
			else
				printError("找不到效果", v)
			end
		end
	end

	return desc
end

function M:getMonsterActionAndEffect(clientProgram)
	local actionId = RogueMgr.instance:getRogueFlow().judgeMgr:getMonsterActionId()
	local actionCo = RoguelikeConfig.instance:getMonsterActionById(actionId)

	if actionCo then
		for k, v in pairs(actionCo.effect) do
			local effectCO = RoguelikeConfig.instance:getEffectById(v)

			if effectCO then
				if clientProgram == effectCO.clientProgram then
					return true, effectCO.params
				end
			else
				printError("找不到效果", v)
			end
		end
	end

	return false
end

function M:getRoleActionAndEffect(clientProgram, actionId)
	local curActionId = actionId or self._roleSelectActionId
	local actionCo = RoguelikeConfig.instance:getRoleActionById(curActionId)

	if actionCo then
		for k, v in pairs(actionCo.effect) do
			local effectCO = RoguelikeConfig.instance:getEffectById(v)

			if effectCO then
				if clientProgram == effectCO.clientProgram then
					return true, effectCO.params
				end
			else
				printError("找不到效果", actionCo.effect)
			end
		end
	end

	return false
end

function M:getCurRoleActionClientProgram(actionId)
	local curActionId = actionId or self._roleSelectActionId
	local actionCo = RoguelikeConfig.instance:getRoleActionById(curActionId)
	local result = {}

	if actionCo then
		for k, v in pairs(actionCo.effect) do
			local effectCO = RoguelikeConfig.instance:getEffectById(v)

			if effectCO then
				table.insert(result, effectCO.clientProgram)
			end
		end
	end

	return result
end

function M:getCurMonsterActionEffectByClientProgram(program)
	local actionId = RogueMgr.instance:getRogueFlow().judgeMgr:getMonsterActionId()
	local actionCo = RoguelikeConfig.instance:getMonsterActionById(actionId)

	if actionCo then
		for k, v in pairs(actionCo.effect) do
			local effectCO = RoguelikeConfig.instance:getEffectById(v)

			if effectCO.clientProgram == program then
				return effectCO.id
			end
		end
	end

	return ""
end

function M:getMonsterAttackDamage(effectParam, useLast)
	if useLast and self._monsterAttack then
		return self._monsterAttack
	end

	local rate = tonumber(string.split(effectParam, "#")[2]) or 1
	local monsterProp = RogueMgr.instance:getModel():getCurMonster().monsterProp

	self._monsterAttack = math.floor(monsterProp:getActionSection() * rate) + RogueMgr.instance:getStateMgr():getMonsterAttrBase()

	return self._monsterAttack
end

function M:setMonsterAttack(attack)
	self._monsterAttack = attack
end

function M:getMonsterAttack()
	return self._monsterAttack or 0
end

function M:getMonsterDefenseWall(effectParam, useLast)
	if useLast and self._monsterDefense then
		return self._monsterDefense
	end

	local rate = tonumber(effectParam) or 1
	local monsterProp = RogueMgr.instance:getModel():getCurMonster().monsterProp

	self._monsterDefense = math.floor(monsterProp:getActionSection() * rate) + RogueMgr.instance:getStateMgr():getMonsterAttrBase()

	return self._monsterDefense
end

function M:getMonsterReduceSanCount(effectParam)
	local param = string.split(effectParam, "#")
	local rate = tonumber(param[#param]) or 1
	local monsterProp = RogueMgr.instance:getModel():getCurMonster().monsterProp

	return monsterProp:getActionSection() * rate
end

function M:getMonsterReduceCoinCount(effectParam)
	local param = string.split(effectParam, "#")
	local rate = tonumber(param[#param]) or 1
	local monsterProp = RogueMgr.instance:getModel():getCurMonster().monsterProp

	return monsterProp:getActionSection() * rate
end

function M:execCardEntries(effectTime, target)
	local entries = self:getCurEntries()
	local totalResult = 0

	for k, v in pairs(entries) do
		local entryCo = RoguelikeConfig.instance:getCardEntryById(v)

		if entryCo then
			local params = string.split(entryCo.effect, "#")
			local program = params[1]
			local result = RogueMgr.instance:getRogueFlow().judgeMgr:getCardEntryHandler(program):execAction(effectTime, entryCo, target)

			if type(result) == "number" then
				totalResult = totalResult + result
			end
		end
	end

	return totalResult
end

function M:destroy()
	self:reset()
end

return M
