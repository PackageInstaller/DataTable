-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makesnowman/controller/MakeSnowmanController.lua

module("logic.extensions.makesnowman.controller.MakeSnowmanController", package.seeall)

local MakeSnowmanController = class("MakeSnowmanController", BaseController)

function MakeSnowmanController:ctor()
	return
end

function MakeSnowmanController:onInit()
	GlobalDispatcher:addListener(MakeSnowmanAgent.handlePM_MakeSnowmanGetInfoRes, self.handlePM_MakeSnowmanGetInfoRes, self)
	GlobalDispatcher:addListener(MakeSnowmanAgent.handlePM_MakeSnowmanGainProgressPrizeRes, self.handlePM_MakeSnowmanGainProgressPrizeRes, self)
end

function MakeSnowmanController:onReset()
	return
end

function MakeSnowmanController:handlePM_MakeSnowmanGetInfoRes(status, msg)
	MakeSnowmanModel.instance:setData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MakeSnowmanShowGetInfo)
end

function MakeSnowmanController:handlePM_MakeSnowmanGainProgressPrizeRes(status, msg)
	MakeSnowmanModel.instance:clearUnits()
	MakeSnowmanModel.instance:setCurBuildSnowman(0)
	GlobalDispatcher:dispatch(GlobalNotify.MakeSnowmanShowGetPrize)
end

MakeSnowmanController.instance = MakeSnowmanController.New()

return MakeSnowmanController
