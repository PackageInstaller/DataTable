-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/noahchallenge/controller/NoahChallengeController.lua

module("logic.extensions.noahchallenge.controller.NoahChallengeController", package.seeall)

local NoahChallengeController = class("NoahChallengeController", BaseController)

function NoahChallengeController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.NoahChallengeEndRes, self._onNoahChallengeEndRes, self)
	GlobalDispatcher:addListener(GlobalNotify.NoahChallengeBuyEndRes, self._onNoahChallengeBuyEndRes, self)
end

function NoahChallengeController:onReset()
	return
end

function NoahChallengeController:_onNoahChallengeEndRes(challengeId)
	if NoahChallengeModel.instance:isPassed(challengeId) then
		UIJumper.instance:pushOneStack(ViewName.DivineEvolveTipView, true)
	end
end

function NoahChallengeController:_onNoahChallengeBuyEndRes()
	UIStateManager.instance:push(ViewName.DivineEvolveTipView)
end

NoahChallengeController.instance = NoahChallengeController.New()

return NoahChallengeController
