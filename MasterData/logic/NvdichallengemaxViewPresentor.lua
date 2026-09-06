-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdichallengemaxViewPresentor.lua

module("logic.extensions.nvdi.view.NvdichallengemaxViewPresentor", package.seeall)

local NvdichallengemaxViewPresentor = class("NvdichallengemaxViewPresentor", ViewPresentor)

function NvdichallengemaxViewPresentor:ctor()
	NvdichallengemaxViewPresentor.super.ctor(self)
end

function NvdichallengemaxViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NvdichallengemaxViewPresentor:dependWhatResources()
	return {
		"ui/views/nvdi/nvdichallengemaxview.prefab"
	}
end

function NvdichallengemaxViewPresentor:buildViews()
	return {
		NvdichallengemaxView.New()
	}
end

return NvdichallengemaxViewPresentor
