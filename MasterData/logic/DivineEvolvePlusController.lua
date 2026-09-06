-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolveplus/controller/DivineEvolvePlusController.lua

module("logic.extensions.divineevolveplus.controller.DivineEvolvePlusController", package.seeall)

local DivineEvolvePlusController = class("DivineEvolvePlusController", BaseController)

DivineEvolvePlusController.DivineLookItemClick = "divinelookitemclick"
DivineEvolvePlusController.MainItemClick = "mainitemclick"
DivineEvolvePlusController.UpdateEvolveCondition = "updateevolveconditionplus"
DivineEvolvePlusController.PetListItemClick = "petlistitemclick"
DivineEvolvePlusController.EvolveCondition = {
	Pet = 2,
	UniqueItem = 3,
	None = 1
}

function DivineEvolvePlusController:onInit()
	GlobalDispatcher:addListener(PetAgent.PM_DivinePlusEvolveRes, self._onDivinePlusEvolveRes, self)
	GlobalDispatcher:addListener(PetAgent.PM_DivineExchangeRes, self._onDivineExchangeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.DivineEvolvePlusAnimationEnd, self._onDivineEvolveAnimationEnd, self)
	GlobalDispatcher:addListener(GlobalNotify.SourceTraceEvolvePlusAnimationEnd, self._onSourceTraceEvolveAnimationEnd, self)
end

function DivineEvolvePlusController:_onDivinePlusEvolveRes(status, msg)
	if status == 0 then
		printInfo("test _onDivineEvolveRes 圣启进化成功1 postRaceId = ", self._postEvolveRaceId)

		self._changeSetId = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(self._changeSetId)

		local newPetMo = BagModel.instance:getPet(msg.newPetId)

		printInfo("test DivineEvolvePlusController:_onDivinePlusEvolveRes", msg.newPetId, newPetMo)
		GlobalDispatcher:dispatch(GlobalNotify.DivineEvolvePlusRes, newPetMo, self._oldPetMo)
	end

	self._preEvolveRaceId = nil
	self._postEvolveRaceId = nil
	self._oldPetMo = nil
end

function DivineEvolvePlusController:_onDivineExchangeRes(status, msg)
	if status == 0 then
		printInfo("test _onDivineExchangeRes 圣启进化成功2 postRaceId = ", self._postEvolveRaceId)

		self._changeSetId = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(self._changeSetId)

		local newPetMo = BagModel.instance:getPet(msg.newPetId)

		printInfo("test DivineEvolvePlusController:_onDivineExchangeRes", msg.newPetId, newPetMo, self._oldPetMo)
		GlobalDispatcher:dispatch(GlobalNotify.DivineEvolvePlusRes, newPetMo, self._oldPetMo)
	end

	self._preEvolveRaceId = nil
	self._postEvolveRaceId = nil
	self._oldPetMo = nil
end

function DivineEvolvePlusController:sendPM_DivinePlusEvolveReq(petId, preEvolveRaceId, postEvolveRaceId)
	print(string.format("DivineEvolvePlusController:sendPM_DivinePlusEvolveReq %s, %s, %s( ServerTime.nowMs:%s, PreciseServerTime.nowMs:%s ) ", petId, preEvolveRaceId, postEvolveRaceId, ServerTime.nowMs(), PreciseServerTime.nowMs()))
	PetAgent.instance:sendPM_DivinePlusEvolveReq(petId, postEvolveRaceId)

	self._preEvolveRaceId = preEvolveRaceId
	self._postEvolveRaceId = postEvolveRaceId

	local oldPetMo = BagModel.instance:getPet(petId)

	if oldPetMo then
		self._oldPetMo = oldPetMo:GetClone()
	end
end

function DivineEvolvePlusController:sendPM_DivineExchangeReq(petId, preEvolveRaceId, postEvolveRaceId, usePet)
	print(string.format("DivineEvolvePlusController:sendPM_DivineExchangeReq %s, %s, %s, %s( ServerTime.nowMs:%s, PreciseServerTime.nowMs:%s ) ", petId, preEvolveRaceId, postEvolveRaceId, usePet, ServerTime.nowMs(), PreciseServerTime.nowMs()))
	PetAgent.instance:sendPM_DivineExchangeReq(postEvolveRaceId, petId, usePet)

	self._preEvolveRaceId = preEvolveRaceId
	self._postEvolveRaceId = postEvolveRaceId

	local oldPetMo = BagModel.instance:getPet(petId)

	if oldPetMo then
		self._oldPetMo = oldPetMo:GetClone()
	end
end

function DivineEvolvePlusController:_onDivineEvolveAnimationEnd(newPetMo, oldPetMo)
	local function callback()
		MaterialController.instance:setChangeSetPopup(self._changeSetId)
		MaterialController.instance:showChangeSetInTemp(self._changeSetId)

		self._changeSetId = -1
	end

	local newRaceId = newPetMo.raceId
	local cfg = EvolveConfig.instance:getDivineEvolvePlusCfgByNewRaceId(newRaceId)

	if cfg then
		UIStateManager.instance:updateParms(ViewName.DivineEvolvePlusView, {
			cfg.raceId
		})
	end

	UIStateManager.instance:push(ViewName.DivineEvolvePlusDisplayView, callback, newPetMo, oldPetMo)
end

function DivineEvolvePlusController:_onSourceTraceEvolveAnimationEnd(newPetMo, oldPetMo)
	self:tryOpenEvolveItemView()

	local newRaceId = newPetMo.raceId
	local cfg = EvolveConfig.instance:getDivineEvolvePlusCfgByNewRaceId(newRaceId)

	if cfg then
		UIStateManager.instance:updateParms(ViewName.SourceTraceEvolveView, {
			cfg.raceId
		})
	end

	PetDisplayModel.instance:addNewPet(newPetMo.petId)
	PetDisplayController.instance:checkAndOpenDisplay()
end

function DivineEvolvePlusController:playEvolveAnimation(newPetMo, oldPetMo)
	GlobalModel.instance:setUIInteractable(false)
	AnimationPlayer.instance:PlayAnim("storyconfig/animations/donghua_shenqijinhua.txt", 1, true)
	AnimationPlayer.instance:setFinishCallback(function()
		GlobalModel.instance:setUIInteractable(true)
		GlobalDispatcher:dispatch(GlobalNotify.DivineEvolvePlusAnimationEnd, newPetMo, oldPetMo)
	end)
end

function DivineEvolvePlusController:playSourceTraceEvolveAnimation(newPetMo, oldPetMo)
	GlobalModel.instance:setUIInteractable(false)
	AnimationPlayer.instance:PlayAnim("storyconfig/animations/donghua_yuanqijinhua.txt", 1, true)
	AnimationPlayer.instance:setFinishCallback(function()
		GlobalModel.instance:setUIInteractable(true)
		GlobalDispatcher:dispatch(GlobalNotify.SourceTraceEvolvePlusAnimationEnd, newPetMo, oldPetMo)
	end)
end

function DivineEvolvePlusController:tryOpenEvolveItemView()
	if checknumber(self._changeSetId) > 0 then
		MaterialController.instance:setChangeSetPopup(self._changeSetId)
		MaterialController.instance:showChangeSetInTemp(self._changeSetId)

		self._changeSetId = -1
	end
end

function DivineEvolvePlusController:getAttrs(conditionStr)
	return DivineEvolveController.instance:getAttrs(conditionStr)
end

function DivineEvolvePlusController:getEvolveTip()
	return "材料精灵已经进行神格觉醒，若将其作为材料进行操作，神格法典不返还，是否确定操作？"
end

DivineEvolvePlusController.instance = DivineEvolvePlusController.New()

return DivineEvolvePlusController
