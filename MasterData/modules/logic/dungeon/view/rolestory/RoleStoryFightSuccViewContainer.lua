-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryFightSuccViewContainer.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryFightSuccViewContainer", package.seeall)

local RoleStoryFightSuccViewContainer = class("RoleStoryFightSuccViewContainer", BaseViewContainer)

function RoleStoryFightSuccViewContainer:buildViews()
	return {
		RoleStoryFightSuccView.New()
	}
end

return RoleStoryFightSuccViewContainer
