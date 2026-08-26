-- chunkname: @modules/logic/permanent/controller/PermanentController.lua

module("modules.logic.permanent.controller.PermanentController", package.seeall)

local PermanentController = class("PermanentController", BaseController)

function PermanentController:onInit()
	return
end

function PermanentController:reInit()
	return
end

function PermanentController:enterActivity(actId)
	local userid = PlayerModel.instance:getMyUserId()
	local activityCo = ActivityConfig.instance:getActivityCo(actId)
	local prefsKey = "PermanentStoryRecord" .. activityCo.storyId .. userid

	if PlayerPrefsHelper.getNumber(prefsKey, 0) == 0 then
		local param = {}

		param.isVersionActivityPV = true

		StoryController.instance:playStory(activityCo.storyId, param, self.storyCallback, self, {
			_actId = actId
		})
		PlayerPrefsHelper.setNumber(prefsKey, 1)
	else
		self:storyCallback({
			_actId = actId
		})
	end
end

function PermanentController:storyCallback(param, viewParam)
	local actId = param._actId
	local permanentCo = PermanentConfig.instance:getPermanentCO(actId)

	if permanentCo then
		ViewMgr.instance:openView(ViewName[permanentCo.enterview], viewParam)
	end
end

function PermanentController:jump2Activity(actId, viewParam)
	local permanentCo = PermanentConfig.instance:getPermanentCO(actId)

	if permanentCo then
		DungeonController.instance:openDungeonView()
		ViewMgr.instance:openView(ViewName[permanentCo.enterview], viewParam)
	end
end

function PermanentController:unlockPermanent(actId)
	ActivityRpc.instance:sendUnlockPermanentRequest(actId)
end

PermanentController.instance = PermanentController.New()

return PermanentController
