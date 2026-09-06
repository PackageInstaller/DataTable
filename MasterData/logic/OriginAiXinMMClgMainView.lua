-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaixinmmclg/view/OriginAiXinMMClgMainView.lua

module("logic.extensions.originaixinmmclg.view.OriginAiXinMMClgMainView", package.seeall)

local OriginAiXinMMClgMainView = class("OriginAiXinMMClgMainView", DivineymjdmainView)

function OriginAiXinMMClgMainView:ctor()
	OriginAiXinMMClgMainView.super.ctor(self)
end

function OriginAiXinMMClgMainView:unbindEvents()
	OriginAiXinMMClgMainView.super.unbindEvents(self)
end

function OriginAiXinMMClgMainView:bindEvents()
	OriginAiXinMMClgMainView.super.bindEvents(self)
end

function OriginAiXinMMClgMainView:buildUI()
	OriginAiXinMMClgMainView.super.buildUI(self)
end

function OriginAiXinMMClgMainView:onExit()
	OriginAiXinMMClgMainView.super.onExit(self)
end

function OriginAiXinMMClgMainView:onEnter()
	OriginAiXinMMClgMainView.super.onEnter(self)
end

function OriginAiXinMMClgMainView:_onClickbtnChallenge()
	local isPass = KingspacedragonController.instance:isChallengePass(self._activityId)

	if isPass then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.OriginAiXinMMClgLevelsView)
end

return OriginAiXinMMClgMainView
