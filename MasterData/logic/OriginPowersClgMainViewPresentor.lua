-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/view/OriginPowersClgMainViewPresentor.lua

module("logic.extensions.originpowersclg.view.OriginPowersClgMainViewPresentor", package.seeall)

local OriginPowersClgMainViewPresentor = class("OriginPowersClgMainViewPresentor", ViewPresentor)

function OriginPowersClgMainViewPresentor:ctor()
	OriginPowersClgMainViewPresentor.super.ctor(self)
end

function OriginPowersClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginPowersClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originpowersclg/originpowersclgmainview.prefab"
	}
end

function OriginPowersClgMainViewPresentor:buildViews()
	return {
		OriginPowersClgMainView.New()
	}
end

return OriginPowersClgMainViewPresentor
