-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/SimpletxttipsViewPresentor.lua

module("logic.extensions.common.instruction.view.SimpletxttipsViewPresentor", package.seeall)

local SimpletxttipsViewPresentor = class("SimpletxttipsViewPresentor", ViewPresentor)

function SimpletxttipsViewPresentor:ctor()
	SimpletxttipsViewPresentor.super.ctor(self)
end

function SimpletxttipsViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function SimpletxttipsViewPresentor:dependWhatResources()
	return {
		"ui/views/common/simpletxttips.prefab"
	}
end

function SimpletxttipsViewPresentor:buildViews()
	return {
		SimpletxttipsView.New()
	}
end

return SimpletxttipsViewPresentor
