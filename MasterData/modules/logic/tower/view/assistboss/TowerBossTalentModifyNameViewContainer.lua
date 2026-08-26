-- chunkname: @modules/logic/tower/view/assistboss/TowerBossTalentModifyNameViewContainer.lua

module("modules.logic.tower.view.assistboss.TowerBossTalentModifyNameViewContainer", package.seeall)

local TowerBossTalentModifyNameViewContainer = class("TowerBossTalentModifyNameViewContainer", BaseViewContainer)

function TowerBossTalentModifyNameViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerBossTalentModifyNameView.New())

	return views
end

return TowerBossTalentModifyNameViewContainer
