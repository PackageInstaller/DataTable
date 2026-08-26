-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/building/V1a5BuildingSkillViewContainer.lua

module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingSkillViewContainer", package.seeall)

local V1a5BuildingSkillViewContainer = class("V1a5BuildingSkillViewContainer", BaseViewContainer)

function V1a5BuildingSkillViewContainer:buildViews()
	return {
		V1a5BuildingSkillView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function V1a5BuildingSkillViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return V1a5BuildingSkillViewContainer
