-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/view/OriginweileitanorstageViewPresentor.lua

module("logic.extensions.originweileita.view.OriginweileitanorstageViewPresentor", package.seeall)

local OriginweileitanorstageViewPresentor = class("OriginweileitanorstageViewPresentor", ViewPresentor)

function OriginweileitanorstageViewPresentor:ctor()
	OriginweileitanorstageViewPresentor.super.ctor(self)
end

function OriginweileitanorstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginweileitanorstageViewPresentor:dependWhatResources()
	return {
		"ui/views/originweileita/originweileitanorstageview.prefab"
	}
end

function OriginweileitanorstageViewPresentor:buildViews()
	return {
		OriginweileitanorstageView.New()
	}
end

return OriginweileitanorstageViewPresentor
