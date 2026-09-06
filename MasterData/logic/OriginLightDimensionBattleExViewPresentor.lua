-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/view/OriginLightDimensionBattleExViewPresentor.lua

module("logic.extensions.originlightdimension.view.OriginLightDimensionBattleExViewPresentor", package.seeall)

local OriginLightDimensionBattleExViewPresentor = class("OriginLightDimensionBattleExViewPresentor", ViewPresentor)

function OriginLightDimensionBattleExViewPresentor:ctor()
	OriginLightDimensionBattleExViewPresentor.super.ctor(self)
end

function OriginLightDimensionBattleExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginLightDimensionBattleExViewPresentor:dependWhatResources()
	return {
		"ui/views/originlightdimension/originlightdimensionbattleexview.prefab"
	}
end

function OriginLightDimensionBattleExViewPresentor:buildViews()
	return {
		OriginLightDimensionBattleExView.New()
	}
end

return OriginLightDimensionBattleExViewPresentor
