-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunwu/view/KunWuMainViewPresentor.lua

module("logic.extensions.kunwu.view.KunWuMainViewPresentor", package.seeall)

local KunWuMainViewPresentor = class("KunWuMainViewPresentor", ViewPresentor)

function KunWuMainViewPresentor:ctor()
	KunWuMainViewPresentor.super.ctor(self)
end

function KunWuMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KunWuMainViewPresentor:dependWhatResources()
	return {
		"ui/views/kunwu/kunwumainview.prefab"
	}
end

function KunWuMainViewPresentor:buildViews()
	return {
		KunWuMainView.New()
	}
end

return KunWuMainViewPresentor
