-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongyanclg/view/OriginLongYanClgStageViewPresentor.lua

module("logic.extensions.originlongyanclg.view.OriginLongYanClgStageViewPresentor", package.seeall)

local OriginLongYanClgStageViewPresentor = class("OriginLongYanClgStageViewPresentor", ViewPresentor)

function OriginLongYanClgStageViewPresentor:ctor()
	OriginLongYanClgStageViewPresentor.super.ctor(self)
end

function OriginLongYanClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginLongYanClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originlongyanclg/originlongyanclgstageview.prefab"
	}
end

function OriginLongYanClgStageViewPresentor:buildViews()
	return {
		OriginLongYanClgStageView.New()
	}
end

return OriginLongYanClgStageViewPresentor
