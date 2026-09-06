-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/MasterFormFmtSubmitViewPresentor.lua

module("logic.extensions.masterform.view.MasterFormFmtSubmitViewPresentor", package.seeall)

local MasterFormFmtSubmitViewPresentor = class("MasterFormFmtSubmitViewPresentor", ViewPresentor)

function MasterFormFmtSubmitViewPresentor:ctor()
	MasterFormFmtSubmitViewPresentor.super.ctor(self)
end

function MasterFormFmtSubmitViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MasterFormFmtSubmitViewPresentor:dependWhatResources()
	return {
		"ui/views/masterform/masterformfmtsubmitview.prefab"
	}
end

function MasterFormFmtSubmitViewPresentor:buildViews()
	return {
		MasterFormFmtSubmitView.New()
	}
end

function MasterFormFmtSubmitViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MasterFormFmtSubmitViewPresentor
