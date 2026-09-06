-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/view/ShadowdragonclgbuffViewPresentor.lua

module("logic.extensions.shadowdragonclg.view.ShadowdragonclgbuffViewPresentor", package.seeall)

local ShadowdragonclgbuffViewPresentor = class("ShadowdragonclgbuffViewPresentor", ViewPresentor)

function ShadowdragonclgbuffViewPresentor:ctor()
	ShadowdragonclgbuffViewPresentor.super.ctor(self)
end

function ShadowdragonclgbuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShadowdragonclgbuffViewPresentor:dependWhatResources()
	return {
		"ui/views/shadowdragonclg/shadowdragonclgbuffview.prefab"
	}
end

function ShadowdragonclgbuffViewPresentor:buildViews()
	return {
		ShadowdragonclgbuffView.New()
	}
end

return ShadowdragonclgbuffViewPresentor
