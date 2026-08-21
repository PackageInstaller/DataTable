-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/DungeonUtil.lua

module("logic.extensions.dungeon.model.DungeonUtil", package.seeall)

local DungeonUtil = {}

function DungeonUtil.getRewardLstNormal(dungeonMo)
	local rewardItemDataList = {}
	local typeDefine = CommEnum.DungeonType
	local dungeonType = dungeonMo:getType()

	if (dungeonType == typeDefine.Material or dungeonType == typeDefine.Gold or dungeonType == typeDefine.Exp) and dungeonMo:getDungeonPreviewReward() then
		for _, v in ipairs(dungeonMo:getDungeonPreviewReward()) do
			local itemData = ItemUtil.createItemData({
				itemId = v
			})

			table.insert(rewardItemDataList, itemData)
		end
	else
		local rewardCodeList = dungeonMo:getNormalReward()
		local rewardList = {}

		if rewardCodeList then
			for i, rewardCode in ipairs(rewardCodeList) do
				local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardCode)

				if rewardCO and rewardCO.rewardShow then
					for i, v in ipairs(rewardCO.rewardShow[1]) do
						local isFixDrop = DungeonUtil.isFixDrop(v, rewardCO.reward)

						table.insert(rewardList, {
							code = v,
							fixDrop = isFixDrop
						})
					end
				end
			end
		end

		rewardList = DungeonModel.instance:mergeAndSortRewardList(rewardList)

		for _, v in ipairs(rewardList or {}) do
			local itemData = ItemUtil.createItemData({
				itemId = v.code
			})

			if v.fixDrop then
				itemData.itemSign = CommEnum.BackPackItemSignTyp.FixDrop
			else
				itemData.itemSign = CommEnum.BackPackItemSignTyp.SmallProbabilityDrop
			end

			table.insert(rewardItemDataList, itemData)
		end
	end

	return rewardItemDataList
end

function DungeonUtil.getRewardLstRandom(dungeonMo)
	local rewardItemDataList = {}

	if dungeonMo:getType() == CommEnum.DungeonType.Material and dungeonMo:getDungeonPreviewReward() then
		return rewardItemDataList
	end

	local rewardCodeList = dungeonMo:getNormalReward()
	local rewardList = {}

	if rewardCodeList then
		for i, rewardCode in ipairs(rewardCodeList) do
			local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardCode)

			if rewardCO and rewardCO.rewardShow then
				for i, v in ipairs(rewardCO.rewardShow[2]) do
					table.insert(rewardList, {
						code = v
					})
				end
			end
		end
	end

	rewardList = DungeonModel.instance:mergeAndSortRewardList(rewardList)

	for _, v in ipairs(rewardList or {}) do
		local itemData = ItemUtil.createItemData({
			itemId = v.code
		})

		table.insert(rewardItemDataList, itemData)
	end

	return rewardItemDataList
end

function DungeonUtil.isFixDrop(itemCode, rewardList)
	if not rewardList then
		return false
	end

	for i, v in ipairs(rewardList) do
		if itemCode == v.code then
			return true
		end
	end

	return false
end

function DungeonUtil.isControlAction(dungeonType)
	local DType = CommEnum.DungeonType

	if dungeonType == DType.ControlAction or dungeonType == DType.ControlActionTeaching then
		return true
	end

	return false
end

function DungeonUtil.isControlActionById(dungeonId)
	local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonId)

	return dungeonMO and DungeonUtil.isControlAction(dungeonMO:getType()) or false
end

return DungeonUtil
