-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/view/ShadowdragonclglockViewPresentor.lua

module("logic.extensions.shadowdragonclg.view.ShadowdragonclglockViewPresentor", package.seeall)

local ShadowdragonclglockViewPresentor = class("ShadowdragonclglockViewPresentor", ViewPresentor)

function ShadowdragonclglockViewPresentor:ctor()
	ShadowdragonclglockViewPresentor.super.ctor(self)
end

function ShadowdragonclglockViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShadowdragonclglockViewPresentor:dependWhatResources()
	return {
		"ui/views/shadowdragonclg/shadowdragonclglockview.prefab"
	}
end

function ShadowdragonclglockViewPresentor:buildViews()
	return {
		ShadowdragonclglockView.New()
	}
end

return ShadowdragonclglockViewPresentor
