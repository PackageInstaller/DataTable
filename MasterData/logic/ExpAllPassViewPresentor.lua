-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpAllPassViewPresentor.lua

module("logic.extensions.expedition.view.ExpAllPassViewPresentor", package.seeall)

local ExpAllPassViewPresentor = class("ExpAllPassViewPresentor", ViewPresentor)

function ExpAllPassViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ExpAllPassViewPresentor:dependWhatResources()
	return {
		"ui/views/expedition/expallpassview.prefab"
	}
end

function ExpAllPassViewPresentor:buildViews()
	return {
		ExpAllPassView.New()
	}
end

function ExpAllPassViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExpAllPassViewPresentor
