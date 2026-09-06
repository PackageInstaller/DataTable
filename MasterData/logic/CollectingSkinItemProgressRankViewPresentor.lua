-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/view/CollectingSkinItemProgressRankViewPresentor.lua

module("logic.extensions.collectingskin.view.CollectingSkinItemProgressRankViewPresentor", package.seeall)

local CollectingSkinItemProgressRankViewPresentor = class("CollectingSkinItemProgressRankViewPresentor", ViewPresentor)

function CollectingSkinItemProgressRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectingSkinItemProgressRankViewPresentor:dependWhatResources()
	return {
		"ui/views/collectingskin/collectingskinitemprogressrankview.prefab"
	}
end

function CollectingSkinItemProgressRankViewPresentor:buildViews()
	return {
		CollectingSkinItemProgressRankView.New()
	}
end

return CollectingSkinItemProgressRankViewPresentor
