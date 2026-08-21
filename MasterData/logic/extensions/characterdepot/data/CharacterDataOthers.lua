-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/data/CharacterDataOthers.lua

module("logic.extensions.characterdepot.data.CharacterDataOthers", package.seeall)

local M = class("CharacterDataOthers", CharacterBaseData)

function M:ctor(params)
	M.super.ctor(self, params.hero)
	self:buildEquips(params.equip)
	self:buildEcho(params.echo)
	self:buildThink(params.thinking)
end

function M:buildEquips(info)
	local heroEquip = self._equipData

	for _, v in ipairs(info) do
		local equip = EquipmentData.New({
			itemId = v.itemId,
			uuid = v.equipUuid
		})

		equip:setLevelAndExp(v.level, v.exp)
		equip:refreshAttrs(v.attrs)
		equip:setDiceAttr(v.originDice)
		equip:setExtraDiceAttrs(v.fixedDices)
		equip:setHeroId(self:getId())
		heroEquip:refreshEquipByPart(equip:getPart(), equip)
	end
end

function M:buildEcho(info)
	if info.id ~= 0 then
		local heroEcho = self._heroEchoItemData
		local echoItemData = EchoItemData.New({
			itemId = info.id,
			uuid = info.id
		})

		echoItemData:setLevel(info.level)
		echoItemData:setHeroId(self:getId())
		heroEcho:setEchoItem(echoItemData)
	end
end

function M:buildThink(info)
	local heroThink = self._thinkingItemData
	local thinkList = info.thinking
	local unlockList = {}
	local lockList = {}

	for _, v in ipairs(thinkList) do
		local cfg = ThinkingConfig.instance:getThinkingCO(v.id)
		local think = ThinkingMO.New(cfg)

		for _, skill in ipairs(v.skill) do
			think:setSkillLevel(skill.id, skill.lv)
		end

		if v.id == info.wearId then
			heroThink:setThinkingMo(think)
			heroThink:setWearingSkillId(info.wearSkill or 0)
		elseif v.unlock then
			table.insert(unlockList, think)
		else
			table.insert(lockList, think)
		end
	end

	heroThink:setLockList(lockList)
	heroThink:setUnLockList(unlockList)
end

return M
