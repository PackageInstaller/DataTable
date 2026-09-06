-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/view/OriginPowersClgNormalResultViewPresentor.lua

module("logic.extensions.originpowersclg.view.OriginPowersClgNormalResultViewPresentor", package.seeall)

local OriginPowersClgNormalResultViewPresentor = class("OriginPowersClgNormalResultViewPresentor", ViewPresentor)

function OriginPowersClgNormalResultViewPresentor:ctor()
	OriginPowersClgNormalResultViewPresentor.super.ctor(self)
end

function OriginPowersClgNormalResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginPowersClgNormalResultViewPresentor:dependWhatResources()
	return {
		"ui/views/originpowersclg/originpowersclgnormalresultview.prefab"
	}
end

function OriginPowersClgNormalResultViewPresentor:buildViews()
	return {
		OriginPowersClgNormalResultView.New()
	}
end

return OriginPowersClgNormalResultViewPresentor
