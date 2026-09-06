-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/repairchannel/controller/RepairChannelController.lua

module("logic.extensions.repairchannel.controller.RepairChannelController", package.seeall)

local RepairChannelController = class("RepairChannelController", BaseController)

function RepairChannelController:onInit()
	self:onReset()
end

function RepairChannelController:onReset()
	return
end

function RepairChannelController:getDefaultActivityId()
	return 605001
end

function RepairChannelController:getInfo(activityId)
	RepairChannelAgent.instance:sendPM_RepairChannelGetInfoReq(activityId)
end

function RepairChannelController:handlePM_RepairChannelGetInfoRes(msg)
	RepairChannelModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_RepairChannelGetInfoRes)
end

function RepairChannelController:repairNode(activityId, branchId, nodeId, petIds_i32_Ary)
	RepairChannelAgent.instance:sendPM_RepairChannelRepairNodeReq(activityId, branchId, nodeId, petIds_i32_Ary)
end

function RepairChannelController:handlePM_RepairChannelRepairNodeRes(msg)
	RepairChannelModel.instance:onRepairNode(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_RepairChannelRepairNodeRes)
end

RepairChannelController.instance = RepairChannelController.New()

return RepairChannelController
