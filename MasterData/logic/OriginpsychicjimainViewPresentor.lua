-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpsychicji/view/OriginpsychicjimainViewPresentor.lua

module("logic.extensions.originpsychicji.view.OriginpsychicjimainViewPresentor", package.seeall)

local OriginpsychicjimainViewPresentor = class("OriginpsychicjimainViewPresentor", ViewPresentor)

function OriginpsychicjimainViewPresentor:ctor()
	OriginpsychicjimainViewPresentor.super.ctor(self)
end

function OriginpsychicjimainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginpsychicjimainViewPresentor:dependWhatResources()
	return {
		"ui/views/originpsychicji/originpsychicjimainview.prefab"
	}
end

function OriginpsychicjimainViewPresentor:buildViews()
	return {
		OriginpsychicjimainView.New()
	}
end

return OriginpsychicjimainViewPresentor
