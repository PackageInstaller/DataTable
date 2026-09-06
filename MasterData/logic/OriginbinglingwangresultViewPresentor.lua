-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originbinglingwang/view/OriginbinglingwangresultViewPresentor.lua

module("logic.extensions.originbinglingwang.view.OriginbinglingwangresultViewPresentor", package.seeall)

local OriginbinglingwangresultViewPresentor = class("OriginbinglingwangresultViewPresentor", ViewPresentor)

function OriginbinglingwangresultViewPresentor:ctor()
	OriginbinglingwangresultViewPresentor.super.ctor(self)
end

function OriginbinglingwangresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginbinglingwangresultViewPresentor:dependWhatResources()
	return {
		"ui/views/originbinglingwang/originbinglingwangresultview.prefab"
	}
end

function OriginbinglingwangresultViewPresentor:buildViews()
	return {
		OriginbinglingwangresultView.New()
	}
end

return OriginbinglingwangresultViewPresentor
