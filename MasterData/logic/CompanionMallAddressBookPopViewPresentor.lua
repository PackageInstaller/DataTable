-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionMallAddressBookPopViewPresentor.lua

module("logic.extensions.companionmall.view.CompanionMallAddressBookPopViewPresentor", package.seeall)

local CompanionMallAddressBookPopViewPresentor = class("CompanionMallAddressBookPopViewPresentor", ViewPresentor)

function CompanionMallAddressBookPopViewPresentor:ctor()
	CompanionMallAddressBookPopViewPresentor.super.ctor(self)
end

function CompanionMallAddressBookPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompanionMallAddressBookPopViewPresentor:dependWhatResources()
	return {
		"ui/views/companionmall/companionmalladdressbookpopview.prefab"
	}
end

function CompanionMallAddressBookPopViewPresentor:buildViews()
	return {
		CompanionMallAddressBookPopView.New()
	}
end

return CompanionMallAddressBookPopViewPresentor
