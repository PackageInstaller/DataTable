-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/skill/VersionActivity1_6SkillViewContainer.lua

module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillViewContainer", package.seeall)

local VersionActivity1_6SkillViewContainer = class("VersionActivity1_6SkillViewContainer", BaseViewContainer)

function VersionActivity1_6SkillViewContainer:buildViews()
	return {
		VersionActivity1_6SkillView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function VersionActivity1_6SkillViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivity1_6SkillViewContainer:onContainerInit()
	return
end

return VersionActivity1_6SkillViewContainer
