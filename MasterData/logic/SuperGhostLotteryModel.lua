-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/superghostlottery/model/SuperGhostLotteryModel.lua

module("logic.extensions.superghostlottery.model.SuperGhostLotteryModel", package.seeall)

local SuperGhostLotteryModel = class("SuperGhostLotteryModel", BaseModel)

SuperGhostLotteryModel.UpdateDrawInfos = "SuperGhostLotteryModel.UpdateDrawInfos"
SuperGhostLotteryModel.DrawSuccessed = "SuperGhostLotteryModel.DrawSuccessed"

function SuperGhostLotteryModel:ctor()
	return
end

function SuperGhostLotteryModel:onInit()
	self:onReset()
end

function SuperGhostLotteryModel:onReset()
	self.isDrawing = false
	self.drawInfo = nil
	self._isNextOrderIdChange = true
	self.changeSetId = nil
	self._isGetFirstPrize = false
end

function SuperGhostLotteryModel:setCurActId(actId)
	self._curActId = actId
end

function SuperGhostLotteryModel:getCurrActId()
	return self._curActId
end

function SuperGhostLotteryModel:setDrawInfos(orderId, infos, selectedBigPrizeIds)
	local actCfg = SuperGhostLotteryConfig.instance:getActivityCfg(self:getCurrActId())

	self._isGetFirstPrize = false

	local datas = {}

	if infos then
		for i, v in ipairs(infos) do
			datas[v] = true

			local rewardCfg = SuperGhostLotteryConfig.instance:getPrizeCfg(actCfg.prizePlanId, v)
		end
	end

	self.drawInfo = {
		orderId = (orderId or nil) and orderId,
		datas = datas
	}
	self._selectedBigPrizeIds = selectedBigPrizeIds
end

function SuperGhostLotteryModel:setSingleDrawInfo(rewardId)
	if self.drawInfo then
		self.drawInfo.datas[rewardId] = true
	else
		printInfo("===SuperGhostLotteryModel:setSingleDrawInfo drawInfo没有数据")
	end
end

function SuperGhostLotteryModel:handlePM_SuperGhostLotterySelectBigPrizeRes(prizeId)
	local isHave = false

	for i, v in ipairs(self._selectedBigPrizeIds) do
		if prizeId == v then
			isHave = true

			break
		end
	end

	if not isHave then
		table.insert(self._selectedBigPrizeIds, prizeId)
	end
end

function SuperGhostLotteryModel:getDrawInfo()
	return self.drawInfo
end

function SuperGhostLotteryModel:drawSuccessed(msg)
	self:setDrawRewardId(msg.prizeId)
	self:setChangeSetId(msg.changeSetId)
	self:setNextOrderId(msg.round)

	if self._isNextOrderIdChange ~= self.drawInfo.orderId then
		self._isNextOrderIdChange = true
	end
end

function SuperGhostLotteryModel:setDrawRewardId(rewardId)
	self.drawRewardId = rewardId
end

function SuperGhostLotteryModel:getDrawPrizeId()
	return checknumber(self.drawRewardId)
end

function SuperGhostLotteryModel:setNextOrderId(nextOrderId)
	self.nextOrderId = nextOrderId
end

function SuperGhostLotteryModel:getNextOrderId()
	return checknumber(self.nextOrderId)
end

function SuperGhostLotteryModel:setChangeSetId(changeSetId)
	self.changeSetId = changeSetId

	MaterialController.instance:saveChangeSetToTemp(self.changeSetId)
end

function SuperGhostLotteryModel:getChangeSetId()
	return self.changeSetId
end

function SuperGhostLotteryModel:isNextOrderIdChange()
	return self._isNextOrderIdChange
end

function SuperGhostLotteryModel:isGetFirstPrize()
	return self._isGetFirstPrize
end

function SuperGhostLotteryModel:drwaAnimEnd()
	local rewardId = self.drawRewardId

	if self._isNextOrderIdChange ~= self.drawInfo.orderId then
		self.drawInfo.datas = {}
		self.drawInfo.orderId = self:getNextOrderId()
	end

	self:setSingleDrawInfo(rewardId)

	local changeSetId = self:getChangeSetId()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function SuperGhostLotteryModel:checkRedDot()
	local dot = false
	local actId = self:getCurrActId()

	if actId then
		local actCfg = WheelFortuneConfig.instance:getActCfgById(actId)
		local arr = string.split(actCfg.activityItem, ":")
		local matType = checknumber(arr[1])
		local matId = checknumber(arr[2])
		local useNum = checknumber(arr[3])
		local has_num = MaterialFacade.instance:getMatNumber(matType, matId)

		dot = useNum <= has_num
	end

	return dot
end

function SuperGhostLotteryModel:getSelectedBigPrizeIds()
	return self._selectedBigPrizeIds
end

SuperGhostLotteryModel.instance = SuperGhostLotteryModel.New()

return SuperGhostLotteryModel
