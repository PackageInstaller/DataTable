-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/directpurchase/view/PetPurchaseViewPresentor.lua

module("logic.extensions.directpurchase.view.PetPurchaseViewPresentor", package.seeall)

local PetPurchaseViewPresentor = class("PetPurchaseViewPresentor", ViewPresentor)

function PetPurchaseViewPresentor:ctor()
	PetPurchaseViewPresentor.super.ctor(self)
end

function PetPurchaseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetPurchaseViewPresentor:dependWhatResources()
	return {
		"ui/views/longnvpurchase/petpurchaseview.prefab"
	}
end

function PetPurchaseViewPresentor:buildViews()
	return {
		PetPurchaseView.New()
	}
end

return PetPurchaseViewPresentor
