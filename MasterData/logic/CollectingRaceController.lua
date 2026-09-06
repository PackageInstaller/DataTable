-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingrace/controller/CollectingRaceController.lua

module("logic.extensions.collectingrace.controller.CollectingRaceController", package.seeall)

local CollectingRaceController = class("CollectingRaceController", BaseController)

CollectingRaceController.E_InfoRes = "E_InfoRes"
CollectingRaceController.E_GainPrizeRes = "E_GainPrizeRes"

function CollectingRaceController:ctor()
	return
end

function CollectingRaceController:onInit()
	return
end

function CollectingRaceController:onReset()
	CollectingRaceModel.instance:onReset()
end

function CollectingRaceController:handleInfoRes(status, msg)
	if status == 0 then
		CollectingRaceModel.instance:handleInfoRes(msg)
		self:localNotify(CollectingRaceController.E_InfoRes)
	end
end

function CollectingRaceController:reqGainPrize(activityId)
	CollectingRaceModel.instance:beforeGainPrize(activityId)
	CollectingRaceAgent.instance:sendPM_CollectingRaceGainPrizeReq(activityId)
end

function CollectingRaceController:handleGainPrizeRes(status, msg)
	if status == 0 then
		CollectingRaceModel.instance:handleGainPrizeRes(msg)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		MaterialController.instance:showChangeSetInTemp(msg.changeSetId)
		self:localNotify(CollectingRaceController.E_GainPrizeRes)
	end
end

CollectingRaceController.instance = CollectingRaceController.New()

return CollectingRaceController
