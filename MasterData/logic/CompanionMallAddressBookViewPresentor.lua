-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionMallAddressBookViewPresentor.lua

module("logic.extensions.companionmall.view.CompanionMallAddressBookViewPresentor", package.seeall)

local CompanionMallAddressBookViewPresentor = class("CompanionMallAddressBookViewPresentor", ViewPresentor)

function CompanionMallAddressBookViewPresentor:ctor()
	CompanionMallAddressBookViewPresentor.super.ctor(self)
end

function CompanionMallAddressBookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompanionMallAddressBookViewPresentor:dependWhatResources()
	return {
		"ui/views/companionmall/companionmalladdressbookview.prefab"
	}
end

function CompanionMallAddressBookViewPresentor:buildViews()
	return {
		CompanionMallAddressBookView.New()
	}
end

return CompanionMallAddressBookViewPresentor
