-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originelizabeth/view/OriginelizabethlifeViewPresentor.lua

module("logic.extensions.originelizabeth.view.OriginelizabethlifeViewPresentor", package.seeall)

local OriginelizabethlifeViewPresentor = class("OriginelizabethlifeViewPresentor", ViewPresentor)

function OriginelizabethlifeViewPresentor:ctor()
	OriginelizabethlifeViewPresentor.super.ctor(self)
end

function OriginelizabethlifeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginelizabethlifeViewPresentor:dependWhatResources()
	return {
		"ui/views/originelizabeth/originelizabethlifeview.prefab"
	}
end

function OriginelizabethlifeViewPresentor:buildViews()
	return {
		OriginelizabethlifeView.New()
	}
end

return OriginelizabethlifeViewPresentor
