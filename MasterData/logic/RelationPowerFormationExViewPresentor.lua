-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/relationpower/view/RelationPowerFormationExViewPresentor.lua

module("logic.extensions.relationpower.view.RelationPowerFormationExViewPresentor", package.seeall)

local RelationPowerFormationExViewPresentor = class("RelationPowerFormationExViewPresentor", ViewPresentor)

function RelationPowerFormationExViewPresentor:ctor()
	RelationPowerFormationExViewPresentor.super.ctor(self)
end

function RelationPowerFormationExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RelationPowerFormationExViewPresentor:dependWhatResources()
	return {
		"ui/views/relationpower/relationpowerformationexview.prefab"
	}
end

function RelationPowerFormationExViewPresentor:buildViews()
	return {
		RelationPowerFormationExView.New()
	}
end

function RelationPowerFormationExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return RelationPowerFormationExViewPresentor
