-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/horselantern/agent/HorseLanternAgent.lua

module("logic.extensions.horselantern.agent.HorseLanternAgent", package.seeall)

local HorseLanternAgent = class("HorseLanternAgent", BaseAgent)

function HorseLanternAgent:handlePM_OnReceiveLanternMsgRes(status, msg)
	if status == 0 then
		printWarn("收到走马灯")

		local msglist = msg.msgList

		self._msgList = msglist

		GlobalDispatcher:dispatch(GlobalNotify.RecLanternMsg, msglist)
	end
end

function HorseLanternAgent:handlePM_DeleteLanternMsgRes(status, msg)
	if status == 0 then
		printInfo("移除走马灯")

		local msgIds = msg.msgIds

		GlobalDispatcher:dispatch(GlobalNotify.DelLanternMsg, msgIds)
	end
end

function HorseLanternAgent:getMsgList()
	return self._msgList
end

HorseLanternAgent.instance = HorseLanternAgent.New()

return HorseLanternAgent
