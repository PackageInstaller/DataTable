-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandcard/view/NewhandcardgetViewPresentor.lua

module("logic.extensions.newhandcard.view.NewhandcardgetViewPresentor", package.seeall)

local NewhandcardgetViewPresentor = class("NewhandcardgetViewPresentor", ViewPresentor)

function NewhandcardgetViewPresentor:ctor()
	NewhandcardgetViewPresentor.super.ctor(self)
end

function NewhandcardgetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewhandcardgetViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandcard/newhandcardgetview.prefab"
	}
end

function NewhandcardgetViewPresentor:buildViews()
	return {
		NewhandcardgetView.New()
	}
end

function NewhandcardgetViewPresentor:onClickOutside()
	self:close()
end

return NewhandcardgetViewPresentor
