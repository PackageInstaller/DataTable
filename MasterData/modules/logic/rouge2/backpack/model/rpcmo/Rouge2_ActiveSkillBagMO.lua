-- chunkname: @modules/logic/rouge2/backpack/model/rpcmo/Rouge2_ActiveSkillBagMO.lua

module("modules.logic.rouge2.backpack.model.rpcmo.Rouge2_ActiveSkillBagMO", package.seeall)

local Rouge2_ActiveSkillBagMO = pureTable("Rouge2_ActiveSkillBagMO", Rouge2_BagMO)

function Rouge2_ActiveSkillBagMO:_onCreateItemDone(itemMo)
	local skillId = itemMo:getItemId()

	Rouge2_MapLocalDataHelper.setActiveSkillDropIndex(skillId)
end

function Rouge2_ActiveSkillBagMO:_onUpdateItemListDone()
	self:_sortItemList()
end

function Rouge2_ActiveSkillBagMO:_onRemoveItemDone()
	self:_sortItemList()
end

function Rouge2_ActiveSkillBagMO:_sortItemList()
	table.sort(self._itemList, self._itemSortFunc)
end

function Rouge2_ActiveSkillBagMO._itemSortFunc(aItem, bItem)
	local aItemId = aItem:getItemId()
	local bItemId = bItem:getItemId()
	local aDropIndex = Rouge2_MapLocalDataHelper.getActiveSkillDropIndex(aItemId)
	local bDropIndex = Rouge2_MapLocalDataHelper.getActiveSkillDropIndex(bItemId)

	if aDropIndex ~= bDropIndex then
		return aDropIndex < bDropIndex
	end

	local aConfig = aItem:getConfig()
	local bConfig = bItem:getConfig()
	local aSkillType = aConfig and aConfig.skillTypeName
	local bSkillType = bConfig and bConfig.skillTypeName

	if aSkillType ~= bSkillType then
		return aSkillType < bSkillType
	end

	if aItemId ~= bItemId then
		return aItemId < bItemId
	end

	local aUid = aItem:getUid()
	local bUid = bItem:getUid()

	return aUid < bUid
end

return Rouge2_ActiveSkillBagMO
