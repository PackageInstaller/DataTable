-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/collection/SKTCollectTaskRankViewPresentor.lua

module("logic.extensions.saintknighttask.view.collection.SKTCollectTaskRankViewPresentor", package.seeall)

local SKTCollectTaskRankViewPresentor = class("SKTCollectTaskRankViewPresentor", ViewPresentor)

function SKTCollectTaskRankViewPresentor:ctor()
	SKTCollectTaskRankViewPresentor.super.ctor(self)
end

function SKTCollectTaskRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SKTCollectTaskRankViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknighttask/sktcollecttaskrankview.prefab"
	}
end

function SKTCollectTaskRankViewPresentor:buildViews()
	return {
		SKTCollectTaskRankView.New()
	}
end

return SKTCollectTaskRankViewPresentor
