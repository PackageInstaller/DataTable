-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originelizabeth/view/OriginelizabethdestinyViewPresentor.lua

module("logic.extensions.originelizabeth.view.OriginelizabethdestinyViewPresentor", package.seeall)

local OriginelizabethdestinyViewPresentor = class("OriginelizabethdestinyViewPresentor", ViewPresentor)

function OriginelizabethdestinyViewPresentor:ctor()
	OriginelizabethdestinyViewPresentor.super.ctor(self)
end

function OriginelizabethdestinyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginelizabethdestinyViewPresentor:dependWhatResources()
	return {
		"ui/views/originelizabeth/originelizabethdestinyview.prefab"
	}
end

function OriginelizabethdestinyViewPresentor:buildViews()
	return {
		OriginelizabethdestinyView.New()
	}
end

return OriginelizabethdestinyViewPresentor
