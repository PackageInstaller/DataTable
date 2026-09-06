-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/father/CommonTabRankFatherListViewPresentor.lua

module("logic.extensions.commontabrank.view.father.CommonTabRankFatherListViewPresentor", package.seeall)

local CommonTabRankFatherListViewPresentor = class("CommonTabRankFatherListViewPresentor", ViewPresentor)

function CommonTabRankFatherListViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CommonTabRankFatherListViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/commontabrankfatherlistview.prefab"
	}
end

function CommonTabRankFatherListViewPresentor:buildViews()
	return {
		CommonTabRankFatherListView.New()
	}
end

return CommonTabRankFatherListViewPresentor
