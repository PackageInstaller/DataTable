-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/view/ShadowdragonclgextViewPresentor.lua

module("logic.extensions.shadowdragonclg.view.ShadowdragonclgextViewPresentor", package.seeall)

local ShadowdragonclgextViewPresentor = class("ShadowdragonclgextViewPresentor", ViewPresentor)

function ShadowdragonclgextViewPresentor:ctor()
	ShadowdragonclgextViewPresentor.super.ctor(self)
end

function ShadowdragonclgextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShadowdragonclgextViewPresentor:dependWhatResources()
	return {
		"ui/views/shadowdragonclg/shadowdragonclgextview.prefab"
	}
end

function ShadowdragonclgextViewPresentor:buildViews()
	return {
		ShadowdragonclgextView.New()
	}
end

return ShadowdragonclgextViewPresentor
