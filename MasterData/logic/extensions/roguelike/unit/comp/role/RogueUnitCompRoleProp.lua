-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/role/RogueUnitCompRoleProp.lua

module("logic.extensions.roguelike.unit.comp.role.RogueUnitCompRoleProp", package.seeall)

local M = class("RogueUnitCompRoleProp", RogueUnitCompBase)
local MIN_SAN_VALUE = 0

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._san = 0
	self._hp = 0
	self._roleId = 0
	self._roleIndex = 0
	self._propertyInfo = {}
end

function M:setSan(san, isCheckDeath)
	if san == nil then
		print("设置san为空", debug.traceback())

		return
	end

	if self._san ~= 0 and san < self._san then
		self._unit.meshModel:play(RoguelikeConst.ROGUE_MONSTER_ANI.HIT, false, true)
	end

	local lastSan = self._san or 0

	self._san = san

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_ROLE_INFO, self._roleId, self._roleIndex, nil, self._san - lastSan)

	if isCheckDeath then
		self:checkShowDeath()
	end
end

function M:getSan()
	return self._san + RoguelikeConst.SAN_OFFSET
end

function M:reduceSan(reduce)
	local lastSan = self._san or 0

	self._san = self._san - reduce < MIN_SAN_VALUE and MIN_SAN_VALUE or self._san - reduce

	print("ROGUE", "角色扣San", self._roleId, reduce, "剩余San", self._san)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_ROLE_INFO, self._roleId, self._roleIndex, nil, self._san - lastSan)
	self:checkShowDeath()
end

function M:setHp(hp, isCheckDeath)
	local lastHp = self._hp

	if self._hp ~= 0 and hp < self._hp then
		self._unit.meshModel:play(RoguelikeConst.ROGUE_MONSTER_ANI.HIT, false, true)
		self._unit.material:showOutlineColor("#BF0000")
	end

	self._hp = hp

	if self._hp - lastHp ~= 0 then
		RogueBroadcastModel.instance:addMoByRoleHpChange(self:getRoleId(), self._hp - lastHp)
	end

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_ROLE_INFO, self._roleId, self._roleIndex, self._hp - lastHp)

	if isCheckDeath then
		self:checkShowDeath()
	end
end

function M:getHp()
	return self._hp
end

function M:setHpMax(hpMax)
	self._hpMax = hpMax
end

function M:getHpMax()
	return self._hpMax
end

function M:setSanMax(sanMax)
	self._sanMax = sanMax
end

function M:getSanMax()
	return self._sanMax + RoguelikeConst.SAN_OFFSET
end

function M:reduceHp(reduce)
	local lastHp = self._hp

	self._hp = self._hp - reduce < 0 and 0 or self._hp - reduce

	print("ROGUE", "角色扣血", self._roleId, reduce, "剩余血量", self._hp)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_ROLE_INFO, self._roleId, self._roleIndex, self._hp - lastHp)
	self:checkShowDeath()
end

function M:setRoleInfo(roleId, roleIndex)
	self._roleId = roleId
	self._heroCO = PastInfoConfig.instance:getCharacterInfo(self._roleId)
	self._characterCo = CharacterConfig.instance:getCharacterItemInfo(roleId)
	self._roleIndex = roleIndex
	self._characterCo = CharacterConfig.instance:getCfgInfoByID(self._roleId)
end

function M:getRoleId()
	return self._roleId
end

function M:getModelId()
	return self._characterCo and self._characterCo.modelId or 0
end

function M:getCard()
	local cards = RoguelikeModel.instance:getRoleCard(self:getRoleId()) or {}

	return #cards
end

function M:getCardIds()
	return RoguelikeModel.instance:getRoleCardIds(self:getRoleId())
end

function M:getCardId(index)
	return self:getCardIds()[index]
end

function M:getCardNos()
	return RoguelikeModel.instance:getRoleCard(self:getRoleId()) or {}
end

function M:getCardNo(cardId, index)
	local nos = self:getCardNos()

	if index ~= nil and index <= #nos then
		return nos[index]
	end

	for k, v in ipairs(nos) do
		if v.cardId == cardId then
			return v
		end
	end
end

function M:getCardSlotIsFull(index)
	local cardId = self:getCardId(index)
	local cardCo = RoguelikeConfig.instance:getRoleActionById(cardId)
	local cardNo = self:getCardNo(cardId, index)
	local openConfig = RoguelikeConfig.instance:getConstByName("CardSlotOpen").numValues
	local propLevel = self:getPropertyLevel(cardCo.attr)
	local openLevel = 1

	for k, v in pairs(openConfig) do
		if v <= propLevel then
			openLevel = k
		end
	end

	local curSlotCount = 0

	for k, v in ipairs(cardNo.entry or {}) do
		local entryCo = RoguelikeConfig.instance:getCardEntryById(v)

		if entryCo.type == 1 then
			curSlotCount = curSlotCount + 1
		end
	end

	return openLevel <= curSlotCount
end

function M:getAllCardSlotIsFull()
	local isFull = true

	for k, v in pairs(self:getCardIds()) do
		isFull = isFull and self:getCardSlotIsFull(k)
	end

	return isFull
end

function M:getCardMax()
	return RoguelikeConst.CARD_MAX
end

function M:getHeadIcon()
	return self._characterCo and self._characterCo.icon or ""
end

function M:getRoleIndex()
	return self._roleIndex
end

function M:initProperty(power, agile, lucky, insight, knowledge, communicate)
	local PROP = RoguelikeConst.ROLE_PROP

	self._propertyInfo[PROP.POWER] = power
	self._propertyInfo[PROP.AGILE] = agile
	self._propertyInfo[PROP.LUCKY] = lucky
	self._propertyInfo[PROP.INSIGHT] = insight
	self._propertyInfo[PROP.KNOWLEDGE] = knowledge
	self._propertyInfo[PROP.COMMUNICATE] = communicate
end

function M:getPropertyValue(prop)
	return self._propertyInfo[prop].value or 0
end

function M:getPropertyLevel(prop)
	return self._propertyInfo[prop].level or 0
end

function M:setPropertyLevel(prop, level)
	self._propertyInfo[prop].level = level

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_ROLE_INFO, self._roleId, self._roleIndex)
end

function M:updateProperty(six)
	for i = 1, 6 do
		self._propertyInfo[i].level = six[i]
	end
end

function M:checkShowDeath()
	if self:getIsDeath() and not self._showDeathMsg then
		self._showDeathMsg = true

		local format = RoguelikeConfig.getBroadCast("Broadcast_Role_Death")
		local msg = string.format(format, self:getName())

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROLE_DEATH, self._roleId, self._roleIndex)
	end
end

function M:getIsDeath()
	return self._hp <= 0
end

function M:getIsFullHp()
	return self._hp == self._hpMax
end

function M:getIsFullSan()
	return self._san == self._sanMax
end

function M:updateByNO(no, index)
	self:setSanMax(RoguelikeModel.instance:getRoleSanMax(), true)
	self:setHpMax(no.attr[RoguelikeConst.ROLE_PROP.HP_MAX])
	self:setSan(RoguelikeModel.instance:getRoleSan())
	self:setHp(no.attr[RoguelikeConst.ROLE_PROP.HP], true)

	for i = 1, 6 do
		self:setPropertyLevel(i, no.attr[i])
	end

	self:setRoleInfo(no.code, index)
end

function M:getName()
	return self._heroCO.name
end

function M:getCampId()
	return self._characterCo.camp
end

return M
