-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingofradiantgoldclg/view/KingOfRadiantGoldClgBuffViewPresentor.lua

module("logic.extensions.kingofradiantgoldclg.view.KingOfRadiantGoldClgBuffViewPresentor", package.seeall)

local KingOfRadiantGoldClgBuffViewPresentor = class("KingOfRadiantGoldClgBuffViewPresentor", ViewPresentor)

function KingOfRadiantGoldClgBuffViewPresentor:ctor()
	KingOfRadiantGoldClgBuffViewPresentor.super.ctor(self)
end

function KingOfRadiantGoldClgBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingOfRadiantGoldClgBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/kingofradiantgoldclg/kingofradiantgoldclgbuffview.prefab"
	}
end

function KingOfRadiantGoldClgBuffViewPresentor:buildViews()
	return {
		KingOfRadiantGoldClgBuffView.New()
	}
end

return KingOfRadiantGoldClgBuffViewPresentor
