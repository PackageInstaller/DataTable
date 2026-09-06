-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/view/OriginPowersClgExtremeViewPresentor.lua

module("logic.extensions.originpowersclg.view.OriginPowersClgExtremeViewPresentor", package.seeall)

local OriginPowersClgExtremeViewPresentor = class("OriginPowersClgExtremeViewPresentor", ViewPresentor)

function OriginPowersClgExtremeViewPresentor:ctor()
	OriginPowersClgExtremeViewPresentor.super.ctor(self)
end

function OriginPowersClgExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginPowersClgExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/originpowersclg/originpowersclgextremeview.prefab"
	}
end

function OriginPowersClgExtremeViewPresentor:buildViews()
	return {
		OriginPowersClgExtremeView.New()
	}
end

return OriginPowersClgExtremeViewPresentor
