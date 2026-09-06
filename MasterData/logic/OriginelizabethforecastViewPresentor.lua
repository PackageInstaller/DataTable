-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originelizabeth/view/OriginelizabethforecastViewPresentor.lua

module("logic.extensions.originelizabeth.view.OriginelizabethforecastViewPresentor", package.seeall)

local OriginelizabethforecastViewPresentor = class("OriginelizabethforecastViewPresentor", ViewPresentor)

function OriginelizabethforecastViewPresentor:ctor()
	OriginelizabethforecastViewPresentor.super.ctor(self)
end

function OriginelizabethforecastViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginelizabethforecastViewPresentor:dependWhatResources()
	return {
		"ui/views/originelizabeth/originelizabethforecastview.prefab"
	}
end

function OriginelizabethforecastViewPresentor:buildViews()
	return {
		OriginelizabethforecastView.New()
	}
end

return OriginelizabethforecastViewPresentor
