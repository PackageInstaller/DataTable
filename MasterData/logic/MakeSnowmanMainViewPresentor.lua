-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makesnowman/view/MakeSnowmanMainViewPresentor.lua

module("logic.extensions.makesnowman.view.MakeSnowmanMainViewPresentor", package.seeall)

local MakeSnowmanMainViewPresentor = class("MakeSnowmanMainViewPresentor", ViewPresentor)

function MakeSnowmanMainViewPresentor:ctor()
	MakeSnowmanMainViewPresentor.super.ctor(self)
end

function MakeSnowmanMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MakeSnowmanMainViewPresentor:dependWhatResources()
	return {
		"ui/views/makesnowman/makesnowmanmainview.prefab"
	}
end

function MakeSnowmanMainViewPresentor:buildViews()
	return {
		MakeSnowmanMainView.New()
	}
end

return MakeSnowmanMainViewPresentor
