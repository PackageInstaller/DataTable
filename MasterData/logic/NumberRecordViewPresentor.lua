-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberRecordViewPresentor.lua

module("logic.extensions.numberbomb.view.NumberRecordViewPresentor", package.seeall)

local NumberRecordViewPresentor = class("NumberRecordViewPresentor", ViewWithGuidePresentor)

function NumberRecordViewPresentor:ctor()
	NumberRecordViewPresentor.super.ctor(self)
end

function NumberRecordViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NumberRecordViewPresentor:dependWhatResources()
	return {
		"ui/views/numberbomb/numberrecordview.prefab"
	}
end

function NumberRecordViewPresentor:buildViews()
	return {
		NumberRecordView.New()
	}
end

return NumberRecordViewPresentor
