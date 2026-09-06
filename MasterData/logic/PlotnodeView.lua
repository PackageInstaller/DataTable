-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotmemories/view/PlotnodeView.lua

module("logic.extensions.plotmemories.view.PlotnodeView", package.seeall)

local PlotnodeView = class("PlotnodeView", ViewComponent)

function PlotnodeView:buildUI()
	PlotnodeView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._cell = self:getGo("cell")
	self._view = ScrollerList.create(self:getGo("view"), self._cell, GameUtil.handler(self._updateCell, self))
end

function PlotnodeView:bindEvents()
	PlotnodeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function PlotnodeView:unbindEvents()
	PlotnodeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function PlotnodeView:onEnter()
	PlotnodeView.super.onEnter(self)

	local openParam = self:getOpenParam()

	self._view:reloadData(PlotmamoriesController.instance:getNodeInfo(openParam[1]))
end

function PlotnodeView:onExit()
	PlotnodeView.super.onExit(self)
end

function PlotnodeView:_updateCell(view, cell, data)
	goutil.findChildTextComponent(cell.gameObject, "name").text = data.name
	goutil.findChildTextComponent(cell.gameObject, "desc").text = data.introduction

	Framework.ButtonAdapter.GetFrom(cell.gameObject, "playBtn"):AddClickListener(function()
		StoryController.instance:startStory(data.storyId, StoryModel.HuiGu)
	end)
end

return PlotnodeView
