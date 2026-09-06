-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectclothes/view/CollectclothesmainViewPresentor.lua

module("logic.extensions.collectclothes.view.CollectclothesmainViewPresentor", package.seeall)

local CollectclothesmainViewPresentor = class("CollectclothesmainViewPresentor", ViewPresentor)

function CollectclothesmainViewPresentor:ctor()
	CollectclothesmainViewPresentor.super.ctor(self)
end

function CollectclothesmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectclothesmainViewPresentor:dependWhatResources()
	return {
		"ui/views/collectclothes/collectclothesmainview.prefab"
	}
end

function CollectclothesmainViewPresentor:buildViews()
	return {
		CollectClothesMainView.New()
	}
end

return CollectclothesmainViewPresentor
