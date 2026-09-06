-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hdsummerlotteryrecommend/view/MultiplegiftpacksViewPresentor.lua

module("logic.extensions.hdsummerlotteryrecommend.view.MultiplegiftpacksViewPresentor", package.seeall)

local MultiplegiftpacksViewPresentor = class("MultiplegiftpacksViewPresentor", ViewPresentor)

function MultiplegiftpacksViewPresentor:ctor()
	MultiplegiftpacksViewPresentor.super.ctor(self)
end

function MultiplegiftpacksViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MultiplegiftpacksViewPresentor:dependWhatResources()
	return {
		"ui/views/hdsummerlotteryrecommend/multiplegiftpacksview.prefab"
	}
end

function MultiplegiftpacksViewPresentor:buildViews()
	return {
		MultiplegiftpacksView.New()
	}
end

return MultiplegiftpacksViewPresentor
