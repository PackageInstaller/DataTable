-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/controller/HerotrialController.lua

module("logic.extensions.Mount.controller.HerotrialController", package.seeall)

local HerotrialController = class("HerotrialController", BaseController)

function HerotrialController:ctor()
	return
end

function HerotrialController:onInit()
	self:onReset()
	HeroTrialAgent.instance:addHandler(HeroTrialAgent.PM_HTChallengeEndRes, self.onAfterFightRes, self)

	self._dayS = 86400
	self._3Hour = 10800
end

function HerotrialController:onReset()
	return
end

function HerotrialController:getHeroTrialInfo(callBack)
	self:updateActivityId()

	local hasGain = HerotrialModel.instance:getIfHasGainInfo()
	local activityId = HerotrialModel.instance:getActivityId()

	if hasGain then
		GlobalDispatcher:dispatch(GlobalNotify.HeroTrialGetInfo)
		GameUtil.callBack(callBack)
	else
		HeroTrialAgent.instance:sendPM_HTGetInfoReq(activityId, function(msg)
			HerotrialModel.instance:setIfHasGainInfo(true)
			HerotrialModel.instance:initHeroTrialInfo(msg)
			GlobalDispatcher:dispatch(GlobalNotify.HeroTrialGetInfo)
			GameUtil.callBack(callBack)
		end)
	end
end

function HerotrialController:getIfCanVerify(petId)
	local plan = self:getCurVerifyPlan()
	local petMo = BagPetsController.instance:getPet(petId)
	local power = FightingPowerFormula.instance:getPetFightingPowerByPetMo(petMo)
	local curPower = HerotrialModel.instance:getHigestVerifiedZdl()
	local activityId = HerotrialModel.instance:getActivityId()
	local plans = HerotrialConfig.instance:getVerifyPlans(activityId)

	if curPower < power then
		return true, plans[1].leftZdl
	else
		return false, plans[1].leftZdl
	end
end

function HerotrialController:getCurVerifyPlan(higestVerifiedZdl)
	local activityId = HerotrialModel.instance:getActivityId()

	if not higestVerifiedZdl then
		::label_7_0::

		local highestZdl = HerotrialModel.instance:getHigestVerifiedZdl()
		local plans = HerotrialConfig.instance:getVerifyPlans(activityId)

		if plans == nil or #plans == 0 then
			return nil
		end

		local ret

		for i = 1, #plans do
			if plans[i] and highestZdl >= plans[i].leftZdl then
				ret = plans[i]
			end
		end

		return ret
	end
end

function HerotrialController:startBattle()
	local activityId = HerotrialModel.instance:getActivityId()

	HeroTrialAgent.instance:sendPM_HTChallengeBossReq(activityId, function(status, msg)
		return
	end, nil, function()
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
	end)
end

function HerotrialController:onAfterFightRes(msg, status)
	if status == 0 then
		HerotrialModel.instance:setNeedToOpenBattleEnd(true)
		HerotrialModel.instance:setCurDamage(msg.damage)

		local before = HerotrialModel.instance:getHighestDamage()

		if before < checknumber(msg.damage) then
			HerotrialModel.instance:setHighestDamage(msg.damage)
		end
	end
end

function HerotrialController:verify(petId)
	if petId then
		local torf = self:getIfCanVerify(petId)

		if torf then
			local beofrePlan = self:getCurVerifyPlan()
			local activityId = HerotrialModel.instance:getActivityId()

			HeroTrialAgent.instance:sendPM_HTUpdateVerifiedZdlReq(activityId, petId, function(msg)
				HerotrialModel.instance:setHigestVerifiedZdl(msg.zdl)

				if beofrePlan then
					if not beofrePlan.leftZdl then
						local beforePlanPower = 0
						local curPlan = self:getCurVerifyPlan()

						if curPlan then
							if not curPlan.leftZdl then
								local curPlanPower = 0
								local success = beforePlanPower < curPlanPower

								UIStateManager.instance:push(ViewName.HTverifysuccessView, true, success, petId)
								GlobalDispatcher:dispatch(GlobalNotify.HeroTrialVerifySuccess)
							end
						end
					end
				end
			end)
		else
			UIStateManager.instance:push(ViewName.HTverifysuccessView, false, false, petId)
		end
	end
end

function HerotrialController:checkIfOpen()
	self:updateActivityId()

	local boo = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.HeroTrial, HerotrialModel.instance:getActivityId())

	if boo then
		return true
	end

	return false
end

function HerotrialController:updateActivityId()
	local beforeId = HerotrialModel.instance:getActivityId()
	local curId
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.HeroTrial)

	if cfg then
		curId = cfg.activityId
	end

	if beforeId ~= curId then
		HerotrialModel.instance:setActivityId(curId)
		HerotrialModel.instance:setIfHasGainInfo(false)

		return true
	else
		return false
	end
end

function HerotrialController:realTimeUpdate(callBack)
	if self:checkIfOpen() then
		self:getHeroTrialInfo(callBack)
	else
		FloatWordMgr.instance:show("不在活动时间内")
	end
end

function HerotrialController:openBattleResultView()
	UIStateManager.instance:open(ViewName.HerotrialchallengeendView, function()
		if HerotrialController.instance:checkIfOpen() then
			UIJumper.instance:pushOneStack(ViewName.HerotrialView, true)
		else
			FloatWordMgr.instance:show("不在活动时间内")
		end
	end)
end

HerotrialController.instance = HerotrialController.New()

return HerotrialController
