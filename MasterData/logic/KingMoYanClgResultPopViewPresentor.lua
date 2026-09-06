-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmoyanclg/view/KingMoYanClgResultPopViewPresentor.lua

module("logic.extensions.ashlesslongyan.view.KingMoYanClgResultPopViewPresentor", package.seeall)

local KingMoYanClgResultPopViewPresentor = class("KingMoYanClgResultPopViewPresentor", ViewPresentor)

function KingMoYanClgResultPopViewPresentor:ctor()
	KingMoYanClgResultPopViewPresentor.super.ctor(self)
end

function KingMoYanClgResultPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function KingMoYanClgResultPopViewPresentor:dependWhatResources()
	return {
		"ui/views/kingmoyanclg/kingmoyanclgresultpopview.prefab"
	}
end

function KingMoYanClgResultPopViewPresentor:buildViews()
	return {
		KingMoYanClgResultPopView.New()
	}
end

return KingMoYanClgResultPopViewPresentor
