-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/model/LuckyDrawModel.lua

module("logic.extensions.luckydraw.model.LuckyDrawModel", package.seeall)

local LuckyDrawModel = class("LuckyDrawModel", BaseModel)

LuckyDrawModel.NUM_OUT_CELL = 14

function LuckyDrawModel:ctor()
	return
end

function LuckyDrawModel:onInit()
	self:onReset()
end

function LuckyDrawModel:onReset()
	self._activityId = nil
	self._luckyScore = 0
	self._totalDrawTimes = 0
	self._hasGetInfo = false
	self._recordList = {}
	self._prizeDrawNum = {}
	self._gainProcessPrizeBit = nil
end

function LuckyDrawModel:setHasGetInfo(HasGetInfo)
	self._hasGetInfo = HasGetInfo
end

function LuckyDrawModel:getHasGetInfo()
	return self._hasGetInfo
end

function LuckyDrawModel:setActId(_activityId)
	self._activityId = _activityId
end

function LuckyDrawModel:getActId()
	return self._activityId
end

function LuckyDrawModel:setCloseAnim(torf)
	self._closeAnim = torf
end

function LuckyDrawModel:getCloseAnim()
	return self._closeAnim
end

function LuckyDrawModel:setCurLuckyScore(luckyScore)
	self._luckyScore = luckyScore
end

function LuckyDrawModel:getCurLuckyScore()
	return self._luckyScore
end

function LuckyDrawModel:setAddLuckyScore(addluckyScore)
	self._addluckyScore = addluckyScore
end

function LuckyDrawModel:getAddLuckyScore()
	return self._addluckyScore
end

function LuckyDrawModel:setPrizeDrawNum(prizeId, drawTimes)
	self._prizeDrawNum[prizeId] = drawTimes
end

function LuckyDrawModel:getPrizeDrawNum(prizeId)
	return checknumber(self._prizeDrawNum[prizeId])
end

function LuckyDrawModel:setTotalDrawtimes(totalTimes)
	self._totalDrawTimes = checkint(totalTimes)
end

function LuckyDrawModel:updateTotalDrawTimes()
	self._totalDrawTimes = self._totalDrawTimes + 1
end

function LuckyDrawModel:getTotalDrawtimes()
	return self._totalDrawTimes
end

function LuckyDrawModel:setRecordList(recordList)
	self._recordList = recordList or {}
end

function LuckyDrawModel:getRecordList()
	return self._recordList
end

function LuckyDrawModel:setGainProcessPrizeBit(bit)
	self._gainProcessPrizeBit = bit
end

function LuckyDrawModel:getGainProcessPrizeBit()
	return self._gainProcessPrizeBit or {}
end

function LuckyDrawModel:onGainProgressPrizeRes(msg)
	self:setCurLuckyScore(msg.luckyScore)
	self:setTotalDrawtimes(msg.totalDrawTimes)
	self:setGainProcessPrizeBit(msg.gainProcessPrizeBit)

	for k, v in ipairs(msg.drawTimes) do
		self:setPrizeDrawNum(v.prizeId, v.drawTimes)
	end
end

LuckyDrawModel.instance = LuckyDrawModel.New()

return LuckyDrawModel
