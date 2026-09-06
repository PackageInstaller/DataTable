-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongzhu/view/OriginlongzhustageViewPresentor.lua

module("logic.extensions.originlongzhu.view.OriginlongzhustageViewPresentor", package.seeall)

local OriginlongzhustageViewPresentor = class("OriginlongzhustageViewPresentor", ViewPresentor)

function OriginlongzhustageViewPresentor:ctor()
	OriginlongzhustageViewPresentor.super.ctor(self)
end

function OriginlongzhustageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginlongzhustageViewPresentor:dependWhatResources()
	return {
		"ui/views/originlongzhu/originlongzhustageview.prefab"
	}
end

function OriginlongzhustageViewPresentor:buildViews()
	return {
		OriginlongzhustageView.New()
	}
end

return OriginlongzhustageViewPresentor
