-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originbinglingwang/view/OriginbinglingwangmainViewPresentor.lua

module("logic.extensions.originbinglingwang.view.OriginbinglingwangmainViewPresentor", package.seeall)

local OriginbinglingwangmainViewPresentor = class("OriginbinglingwangmainViewPresentor", ViewPresentor)

function OriginbinglingwangmainViewPresentor:ctor()
	OriginbinglingwangmainViewPresentor.super.ctor(self)
end

function OriginbinglingwangmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginbinglingwangmainViewPresentor:dependWhatResources()
	return {
		"ui/views/originbinglingwang/originbinglingwangmainview.prefab"
	}
end

function OriginbinglingwangmainViewPresentor:buildViews()
	return {
		OriginbinglingwangmainView.New()
	}
end

return OriginbinglingwangmainViewPresentor
