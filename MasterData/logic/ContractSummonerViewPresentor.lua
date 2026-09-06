-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSummonerViewPresentor.lua

module("logic.extensions.contract.view.ContractSummonerViewPresentor", package.seeall)

local ContractSummonerViewPresentor = class("ContractSummonerViewPresentor", ViewPresentor)

function ContractSummonerViewPresentor:ctor()
	ContractSummonerViewPresentor.super.ctor(self)
end

function ContractSummonerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ContractSummonerViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractsummonerview.prefab"
	}
end

function ContractSummonerViewPresentor:buildViews()
	return {
		ContractSummonerView.New()
	}
end

return ContractSummonerViewPresentor
