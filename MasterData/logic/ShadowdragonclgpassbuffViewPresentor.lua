-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/view/ShadowdragonclgpassbuffViewPresentor.lua

module("logic.extensions.shadowdragonclg.view.ShadowdragonclgpassbuffViewPresentor", package.seeall)

local ShadowdragonclgpassbuffViewPresentor = class("ShadowdragonclgpassbuffViewPresentor", ViewPresentor)

function ShadowdragonclgpassbuffViewPresentor:ctor()
	ShadowdragonclgpassbuffViewPresentor.super.ctor(self)
end

function ShadowdragonclgpassbuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShadowdragonclgpassbuffViewPresentor:dependWhatResources()
	return {
		"ui/views/shadowdragonclg/shadowdragonclgpassbuffview.prefab"
	}
end

function ShadowdragonclgpassbuffViewPresentor:buildViews()
	return {
		ShadowdragonclgpassbuffView.New()
	}
end

function ShadowdragonclgpassbuffViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(ViewName.ShadowdragonclgpassbuffView)
end

return ShadowdragonclgpassbuffViewPresentor
