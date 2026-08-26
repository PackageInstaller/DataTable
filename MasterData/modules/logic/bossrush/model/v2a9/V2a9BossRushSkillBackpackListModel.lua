-- chunkname: @modules/logic/bossrush/model/v2a9/V2a9BossRushSkillBackpackListModel.lua

module("modules.logic.bossrush.model.v2a9.V2a9BossRushSkillBackpackListModel", package.seeall)

local V2a9BossRushSkillBackpackListModel = class("V2a9BossRushSkillBackpackListModel", ListScrollModel)

function V2a9BossRushSkillBackpackListModel:setMoList(stage)
	local list = AssassinItemModel.instance:getAssassinItemMoList()
	local moList = {}

	for _, mo in ipairs(list) do
		local _mo = V2a9BossRushAssassinMO.New()

		_mo:init(mo, stage)
		table.insert(moList, _mo)
	end

	self:setList(moList, stage)
end

function V2a9BossRushSkillBackpackListModel:initSelect()
	local selectId = V2a9BossRushModel.instance:getSelectedItemId()
	local moList = self:getList()
	local index

	if selectId then
		local mo = self:getById(selectId)

		index = self:getIndex(mo)
	else
		index = 1
		selectId = moList[1] and moList[index]:getId()

		V2a9BossRushModel.instance:selectSpItemId(selectId)
	end

	if selectId and index then
		self:selectCell(index, true)
	end
end

function V2a9BossRushSkillBackpackListModel:getMObyItemType(itemType)
	for _, mo in ipairs(self:getList()) do
		if mo.itemType == itemType then
			return mo
		end
	end
end

V2a9BossRushSkillBackpackListModel.instance = V2a9BossRushSkillBackpackListModel.New()

return V2a9BossRushSkillBackpackListModel
