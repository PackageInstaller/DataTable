-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/webofficialpay/agent/WebOfficialPayAgent.lua

module("logic.extensions.webofficialpay.agent.WebOfficialPayAgent", package.seeall)

local WebOfficialPayAgent = class("WebOfficialPayAgent", BaseAgent)

function WebOfficialPayAgent:handlePM_Notify_WebOfficialPaySuccessRes(status, msg)
	if status == 0 then
		WebOfficialPayController.instance:pushOneMsg(msg)
	end
end

WebOfficialPayAgent.instance = WebOfficialPayAgent.New()

return WebOfficialPayAgent
