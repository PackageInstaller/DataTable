-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/qianli/QianliMainView.lua

module("logic.extensions.timelimitedchallenge.view.qianli.QianliMainView", package.seeall)

local QianliMainView = class("QianliMainView", PerfectRuleModeMainView)

function QianliMainView:buildUI()
	QianliMainView.super.buildUI(self)

	self._challengeId = 24
end

return QianliMainView
