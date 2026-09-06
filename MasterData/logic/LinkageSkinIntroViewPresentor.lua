-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageskinintro/view/LinkageSkinIntroViewPresentor.lua

module("logic.extensions.linkageskinintro.view.LinkageSkinIntroViewPresentor", package.seeall)

local LinkageSkinIntroViewPresentor = class("LinkageSkinIntroViewPresentor", ViewPresentor)

function LinkageSkinIntroViewPresentor:ctor()
	LinkageSkinIntroViewPresentor.super.ctor(self)
end

function LinkageSkinIntroViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LinkageSkinIntroViewPresentor:dependWhatResources()
	return {
		"ui/views/linkageskinintro/linkageskinintroview.prefab"
	}
end

function LinkageSkinIntroViewPresentor:buildViews()
	return {
		LinkageSkinIntroView.New()
	}
end

return LinkageSkinIntroViewPresentor
