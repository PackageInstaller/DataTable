-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RoguePlotView.lua

module("logic.extensions.roguelike.view.explore.RoguePlotView", package.seeall)

local M = class("RoguePlotView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClick = self:getBtn("run_group_plot_view_156219711")
end

function M:onEnter()
	local plotCode = self:getFirstParam() or 1

	self:showPlot(plotCode)
end

function M:onExit()
	self._plotList = {}
	self._curStepIndex = 0
end

function M:showPlot(plotCode)
	local plots = RoguelikeConfig.instance:getPlotListById(plotCode)

	self._plotList = plots
	self._curStepIndex = 2

	self:showPlotStep(self._curStepIndex)
end

function M:showPlotStep(index)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_PLOT_STEP, index)
end

function M:bindEvents()
	self._btnClick:AddClickListener(self.onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onClick()
	self._curStepIndex = self._curStepIndex + 1

	if self._curStepIndex > #self._plotList then
		self:close()
	else
		self:showPlotStep(self._curStepIndex)

		if self._curStepIndex == #self._plotList then
			self:close()
		end
	end
end

return M
