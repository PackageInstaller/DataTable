-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractSkillResetViewPresentor.lua

module("logic.extensions.contract.view.ContractSkillResetViewPresentor", package.seeall)

local ContractSkillResetViewPresentor = class("ContractSkillResetViewPresentor", ViewPresentor)

function ContractSkillResetViewPresentor:ctor()
	ContractSkillResetViewPresentor.super.ctor(self)
end

function ContractSkillResetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ContractSkillResetViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractskillresetview.prefab"
	}
end

function ContractSkillResetViewPresentor:buildViews()
	return {
		ContractSkillResetView.New()
	}
end

return ContractSkillResetViewPresentor
