-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/SxGameStartViewPresentor.lua

module("logic.extensions.sxgame.view.SxGameStartViewPresentor", package.seeall)

local SxGameStartViewPresentor = class("SxGameStartViewPresentor", ViewPresentor)

function SxGameStartViewPresentor:ctor()
	SxGameStartViewPresentor.super.ctor(self)
end

function SxGameStartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SxGameStartViewPresentor:dependWhatResources()
	return {
		"ui/views/sxgame/sxgamestartview.prefab"
	}
end

function SxGameStartViewPresentor:buildViews()
	local views = {}
	local view = SxGameStartView.New()

	table.insert(views, view)

	return views
end

function SxGameStartViewPresentor:onClickOutside()
	UIStateManager.instance:pop()
end

return SxGameStartViewPresentor
