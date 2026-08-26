-- chunkname: @modules/logic/versionactivity2_8/act196/model/Activity196Model.lua

module("modules.logic.versionactivity2_8.act196.model.Activity196Model", package.seeall)

local Activity196Model = class("Activity196Model", BaseModel)

function Activity196Model:onInit()
	return
end

function Activity196Model:setActInfo(rewardIdList)
	self._rewardIdList = nil

	if rewardIdList and #rewardIdList > 0 then
		self._rewardIdList = rewardIdList
	end
end

function Activity196Model:updateRewardIdList(id)
	self._rewardIdList = self._rewardIdList or {}

	table.insert(self._rewardIdList, id)
end

function Activity196Model:checkRewardReceied(id)
	if self._rewardIdList and #self._rewardIdList > 0 then
		for _, value in ipairs(self._rewardIdList) do
			if value == id then
				return true
			end
		end
	end

	return false
end

function Activity196Model:checkGetAllReward()
	if not self._rewardIdList then
		return false
	end

	local rewardcount = Activity2ndConfig.instance:getRewardCount()

	if #self._rewardIdList == rewardcount then
		return true
	end

	return false
end

function Activity196Model:reInit()
	return
end

Activity196Model.instance = Activity196Model.New()

return Activity196Model
