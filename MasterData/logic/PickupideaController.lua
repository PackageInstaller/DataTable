-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/controller/PickupideaController.lua

module("logic.extensions.pickupidea.controller.PickupideaController", package.seeall)

local PickupideaController = class("PickupideaController", BaseController)

function PickupideaController:ctor()
	return
end

function PickupideaController:onInit()
	LocalUserDataController.instance:whenLocalDataInited(function()
		self:_calStoryRedpoint()
	end)
	self:onReset()
end

function PickupideaController:onReset()
	return
end

function PickupideaController:getGoodFeelProgress(activityId, id)
	local cfg = PickupideaConfig.instance:getRoleCfg(activityId, id)

	return (MaterialFacade.instance:getMatNumber(MatType.ACTIVITY_ITEM, cfg.activityItemId))
end

function PickupideaController:tryStartGame(activityId)
	self._clientKey = math.random(1, 9)

	PickUpIdeaAgent.instance:sendPM_PickUpIdeaStartGameReq(activityId, self._clientKey)
end

function PickupideaController:handlePM_PickUpIdeaStartGameRes(serverKey)
	local activityId = PickupideaModel.instance:getActivityId()

	self._serverKey = serverKey

	UIStateManager.instance:push(ViewName.PickupideagameView, activityId)
end

function PickupideaController:sendPM_PickUpIdeaEndGameReq(score)
	local serverResList = {
		score
	}
	local encryptedKey = GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, serverResList)

	PickUpIdeaAgent.instance:sendPM_PickUpIdeaEndGameReq(score, encryptedKey)
end

function PickupideaController:_calStoryRedpoint()
	local isActive = false
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.PickUpIdea)

	if activityId > 0 then
		local roleCfgs = PickupideaConfig.instance:getRoleCfgs(activityId)

		for _, role in ipairs(roleCfgs) do
			local hasNum = MaterialFacade.instance:getMatNumber(MatType.ACTIVITY_ITEM, role.activityItemId)
			local storyCfgs = PickupideaConfig.instance:getStoryCfgs(activityId, role.roleId)

			for _, v in ipairs(storyCfgs) do
				local key = self:getStoryViewKey(activityId, role.roleId, v.index)
				local isView = GameUtil.getUserData(key)
				local isSubActive = false

				if not isView and hasNum >= v.progress then
					isActive = true
					isSubActive = true
				end

				RedPointController.instance:setRedPointInfo(key, isSubActive)
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PICKUPIDEA_STORY, isActive)
end

function PickupideaController:getStoryViewKey(activityId, id, index)
	return string.format("PickupideaStoryViewKey_%s_%s_%s", activityId, id, index)
end

function PickupideaController:setIsViewStory(activityId, id, index)
	local key = self:getStoryViewKey(activityId, id, index)

	GameUtil.saveUserData(key, true)
	self:_calStoryRedpoint()
end

function PickupideaController:getStoryIsView(activityId, id, index)
	local key = self:getStoryViewKey(activityId, id, index)

	return GameUtil.getUserData(key)
end

PickupideaController.instance = PickupideaController.New()

return PickupideaController
