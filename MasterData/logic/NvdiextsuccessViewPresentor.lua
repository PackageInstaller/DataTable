-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdiextsuccessViewPresentor.lua

module("logic.extensions.nvdi.view.NvdiextsuccessViewPresentor", package.seeall)

local NvdiextsuccessViewPresentor = class("NvdiextsuccessViewPresentor", ViewPresentor)

function NvdiextsuccessViewPresentor:ctor()
	NvdiextsuccessViewPresentor.super.ctor(self)
end

function NvdiextsuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NvdiextsuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/nvdi/nvdiextsuccessview.prefab"
	}
end

function NvdiextsuccessViewPresentor:buildViews()
	return {
		NvdiextsuccessView.New()
	}
end

return NvdiextsuccessViewPresentor
