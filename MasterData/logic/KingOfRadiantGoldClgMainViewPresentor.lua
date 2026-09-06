-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingofradiantgoldclg/view/KingOfRadiantGoldClgMainViewPresentor.lua

module("logic.extensions.kingofradiantgoldclg.view.KingOfRadiantGoldClgMainViewPresentor", package.seeall)

local KingOfRadiantGoldClgMainViewPresentor = class("KingOfRadiantGoldClgMainViewPresentor", ViewPresentor)

function KingOfRadiantGoldClgMainViewPresentor:ctor()
	KingOfRadiantGoldClgMainViewPresentor.super.ctor(self)
end

function KingOfRadiantGoldClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingOfRadiantGoldClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/kingofradiantgoldclg/kingofradiantgoldclgmainview.prefab"
	}
end

function KingOfRadiantGoldClgMainViewPresentor:buildViews()
	return {
		KingOfRadiantGoldClgMainView.New()
	}
end

return KingOfRadiantGoldClgMainViewPresentor
