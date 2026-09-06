-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractListViewPresentor.lua

module("logic.extensions.contract.view.ContractListViewPresentor", package.seeall)

local ContractListViewPresentor = class("ContractListViewPresentor", ViewPresentor)

function ContractListViewPresentor:ctor()
	ContractListViewPresentor.super.ctor(self)
end

function ContractListViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ContractListViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractlistview.prefab"
	}
end

function ContractListViewPresentor:buildViews()
	return {
		ContractListView.New()
	}
end

return ContractListViewPresentor
