-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/MasterFormSystemViewPresentor.lua

module("logic.extensions.masterform.view.MasterFormSystemViewPresentor", package.seeall)

local MasterFormSystemViewPresentor = class("MasterFormSystemViewPresentor", ViewPresentor)

function MasterFormSystemViewPresentor:ctor()
	MasterFormSystemViewPresentor.super.ctor(self)
end

function MasterFormSystemViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MasterFormSystemViewPresentor:dependWhatResources()
	return {
		"ui/views/masterform/masterformsystemview.prefab"
	}
end

function MasterFormSystemViewPresentor:buildViews()
	return {
		MasterFormSystemView.New()
	}
end

function MasterFormSystemViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MasterFormSystemViewPresentor
