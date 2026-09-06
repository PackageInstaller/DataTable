-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/view/OriginPowersClgExtResultViewPresentor.lua

module("logic.extensions.originpowersclg.view.OriginPowersClgExtResultViewPresentor", package.seeall)

local OriginPowersClgExtResultViewPresentor = class("OriginPowersClgExtResultViewPresentor", ViewPresentor)

function OriginPowersClgExtResultViewPresentor:ctor()
	OriginPowersClgExtResultViewPresentor.super.ctor(self)
end

function OriginPowersClgExtResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginPowersClgExtResultViewPresentor:dependWhatResources()
	return {
		"ui/views/originpowersclg/originpowersclgextresultview.prefab"
	}
end

function OriginPowersClgExtResultViewPresentor:buildViews()
	return {
		OriginPowersClgExtResultView.New()
	}
end

return OriginPowersClgExtResultViewPresentor
