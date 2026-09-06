-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originbinglingwang/view/OriginbinglingwangstageViewPresentor.lua

module("logic.extensions.originbinglingwang.view.OriginbinglingwangstageViewPresentor", package.seeall)

local OriginbinglingwangstageViewPresentor = class("OriginbinglingwangstageViewPresentor", ViewPresentor)

function OriginbinglingwangstageViewPresentor:ctor()
	OriginbinglingwangstageViewPresentor.super.ctor(self)
end

function OriginbinglingwangstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginbinglingwangstageViewPresentor:dependWhatResources()
	return {
		"ui/views/originbinglingwang/originbinglingwangstageview.prefab"
	}
end

function OriginbinglingwangstageViewPresentor:buildViews()
	return {
		OriginbinglingwangstageView.New()
	}
end

return OriginbinglingwangstageViewPresentor
