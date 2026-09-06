-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originelizabeth/view/OriginelizabethbuffViewPresentor.lua

module("logic.extensions.originelizabeth.view.OriginelizabethbuffViewPresentor", package.seeall)

local OriginelizabethbuffViewPresentor = class("OriginelizabethbuffViewPresentor", ViewPresentor)

function OriginelizabethbuffViewPresentor:ctor()
	OriginelizabethbuffViewPresentor.super.ctor(self)
end

function OriginelizabethbuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginelizabethbuffViewPresentor:dependWhatResources()
	return {
		"ui/views/originelizabeth/originelizabethbuffview.prefab"
	}
end

function OriginelizabethbuffViewPresentor:buildViews()
	return {
		OriginelizabethbuffView.New()
	}
end

return OriginelizabethbuffViewPresentor
