-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaDetailViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaDetailViewPresentor", package.seeall)

local MiyaDetailViewPresentor = class("MiyaDetailViewPresentor", ViewPresentor)

function MiyaDetailViewPresentor:ctor()
	MiyaDetailViewPresentor.super.ctor(self)
end

function MiyaDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiyaDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miyadetailview.prefab"
	}
end

function MiyaDetailViewPresentor:buildViews()
	return {
		MiyaDetailView.New()
	}
end

return MiyaDetailViewPresentor
