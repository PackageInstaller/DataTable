-- chunkname: @modules/logic/fight/view/FightSystemFightNoticeViewContainer.lua

module("modules.logic.fight.view.FightSystemFightNoticeViewContainer", package.seeall)

local FightSystemFightNoticeViewContainer = class("FightSystemFightNoticeViewContainer", BaseViewContainer)

function FightSystemFightNoticeViewContainer:buildViews()
	local views = {}

	table.insert(views, FightSystemFightNoticeView.New())

	return views
end

return FightSystemFightNoticeViewContainer
