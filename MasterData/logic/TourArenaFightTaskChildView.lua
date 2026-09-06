-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/tourarena/TourArenaFightTaskChildView.lua

module("logic.extensions.eventtasksummary.view.tab.tourarena.TourArenaFightTaskChildView", package.seeall)

local TourArenaFightTaskChildView = class("TourArenaFightTaskChildView", EventTaskTabChildView)

function TourArenaFightTaskChildView:buildUI()
	TourArenaFightTaskChildView.super.buildUI(self)
	self._taskScrollList:regReloadFinish(function()
		self:_onReloadFinish()
	end)
end

function TourArenaFightTaskChildView:onEnter()
	TourArenaFightTaskChildView.super.onEnter(self)
end

function TourArenaFightTaskChildView:_onTaskTabUpdate()
	self._needLocation = true

	TourArenaFightTaskChildView.super._onTaskTabUpdate(self)
end

function TourArenaFightTaskChildView:_onReloadFinish()
	if self._needLocation then
		self._needLocation = false

		local index = self:_getMoveIndex()

		self._taskScrollList:MoveCellToBegin(index - 1)
	end
end

function TourArenaFightTaskChildView:_getMoveIndex()
	local index = 0

	for _, taskInfoList in ipairs(self._typeInfoList) do
		index = index + 1

		if taskInfoList[1] and taskInfoList[1].state == GameEnum.PrizeState.IsCanGet then
			return index
		end
	end

	return 1
end

return TourArenaFightTaskChildView
