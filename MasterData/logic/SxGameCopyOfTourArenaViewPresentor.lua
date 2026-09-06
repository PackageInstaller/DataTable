-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/copy/sxgame/SxGameCopyOfTourArenaViewPresentor.lua

module("logic.extensions.tourarena.view.copy.sxgame.SxGameCopyOfTourArenaViewPresentor", package.seeall)

local SxGameCopyOfTourArenaViewPresentor = class("SxGameCopyOfTourArenaViewPresentor", SxGameViewPresentor)

function SxGameCopyOfTourArenaViewPresentor:buildViews()
	local views = {}
	local view = SxGameCopyOfTourArenaView.New()

	table.insert(views, view)

	return views
end

return SxGameCopyOfTourArenaViewPresentor
