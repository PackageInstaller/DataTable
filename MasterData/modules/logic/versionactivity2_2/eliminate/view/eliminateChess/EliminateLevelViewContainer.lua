-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateLevelViewContainer.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelViewContainer", package.seeall)

local EliminateLevelViewContainer = class("EliminateLevelViewContainer", BaseViewContainer)

function EliminateLevelViewContainer:buildViews()
	self._sceneView = EliminateSceneView.New()
	self._teamChessView = EliminateTeamChessView.New()
	self._eliminateView = EliminateView.New()
	self._eliminateLevelView = EliminateLevelView.New()

	return {
		self._sceneView,
		self._teamChessView,
		self._eliminateView,
		self._eliminateLevelView
	}
end

function EliminateLevelViewContainer:setTeamChessViewParent(parent, canvas)
	self._eliminateLevelView:setParent(parent, canvas)
end

function EliminateLevelViewContainer:setTeamChessTipViewParent(parent, canvas)
	self._teamChessView:setTipViewParent(parent, canvas)
end

function EliminateLevelViewContainer:setVisibleInternal(isVisible)
	if self._sceneView ~= nil then
		self._sceneView:setSceneVisible(isVisible)
		EliminateLevelViewContainer.super.setVisibleInternal(self, isVisible)
	end
end

function EliminateLevelViewContainer:onContainerOpenFinish()
	return
end

return EliminateLevelViewContainer
