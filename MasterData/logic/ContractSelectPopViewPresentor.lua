-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSelectPopViewPresentor.lua

module("logic.extensions.contract.view.ContractSelectPopViewPresentor", package.seeall)

local ContractSelectPopViewPresentor = class("ContractSelectPopViewPresentor", ViewPresentor)

function ContractSelectPopViewPresentor:ctor()
	ContractSelectPopViewPresentor.super.ctor(self)
end

function ContractSelectPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ContractSelectPopViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractselectpopview.prefab"
	}
end

function ContractSelectPopViewPresentor:buildViews()
	return {
		ContractSelectPopView.New()
	}
end

return ContractSelectPopViewPresentor
