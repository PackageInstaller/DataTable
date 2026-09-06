-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationTaskView.lua

module("logic.extensions.threeelimination.view.ThreeEliminationTaskView", package.seeall)

local ThreeEliminationTaskView = class("ThreeEliminationTaskView", EventTaskTabFrameView)

function ThreeEliminationTaskView:ctor()
	ThreeEliminationTaskView.super.ctor(self)
end

function ThreeEliminationTaskView:unbindEvents()
	ThreeEliminationTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose, self.close, self)
end

function ThreeEliminationTaskView:bindEvents()
	ThreeEliminationTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ThreeEliminationTaskView:buildUI()
	ThreeEliminationTaskView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
end

function ThreeEliminationTaskView:onExit()
	ThreeEliminationTaskView.super.onExit(self)
end

function ThreeEliminationTaskView:onEnter()
	ThreeEliminationTaskView.super.onEnter(self)
end

return ThreeEliminationTaskView
