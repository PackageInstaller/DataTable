-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdiNorDetailViewPresentor.lua

module("logic.extensions.nvdi.view.NvdiNorDetailViewPresentor", package.seeall)

local NvdiNorDetailViewPresentor = class("NvdiNorDetailViewPresentor", ViewPresentor)

function NvdiNorDetailViewPresentor:ctor()
	NvdiNorDetailViewPresentor.super.ctor(self)
end

function NvdiNorDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NvdiNorDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/farnas/farnasnordetailview.prefab"
	}
end

function NvdiNorDetailViewPresentor:buildViews()
	return {
		NvdiNorDetailView.New()
	}
end

return NvdiNorDetailViewPresentor
