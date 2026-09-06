-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractskillpopViewPresentor.lua

module("logic.extensions.contract.view.ContractskillpopViewPresentor", package.seeall)

local ContractskillpopViewPresentor = class("ContractskillpopViewPresentor", ViewPresentor)

function ContractskillpopViewPresentor:ctor()
	ContractskillpopViewPresentor.super.ctor(self)
end

function ContractskillpopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ContractskillpopViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractskillpopview.prefab"
	}
end

function ContractskillpopViewPresentor:buildViews()
	return {
		ContractskillpopView.New()
	}
end

return ContractskillpopViewPresentor
