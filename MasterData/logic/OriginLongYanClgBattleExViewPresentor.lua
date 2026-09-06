-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongyanclg/view/OriginLongYanClgBattleExViewPresentor.lua

module("logic.extensions.originlongyanclg.view.OriginLongYanClgBattleExViewPresentor", package.seeall)

local OriginLongYanClgBattleExViewPresentor = class("OriginLongYanClgBattleExViewPresentor", ViewPresentor)

function OriginLongYanClgBattleExViewPresentor:ctor()
	OriginLongYanClgBattleExViewPresentor.super.ctor(self)
end

function OriginLongYanClgBattleExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginLongYanClgBattleExViewPresentor:dependWhatResources()
	return {
		"ui/views/originlongyanclg/originlongyanclgbattleexview.prefab"
	}
end

function OriginLongYanClgBattleExViewPresentor:buildViews()
	return {
		OriginLongYanClgBattleExView.New()
	}
end

return OriginLongYanClgBattleExViewPresentor
