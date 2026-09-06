-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandcard/view/NewhandcardViewPresentor.lua

module("logic.extensions.newhandcard.view.NewhandcardViewPresentor", package.seeall)

local NewhandcardViewPresentor = class("NewhandcardViewPresentor", ViewPresentor)

function NewhandcardViewPresentor:ctor()
	NewhandcardViewPresentor.super.ctor(self)
end

function NewhandcardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewhandcardViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandcard/newhandcardview.prefab"
	}
end

function NewhandcardViewPresentor:buildViews()
	return {
		NewhandcardView.New()
	}
end

function NewhandcardViewPresentor:onClickOutside()
	self:close()
end

return NewhandcardViewPresentor
