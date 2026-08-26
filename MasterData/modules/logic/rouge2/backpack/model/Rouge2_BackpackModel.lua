-- chunkname: @modules/logic/rouge2/backpack/model/Rouge2_BackpackModel.lua

module("modules.logic.rouge2.backpack.model.Rouge2_BackpackModel", package.seeall)

local Rouge2_BackpackModel = class("Rouge2_BackpackModel", BaseModel)

function Rouge2_BackpackModel:onInit()
	self._bagInfo = nil
end

function Rouge2_BackpackModel:reInit()
	self:onInit()
end

function Rouge2_BackpackModel:getActiveSkillHoleStatus(index)
	local isUse = self:isActiveSkillIndexInUse(index)

	if isUse then
		if not Rouge2_Enum.ActiveSkillHoleStatus.Equip then
			return Rouge2_Enum.ActiveSkillHoleStatus.Empty
		end
	end
end

function Rouge2_BackpackModel:isActiveSkillIndexInUse(index)
	local skillMo = self:index2UseActiveSkill(index)

	return skillMo and skillMo ~= nil
end

function Rouge2_BackpackModel:index2UseActiveSkill(index)
	if not index then
		return
	end

	local itemList = self:getItemList(Rouge2_Enum.BagType.ActiveSkill)

	return itemList and itemList[index]
end

function Rouge2_BackpackModel:updateBagInfo(bagInfo)
	self._bagInfo = self._bagInfo or Rouge2_BagInfoMO.New()

	self._bagInfo:init(bagInfo)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onUpdateBagInfo)
end

function Rouge2_BackpackModel:updateItems(itemInfoList)
	local bagInfo = self:getBagInfo()

	if bagInfo then
		bagInfo:updateItems(itemInfoList)
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onUpdateBagInfo)
end

function Rouge2_BackpackModel:removeItems(itemInfoList)
	local bagInfo = self:getBagInfo()

	if bagInfo then
		bagInfo:removeItems(itemInfoList)
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onUpdateBagInfo)
end

function Rouge2_BackpackModel:getBagInfo()
	return self._bagInfo
end

function Rouge2_BackpackModel:getSubBag(bagType)
	local bagInfo = self:getBagInfo()

	return bagInfo and bagInfo:getBag(bagType)
end

function Rouge2_BackpackModel:getItemList(bagType)
	local bagMo = self:getSubBag(bagType)

	return bagMo and bagMo:getItemList()
end

function Rouge2_BackpackModel:getItemListByItemId(itemId)
	local bagType = Rouge2_BackpackHelper.itemId2BagType(itemId)
	local bagMo = self:getSubBag(bagType)

	return bagMo and bagMo:getItemListByItemId(itemId)
end

function Rouge2_BackpackModel:getFilterItemList(bagType, filterTypeMap)
	local itemList = self:getItemList(bagType)

	return Rouge2_BackpackHelper.filterItemList(itemList, filterTypeMap)
end

function Rouge2_BackpackModel:getItem(uid)
	local bagType = Rouge2_BackpackHelper.uid2BagType(uid)
	local bagMo = self:getSubBag(bagType)

	return bagMo and bagMo:getItem(uid)
end

function Rouge2_BackpackModel:getNotUniqueCollectionNum()
	local allMoList = self:getItemList(Rouge2_Enum.BagType.Relics)
	local num = 0

	if allMoList then
		for _, relicsMo in ipairs(allMoList) do
			if not Rouge2_CollectionHelper.isUniqueCollection(relicsMo.itemId) then
				num = num + 1
			end
		end
	end

	return num
end

function Rouge2_BackpackModel:getAttrUpdateActiveRelicsList(attrId, attrValue)
	attrValue = attrValue or Rouge2_Model.instance:getAttrValue(attrId)

	local relicsList = Rouge2_CollectionConfig.instance:getAttrUpdateRelicsList(attrId, attrValue)

	if relicsList then
		local hasRelcisList = {}
		local hasRelicsIdList = {}

		for _, relicsInfo in ipairs(relicsList) do
			local relicsCo = relicsInfo.config
			local relicsId = relicsCo and relicsCo.id
			local itemList = Rouge2_BackpackModel.instance:getItemListByItemId(relicsId)

			if itemList and #itemList > 0 then
				table.insert(hasRelcisList, relicsInfo)
				table.insert(hasRelicsIdList, relicsId)
			end
		end

		return hasRelcisList, hasRelicsIdList
	end
end

function Rouge2_BackpackModel:getCurBoxPoint()
	local leaderInfo = Rouge2_Model.instance:getLeaderInfo()

	if leaderInfo then
		if not leaderInfo.consumeAttrNum then
			local consumeAttrNum = 0
			local boxAttrId = tonumber(lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.BXSBoxCountAttrId].value)
			local attrValue = Rouge2_Model.instance:getAttrValue(boxAttrId)

			return attrValue - consumeAttrNum
		end
	end
end

function Rouge2_BackpackModel:getTalentStatus(talentId)
	local talentCo = Rouge2_CareerConfig.instance:getTalentConfig(talentId)

	if not talentCo then
		return
	end

	if self:isTalentActive(talentId) then
		if self:isActiveSkillIndexInUse(talentCo.ordinal) then
			return Rouge2_Enum.ActiveSkillHoleStatus.Equip
		end

		return Rouge2_Enum.BagTalentStatus.Active, Rouge2_Enum.BagTalentNotActiveReason.HasActive
	end

	if not Rouge2_BackpackController.instance:isPreTalentActive(talentId) then
		return Rouge2_Enum.BagTalentStatus.Lock, Rouge2_Enum.BagTalentNotActiveReason.NotActivePreTalent
	end

	if not Rouge2_MapUnlockHelper.checkIsUnlock(talentCo.unlock) then
		return Rouge2_Enum.BagTalentStatus.Lock, Rouge2_Enum.BagTalentNotActiveReason.NotPassCondition
	end

	local canUsePointNum = self:getCanUseTalentPoint()

	if canUsePointNum < talentCo.unlockCost then
		return Rouge2_Enum.BagTalentStatus.UnlockNotActive, Rouge2_Enum.BagTalentNotActiveReason.LackTalentPoint
	end

	return Rouge2_Enum.BagTalentStatus.UnlockCanActive
end

function Rouge2_BackpackModel:isTalentActive(talentId)
	local leaderInfo = Rouge2_Model.instance:getLeaderInfo()

	return leaderInfo and leaderInfo:isTalentActive(talentId)
end

function Rouge2_BackpackModel:getActiveTalentIds()
	local leaderInfo = Rouge2_Model.instance:getLeaderInfo()

	return leaderInfo and leaderInfo:getActiveTalentIds()
end

function Rouge2_BackpackModel:getLastTransformTalentId()
	local transformIdList = Rouge2_CareerConfig.instance:getTalentTransformIdList()

	if transformIdList then
		if not #transformIdList then
			local transformIdNum = 0

			for i = transformIdNum, 1, -1 do
				local transformId = transformIdList[i]

				if self:isTalentActive(transformId) then
					return transformId, i
				end
			end
		end
	end
end

function Rouge2_BackpackModel:getCanUseTalentPoint()
	local leaderInfo = Rouge2_Model.instance:getLeaderInfo()

	return leaderInfo and leaderInfo:getTalentPoint() or 0
end

Rouge2_BackpackModel.instance = Rouge2_BackpackModel.New()

return Rouge2_BackpackModel
