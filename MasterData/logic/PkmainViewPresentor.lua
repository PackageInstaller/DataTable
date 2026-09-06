-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/view/PkmainViewPresentor.lua

module("logic.extensions.pk.view.PkmainViewPresentor", package.seeall)

local PkmainViewPresentor = class("PkmainViewPresentor", ViewPresentor)

function PkmainViewPresentor:ctor()
	PkmainViewPresentor.super.ctor(self)
end

function PkmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PkmainViewPresentor:dependWhatResources()
	return {
		"ui/views/traincampqiecuo/traincampqiecuomainview.prefab"
	}
end

function PkmainViewPresentor:buildViews()
	return {
		PkmainView.New()
	}
end

return PkmainViewPresentor
