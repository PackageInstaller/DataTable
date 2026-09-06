-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/diamondtask/controller/DiamondTaskController.lua

module("logic.extensions.diamondtask.controller.DiamondTaskController", package.seeall)

local DiamondTaskController = class("DiamondTaskController", BaseController)

function DiamondTaskController:ctor()
	return
end

function DiamondTaskController:gainActiveGift(periodType, indexList)
	DiamondTaskAgent.instance:sendGainActivityScoreGiftReq(periodType, indexList)
end

function DiamondTaskController:gainTaskGift(periodType, taskIdList)
	DiamondTaskAgent.instance:sendGainTaskGiftReq(periodType, taskIdList)
end

function DiamondTaskController:getDiamondTaskInfo()
	DiamondTaskAgent.instance:sendGetDiamondTaskInfosReq()
end

DiamondTaskController.instance = DiamondTaskController.New()

return DiamondTaskController
