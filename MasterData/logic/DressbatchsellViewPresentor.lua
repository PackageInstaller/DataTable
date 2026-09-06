-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/DressbatchsellViewPresentor.lua

module("logic.extensions.dress.view.DressbatchsellViewPresentor", package.seeall)

local DressbatchsellViewPresentor = class("DressbatchsellViewPresentor", ViewPresentor)

function DressbatchsellViewPresentor:ctor()
	DressbatchsellViewPresentor.super.ctor(self)
end

function DressbatchsellViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function DressbatchsellViewPresentor:dependWhatResources()
	return {
		"ui/views/dress/dressbatchsellview.prefab"
	}
end

function DressbatchsellViewPresentor:buildViews()
	return {
		DressbatchsellView.New()
	}
end

return DressbatchsellViewPresentor
