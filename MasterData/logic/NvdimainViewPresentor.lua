-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdimainViewPresentor.lua

module("logic.extensions.nvdi.view.NvdimainViewPresentor", package.seeall)

local NvdimainViewPresentor = class("NvdimainViewPresentor", ViewPresentor)

function NvdimainViewPresentor:ctor()
	NvdimainViewPresentor.super.ctor(self)
end

function NvdimainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NvdimainViewPresentor:dependWhatResources()
	return {
		"ui/views/nvdi/nvdimainview.prefab"
	}
end

function NvdimainViewPresentor:buildViews()
	return {
		NvdimainView.New()
	}
end

return NvdimainViewPresentor
