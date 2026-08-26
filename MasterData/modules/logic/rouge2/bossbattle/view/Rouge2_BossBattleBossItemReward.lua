-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossBattleBossItemReward.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossBattleBossItemReward", package.seeall)

local Rouge2_BossBattleBossItemReward = class("Rouge2_BossBattleBossItemReward", LuaCompBase)

function Rouge2_BossBattleBossItemReward.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_BossBattleBossItemReward)
end

function Rouge2_BossBattleBossItemReward:init(go)
	self.go = go
	self._goRoot = gohelper.findChild(self.go, "#go_Root")
	self._goReward = gohelper.findChild(self.go, "#go_Root/Reward")
	self._goRewardList = gohelper.findChild(self.go, "#go_Root/scroll_Reward/Viewport/#go_RewardList")
	self._goRewardItem = gohelper.findChild(self.go, "#go_Root/scroll_Reward/Viewport/#go_RewardList/#go_RewardItem")
	self._goClaimFlag = gohelper.findChild(self.go, "#go_Root/#go_ClaimFlag")
	self._iconItemTab = self:getUserDataTb_()
end

function Rouge2_BossBattleBossItemReward:addEvents()
	return
end

function Rouge2_BossBattleBossItemReward:removeEvents()
	return
end

function Rouge2_BossBattleBossItemReward:onUpdateMO(battleInfo, bossCo)
	self._bossCo = bossCo
	self._bossId = bossCo and bossCo.id
	self._battleInfo = battleInfo
	self._bossInfo = self._battleInfo and self._battleInfo:getBossInfoById(self._bossId)

	self:refreshRewardList()
end

function Rouge2_BossBattleBossItemReward:refreshRewardList()
	self._itemList = self:_buildItemMoList()

	if self._itemList then
		local hasReward = #self._itemList > 0

		gohelper.setActive(self._goRoot, hasReward)

		if self._bossInfo then
			local hasAnyRewardCanGet = self._bossInfo:hasAnyRewardCanGet()

			gohelper.setActive(self._goClaimFlag, self._bossInfo)

			if not hasReward then
				return
			end

			gohelper.CreateObjList(self, self._refreshRewardItem, self._itemList, self._goRewardList, self._goRewardItem)
		end
	end
end

function Rouge2_BossBattleBossItemReward:_buildItemMoList()
	local resultList = {}
	local rewardList = Rouge2_BossBattleConfig.instance:getRewardListByBossId(self._bossId)

	if rewardList then
		for _, rewardCo in ipairs(rewardList) do
			local status = self._bossInfo and self._bossInfo:getRewardStatus(rewardCo.id) or Rouge2_OutsideEnum.BossRewardStatus.Lock
			local itemList = Rouge2_BossBattleConfig.instance:getItemListByRewardId(rewardCo.id)

			if itemList then
				for j, itemInfo in ipairs(itemList) do
					local itemMo = {
						status = status,
						index = j,
						itemInfo = itemInfo,
						rewardCo = rewardCo,
						stage = rewardCo.stage
					}

					table.insert(resultList, itemMo)
				end
			end
		end
	end

	table.sort(resultList, self._rewardItemSortFunc)

	return resultList
end

function Rouge2_BossBattleBossItemReward._rewardItemSortFunc(aItemMo, bItemMo)
	local aStatus = aItemMo.status
	local bStatus = bItemMo.status

	if aStatus ~= bStatus then
		if aStatus == Rouge2_OutsideEnum.BossRewardStatus.CanGet or bStatus == Rouge2_OutsideEnum.BossRewardStatus.CanGet then
			return aStatus == Rouge2_OutsideEnum.BossRewardStatus.CanGet
		end

		return aStatus < bStatus
	end

	if aItemMo.stage ~= bItemMo.stage then
		return aItemMo.stage < bItemMo.stage
	end

	return aItemMo.index < bItemMo.index
end

function Rouge2_BossBattleBossItemReward:_refreshRewardItem(goItem, itemMo, index)
	local goHasGet = gohelper.findChild(goItem, "go_HasGet")
	local goIcon = gohelper.findChild(goItem, "go_Icon")
	local iconItem = self._iconItemTab[index]

	if not iconItem then
		iconItem = IconMgr.instance:getCommonPropItemIcon(goIcon)
		self._iconItemTab[index] = iconItem
	end

	local materialType = itemMo.itemInfo[1]
	local itemId = itemMo.itemInfo[2]
	local count = itemMo.itemInfo[3]

	iconItem:setMOValue(materialType, itemId, count)
	iconItem:isShowCount(false)
	gohelper.setActive(goHasGet, itemMo.status == Rouge2_OutsideEnum.BossRewardStatus.HasGet)
end

return Rouge2_BossBattleBossItemReward
