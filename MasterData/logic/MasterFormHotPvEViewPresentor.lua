-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/MasterFormHotPvEViewPresentor.lua

module("logic.extensions.masterform.view.MasterFormHotPvEViewPresentor", package.seeall)

local MasterFormHotPvEViewPresentor = class("MasterFormHotPvEViewPresentor", ViewPresentor)

function MasterFormHotPvEViewPresentor:ctor()
	MasterFormHotPvEViewPresentor.super.ctor(self)
end

function MasterFormHotPvEViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MasterFormHotPvEViewPresentor:dependWhatResources()
	return {
		"ui/views/masterform/masterformhotpveview.prefab"
	}
end

function MasterFormHotPvEViewPresentor:buildViews()
	return {
		MasterFormHotPvEView.New()
	}
end

function MasterFormHotPvEViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MasterFormHotPvEViewPresentor
