-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongzhu/view/OriginlongzhubuffViewPresentor.lua

module("logic.extensions.originlongzhu.view.OriginlongzhubuffViewPresentor", package.seeall)

local OriginlongzhubuffViewPresentor = class("OriginlongzhubuffViewPresentor", ViewPresentor)

function OriginlongzhubuffViewPresentor:ctor()
	OriginlongzhubuffViewPresentor.super.ctor(self)
end

function OriginlongzhubuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginlongzhubuffViewPresentor:dependWhatResources()
	return {
		"ui/views/originlongzhu/originlongzhubuffview.prefab"
	}
end

function OriginlongzhubuffViewPresentor:buildViews()
	return {
		OriginlongzhubuffView.New()
	}
end

return OriginlongzhubuffViewPresentor
