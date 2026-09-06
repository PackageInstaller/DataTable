-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingofradiantgoldclg/view/KingOfRadiantGoldClgResultViewPresentor.lua

module("logic.extensions.kingofradiantgoldclg.view.KingOfRadiantGoldClgResultViewPresentor", package.seeall)

local KingOfRadiantGoldClgResultViewPresentor = class("KingOfRadiantGoldClgResultViewPresentor", ViewPresentor)

function KingOfRadiantGoldClgResultViewPresentor:ctor()
	KingOfRadiantGoldClgResultViewPresentor.super.ctor(self)
end

function KingOfRadiantGoldClgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingOfRadiantGoldClgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/kingofradiantgoldclg/kingofradiantgoldclgresultview.prefab"
	}
end

function KingOfRadiantGoldClgResultViewPresentor:buildViews()
	return {
		KingOfRadiantGoldClgResultView.New()
	}
end

return KingOfRadiantGoldClgResultViewPresentor
