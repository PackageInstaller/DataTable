-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MonthcardrecordPresentor.lua

module("logic.extensions.monthcard.view.MonthcardrecordPresentor", package.seeall)

local MonthcardrecordPresentor = class("MonthcardrecordPresentor", ViewPresentor)

function MonthcardrecordPresentor:ctor()
	MonthcardrecordPresentor.super.ctor(self)
end

function MonthcardrecordPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MonthcardrecordPresentor:dependWhatResources()
	return {
		"ui/views/monthcard/monthcardrecordview.prefab"
	}
end

function MonthcardrecordPresentor:buildViews()
	return {
		MonthcardrecordView.New()
	}
end

return MonthcardrecordPresentor
