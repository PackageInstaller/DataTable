-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandcard/view/NewhandcardrecordViewPresentor.lua

module("logic.extensions.newhandcard.view.NewhandcardrecordViewPresentor", package.seeall)

local NewhandcardrecordViewPresentor = class("NewhandcardrecordViewPresentor", ViewPresentor)

function NewhandcardrecordViewPresentor:ctor()
	NewhandcardrecordViewPresentor.super.ctor(self)
end

function NewhandcardrecordViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewhandcardrecordViewPresentor:dependWhatResources()
	return {
		"ui/views/monthcard/monthcardrecordview.prefab"
	}
end

function NewhandcardrecordViewPresentor:buildViews()
	return {
		NewhandcardrecordView.New()
	}
end

function NewhandcardrecordViewPresentor:onClickOutside()
	self:close()
end

return NewhandcardrecordViewPresentor
