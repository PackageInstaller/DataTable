-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/villaintrial/view/VillaintrialInstructionViewPresentor.lua

module("logic.extensions.villaintrial.view.VillaintrialInstructionViewPresentor", package.seeall)

local VillaintrialInstructionViewPresentor = class("VillaintrialInstructionViewPresentor", ViewPresentor)

function VillaintrialInstructionViewPresentor:ctor()
	VillaintrialInstructionViewPresentor.super.ctor(self)
end

function VillaintrialInstructionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VillaintrialInstructionViewPresentor:dependWhatResources()
	return {
		"ui/views/villaintrial/villaintrialinstructionview.prefab"
	}
end

function VillaintrialInstructionViewPresentor:buildViews()
	return {
		VillaintrialInstructionView.New()
	}
end

return VillaintrialInstructionViewPresentor
