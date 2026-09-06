-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunwu/view/KunWuExtTipViewPresentor.lua

module("logic.extensions.kunwu.view.KunWuExtTipViewPresentor", package.seeall)

local KunWuExtTipViewPresentor = class("KunWuExtTipViewPresentor", ViewPresentor)

function KunWuExtTipViewPresentor:ctor()
	KunWuExtTipViewPresentor.super.ctor(self)
end

function KunWuExtTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KunWuExtTipViewPresentor:dependWhatResources()
	return {
		"ui/views/kunwu/kunwuexttipview.prefab"
	}
end

function KunWuExtTipViewPresentor:buildViews()
	return {
		KunWuExtTipView.New()
	}
end

return KunWuExtTipViewPresentor
