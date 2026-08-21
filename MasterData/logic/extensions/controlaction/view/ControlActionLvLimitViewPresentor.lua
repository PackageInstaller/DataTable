-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/ControlActionLvLimitViewPresentor.lua

module("logic.extensions.controlaction.view.ControlActionLvLimitViewPresentor", package.seeall)

local M = class("ControlActionLvLimitViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Regulatory_level_limit_tips
	}
end

function M:buildViews()
	local views = {}

	self._clickView = ToolTipsPointerDownHandlerComp.New()

	table.insert(views, self._clickView)
	table.insert(views, ControlActionLvLimitView.New())
	table.insert(views, ToolTipsFixTipsPosComp.New())

	return views
end

function M:_onCloseAnimationDone()
	if self._clickView._isDraging then
		self._clickView:simulateCloseWhenDraging()
	else
		M.super._onCloseAnimationDone(self)
	end
end

function M:closeWhenDragEnd()
	M.super._onCloseAnimationDone(self)
end

return M
