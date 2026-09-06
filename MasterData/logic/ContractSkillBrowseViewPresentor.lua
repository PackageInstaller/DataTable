-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSkillBrowseViewPresentor.lua

module("logic.extensions.contract.view.ContractSkillBrowseViewPresentor", package.seeall)

local ContractSkillBrowseViewPresentor = class("ContractSkillBrowseViewPresentor", ViewPresentor)

function ContractSkillBrowseViewPresentor:ctor()
	ContractSkillBrowseViewPresentor.super.ctor(self)
end

function ContractSkillBrowseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ContractSkillBrowseViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractskillbrowseview.prefab"
	}
end

function ContractSkillBrowseViewPresentor:buildViews()
	return {
		ContractSkillBrowseView.New()
	}
end

return ContractSkillBrowseViewPresentor
