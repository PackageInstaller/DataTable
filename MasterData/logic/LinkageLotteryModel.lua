-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkagelottery/model/LinkageLotteryModel.lua

module("logic.extensions.linkagelottery.model.LinkageLotteryModel", package.seeall)

local LinkageLotteryModel = class("LinkageLotteryModel", BaseModel)

function LinkageLotteryModel:ctor()
	return
end

function LinkageLotteryModel:onInit()
	self:onReset()
end

function LinkageLotteryModel:onReset()
	self._activityId = 0
	self._lotterIdList = {}
	self._buyTime = 0

	self:resetTemp()
end

function LinkageLotteryModel:resetTemp()
	self._lotteryId = 0
	self._changeSetId = nil
end

function LinkageLotteryModel:onLinkageLotterygetInfoRes(msg)
	self._lotterIdList = GameUtil.pbToTable(msg.lotterId) or {}
	self._buyTime = msg.buyTime
end

function LinkageLotteryModel:onLinkageLotteryBuyLotteryRes(msg)
	self._buyTime = msg.buyTime
end

function LinkageLotteryModel:onLinkageLotteryRandRes(msg)
	self._lotteryId = msg.lotteryId
	self._changeSetId = msg.changeSetId

	if not TableUtil.isHad(self._lotterIdList, msg.lotteryId) then
		table.insert(self._lotterIdList, msg.lotteryId)
	end
end

function LinkageLotteryModel:getActivityId()
	if self._activityId > 0 then
		return self._activityId
	end

	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.LINKAGE_LOTTERY)

	self._activityId = cfg and cfg.activityId or 229001

	return self._activityId
end

function LinkageLotteryModel:hasGetPrizeCount()
	return #self._lotterIdList
end

function LinkageLotteryModel:isGetedReward(lotteryId)
	return TableUtil.isHad(self._lotterIdList, lotteryId)
end

function LinkageLotteryModel:getRandomLotteryId()
	return self._lotteryId
end

function LinkageLotteryModel:getChangeSetId()
	self._changeSetId = nil

	return self._changeSetId
end

LinkageLotteryModel.instance = LinkageLotteryModel.New()

return LinkageLotteryModel
