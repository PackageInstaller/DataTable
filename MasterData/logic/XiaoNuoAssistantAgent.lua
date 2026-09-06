-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/agent/XiaoNuoAssistantAgent.lua

module("logic.extensions.xiaonuoassistant.agent.XiaoNuoAssistantAgent", package.seeall)

local XiaoNuoAssistantAgent = class("XiaoNuoAssistantAgent", BaseAgent)

function XiaoNuoAssistantAgent:sendXiaoNuoAssistantInfoReq(params)
	local req = XiaoNuoAssistantExtension_pb.XiaoNuoAssistantInfoReq()

	if params then
		for i, v in ipairs(params) do
			local info = req.params:add()

			info.type = v.type

			if v.param then
				info.param = v.param
			end
		end
	end

	self:sendMsg(req)
end

function XiaoNuoAssistantAgent:handleXiaoNuoAssistantInfoRes(status, msg)
	if status == 0 then
		XiaoNuoAssistantModel.instance:onhandleXiaoNuoAssistantInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantInfoRes)
	end
end

XiaoNuoAssistantAgent.instance = XiaoNuoAssistantAgent.New()

return XiaoNuoAssistantAgent
