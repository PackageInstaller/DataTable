-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetRenameViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetRenameViewPresentor", package.seeall)

local CutePetRenameViewPresentor = class("CutePetRenameViewPresentor", ViewPresentor)

function CutePetRenameViewPresentor:ctor()
	CutePetRenameViewPresentor.super.ctor(self)
end

function CutePetRenameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CutePetRenameViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetrenameview.prefab"
	}
end

function CutePetRenameViewPresentor:buildViews()
	return {
		CutePetRenameView.New()
	}
end

return CutePetRenameViewPresentor
