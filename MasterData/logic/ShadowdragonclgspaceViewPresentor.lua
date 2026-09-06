-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/view/ShadowdragonclgspaceViewPresentor.lua

module("logic.extensions.shadowdragonclg.view.ShadowdragonclgspaceViewPresentor", package.seeall)

local ShadowdragonclgspaceViewPresentor = class("ShadowdragonclgspaceViewPresentor", ViewPresentor)

function ShadowdragonclgspaceViewPresentor:ctor()
	ShadowdragonclgspaceViewPresentor.super.ctor(self)
end

function ShadowdragonclgspaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShadowdragonclgspaceViewPresentor:dependWhatResources()
	return {
		"ui/views/shadowdragonclg/shadowdragonclgspaceview.prefab"
	}
end

function ShadowdragonclgspaceViewPresentor:buildViews()
	return {
		ShadowdragonclgspaceView.New()
	}
end

return ShadowdragonclgspaceViewPresentor
