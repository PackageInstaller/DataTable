-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/view/OriginPowersClgNormalBuffViewPresentor.lua

module("logic.extensions.originpowersclg.view.OriginPowersClgNormalBuffViewPresentor", package.seeall)

local OriginPowersClgNormalBuffViewPresentor = class("OriginPowersClgNormalBuffViewPresentor", ViewPresentor)

function OriginPowersClgNormalBuffViewPresentor:ctor()
	OriginPowersClgNormalBuffViewPresentor.super.ctor(self)
end

function OriginPowersClgNormalBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginPowersClgNormalBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/originpowersclg/originpowersclgnormalbuffview.prefab"
	}
end

function OriginPowersClgNormalBuffViewPresentor:buildViews()
	return {
		OriginPowersClgNormalBuffView.New()
	}
end

return OriginPowersClgNormalBuffViewPresentor
