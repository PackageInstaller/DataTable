-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/view/RecallCodeViewPresentor.lua

module("logic.extensions.recalltask.view.RecallCodeViewPresentor", package.seeall)

local RecallCodeViewPresentor = class("RecallCodeViewPresentor", ViewPresentor)

function RecallCodeViewPresentor:ctor()
	RecallCodeViewPresentor.super.ctor(self)
end

function RecallCodeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RecallCodeViewPresentor:dependWhatResources()
	return {
		"ui/views/exchangecode/recallcodeview.prefab"
	}
end

function RecallCodeViewPresentor:buildViews()
	return {
		RecallCodeView.New()
	}
end

return RecallCodeViewPresentor
