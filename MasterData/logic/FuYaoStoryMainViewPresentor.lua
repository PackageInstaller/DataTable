-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyaostory/view/FuYaoStoryMainViewPresentor.lua

module("logic.extensions.fuyaostory.view.FuYaoStoryMainViewPresentor", package.seeall)

local FuYaoStoryMainViewPresentor = class("FuYaoStoryMainViewPresentor", ViewPresentor)

function FuYaoStoryMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FuYaoStoryMainViewPresentor:dependWhatResources()
	return {
		"ui/views/fuyaostory/fuyaostorymainview.prefab"
	}
end

function FuYaoStoryMainViewPresentor:buildViews()
	return {
		FuYaoStoryMainView.New()
	}
end

return FuYaoStoryMainViewPresentor
