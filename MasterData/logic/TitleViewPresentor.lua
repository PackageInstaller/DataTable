-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/title/view/TitleViewPresentor.lua

module("logic.extensions.title.view.TitleViewPresentor", package.seeall)

local TitleViewPresentor = class("TitleViewPresentor", ViewWithGuidePresentor)

function TitleViewPresentor:ctor()
	TitleViewPresentor.super.ctor(self)
end

function TitleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TitleViewPresentor:dependWhatResources()
	return {
		"ui/views/title/titleview.prefab"
	}
end

function TitleViewPresentor:buildViews()
	return {
		TitleView.New()
	}
end

return TitleViewPresentor
