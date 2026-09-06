-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mazegame/view/MazeGameLevelViewPresentor.lua

module("logic.extensions.mazegame.view.MazeGameLevelViewPresentor", package.seeall)

local MazeGameLevelViewPresentor = class("MazeGameLevelViewPresentor", ViewPresentor)

function MazeGameLevelViewPresentor:ctor()
	MazeGameLevelViewPresentor.super.ctor(self)
end

function MazeGameLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MazeGameLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/mazegame/mazegamelevelview.prefab"
	}
end

function MazeGameLevelViewPresentor:buildViews()
	return {
		MazeGameLevelView.New()
	}
end

return MazeGameLevelViewPresentor
