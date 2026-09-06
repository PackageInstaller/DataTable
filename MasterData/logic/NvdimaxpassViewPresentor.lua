-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdimaxpassViewPresentor.lua

module("logic.extensions.nvdi.view.NvdimaxpassViewPresentor", package.seeall)

local NvdimaxpassViewPresentor = class("NvdimaxpassViewPresentor", ViewPresentor)

function NvdimaxpassViewPresentor:ctor()
	NvdimaxpassViewPresentor.super.ctor(self)
end

function NvdimaxpassViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NvdimaxpassViewPresentor:dependWhatResources()
	return {
		"ui/views/nvdi/nvdimaxpassview.prefab"
	}
end

function NvdimaxpassViewPresentor:buildViews()
	return {
		NvdimaxpassView.New()
	}
end

return NvdimaxpassViewPresentor
