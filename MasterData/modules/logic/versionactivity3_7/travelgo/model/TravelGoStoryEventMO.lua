-- chunkname: @modules/logic/versionactivity3_7/travelgo/model/TravelGoStoryEventMO.lua

module("modules.logic.versionactivity3_7.travelgo.model.TravelGoStoryEventMO", package.seeall)

local TravelGoStoryEventMO = pureTable("TravelGoStoryEventMO", TravelGoEventMO)

function TravelGoStoryEventMO:onSetData()
	if not string.nilorempty(self.cfg.typeParam) then
		self.choiceList = GameUtil.splitString2(self.cfg.typeParam, false, "|", ":")
	end

	self.choiceReward = {}
end

function TravelGoStoryEventMO:getStoryChoicePre(index)
	return self.choiceList[index][1]
end

function TravelGoStoryEventMO:getStorySelectDescList(index)
	local desc = self.choiceList[index][2]

	return string.split(desc, "#")
end

function TravelGoStoryEventMO:setStoryChoice(choiceIndex)
	self.choiceIndex = choiceIndex
end

function TravelGoStoryEventMO:getChoiceRewards(choiceIndex)
	if self.choiceReward[choiceIndex] == nil then
		local str

		if choiceIndex == 1 then
			str = self.cfg.result1reward
		elseif choiceIndex == 2 then
			str = self.cfg.result2reward
		end

		local rewardList = TravelGoController.instance.travelGoRewardMgr:parseRewardStr(str, self.eventId)

		if rewardList then
			self.choiceReward[choiceIndex] = rewardList
		end
	end

	return self.choiceReward[choiceIndex]
end

function TravelGoStoryEventMO:getChoiceDesc(choiceIndex)
	local result = ""
	local cfgChooseDesc = self.cfg.chooseDesc

	if not string.nilorempty(cfgChooseDesc) then
		local chooseDescList = string.split(cfgChooseDesc, "|")

		result = chooseDescList[choiceIndex] or ""
	end

	return result
end

function TravelGoStoryEventMO:getResultRewardStr()
	return (self.choiceIndex == 1 or nil) and (self.cfg.result1reward or self.cfg.result2reward)
end

return TravelGoStoryEventMO
