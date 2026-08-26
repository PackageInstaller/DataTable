-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyResultMo.lua

module("modules.logic.sp01.odyssey.model.OdysseyResultMo", package.seeall)

local OdysseyResultMo = pureTable("OdysseyResultMo")

function OdysseyResultMo:init(info)
	self._iswin = info.result == OdysseyEnum.Result.Win
	self._rewardList = info.reward and info.reward.rewards
	self._element = info.element
	self._elementId = info.element.id
	self._resultconfig = OdysseyConfig.instance:getElementFightConfig(self._elementId)
	self._fighttype = self._resultconfig.type
	self._isMyth = self._resultconfig.type == OdysseyEnum.FightType.Myth
	self._isConquer = self._resultconfig.type == OdysseyEnum.FightType.Conquer

	if self._isMyth and self._element and self._element.mythicEle then
		local info = self._element.mythicEle

		self._fightRecord = info.evaluation
		self._fightFinishedTaskIds = info.finishedTaskIds
	end

	if self._isConquer and self._element and self._element.conquestEle then
		self._conquestEle = self._element.conquestEle
	end
end

function OdysseyResultMo:getConquestEle()
	return self._conquestEle
end

function OdysseyResultMo:getElementId()
	return self._elementId
end

function OdysseyResultMo:checkFightTypeIsMyth()
	return self._isMyth
end

function OdysseyResultMo:checkFightTypeIsConquer()
	return self._isConquer
end

function OdysseyResultMo:getFightRecord()
	return self._fightRecord
end

function OdysseyResultMo:getFightFinishedTaskIdList()
	return self._fightFinishedTaskIds
end

function OdysseyResultMo:canShowMythSuccess()
	return self._fightFinishedTaskIds and #self._fightFinishedTaskIds > 0
end

function OdysseyResultMo:getRewardList()
	local list = {}

	for index, reward in ipairs(self._rewardList) do
		local itemReward = reward.itemReward
		local expReward = reward.expReward
		local talentReward = reward.talentReward

		if itemReward and itemReward.count > 0 then
			local mo = {}

			mo.rewardType = OdysseyEnum.ResultRewardType.Item

			local itemco = OdysseyConfig.instance:getItemConfig(itemReward.itemId)

			mo.itemType = itemco.type
			mo.itemId = itemco.id
			mo.count = itemReward.count

			table.insert(list, mo)
		end

		if expReward and expReward.exp > 0 then
			local mo = {}

			mo.rewardType = OdysseyEnum.ResultRewardType.Exp
			mo.count = expReward.exp

			table.insert(list, mo)
		end

		if talentReward and talentReward.point > 0 then
			local mo = {}

			mo.rewardType = OdysseyEnum.ResultRewardType.Talent
			mo.count = talentReward.point

			table.insert(list, mo)
		end
	end

	return list
end

return OdysseyResultMo
