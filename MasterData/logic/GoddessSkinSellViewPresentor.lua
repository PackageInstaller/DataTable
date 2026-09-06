-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/GoddessSkinSellViewPresentor.lua

module("logic.extensions.firstcharge.view.GoddessSkinSellViewPresentor", package.seeall)

local GoddessSkinSellViewPresentor = class("GoddessSkinSellViewPresentor", ViewPresentor)

function GoddessSkinSellViewPresentor:ctor()
	GoddessSkinSellViewPresentor.super.ctor(self)
end

function GoddessSkinSellViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessSkinSellViewPresentor:dependWhatResources()
	return {
		"ui/views/firstcharge/petskinsaleview.prefab"
	}
end

function GoddessSkinSellViewPresentor:buildViews()
	return {
		GoddessSkinSellView.New()
	}
end

return GoddessSkinSellViewPresentor
