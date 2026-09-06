-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/leila/LeilaMainView.lua

module("logic.extensions.timelimitedchallenge.view.leila.LeilaMainView", package.seeall)

local LeilaMainView = class("LeilaMainView", PerfectRuleModeMainView)

function LeilaMainView:buildUI()
	LeilaMainView.super.buildUI(self)

	self._challengeId = 19
end

return LeilaMainView
