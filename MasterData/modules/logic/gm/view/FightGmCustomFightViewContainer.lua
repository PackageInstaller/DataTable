-- chunkname: @modules/logic/gm/view/FightGmCustomFightViewContainer.lua

module("modules.logic.gm.view.FightGmCustomFightViewContainer", package.seeall)

local FightGmCustomFightViewContainer = class("FightGmCustomFightViewContainer", BaseViewContainer)

function FightGmCustomFightViewContainer:buildViews()
	local views = {}

	table.insert(views, FightGmCustomFightView.New())

	return views
end

return FightGmCustomFightViewContainer
