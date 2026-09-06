-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractBookViewPresentor.lua

module("logic.extensions.contract.view.ContractBookViewPresentor", package.seeall)

local ContractBookViewPresentor = class("ContractBookViewPresentor", ViewPresentor)

function ContractBookViewPresentor:ctor()
	ContractBookViewPresentor.super.ctor(self)
end

function ContractBookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ContractBookViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractbookview.prefab"
	}
end

function ContractBookViewPresentor:buildViews()
	return {
		ContractBookView.New()
	}
end

return ContractBookViewPresentor
