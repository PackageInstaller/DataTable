-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialrecover/agent/MaterialRecoverAgent.lua

module("logic.extensions.materialrecover.agent.MaterialRecoverAgent", package.seeall)

local MaterialRecoverAgent = class("MaterialRecoverAgent", BaseAgent)

function MaterialRecoverAgent:sendPM_GetMaterialRecoverInfosReq()
	local req = MaterialRecoverExtension_pb.PM_GetMaterialRecoverInfosReq()

	self:sendMsg(req)
end

function MaterialRecoverAgent:handlePM_GetMaterialRecoverInfosRes(status, msg)
	if status == 0 then
		MaterialRecoverController.instance:onGetAllRecoverInfos(msg.infos)
	end
end

function MaterialRecoverAgent:sendPM_GainMaterialRecoverReq(funType, state)
	local req = MaterialRecoverExtension_pb.PM_GainMaterialRecoverReq()

	req.funType = funType
	req.state = state

	self:sendMsg(req)
end

function MaterialRecoverAgent:handlePM_GainMaterialRecoverRes(status, msg)
	if status == 0 then
		MaterialRecoverController.instance:onGainMaterialRecover()
	end
end

MaterialRecoverAgent.instance = MaterialRecoverAgent.New()

return MaterialRecoverAgent
