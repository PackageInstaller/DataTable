-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/view/OriginjiustageViewPresentor.lua

module("logic.extensions.originjiu.view.OriginjiustageViewPresentor", package.seeall)

local OriginjiustageViewPresentor = class("OriginjiustageViewPresentor", ViewPresentor)

function OriginjiustageViewPresentor:ctor()
	OriginjiustageViewPresentor.super.ctor(self)
end

function OriginjiustageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginjiustageViewPresentor:dependWhatResources()
	return {
		"ui/views/originjiu/originjiustageview.prefab"
	}
end

function OriginjiustageViewPresentor:buildViews()
	return {
		OriginjiustageView.New()
	}
end

return OriginjiustageViewPresentor
