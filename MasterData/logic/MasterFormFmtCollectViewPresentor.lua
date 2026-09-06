-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/MasterFormFmtCollectViewPresentor.lua

module("logic.extensions.masterform.view.MasterFormFmtCollectViewPresentor", package.seeall)

local MasterFormFmtCollectViewPresentor = class("MasterFormFmtCollectViewPresentor", ViewPresentor)

function MasterFormFmtCollectViewPresentor:ctor()
	MasterFormFmtCollectViewPresentor.super.ctor(self)
end

function MasterFormFmtCollectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MasterFormFmtCollectViewPresentor:dependWhatResources()
	return {
		"ui/views/masterform/masterformfmtcollectview.prefab"
	}
end

function MasterFormFmtCollectViewPresentor:buildViews()
	return {
		MasterFormFmtCollectView.New()
	}
end

return MasterFormFmtCollectViewPresentor
