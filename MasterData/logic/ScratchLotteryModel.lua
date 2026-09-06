-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaoxiaoleskin/model/ScratchLotteryModel.lua

module("logic.extensions.xiaoxiaoleskin.model.ScratchLotteryModel", package.seeall)

local ScratchLotteryModel = class("ScratchLotteryModel", BaseModel)

ScratchLotteryModel.PrizeType = {
	tianZiBoom = -3,
	special = -1,
	crossBoom = -2
}

function ScratchLotteryModel:ctor()
	return
end

function ScratchLotteryModel:onInit()
	self:onReset()
end

function ScratchLotteryModel:onReset()
	self._msgMap = {}
	self._changeSetIdMap = {}
	self._nextRoundMap = {}
	self._lastSpecialPrizeCountMap = {}
	self._flipInfoMap = {}
end

function ScratchLotteryModel:setGameInfo(msg)
	local activityId = msg.activityId

	self._msgMap[activityId] = GameUtil.pbToTable(msg) or {}
end

function ScratchLotteryModel:setFlipInfo(msg, activityId)
	local tb = GameUtil.pbToTable(msg)

	self._flipInfoMap[activityId] = tb

	local info = self._msgMap[activityId]

	if info then
		info.position = info.position or {}

		if not tb.position then
			local posList = {}

			for i, v in ipairs(posList) do
				table.insert(info.position, v)
			end

			if tb.nextRound then
				info.round = info.round + 1
				info.bigPrizeId = tb.bigPrizeId
			end

			info.digTimes = info.digTimes + 1
			self._changeSetIdMap[activityId] = tb.changeSetId
			self._nextRoundMap[activityId] = tb.nextRound
		end
	end
end

function ScratchLotteryModel:setLastSpecialPrizeCount(activityId)
	self._lastSpecialPrizeCountMap[activityId] = self:getSpecialPrizeCount(activityId)
end

function ScratchLotteryModel:getNextRound(activityId)
	self._nextRoundMap[activityId] = nil

	return self._nextRoundMap[activityId]
end

function ScratchLotteryModel:getChangeSetId(activityId)
	self._changeSetIdMap[activityId] = nil

	return (checknumber(self._changeSetIdMap[activityId]))
end

function ScratchLotteryModel:getInfoPosition(activityId)
	local info = self._msgMap[activityId]

	if info then
		return info.position
	end

	return nil
end

function ScratchLotteryModel:getGamePosition(activityId)
	local info = self._flipInfoMap[activityId]

	if info then
		return info.position
	end

	return nil
end

function ScratchLotteryModel:getDigTimes(activityId)
	local info = self._msgMap[activityId]

	if info then
		return checknumber(info.digTimes)
	end

	return 0
end

function ScratchLotteryModel:getBigPrizeCfgById(activityId)
	local info = self._msgMap[activityId]

	if info then
		return (ScratchLotteryConfig.instance:getBigPrizeCfgById(info.bigPrizeId))
	end

	return nil
end

function ScratchLotteryModel:getSpecialPrizeCount(activityId)
	local info = self._msgMap[activityId]
	local count = 0

	if info then
		for i, v in ipairs(info.position or {}) do
			if v.prizeId == ScratchLotteryModel.PrizeType.special then
				count = count + 1
			end
		end
	end

	return count
end

function ScratchLotteryModel:getNormalRewardName(activityId)
	local count = self:getSpecialPrizeCount(activityId)
	local num = count - checknumber(self._lastSpecialPrizeCountMap[activityId])
	local cfg = self:getBigPrizeCfgById(activityId) or {}
	local name = ""
	local cc = cfg[count]

	if cc then
		name = MaterialMgr.getMaterialsNameByCfg(cc.normalReward)
	end

	for i = 1, num - 1 do
		cc = cfg[count - i]

		if cfg[count - i] then
			name = string.format("%s,%s", name, MaterialMgr.getMaterialsNameByCfg(cc.normalReward))
		end
	end

	return name
end

function ScratchLotteryModel:getBuyTimesLen(activityId)
	local cfg = ScratchLotteryConfig.instance:getCostByTimes(activityId) or {}

	return #cfg
end

ScratchLotteryModel.instance = ScratchLotteryModel.New()

return ScratchLotteryModel
