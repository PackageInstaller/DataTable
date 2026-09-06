-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongzhu/view/OriginlongzhumainViewPresentor.lua

module("logic.extensions.originlongzhu.view.OriginlongzhumainViewPresentor", package.seeall)

local OriginlongzhumainViewPresentor = class("OriginlongzhumainViewPresentor", ViewPresentor)

function OriginlongzhumainViewPresentor:ctor()
	OriginlongzhumainViewPresentor.super.ctor(self)
end

function OriginlongzhumainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginlongzhumainViewPresentor:dependWhatResources()
	return {
		"ui/views/originlongzhu/originlongzhumainview.prefab"
	}
end

function OriginlongzhumainViewPresentor:buildViews()
	return {
		OriginlongzhumainView.New()
	}
end

return OriginlongzhumainViewPresentor
