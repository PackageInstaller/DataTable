-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MonthcardpromotionViewPresentor.lua

module("logic.extensions.monthcard.view.MonthcardpromotionViewPresentor", package.seeall)

local MonthcardpromotionViewPresentor = class("MonthcardpromotionViewPresentor", ViewPresentor)

function MonthcardpromotionViewPresentor:ctor()
	MonthcardpromotionViewPresentor.super.ctor(self)
end

function MonthcardpromotionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MonthcardpromotionViewPresentor:dependWhatResources()
	return {
		"ui/views/monthcard/monthcardpromotionview.prefab"
	}
end

function MonthcardpromotionViewPresentor:buildViews()
	return {
		MonthcardpromotionView.New()
	}
end

return MonthcardpromotionViewPresentor
