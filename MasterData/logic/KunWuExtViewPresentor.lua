-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunwu/view/KunWuExtViewPresentor.lua

module("logic.extensions.kunwu.view.KunWuExtViewPresentor", package.seeall)

local KunWuExtViewPresentor = class("KunWuExtViewPresentor", ViewPresentor)

function KunWuExtViewPresentor:ctor()
	KunWuExtViewPresentor.super.ctor(self)
end

function KunWuExtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KunWuExtViewPresentor:dependWhatResources()
	return {
		"ui/views/kunwu/kunwuextview.prefab"
	}
end

function KunWuExtViewPresentor:buildViews()
	return {
		KunWuExtView.New()
	}
end

return KunWuExtViewPresentor
