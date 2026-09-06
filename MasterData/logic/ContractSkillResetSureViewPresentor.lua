-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSkillResetSureViewPresentor.lua

module("logic.extensions.contract.view.ContractSkillResetSureViewPresentor", package.seeall)

local ContractSkillResetSureViewPresentor = class("ContractSkillResetSureViewPresentor", ViewPresentor)

function ContractSkillResetSureViewPresentor:ctor()
	ContractSkillResetSureViewPresentor.super.ctor(self)
end

function ContractSkillResetSureViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ContractSkillResetSureViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractskillresetsureview.prefab"
	}
end

function ContractSkillResetSureViewPresentor:buildViews()
	return {
		ContractSkillResetSureView.New()
	}
end

return ContractSkillResetSureViewPresentor
