-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neverland/view/NeverLandTaskCellViewPresentor.lua

module("logic.extensions.neverland.view.NeverLandTaskCellViewPresentor", package.seeall)

local NeverLandTaskCellViewPresentor = class("NeverLandTaskCellViewPresentor", ViewPresentor)

function NeverLandTaskCellViewPresentor:ctor()
	NeverLandTaskCellViewPresentor.super.ctor(self)
end

function NeverLandTaskCellViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NeverLandTaskCellViewPresentor:dependWhatResources()
	return {
		"ui/views/neverland/neverlandtaskcellview.prefab"
	}
end

function NeverLandTaskCellViewPresentor:buildViews()
	return {
		NeverLandTaskCellView.New()
	}
end

return NeverLandTaskCellViewPresentor
