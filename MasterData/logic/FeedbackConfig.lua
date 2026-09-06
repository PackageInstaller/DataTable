-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/feedback/config/FeedbackConfig.lua

module("logic.extensions.feedback.config.FeedbackConfig", package.seeall)

local FeedbackConfig = class("FeedbackConfig", BaseConfig)

function FeedbackConfig:onInit()
	FeedbackConfig.super.onInit(self)

	self._feedbackCfg = nil
end

function FeedbackConfig:getNames()
	return {
		"feedback_reply"
	}
end

function FeedbackConfig:handleConfig(name, content)
	if name == "feedback_reply" then
		self._feedbackCfg = content
	end
end

function FeedbackConfig:getCfgById(id)
	return self._feedbackCfg[id]
end

function FeedbackConfig:getCfgs()
	return self._feedbackCfg
end

FeedbackConfig.instance = FeedbackConfig.New()

return FeedbackConfig
