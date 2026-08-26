-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/work/event/TravelGoLevelUpWork.lua

module("modules.logic.versionactivity3_7.travelgo.controller.work.event.TravelGoLevelUpWork", package.seeall)

local TravelGoLevelUpWork = class("TravelGoLevelUpWork", BaseWork)

function TravelGoLevelUpWork:ctor()
	return
end

function TravelGoLevelUpWork:onStart()
	local level = TravelGoModel.instance.level
	local recordLevel = TravelGoModel.instance.recordLevel

	if recordLevel < level then
		local actId = TravelGoModel.instance.activityId
		local str = TravelGoConfig.instance:getConsValue(actId, TravelGoConst.ConstId.LevelUpReward)
		local rewardList = TravelGoController.instance.travelGoRewardMgr:parseRewardStr(str)

		self.flow = FlowSequence.New()

		local delayShowTime = TravelGoConfig.instance:getConsValue(actId, TravelGoConst.ConstId.DelayShowLevelUpReward, true) or 0

		self.flow:addWork(TimerWork.New(delayShowTime))
		self.flow:registerDoneListener(self.onEventFinish, self)

		local count = level - recordLevel

		for i = 1, count do
			local desc = GameUtil.getSubPlaceholderLuaLang(luaLang("TravelGoLevelUpWork_1"), {
				TravelGoModel.instance.recordLevel + i
			})

			self.flow:addWork(FunctionWork.New(TravelGoController.instance.addDescItem, TravelGoController.instance, {
				desc = desc
			}))

			local work = TravelGoController.instance.travelGoRewardMgr:createGainRewardWork(rewardList)

			self.flow:addWork(work)
		end

		self.flow:start()
		TravelGoModel.instance:recordLevelUpCheck()
	else
		self:onDone(true)
	end
end

function TravelGoLevelUpWork:onEventFinish()
	self:onDone(true)
end

function TravelGoLevelUpWork:clearWork()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

return TravelGoLevelUpWork
