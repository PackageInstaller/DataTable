-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongyanclg/view/OriginLongYanClgFmtExViewPresentor.lua

module("logic.extensions.originlongyanclg.view.OriginLongYanClgFmtExViewPresentor", package.seeall)

local OriginLongYanClgFmtExViewPresentor = class("OriginLongYanClgFmtExViewPresentor", ViewPresentor)

function OriginLongYanClgFmtExViewPresentor:ctor()
	OriginLongYanClgFmtExViewPresentor.super.ctor(self)
end

function OriginLongYanClgFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginLongYanClgFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/originlongyanclg/originlongyanclgfmtexview.prefab"
	}
end

function OriginLongYanClgFmtExViewPresentor:buildViews()
	return {
		OriginLongYanClgFmtExView.New()
	}
end

return OriginLongYanClgFmtExViewPresentor
