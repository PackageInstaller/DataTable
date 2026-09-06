-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/longyanxixiskin/agent/LongYanXiXiSkinAgent.lua

module("logic.extensions.longyanxixiskin.agent.LongYanXiXiSkinAgent", package.seeall)

local LongYanXiXiSkinAgent = class("LongYanXiXiSkinAgent", BaseAgent)

LongYanXiXiSkinAgent.PM_LongYanXiXiSkinGainRes = "LongYanXiXiSkinAgent_PM_LongYanXiXiSkinGainRes"

function LongYanXiXiSkinAgent:ctor()
	return
end

function LongYanXiXiSkinAgent:setExtId(extId)
	LongYanXiXiSkinAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function LongYanXiXiSkinAgent:handlePM_LongYanXiXiSkinGainRes(status, msg)
	self:dispatch(LongYanXiXiSkinAgent.PM_LongYanXiXiSkinGainRes, status, msg)
end

LongYanXiXiSkinAgent.instance = LongYanXiXiSkinAgent.New()

return LongYanXiXiSkinAgent
