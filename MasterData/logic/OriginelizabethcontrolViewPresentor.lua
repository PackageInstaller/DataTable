-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originelizabeth/view/OriginelizabethcontrolViewPresentor.lua

module("logic.extensions.originelizabeth.view.OriginelizabethcontrolViewPresentor", package.seeall)

local OriginelizabethcontrolViewPresentor = class("OriginelizabethcontrolViewPresentor", ViewPresentor)

function OriginelizabethcontrolViewPresentor:ctor()
	OriginelizabethcontrolViewPresentor.super.ctor(self)
end

function OriginelizabethcontrolViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginelizabethcontrolViewPresentor:dependWhatResources()
	return {
		"ui/views/originelizabeth/originelizabethcontrolview.prefab"
	}
end

function OriginelizabethcontrolViewPresentor:buildViews()
	return {
		OriginelizabethcontrolView.New()
	}
end

return OriginelizabethcontrolViewPresentor
