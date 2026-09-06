-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/view/ShadowdragonclgmainViewPresentor.lua

module("logic.extensions.shadowdragonclg.view.ShadowdragonclgmainViewPresentor", package.seeall)

local ShadowdragonclgmainViewPresentor = class("ShadowdragonclgmainViewPresentor", ViewPresentor)

function ShadowdragonclgmainViewPresentor:ctor()
	ShadowdragonclgmainViewPresentor.super.ctor(self)
end

function ShadowdragonclgmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShadowdragonclgmainViewPresentor:dependWhatResources()
	return {
		"ui/views/shadowdragonclg/shadowdragonclgmainview.prefab"
	}
end

function ShadowdragonclgmainViewPresentor:buildViews()
	return {
		ShadowdragonclgmainView.New()
	}
end

return ShadowdragonclgmainViewPresentor
