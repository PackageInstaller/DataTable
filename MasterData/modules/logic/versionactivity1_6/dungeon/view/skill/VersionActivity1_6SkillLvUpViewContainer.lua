-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/skill/VersionActivity1_6SkillLvUpViewContainer.lua

module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillLvUpViewContainer", package.seeall)

local VersionActivity1_6SkillLvUpViewContainer = class("VersionActivity1_6SkillLvUpViewContainer", BaseViewContainer)

function VersionActivity1_6SkillLvUpViewContainer:buildViews()
	return {
		VersionActivity1_6SkillLvUpView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function VersionActivity1_6SkillLvUpViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		self.navigateView
	}
end

function VersionActivity1_6SkillLvUpViewContainer:onContainerInit()
	return
end

return VersionActivity1_6SkillLvUpViewContainer
