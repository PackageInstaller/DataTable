-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/nainfei/NianfeistageViewPresentor.lua

module("logic.extensions.scenariocopy.view.dreamteammutualhelp.NianfeistageViewPresentor", package.seeall)

local NianfeistageViewPresentor = class("NianfeistageViewPresentor", ViewPresentor)

function NianfeistageViewPresentor:ctor()
	NianfeistageViewPresentor.super.ctor(self)
end

function NianfeistageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NianfeistageViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/nianfei/nianfeistageview.prefab"
	}
end

function NianfeistageViewPresentor:buildViews()
	return {
		NianfeistageView.New()
	}
end

return NianfeistageViewPresentor
