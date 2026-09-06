-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/tourarena/TourArenaFightTaskFrameView.lua

module("logic.extensions.eventtasksummary.view.tab.tourarena.TourArenaFightTaskFrameView", package.seeall)

local TourArenaFightTaskFrameView = class("TourArenaFightTaskFrameView", EventTaskTabFrameView)

function TourArenaFightTaskFrameView:setActId()
	self._activityId = TourArenaController.instance:getActivityIdOfFight()
end

return TourArenaFightTaskFrameView
