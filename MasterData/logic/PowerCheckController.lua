-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/controller/PowerCheckController.lua

module("logic.extensions.handbook.controller.PowerCheckController", package.seeall)

local PowerCheckController = class("PowerCheckController", BaseController)

PowerCheckController.RoleResLoadFinish = "RoleResLoadFinish"

function PowerCheckController:ctor()
	PowerCheckController.super.ctor(self)
end

function PowerCheckController:onInit()
	self:onReset()
end

function PowerCheckController:onReset()
	self:resetCustomShowCI()
end

function PowerCheckController:sendCalZdlAndRankReq(petId)
	PetManualAgent.instance:sendCalZdlAndRankReq(petId)
end

function PowerCheckController:onCalZdlAndRankReq(msg)
	PowerCheckModel.instance:setPetZdlInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandBookPowerCheck)
end

function PowerCheckController:onGetRaceZdlRankReq(msg)
	PowerCheckModel.instance:onGetRaceZdlRankReq(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandBookPowerCheckRank)
end

function PowerCheckController:onRaceRankKudosReq(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	MaterialController.instance:showChangeSetInTemp(msg.changeSetId)
end

function PowerCheckController:onGainRankPrizeReq(msg)
	PetRankModel.instance:handleGainRankPrize(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

	if self._customShowCi then
		self._customShowCi = false
	else
		MaterialController.instance:showChangeSetInTemp(msg.changeSetId)
	end
end

function PowerCheckController:sendGainRankPrizeReq(rankType, subType, raceId)
	self._customShowCi = true

	PetManualAgent.instance:sendGainRankPrizeReq(raceId, rankType, subType)
end

function PowerCheckController:resetCustomShowCI()
	self._customShowCi = false
end

function PowerCheckController:onOneKeyPetRankPrizeInfoRes(msg)
	if #msg.items <= 0 then
		if not self._onekeyPetRankPrize_onlyCheckData then
			FloatWordMgr.instance:show("已领取所有奖励")
		end

		return
	end

	if not self._onekeyPetRankPrize_onlyCheckData then
		UIStateManager.instance:push(ViewName.PetranksweepView, msg.items)
	end

	self._onekeyPetRankPrize_onlyCheckData = false
end

function PowerCheckController:sendOneKeyPetRankPrizeInfoReq(onlyCheckData)
	self._onekeyPetRankPrize_onlyCheckData = onlyCheckData

	PetManualAgent.instance:sendOneKeyPetRankPrizeInfoReq()
end

PowerCheckController.instance = PowerCheckController.New()

return PowerCheckController
