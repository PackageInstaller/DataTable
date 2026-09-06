-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongyanclg/view/OriginLongYanClgMainViewPresentor.lua

module("logic.extensions.originlongyanclg.view.OriginLongYanClgMainViewPresentor", package.seeall)

local OriginLongYanClgMainViewPresentor = class("OriginLongYanClgMainViewPresentor", ViewPresentor)

function OriginLongYanClgMainViewPresentor:ctor()
	OriginLongYanClgMainViewPresentor.super.ctor(self)
end

function OriginLongYanClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginLongYanClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originlongyanclg/originlongyanclgmainview.prefab"
	}
end

function OriginLongYanClgMainViewPresentor:buildViews()
	return {
		OriginLongYanClgMainView.New()
	}
end

return OriginLongYanClgMainViewPresentor
