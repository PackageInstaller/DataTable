-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdibuffViewPresentor.lua

module("logic.extensions.nvdi.view.NvdibuffViewPresentor", package.seeall)

local NvdibuffViewPresentor = class("NvdibuffViewPresentor", ViewPresentor)

function NvdibuffViewPresentor:ctor()
	NvdibuffViewPresentor.super.ctor(self)
end

function NvdibuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NvdibuffViewPresentor:dependWhatResources()
	return {
		"ui/views/nvdi/nvdibuffview.prefab"
	}
end

function NvdibuffViewPresentor:buildViews()
	return {
		NvdibuffView.New()
	}
end

return NvdibuffViewPresentor
