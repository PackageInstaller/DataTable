-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingofradiantgoldclg/view/KingOfRadiantGoldClgCollectViewPresentor.lua

module("logic.extensions.kingofradiantgoldclg.view.KingOfRadiantGoldClgCollectViewPresentor", package.seeall)

local KingOfRadiantGoldClgCollectViewPresentor = class("KingOfRadiantGoldClgCollectViewPresentor", ViewPresentor)

function KingOfRadiantGoldClgCollectViewPresentor:ctor()
	KingOfRadiantGoldClgCollectViewPresentor.super.ctor(self)
end

function KingOfRadiantGoldClgCollectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingOfRadiantGoldClgCollectViewPresentor:dependWhatResources()
	return {
		"ui/views/kingofradiantgoldclg/kingofradiantgoldclgcollectview.prefab"
	}
end

function KingOfRadiantGoldClgCollectViewPresentor:buildViews()
	return {
		KingOfRadiantGoldClgCollectView.New()
	}
end

return KingOfRadiantGoldClgCollectViewPresentor
