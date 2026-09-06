-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/controller/FormationCollectController.lua

module("logic.extensions.masterform.controller.FormationCollectController", package.seeall)

local FormationCollectController = class("FormationCollectController", BaseController)

function FormationCollectController:onInit()
	self:onReset()
end

function FormationCollectController:onReset()
	return
end

function FormationCollectController:sendPM_FormationCollectInfoReq()
	FormationCollectAgent.instance:sendPM_FormationCollectInfoReq()
end

function FormationCollectController:handlePM_FormationCollectInfoRes(msg)
	FormationCollectModel.instance:handlePM_FormationCollectInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormationCollectInfoRes)
end

function FormationCollectController:sendPM_FormationCollectGetPrizeReq(fmtId)
	FormationCollectAgent.instance:sendPM_FormationCollectGetPrizeReq(fmtId)
end

function FormationCollectController:handlePM_FormationCollectGetPrizeRes(msg)
	FormationCollectModel.instance:handlePM_FormationCollectGetPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormationCollectGetPrizeRes, checknumber(msg.fmtId))
end

FormationCollectController.instance = FormationCollectController.New()

return FormationCollectController
