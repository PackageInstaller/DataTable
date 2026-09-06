-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/agent/FormationCollectAgent.lua

module("logic.extensions.masterform.agent.FormationCollectAgent", package.seeall)

local FormationCollectAgent = class("FormationCollectAgent", BaseAgent)

function FormationCollectAgent:sendPM_FormationCollectInfoReq()
	local req = FormationCollectExtension_pb.PM_FormationCollectInfoReq()

	self:sendMsg(req)
end

function FormationCollectAgent:handlePM_FormationCollectInfoRes(status, msg)
	if status == 0 then
		FormationCollectController.instance:handlePM_FormationCollectInfoRes(msg)
	end
end

function FormationCollectAgent:sendPM_FormationCollectGetPrizeReq(fmtId)
	local req = FormationCollectExtension_pb.PM_FormationCollectGetPrizeReq()

	req.fmtId = fmtId

	self:sendMsg(req)
end

function FormationCollectAgent:handlePM_FormationCollectGetPrizeRes(status, msg)
	if status == 0 then
		FormationCollectController.instance:handlePM_FormationCollectGetPrizeRes(msg)
	end
end

FormationCollectAgent.instance = FormationCollectAgent.New()

return FormationCollectAgent
