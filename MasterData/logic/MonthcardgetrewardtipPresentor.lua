-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MonthcardgetrewardtipPresentor.lua

module("logic.extensions.monthcard.view.MonthcardgetrewardtipPresentor", package.seeall)

local MonthcardgetrewardtipPresentor = class("MonthcardgetrewardtipPresentor", ViewPresentor)

function MonthcardgetrewardtipPresentor:ctor()
	MonthcardgetrewardtipPresentor.super.ctor(self)
end

function MonthcardgetrewardtipPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MonthcardgetrewardtipPresentor:dependWhatResources()
	return {
		"ui/views/monthcard/monthcardgetrewardtip.prefab"
	}
end

function MonthcardgetrewardtipPresentor:buildViews()
	return {
		MonthcardgetrewardtipView.New()
	}
end

function MonthcardgetrewardtipPresentor:onClickOutside()
	self:close()
end

return MonthcardgetrewardtipPresentor
