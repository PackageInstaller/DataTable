-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpAllBuffViewPresentor.lua

module("logic.extensions.expedition.view.ExpAllBuffViewPresentor", package.seeall)

local ExpAllBuffViewPresentor = class("ExpAllBuffViewPresentor", ViewPresentor)

function ExpAllBuffViewPresentor:ctor()
	ExpAllBuffViewPresentor.super.ctor(self)
end

function ExpAllBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ExpAllBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/expedition/allbuffview.prefab"
	}
end

function ExpAllBuffViewPresentor:buildViews()
	return {
		ExpAllBuffView.New()
	}
end

return ExpAllBuffViewPresentor
