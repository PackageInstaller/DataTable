-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/TravelGoRewardMgr.lua

module("modules.logic.versionactivity3_7.travelgo.controller.TravelGoRewardMgr", package.seeall)

local TravelGoRewardMgr = class("TravelGoRewardMgr", TravelGoBase)

function TravelGoRewardMgr:onEnable()
	self.RewardClass = {
		[TravelGoEnum.RewardType.Exp] = TravelGoExpReward,
		[TravelGoEnum.RewardType.Skill] = TravelGoSkillReward,
		[TravelGoEnum.RewardType.Attr] = TravelGoAttrReward
	}
end

function TravelGoRewardMgr:onDisable()
	return
end

function TravelGoRewardMgr:parseRewardStr(str, eventId)
	if string.nilorempty(str) then
		return
	end

	local rewardList = {}
	local strList = string.split(str, "|")

	for i, infoStr in ipairs(strList) do
		local infos = string.split(infoStr, "#")
		local type = tonumber(infos[1])

		table.remove(infos, 1)

		local Class = self.RewardClass[type]

		if Class then
			local obj = Class.New()

			obj:setData(type, infos, eventId)
			table.insert(rewardList, obj)
		else
			logError("未定义的奖励类型 " .. type .. " " .. debug.traceback())
		end
	end

	return rewardList
end

function TravelGoRewardMgr:createGainRewardWork(rewardList)
	return TravelGoGainRewardWork.New(rewardList)
end

return TravelGoRewardMgr
