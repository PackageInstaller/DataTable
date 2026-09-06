-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/view/TraincampqiecuomodpowerViewPresentor.lua

module("logic.extensions.traincampqiecuo.view.TraincampqiecuomodpowerViewPresentor", package.seeall)

local TraincampqiecuomodpowerViewPresentor = class("TraincampqiecuomodpowerViewPresentor", ViewPresentor)

function TraincampqiecuomodpowerViewPresentor:ctor()
	TraincampqiecuomodpowerViewPresentor.super.ctor(self)
end

function TraincampqiecuomodpowerViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TraincampqiecuomodpowerViewPresentor:dependWhatResources()
	return {
		"ui/views/traincampqiecuo/traincampqiecuomodpowerview.prefab"
	}
end

function TraincampqiecuomodpowerViewPresentor:buildViews()
	return {
		TraincampqiecuomodpowerView.New()
	}
end

return TraincampqiecuomodpowerViewPresentor
