-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/topuplottery/model/TULActMo.lua

module("logic.extensions.topuplottery.model.TULActMo", package.seeall)

local TULActMo = tableMO()

function TULActMo:ctor()
	return
end

function TULActMo:updateByServerData(params)
	self.activityId = params.activityId
	self.totalMoney = params.totalMoney
	self.lotteryNum = params.lotteryNum
	self.todayRandTime = params.todayRandTime
	self.randTime = params.randTime
	self.bigPrizeId = params.bigPrizeId
end

function TULActMo:setBigPrize(bigPrizeId)
	self.bigPrizeId = bigPrizeId
end

function TULActMo:handleRandRes(params)
	self._lastChangeSetId = params.changeSetId

	MaterialController.instance:saveChangeSetToTemp(params.changeSetId)

	self.todayRandTime = checknumber(self.todayRandTime) + 1
	self.randTime = checknumber(self.randTime) + 1
	self.lotteryNum = checknumber(self.lotteryNum) - 1

	local activityConfig = TopUpLotteryConfig.instance:getActivityConfig(self.activityId)

	if self.randTime % activityConfig.bigPrizeTime == 0 then
		self.bigPrizeId = 0
	end
end

function TULActMo:popAndShowChangeSet()
	if self._lastChangeSetId ~= nil then
		MaterialController.instance:showChangeSetInTemp(self._lastChangeSetId)
	end

	self._lastChangeSetId = nil
end

return TULActMo
