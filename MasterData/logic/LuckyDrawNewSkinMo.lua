-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckyskinlottery/model/LuckyDrawNewSkinMo.lua

module("logic.extensions.luckyskinlottery.model.LuckyDrawNewSkinMo", package.seeall)

local LuckyDrawNewSkinMo = tableMO()

function LuckyDrawNewSkinMo:ctor(activityId)
	self._activityId = activityId
	self._records = {}
	self._curProcess = 0
	self._curLotteryCount = 0
	self._lotteryPlan = 0
	self._processId = 0
	self._rateId = 0
	self._rewardIdMark = 0
	self._reset = false
	self._rankInfo = {}
	self._changeSetIds = {}
	self._curFreeNum = 0
end

function LuckyDrawNewSkinMo:setViewInfo(msg)
	self._curProcess = msg.curProcess
	self._curLotteryCount = msg.curLotteryCount
	self._lotteryPlan = msg.lotteryPlan
	self._rewardIdMark = msg.rewardIdMark
end

function LuckyDrawNewSkinMo:setSkinLotteryInfo(msg)
	self._processId = msg.process
	self._rate = msg.rate
	self._curProcess = msg.curProcess
	self._curLotteryCount = msg.curLotteryCount
	self._curFreeNum = msg.freeNum
end

function LuckyDrawNewSkinMo:setRankRollTextInfo(msg)
	self._records = msg
end

function LuckyDrawNewSkinMo:setSkinLotteryGetProcessReward(msg)
	self._rewardIdMark = msg.rewardIdMark
	self._reset = msg.reset
	self._changeSetIds = msg.changeSetIds
end

function LuckyDrawNewSkinMo:setRankInfo(msg)
	self._rankInfo.ranks = self:handleRankInfo(msg.ranks)
	self._rankInfo.myRank = msg.myRank
end

function LuckyDrawNewSkinMo:showChangeSetIds()
	local planId = LuckySkinLotteryConfig.instance:getProgressRewardPlan(self._lotteryPlan)
	local cfg = LuckySkinLotteryConfig.instance:getRewardCfgList(planId)
	local isAll = true
	local matType = 0
	local matId = 0

	for i, v in ipairs(cfg) do
		local isScoreEnough = self._curProcess >= v.needPoint

		if not isScoreEnough then
			isAll = false
			matType, matId = MaterialMgr.getMatParams(v.bigReward)

			break
		end
	end

	for i, v in ipairs(self._changeSetIds) do
		local changSetId = MaterialController.instance:getClientChangeSetId(true)
		local list = MaterialController.instance:getItemsByChangeSetId(v)

		if not isAll then
			for _, mo in ipairs(list) do
				if mo.type == matType and mo.id == matId then
					ViewAutoShowController.instance:trySetAutoEvaluation(1, ViewAutoShowController.TAPTAP_FUNC_4)
				end
			end
		end

		MaterialController.instance:showChangeSetItemMo(list, changSetId)
	end
end

function LuckyDrawNewSkinMo:getIsRest()
	return self._reset
end

function LuckyDrawNewSkinMo:getRankInfo()
	return self._rankInfo
end

function LuckyDrawNewSkinMo:getLotteryPlan()
	return self._lotteryPlan
end

function LuckyDrawNewSkinMo:getCurLotteryCount()
	return self._curLotteryCount
end

function LuckyDrawNewSkinMo:getProgressId()
	return self._processId
end

function LuckyDrawNewSkinMo:getRateId()
	return self._rate
end

function LuckyDrawNewSkinMo:getCurProgress()
	return self._curProcess
end

function LuckyDrawNewSkinMo:getCurFreeNum()
	return self._curFreeNum
end

function LuckyDrawNewSkinMo:isRewardCanGet(id, needPoint)
	local isScoreEnough = needPoint <= self._curProcess

	if isScoreEnough then
		local isGeted = self:isRewardGeted(id)

		return not isGeted
	else
		return false
	end
end

function LuckyDrawNewSkinMo:isRewardGeted(id)
	return checknumber(self._rewardIdMark) >= checknumber(id)
end

function LuckyDrawNewSkinMo:isAnyRewardCanGet()
	local planId = LuckySkinLotteryConfig.instance:getProgressRewardPlan(self._lotteryPlan)
	local cfg = LuckySkinLotteryConfig.instance:getRewardCfgList(planId)

	for i, v in ipairs(cfg) do
		if self:isRewardCanGet(v.rewarId, v.needPoint) then
			return true
		end
	end

	return false
end

function LuckyDrawNewSkinMo:getRecordList()
	return self._records
end

function LuckyDrawNewSkinMo:handleRankInfo(str)
	local json = require("cjson")
	local newRank = {}

	for _, v in ipairs(str) do
		table.insert(newRank, json.decode(v))
	end

	return newRank
end

return LuckyDrawNewSkinMo
