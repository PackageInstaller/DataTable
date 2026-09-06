-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originzhengli/view/OriginzhengliResultViewPresentor.lua

module("logic.extensions.originzhengli.view.OriginzhengliResultViewPresentor", package.seeall)

local OriginzhengliResultViewPresentor = class("OriginzhengliResultViewPresentor", ViewPresentor)

function OriginzhengliResultViewPresentor:ctor()
	OriginzhengliResultViewPresentor.super.ctor(self)
end

function OriginzhengliResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginzhengliResultViewPresentor:dependWhatResources()
	return {
		"ui/views/originzhengli/originzhengliresultview.prefab"
	}
end

function OriginzhengliResultViewPresentor:buildViews()
	return {
		OriginzhengliResultView.New()
	}
end

return OriginzhengliResultViewPresentor
