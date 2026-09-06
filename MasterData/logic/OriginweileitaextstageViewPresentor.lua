-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/view/OriginweileitaextstageViewPresentor.lua

module("logic.extensions.originweileita.view.OriginweileitaextstageViewPresentor", package.seeall)

local OriginweileitaextstageViewPresentor = class("OriginweileitaextstageViewPresentor", ViewPresentor)

function OriginweileitaextstageViewPresentor:ctor()
	OriginweileitaextstageViewPresentor.super.ctor(self)
end

function OriginweileitaextstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginweileitaextstageViewPresentor:dependWhatResources()
	return {
		"ui/views/originweileita/originweileitaextstageview.prefab"
	}
end

function OriginweileitaextstageViewPresentor:buildViews()
	return {
		OriginweileitaextstageView.New()
	}
end

return OriginweileitaextstageViewPresentor
