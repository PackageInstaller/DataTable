-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/work/reward/TravelGoSkillRewardWork.lua

module("modules.logic.versionactivity3_7.travelgo.controller.work.reward.TravelGoSkillRewardWork", package.seeall)

local TravelGoSkillRewardWork = class("TravelGoSkillRewardWork", BaseWork)

function TravelGoSkillRewardWork:ctor(travelGoSkillReward)
	self.travelGoSkillReward = travelGoSkillReward
end

function TravelGoSkillRewardWork:onStart()
	TravelGoController.instance:registerCallback(TravelGoEvent.OnSelectSkillReward, self.onSelectSkillReward, self)

	local isHaveRare3 = false
	local skillCfgs = self.travelGoSkillReward:getSkillCfgList()

	for i, cfg in ipairs(skillCfgs) do
		TravelGoController.instance:addSkillRewardItem({
			skillCfg = cfg,
			index = i
		})

		if cfg.rare == 3 then
			isHaveRare3 = true
		end
	end

	if isHaveRare3 then
		AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_beiai_xran_option_high)
	else
		AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_beiai_xran_option_low)
	end
end

function TravelGoSkillRewardWork:onSelectSkillReward(param)
	local index = param.index

	self.travelGoSkillReward:setSelectSkill(index)
	self.travelGoSkillReward:giveRewards()
	self:onDone(true)
end

function TravelGoSkillRewardWork:clearWork()
	TravelGoController.instance:unregisterCallback(TravelGoEvent.OnSelectSkillReward, self.onSelectSkillReward, self)
end

return TravelGoSkillRewardWork
