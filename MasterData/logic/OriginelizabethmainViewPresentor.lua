-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originelizabeth/view/OriginelizabethmainViewPresentor.lua

module("logic.extensions.originelizabeth.view.OriginelizabethmainViewPresentor", package.seeall)

local OriginelizabethmainViewPresentor = class("OriginelizabethmainViewPresentor", ViewPresentor)

function OriginelizabethmainViewPresentor:ctor()
	OriginelizabethmainViewPresentor.super.ctor(self)
end

function OriginelizabethmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginelizabethmainViewPresentor:dependWhatResources()
	return {
		"ui/views/originelizabeth/originelizabethmainview.prefab"
	}
end

function OriginelizabethmainViewPresentor:buildViews()
	return {
		OriginelizabethmainView.New()
	}
end

return OriginelizabethmainViewPresentor
