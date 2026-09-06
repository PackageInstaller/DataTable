-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractPetPopViewPresentor.lua

module("logic.extensions.contract.view.ContractPetPopViewPresentor", package.seeall)

local ContractPetPopViewPresentor = class("ContractPetPopViewPresentor", ViewPresentor)

function ContractPetPopViewPresentor:ctor()
	ContractPetPopViewPresentor.super.ctor(self)
end

function ContractPetPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ContractPetPopViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractpetpopview.prefab"
	}
end

function ContractPetPopViewPresentor:buildViews()
	return {
		ContractPetPopView.New()
	}
end

return ContractPetPopViewPresentor
