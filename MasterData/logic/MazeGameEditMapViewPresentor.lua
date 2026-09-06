-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mazegame/view/MazeGameEditMapViewPresentor.lua

module("logic.extensions.mazegame.view.MazeGameEditMapViewPresentor", package.seeall)

local MazeGameEditMapViewPresentor = class("MazeGameEditMapViewPresentor", ViewPresentor)

function MazeGameEditMapViewPresentor:ctor()
	MazeGameEditMapViewPresentor.super.ctor(self)
end

function MazeGameEditMapViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MazeGameEditMapViewPresentor:dependWhatResources()
	return {
		"ui/views/mazegame/mazegameeditmapview.prefab"
	}
end

function MazeGameEditMapViewPresentor:buildViews()
	return {
		MazeGameEditMapView.New()
	}
end

return MazeGameEditMapViewPresentor
