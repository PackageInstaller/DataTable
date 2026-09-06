-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdiextViewPresentor.lua

module("logic.extensions.nvdi.view.NvdiextViewPresentor", package.seeall)

local NvdiextViewPresentor = class("NvdiextViewPresentor", ViewPresentor)

function NvdiextViewPresentor:ctor()
	NvdiextViewPresentor.super.ctor(self)
end

function NvdiextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NvdiextViewPresentor:dependWhatResources()
	return {
		"ui/views/nvdi/nvdiextview.prefab"
	}
end

function NvdiextViewPresentor:buildViews()
	return {
		NvdiextView.New()
	}
end

return NvdiextViewPresentor
