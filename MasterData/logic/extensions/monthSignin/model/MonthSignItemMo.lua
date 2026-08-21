-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthSignin/model/MonthSignItemMo.lua

module("logic.extensions.monthSignin.model.MonthSignItemMo", package.seeall)

local M = class("MonthSignItemMo")

function M:ctor()
	self._id = nil
	self._status = nil
	self._isSp = false
	self._data = nil
	self._rewardcount = nil
	self._rewardicon = nil
end

function M:setSignMo(moTable)
	self._id = moTable.id
	self._status = moTable.status

	local info = MonthSigninConfig.instance:getInfoById(self._id)

	self._isSp = info.isSpecial

	local rewardInfo = RewardConfig.instance:getRewardCfgByCode(info.reward)
	local itemID = rewardInfo.reward[1].code
	local count = rewardInfo.reward[1].num

	self._data = ItemUtil.createItemData({
		itemId = itemID
	})

	self._data:setCount(0)

	self._rewardcount = count
	self._rewardicon = self._data:getIcon()
end

function M:getItemType()
	return self._data:getType()
end

function M:getID()
	return self._id
end

function M:getStatus()
	return self._status
end

function M:setStatus(status)
	self._status = status
end

function M:getRewardCount()
	return self._rewardcount
end

function M:getRewardIcon()
	return self._rewardicon
end

function M:getData()
	return self._data
end

function M:getIsSp()
	return self._isSp
end

function M:getRewardName()
	return self._data:getName()
end

return M
