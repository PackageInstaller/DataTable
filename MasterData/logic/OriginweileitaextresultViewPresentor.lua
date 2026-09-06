-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/view/OriginweileitaextresultViewPresentor.lua

module("logic.extensions.originweileita.view.OriginweileitaextresultViewPresentor", package.seeall)

local OriginweileitaextresultViewPresentor = class("OriginweileitaextresultViewPresentor", ViewPresentor)

function OriginweileitaextresultViewPresentor:ctor()
	OriginweileitaextresultViewPresentor.super.ctor(self)
end

function OriginweileitaextresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginweileitaextresultViewPresentor:dependWhatResources()
	return {
		"ui/views/originweileita/originweileitaextresultview.prefab"
	}
end

function OriginweileitaextresultViewPresentor:buildViews()
	return {
		OriginweileitaextresultView.New()
	}
end

return OriginweileitaextresultViewPresentor
