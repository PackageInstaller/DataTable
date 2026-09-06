-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/evolve/controller/EvolveController.lua

module("logic.extensions.evolve.controller.EvolveController", package.seeall)

local EvolveController = class("EvolveController", BaseController)

function EvolveController:ctor()
	self._changeSetId = -1
end

function EvolveController:onInit()
	GlobalDispatcher:addListener(PetAgent.PM_EvolvePetRes, self._onEvolvePetRes, self)
	GlobalDispatcher:addListener(GlobalNotify.EvolveAnimationEnd, self._onEvolveAnimationEnd, self)
end

function EvolveController:onReset()
	return
end

function EvolveController:sendPM_EvolvePetReq(petId, targetRaceId, handler, handlerObj, errHandler)
	self._targetRaceId = targetRaceId

	PetAgent.instance:sendPM_EvolvePetReq(petId, targetRaceId, handler, handlerObj, errHandler)
end

function EvolveController:_onEvolvePetRes(status, msg)
	if status == 0 then
		self._changeSetId = msg.changeSetId

		printInfo("test _onEvolvePetRes 进化成功 postRaceId = ", self._targetRaceId)
		MaterialController.instance:saveChangeSetToTemp(self._changeSetId)
		GlobalDispatcher:dispatch(GlobalNotify.EvolveSuccess, self._targetRaceId)

		self._targetRaceId = nil
	end
end

function EvolveController:_onEvolveAnimationEnd()
	MaterialController.instance:setChangeSetPopup(self._changeSetId)
	MaterialController.instance:showChangeSetInTemp(self._changeSetId)

	self._changeSetId = -1
end

function EvolveController:playEvolveAnimation(preRaceId, postRaceId)
	GlobalModel.instance:setUIInteractable(false)
	printInfo("test 开始播放")
	AnimatorEffect.instance:onPlayEffect(preRaceId, postRaceId, "storyconfig/animations/petevolve.txt", function()
		GlobalModel.instance:setUIInteractable(true)
		printInfo("test 播放完成")
		GlobalDispatcher:dispatch(GlobalNotify.EvolveAnimationEnd)
	end)
end

EvolveController.instance = EvolveController.New()

return EvolveController
