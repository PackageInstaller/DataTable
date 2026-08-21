-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/ControlActionViewPresentor.lua

module("logic.extensions.controlaction.view.ControlActionViewPresentor", package.seeall)

local M = class("ControlActionViewPresentor", ViewPresentor)

M.Url_View = ResName.Regulatory_action_desk_view

function M:dependWhatResources()
	return {
		M.Url_View
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ControlActionView.New())
	table.insert(views, TitleView.New())

	return views
end

function M:playCloseAnimation(windowCloseReasonType, isStop)
	self._views[1]:playCloseAnimation(windowCloseReasonType, isStop)
	settimer(1, function()
		self:_onCloseAnimationDone()
	end, self, false)
end

return M
