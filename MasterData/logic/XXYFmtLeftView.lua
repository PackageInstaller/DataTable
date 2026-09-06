-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinxiyamirror/view/formation/XXYFmtLeftView.lua

module("logic.extensions.xinxiyamirror.view.formation.XXYFmtLeftView", package.seeall)

local XXYFmtLeftView = class("XXYFmtLeftView", FormationLeftView)

function XXYFmtLeftView:onEnter()
	local params = self._viewPresentor:getFirstParam()

	if params and params.isMirror then
		self:_getCurFormation():ResetPosition()
	end

	XXYFmtLeftView.super.onEnter(self)
end

return XXYFmtLeftView
