-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonNewAchievementCell.lua

module("logic.extensions.season.view.SeasonNewAchievementCell", package.seeall)

local M = class("SeasonNewAchievementCell")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGO)
	self._rewardItemCellList = nil
	self._curLv = 0
	self._isVip = nil
end

function M:Awake()
	self.go_stateNormal = self._registry:findUIElement("secret_time_achievements_grid_item_959583629")
	self.text_txtLv = self._registry:findUIElement("secret_time_achievements_grid_item_-1663927867", UIComponentType.Text)
	self.go_stateLock = self._registry:findUIElement("secret_time_achievements_grid_item_1712364336")
	self.text_txtLockLv = self._registry:findUIElement("secret_time_achievements_grid_item_2043037028", UIComponentType.Text)
	self.go_alrearyGet_normal = self._registry:findUIElement("secret_time_achievements_grid_item_106617622")
	self.go_alrearyGet_vip = self._registry:findUIElement("secret_time_achievements_grid_item_393276289")
	self.go_reward_normal_item = self._registry:findUIElement("0&rewards_detail_item_2141037416")
	self.go_reward_vip_item1 = self._registry:findUIElement("1&rewards_detail_item_2141037416")
	self.go_reward_vip_item2 = self._registry:findUIElement("2&rewards_detail_item_2141037416")
	self._rewardItemCellList = {
		Astral.LuaComponentContainer.Add(self.go_reward_normal_item, SeasonRewardItemCell),
		Astral.LuaComponentContainer.Add(self.go_reward_vip_item1, SeasonRewardItemCell),
		Astral.LuaComponentContainer.Add(self.go_reward_vip_item2, SeasonRewardItemCell)
	}
	self.btn_self = self._registry:findUIElement("secret_time_achievements_grid_item_-354723443", UIComponentType.ButtonAdapter)

	self.btn_self:AddClickListener(self._onClick, self)
end

function M:_onClick()
	if self._clickCallback then
		self._clickCallback(self._clickTarget, self)
	end
end

function M:updateData(lvRewardMO)
	if not lvRewardMO then
		return
	end

	local isVip = SeasonModel.instance:isVip()
	local isPlayUnlock = false

	if self._curLv == lvRewardMO:getLv() and self._isVip ~= isVip and self._isVip ~= nil then
		isPlayUnlock = true
	end

	self._curLv = lvRewardMO:getLv()
	self._isVip = isVip

	local rewardState = lvRewardMO:getRewardStatus()

	goutil.setActive(self.btn_self.gameObject, rewardState == SeasonEnum.RewardStatus.AllActive or rewardState == SeasonEnum.RewardStatus.VipActive)
	goutil.setActive(self.go_stateNormal, rewardState ~= SeasonEnum.RewardStatus.None)
	goutil.setActive(self.go_stateLock, rewardState == SeasonEnum.RewardStatus.None)
	goutil.setActive(self.go_alrearyGet_normal, rewardState == SeasonEnum.RewardStatus.Finished or rewardState == SeasonEnum.RewardStatus.VipActive)
	goutil.setActive(self.go_alrearyGet_vip, rewardState == SeasonEnum.RewardStatus.Finished and self._isVip)

	self.text_txtLv.text = lvRewardMO:getLv()
	self.text_txtLockLv.text = lvRewardMO:getLv()

	local allReward = lvRewardMO:getTotalRewards()

	for i = 1, #allReward do
		local rewardItemMo = allReward[i]
		local cell = self._rewardItemCellList[i]

		if cell and rewardItemMo then
			local receiveItemState = self:_getRewardItemStatus(rewardState, rewardItemMo)

			cell:updateData(rewardItemMo, receiveItemState)

			if isPlayUnlock then
				cell:getComponent("receiveLock"):playUnlockAnim()
			end
		end
	end

	for i = 1, #self._rewardItemCellList do
		local cell = self._rewardItemCellList[i]

		cell:setVisible(allReward[i] ~= nil)
	end
end

function M:_getRewardItemStatus(rewardState, rewardItemMo)
	local receiveItemState = CommEnum.RewardEnum.CanNotGot

	if rewardItemMo:isVip() then
		if rewardState == SeasonEnum.RewardStatus.Finished then
			receiveItemState = self._isVip and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot
		elseif rewardState == SeasonEnum.RewardStatus.AllActive then
			receiveItemState = self._isVip and CommEnum.RewardEnum.CanGot or CommEnum.RewardEnum.CanNotGot
		elseif rewardState == SeasonEnum.RewardStatus.VipActive then
			receiveItemState = CommEnum.RewardEnum.CanGot
		end
	elseif rewardState == SeasonEnum.RewardStatus.Finished then
		receiveItemState = CommEnum.RewardEnum.HasGot
	elseif rewardState == SeasonEnum.RewardStatus.AllActive then
		receiveItemState = CommEnum.RewardEnum.CanGot
	elseif rewardState == SeasonEnum.RewardStatus.VipActive then
		receiveItemState = CommEnum.RewardEnum.HasGot
	end

	return receiveItemState
end

function M:setIndex(idx)
	self._index = idx
end

function M:getIndex()
	return self._index
end

function M:setClickCallback(callback, target)
	self._clickCallback = callback
	self._clickTarget = target
end

function M:OnDestroy()
	self._clickCallback = nil
	self._clickTarget = nil
	self._registry = nil
	self._rewardItemCellList = nil

	if self.btn_self then
		self.btn_self:RemoveClickListener()
	end
end

return M
