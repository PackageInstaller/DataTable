-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/view/OriginweileitanorresultViewPresentor.lua

module("logic.extensions.originweileita.view.OriginweileitanorresultViewPresentor", package.seeall)

local OriginweileitanorresultViewPresentor = class("OriginweileitanorresultViewPresentor", ViewPresentor)

function OriginweileitanorresultViewPresentor:ctor()
	OriginweileitanorresultViewPresentor.super.ctor(self)
end

function OriginweileitanorresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginweileitanorresultViewPresentor:dependWhatResources()
	return {
		"ui/views/originweileita/originweileitanorresultview.prefab"
	}
end

function OriginweileitanorresultViewPresentor:buildViews()
	return {
		OriginweileitanorresultView.New()
	}
end

return OriginweileitanorresultViewPresentor
