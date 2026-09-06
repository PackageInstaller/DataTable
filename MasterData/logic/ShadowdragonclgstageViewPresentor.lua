-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/view/ShadowdragonclgstageViewPresentor.lua

module("logic.extensions.shadowdragonclg.view.ShadowdragonclgstageViewPresentor", package.seeall)

local ShadowdragonclgstageViewPresentor = class("ShadowdragonclgstageViewPresentor", ViewPresentor)

function ShadowdragonclgstageViewPresentor:ctor()
	ShadowdragonclgstageViewPresentor.super.ctor(self)
end

function ShadowdragonclgstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShadowdragonclgstageViewPresentor:dependWhatResources()
	return {
		"ui/views/shadowdragonclg/shadowdragonclgstageview.prefab"
	}
end

function ShadowdragonclgstageViewPresentor:buildViews()
	return {
		ShadowdragonclgstageView.New()
	}
end

return ShadowdragonclgstageViewPresentor
