-- chunkname: @modules/logic/rouge2/backpack/controller/Rouge2_AttrDropController.lua

module("modules.logic.rouge2.backpack.controller.Rouge2_AttrDropController", package.seeall)

local Rouge2_AttrDropController = class("Rouge2_AttrDropController", BaseController)

function Rouge2_AttrDropController:canGetAttrDropReward(attrId)
	local careerId = Rouge2_Model.instance:getCareerId()
	local attrValue = Rouge2_Model.instance:getAttrValue(attrId)
	local dropList = Rouge2_AttributeConfig.instance:getAttrDropListByAttrValue(careerId, attrId, attrValue)

	if not dropList or #dropList <= 0 then
		return
	end

	for _, dropCo in ipairs(dropList) do
		if not Rouge2_Model.instance:isGetAttrDrop(dropCo.id) then
			return true
		end
	end
end

function Rouge2_AttrDropController:getAttrBuffList(attrId)
	local dropItemList = {}
	local dropIdList = Rouge2_Model.instance:getAttrDropIdList(attrId)

	if dropIdList then
		for _, dropId in ipairs(dropIdList) do
			local itemIdList = Rouge2_Model.instance:getAttrDropItemList(dropId)

			if itemIdList then
				for _, itemId in ipairs(itemIdList) do
					local itemMoList = Rouge2_BackpackModel.instance:getItemListByItemId(itemId)

					tabletool.addValues(dropItemList, itemMoList)
				end
			end
		end
	end

	table.sort(dropItemList, self._attrBuffSortFunc)

	return dropItemList
end

function Rouge2_AttrDropController._attrBuffSortFunc(aBuffMo, bBuffMo)
	local aBuffCo = aBuffMo:getConfig()
	local bBuffCo = bBuffMo:getConfig()

	if aBuffCo then
		if not aBuffCo.rare then
			local aBuffRare = 0

			if bBuffCo then
				if not bBuffCo.rare then
					local bBuffRare = 0

					if aBuffRare ~= bBuffRare then
						return bBuffRare < aBuffRare
					end

					local aBuffId = aBuffMo:getItemId() or 0
					local bBuffId = bBuffMo:getItemId() or 0

					if aBuffId ~= bBuffId then
						return aBuffId < bBuffId
					end

					return aBuffMo:getUid() < bBuffMo:getUid()
				end
			end
		end
	end
end

function Rouge2_AttrDropController:recordWaitGetAttrReward(isWait)
	self._waitGetAttrReward = isWait
end

function Rouge2_AttrDropController:isWaitGetAttrReward()
	return self._waitGetAttrReward
end

function Rouge2_AttrDropController:checkAttrDropHasEffectHero()
	local curInteractive = Rouge2_MapModel.instance:getCurInteractiveJson()

	if not curInteractive or curInteractive.dropType ~= Rouge2_MapEnum.DropType.AttrBuff then
		return
	end

	local itemList = curInteractive.dropCollectList

	if itemList then
		for _, itemId in ipairs(itemList) do
			local itemCo = Rouge2_BackpackHelper.getItemConfig(itemId)
			local battleTag = itemCo and itemCo.battleTag

			if not string.nilorempty(battleTag) then
				return true
			end
		end
	end
end

function Rouge2_AttrDropController:getRemainStep2GetBigAttrDrop()
	local leaderInfo = Rouge2_Model.instance:getLeaderInfo()
	local dropNum = leaderInfo and leaderInfo:getDropNum() or 0
	local maxStepCo = lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.BigAttrDropStep]
	local maxStep = maxStepCo and tonumber(maxStepCo.value) or 0

	return maxStep - 1 - dropNum % maxStep
end

Rouge2_AttrDropController.instance = Rouge2_AttrDropController.New()

return Rouge2_AttrDropController
