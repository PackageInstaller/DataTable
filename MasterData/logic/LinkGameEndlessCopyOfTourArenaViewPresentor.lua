-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/copy/link/LinkGameEndlessCopyOfTourArenaViewPresentor.lua

module("logic.extensions.tourarena.view.copy.link.LinkGameEndlessCopyOfTourArenaViewPresentor", package.seeall)

local LinkGameEndlessCopyOfTourArenaViewPresentor = class("LinkGameEndlessCopyOfTourArenaViewPresentor", LinkGameEndlessViewPresentor)

function LinkGameEndlessCopyOfTourArenaViewPresentor:buildViews()
	return {
		LinkGameEndlessCopyOfTourArenaView.New()
	}
end

return LinkGameEndlessCopyOfTourArenaViewPresentor
