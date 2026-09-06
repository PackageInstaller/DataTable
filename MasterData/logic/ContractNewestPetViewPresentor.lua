-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractNewestPetViewPresentor.lua

module("logic.extensions.contract.view.ContractNewestPetViewPresentor", package.seeall)

local ContractNewestPetViewPresentor = class("ContractNewestPetViewPresentor", ViewPresentor)

function ContractNewestPetViewPresentor:ctor()
	ContractNewestPetViewPresentor.super.ctor(self)
end

function ContractNewestPetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ContractNewestPetViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractnewestpetview.prefab"
	}
end

function ContractNewestPetViewPresentor:buildViews()
	return {
		ContractNewestPetView.New()
	}
end

return ContractNewestPetViewPresentor
