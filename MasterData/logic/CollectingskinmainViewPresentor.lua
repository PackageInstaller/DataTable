-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/view/CollectingskinmainViewPresentor.lua

module("logic.extensions.collectingskin.view.CollectingskinmainViewPresentor", package.seeall)

local CollectingskinmainViewPresentor = class("CollectingskinmainViewPresentor", ViewPresentor)

function CollectingskinmainViewPresentor:ctor()
	CollectingskinmainViewPresentor.super.ctor(self)
end

function CollectingskinmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectingskinmainViewPresentor:dependWhatResources()
	return {
		"ui/views/collectingskin/collectingskinmainview.prefab"
	}
end

function CollectingskinmainViewPresentor:buildViews()
	return {
		CollectingskinmainView.New()
	}
end

return CollectingskinmainViewPresentor
