-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/view/KingciyuanchallengebuffpopupViewPresentor.lua

module("logic.extensions.kingciyuanchallenge.view.KingciyuanchallengebuffpopupViewPresentor", package.seeall)

local KingciyuanchallengebuffpopupViewPresentor = class("KingciyuanchallengebuffpopupViewPresentor", ViewPresentor)

function KingciyuanchallengebuffpopupViewPresentor:ctor()
	KingciyuanchallengebuffpopupViewPresentor.super.ctor(self)
end

function KingciyuanchallengebuffpopupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function KingciyuanchallengebuffpopupViewPresentor:dependWhatResources()
	return {
		"ui/views/kingciyuanchallenge/kingciyuanchallengebuffpopupview.prefab"
	}
end

function KingciyuanchallengebuffpopupViewPresentor:buildViews()
	return {
		KingciyuanchallengebuffpopupView.New()
	}
end

return KingciyuanchallengebuffpopupViewPresentor
