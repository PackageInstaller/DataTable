-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/GenetipPresentor.lua

module("logic.extensions.zoo.view.GenetipPresentor", package.seeall)

local GenetipPresentor = class("GenetipPresentor", ViewPresentor)

function GenetipPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function GenetipPresentor:dependWhatResources()
	return {
		"ui/views/zoo/genetipview.prefab"
	}
end

function GenetipPresentor:buildViews()
	return {
		GeneTipView.New()
	}
end

return GenetipPresentor
