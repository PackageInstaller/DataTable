-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/controller/PetverifyController.lua

module("logic.extensions.petverify.controller.PetverifyController", package.seeall)

local PetverifyController = class("PetverifyController", BaseController)

PetverifyController.VERIFYTYPE_POWER = GameEnum.VERIFYTYPE_POWER
PetverifyController.VERIFYTYPE_LEVEL = GameEnum.VERIFYTYPE_LEVEL
PetverifyController.VERIFYTYPE_STARLEVEL = GameEnum.VERIFYTYPE_STARLEVEL
PetverifyController.VERIFYTYPE = GameEnum.VERIFYTYPE

function PetverifyController:ctor()
	return
end

function PetverifyController:onReset()
	self.petVerifyMap = {}
	self.getInfoCallBackList = {}
	self.petInfoCallBackList = {}
	self.callbackFlagId = 1
	self.isSendGetInfo = false
end

function PetverifyController:onInit()
	self:onReset()
end

function PetverifyController:getVerifyInfo(planId, callBack)
	if self.petVerifyMap[planId] == nil then
		self.getInfoCallBackList[self.callbackFlagId] = callBack
		self.callbackFlagId = self.callbackFlagId + 1

		PetVerifyBuffAgent.instance:sendPM_PetVerifyInfoReq(planId, function(msg)
			self.petVerifyMap[planId] = msg.petVerify

			for k, v in pairs(self.getInfoCallBackList) do
				GameUtil.callBack(v)
			end

			self.getInfoCallBackList = {}
		end)

		return self.callbackFlagId
	else
		GameUtil.callBack(callBack)
	end
end

function PetverifyController:rmVerifyInfoCallback(id)
	if id then
		self.getInfoCallBackList[id] = nil
	end
end

function PetverifyController:sendVerifyPetIds(planId, petIds, callBack, dontOpenView)
	if self:checkCanVerify(planId, petIds) then
		local beofrePlan = self:getCurrPlanBuff(planId)

		PetVerifyBuffAgent.instance:sendPM_SetPetVerifyReq(planId, petIds, function(msg)
			self.petVerifyMap[planId] = msg.petVerify

			if beofrePlan then
				if not beofrePlan.target then
					local beforePlanPower = -1
					local curPlan = self:getCurrPlanBuff(planId)

					if curPlan then
						if not curPlan.target then
							local curPlanPower = -1
							local success = beforePlanPower < curPlanPower

							if dontOpenView ~= true then
								UIStateManager.instance:push(ViewName.PetverifysuccessView, planId, true, success, petIds)
							end

							GameUtil.callBack(callBack)

							local buffId = 0
							local lvl = 0

							if curPlan then
								buffId = curPlan.buffId
								lvl = curPlan.level
							else
								local plans = PetVerifyBuffConfig.instance:getBuffListById(planId)

								buffId = plans[1].buffId
							end

							GlobalDispatcher:dispatch(GlobalNotify.PetVerifySuccess, buffId, lvl)
						end
					end
				end
			end
		end)
	elseif dontOpenView ~= true then
		UIStateManager.instance:push(ViewName.PetverifysuccessView, planId, false, false, petIds)
	end
end

function PetverifyController:rmVerifyPetIdsCallback(id)
	if id then
		self.petInfoCallBackList[id] = nil
	end
end

function PetverifyController:getInfo(id)
	return self.petVerifyMap[id]
end

function PetverifyController:checkCanVerify(planId, petIds)
	local info = self:getInfo(planId)
	local verifyValue = info.verifyValue
	local plans = PetVerifyBuffConfig.instance:getBuffListById(planId)
	local verifyPlan = PetVerifyBuffConfig.instance:getPlanCfgById(planId)
	local sum = self:calculateTargetSum(petIds, verifyPlan.type)

	return verifyValue < sum
end

function PetverifyController:getCurrPlanBuff(planId)
	local info = self:getInfo(planId)
	local verifyPlanCfg = PetVerifyBuffConfig.instance:getPlanCfgById(planId)
	local buffPlans = PetVerifyBuffConfig.instance:getBuffListById(planId)
	local firstBuff
	local ret

	if verifyPlanCfg then
		local maxPower = -1

		if buffPlans then
			for k, v in pairs(buffPlans) do
				if ((info or nil) and info.verifyValue) >= v.target and maxPower < v.target then
					ret = v
					maxPower = v.target
				end
			end
		end
	end

	return ret, (buffPlans and #buffPlans > 0 or nil) and buffPlans[1]
end

function PetverifyController:showEnterView(presntor, go, planId)
	return ViewMgr.instance:openAt(go, ViewName.PetverifyentranceView, presntor, planId)
end

function PetverifyController:showBtnView(presntor, go, buffId, lvl, callBack)
	buffId = checknumber(buffId)

	local buffCfg = BattleConfig.instance:getBuffCo(buffId)

	if buffCfg then
		return ViewMgr.instance:openAt(go, ViewName.PetverifybtnUI, presntor, buffId, lvl, callBack)
	end
end

function PetverifyController:calculateTargetSum(petIds, verifyType)
	local sum = 0
	local value = 0

	for k, petId in ipairs(petIds) do
		local petMo = BagModel.instance:getPet(petId)

		if petMo then
			if verifyType == PetverifyController.VERIFYTYPE_POWER then
				value = FightingPowerFormula.instance:getPetFightingPowerByPetMo(petMo)
			elseif verifyType == PetverifyController.VERIFYTYPE_LEVEL then
				value = petMo.curLv
			elseif verifyType == PetverifyController.VERIFYTYPE_STARLEVEL then
				value = CharacterConfig.instance:getAwakenRareCfg(petMo.awakeLevel).starNum
			end
		end

		sum = sum + checknumber(value)
	end

	return sum
end

PetverifyController.instance = PetverifyController.New()

return PetverifyController
