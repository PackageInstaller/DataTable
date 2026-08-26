-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/work/reward/TravelGoGainRewardWork.lua

module("modules.logic.versionactivity3_7.travelgo.controller.work.reward.TravelGoGainRewardWork", package.seeall)

local TravelGoGainRewardWork = class("TravelGoGainRewardWork", BaseWork)

function TravelGoGainRewardWork:ctor(rewardList)
	self.rewardList = rewardList
end

function TravelGoGainRewardWork:onStart()
	self.flow = FlowSequence.New()

	local isPlayAnim = false

	for i, v in ipairs(self.rewardList) do
		if v.type == TravelGoEnum.RewardType.Exp then
			logNormal("小瑞安依 奖励经验")
			v:giveRewards()
		elseif v.type == TravelGoEnum.RewardType.Attr then
			logNormal("小瑞安依 奖励属性")
			v:giveRewards()
		elseif v.type == TravelGoEnum.RewardType.Skill then
			logNormal("小瑞安依 奖励技能")
			self.flow:addWork(TravelGoSkillRewardWork.New(v))

			isPlayAnim = true
		end
	end

	self.flow:addWork(TravelGoDispatchEventWork.New(TravelGoEvent.OnGainReward, self.rewardList))

	if isPlayAnim then
		self.flow:addWork(TravelGoDispatchEventWork.New(TravelGoEvent.OnPlayerStopMove))
		self.flow:addWork(TravelGoDispatchEventWork.New(TravelGoEvent.OnPlayGainRewardAnimation))

		local speedScale = TravelGoConfig.instance:getConsValue(TravelGoModel.instance.activityId, TravelGoConst.ConstId.NormalSpeed, true) or 1

		self.flow:addWork(TimerWork.New(TravelGoConst.GainRewardAnimTime / speedScale))
		self.flow:addWork(TravelGoDispatchEventWork.New(TravelGoEvent.OnPlayerStartMove))
	end

	self.flow:registerDoneListener(self.onOk, self)
	self.flow:start()
end

function TravelGoGainRewardWork:onOk()
	self:onDone(true)
end

function TravelGoGainRewardWork:clearWork()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

return TravelGoGainRewardWork
