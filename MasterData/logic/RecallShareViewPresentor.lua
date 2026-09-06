-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/view/RecallShareViewPresentor.lua

module("logic.extensions.recalltask.view.RecallShareViewPresentor", package.seeall)

local RecallShareViewPresentor = class("RecallShareViewPresentor", ViewPresentor)

function RecallShareViewPresentor:ctor()
	RecallShareViewPresentor.super.ctor(self)
end

function RecallShareViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RecallShareViewPresentor:dependWhatResources()
	return {
		"ui/views/recalltask/recallshareview.prefab"
	}
end

function RecallShareViewPresentor:buildViews()
	return {
		RecallShareView.New()
	}
end

return RecallShareViewPresentor
