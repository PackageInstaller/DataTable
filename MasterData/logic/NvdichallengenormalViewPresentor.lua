-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdichallengenormalViewPresentor.lua

module("logic.extensions.nvdi.view.NvdichallengenormalViewPresentor", package.seeall)

local NvdichallengenormalViewPresentor = class("NvdichallengenormalViewPresentor", ViewPresentor)

function NvdichallengenormalViewPresentor:ctor()
	NvdichallengenormalViewPresentor.super.ctor(self)
end

function NvdichallengenormalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NvdichallengenormalViewPresentor:dependWhatResources()
	return {
		"ui/views/nvdi/nvdichallengenormalview.prefab"
	}
end

function NvdichallengenormalViewPresentor:buildViews()
	return {
		NvdichallengenormalView.New()
	}
end

return NvdichallengenormalViewPresentor
