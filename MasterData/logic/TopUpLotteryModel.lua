-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/topuplottery/model/TopUpLotteryModel.lua

module("logic.extensions.topuplottery.model.TopUpLotteryModel", package.seeall)

local TopUpLotteryModel = class("TopUpLotteryModel", BaseModel)

function TopUpLotteryModel:ctor()
	self:onReset()
end

function TopUpLotteryModel:onInit()
	self:onReset()
end

function TopUpLotteryModel:onReset()
	self._moByActId = {}
end

function TopUpLotteryModel:getMoOrCreateNew(activityId)
	self._moByActId[activityId] = self._moByActId[activityId] or TULActMo.New()

	return self._moByActId[activityId]
end

function TopUpLotteryModel:handleGetInfoRes(msg)
	local mo = self:getMoOrCreateNew(msg.activityId)

	mo:updateByServerData(msg)
end

function TopUpLotteryModel:handleSetBigPrizeRes(msg)
	local mo = self:getMoOrCreateNew(msg.activityId)

	mo:setBigPrize(msg.prizeId)
end

function TopUpLotteryModel:handleRandRes(msg)
	local mo = self:getMoOrCreateNew(msg.activityId)

	mo:handleRandRes(msg)
end

TopUpLotteryModel.instance = TopUpLotteryModel.New()

return TopUpLotteryModel
