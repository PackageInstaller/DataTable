-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetShowInfoPersentorNew.lua

module("logic.extensions.bag.view.stack.PetShowInfoPersentorNew", package.seeall)

local PetShowInfoPersentorNew = class("PetShowInfoPersentorNew", ViewWithGuidePresentor)

function PetShowInfoPersentorNew:ctor()
	PetShowInfoPersentorNew.super.ctor(self)
end

function PetShowInfoPersentorNew:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetShowInfoPersentorNew:dependWhatResources()
	return {
		"ui/views/bag/petshowinfo.prefab"
	}
end

function PetShowInfoPersentorNew:buildViews()
	return {
		PetShowInfoStackNew.New()
	}
end

function PetShowInfoPersentorNew:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PetShowInfoPersentorNew
