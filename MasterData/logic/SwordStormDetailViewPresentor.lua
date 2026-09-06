-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/swordstorm/view/SwordStormDetailViewPresentor.lua

module("logic.extensions.swordstorm.view.SwordStormDetailViewPresentor", package.seeall)

local SwordStormDetailViewPresentor = class("SwordStormDetailViewPresentor", ViewPresentor)

function SwordStormDetailViewPresentor:ctor()
	SwordStormDetailViewPresentor.super.ctor(self)
end

function SwordStormDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SwordStormDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/swordstorm/swordstormdetailview.prefab"
	}
end

function SwordStormDetailViewPresentor:buildViews()
	return {
		SwordStormDetailView.New()
	}
end

return SwordStormDetailViewPresentor
