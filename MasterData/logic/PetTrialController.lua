-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettrial/controller/PetTrialController.lua

module("logic.extensions.pettrial.controller.PetTrialController", package.seeall)

local PetTrialController = class("PetTrialController", BaseController)

function PetTrialController:ctor()
	return
end

function PetTrialController:onInit()
	KingLoadAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.showChangeSet, self))
end

function PetTrialController:loadInfo()
	PetTrialAgent.instance:sendGetMyTrialInfoReq()
end

function PetTrialController:clearHandler()
	self._handler = nil
	self._handlerObj = nil
end

function PetTrialController:getMyKingLoadInfoReq(handler, handlerObj)
	self._handler = handler
	self._handlerObj = handlerObj

	KingLoadAgent.instance:sendGetMyKingLoadInfoReq(self._onGetMyKingLoadInfoRes, self)
end

function PetTrialController:_onGetMyKingLoadInfoRes(msg)
	PetTrialModel.instance:setCurStage(msg.passedStage)

	if self._handler then
		if self._handlerObj then
			self._handler(self._handlerObj)
		else
			self._handler()
		end
	end
end

function PetTrialController:showChangeSet(changeSetId, msgName)
	if msgName == "handleChallengeEndRes" then
		BattleSettlementModel.instance:setChangeSetId(changeSetId)
	else
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
	end
end

PetTrialController.instance = PetTrialController.New()

return PetTrialController
