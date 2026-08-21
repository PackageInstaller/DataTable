-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/RewardPreviewView.lua

module("logic.extensions.dungeon.view.RewardPreviewView", package.seeall)

local M = class("RewardPreviewView", DungeonRewardDetailView)

function M:buildUI()
	M.super.buildUI(self)

	local compG_FirstPass = self:getCompGroup(self.kType.FirstPass)

	if compG_FirstPass then
		goutil.setActive(compG_FirstPass.goText1, false)
		goutil.setActive(compG_FirstPass.goText2, true)
	end
end

function M:onEnter()
	local param = self:getOpenParam()

	self._rewardList = param[1]
	self._hasGot = param[2]

	self:_refreshView()
end

function M:getRewardItemPrefab()
	return self:getResInstance(ResName.Common_Backpack_Item)
end

function M:isFirstPassRewardGot()
	return self._hasGot
end

function M:getRewardLstFirstPass()
	local rewardList = {}

	for i, rewardCode in ipairs(self._rewardList) do
		local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardCode)

		self:_collectFirstPassRewardItemData(rewardList, rewardCO.reward)
		self:_collectFirstPassRewardItemData(rewardList, rewardCO.randomReward1)
		self:_collectFirstPassRewardItemData(rewardList, rewardCO.randomReward2)
		self:_collectFirstPassRewardItemData(rewardList, rewardCO.randomReward3)
	end

	return rewardList
end

function M:getRewardLstNormal()
	return {}
end

function M:getRewardLstRandom()
	return {}
end

function M:_onClickReturn()
	self:back()
end

return M
