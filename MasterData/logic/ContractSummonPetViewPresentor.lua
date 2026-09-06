-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSummonPetViewPresentor.lua

module("logic.extensions.contract.view.ContractSummonPetViewPresentor", package.seeall)

local ContractSummonPetViewPresentor = class("ContractSummonPetViewPresentor", ViewPresentor)

function ContractSummonPetViewPresentor:ctor()
	ContractSummonPetViewPresentor.super.ctor(self)
end

function ContractSummonPetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ContractSummonPetViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractsummonpetview.prefab"
	}
end

function ContractSummonPetViewPresentor:buildViews()
	return {
		ContractSummonPetView.New()
	}
end

return ContractSummonPetViewPresentor
