-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSuccessViewPresentor.lua

module("logic.extensions.contract.view.ContractSuccessViewPresentor", package.seeall)

local ContractSuccessViewPresentor = class("ContractSuccessViewPresentor", ViewPresentor)

function ContractSuccessViewPresentor:ctor()
	ContractSuccessViewPresentor.super.ctor(self)
end

function ContractSuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ContractSuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractsuccessview.prefab"
	}
end

function ContractSuccessViewPresentor:buildViews()
	return {
		ContractSuccessView.New()
	}
end

return ContractSuccessViewPresentor
