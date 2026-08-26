-- chunkname: @modules/logic/gm/view/FightGMDouQuQuTestContainer.lua

module("modules.logic.gm.view.FightGMDouQuQuTestContainer", package.seeall)

local FightGMDouQuQuTestContainer = class("FightGMDouQuQuTestContainer", BaseViewContainer)

function FightGMDouQuQuTestContainer:buildViews()
	local views = {}

	table.insert(views, FightGMDouQuQuTest.New())

	return views
end

return FightGMDouQuQuTestContainer
