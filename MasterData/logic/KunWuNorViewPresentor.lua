-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunwu/view/KunWuNorViewPresentor.lua

module("logic.extensions.kunwu.view.KunWuNorViewPresentor", package.seeall)

local KunWuNorViewPresentor = class("KunWuNorViewPresentor", ViewPresentor)

function KunWuNorViewPresentor:ctor()
	KunWuNorViewPresentor.super.ctor(self)
end

function KunWuNorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KunWuNorViewPresentor:dependWhatResources()
	return {
		"ui/views/kunwu/kunwunorview.prefab"
	}
end

function KunWuNorViewPresentor:buildViews()
	return {
		KunWuNorView.New()
	}
end

return KunWuNorViewPresentor
