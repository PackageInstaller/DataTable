-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mazegame/view/MazeGameViewPresentor.lua

module("logic.extensions.mazegame.view.MazeGameViewPresentor", package.seeall)

local MazeGameViewPresentor = class("MazeGameViewPresentor", ViewPresentor)

function MazeGameViewPresentor:ctor()
	MazeGameViewPresentor.super.ctor(self)
end

function MazeGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MazeGameViewPresentor:dependWhatResources()
	return {
		"ui/views/mazegame/mazegameview.prefab"
	}
end

function MazeGameViewPresentor:buildViews()
	return {
		MazeGameView.New()
	}
end

return MazeGameViewPresentor
