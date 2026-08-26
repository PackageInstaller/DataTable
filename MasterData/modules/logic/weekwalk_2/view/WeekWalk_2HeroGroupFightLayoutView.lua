-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeroGroupFightLayoutView.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeroGroupFightLayoutView", package.seeall)

local WeekWalk_2HeroGroupFightLayoutView = class("WeekWalk_2HeroGroupFightLayoutView", HeroGroupFightLayoutView)

function WeekWalk_2HeroGroupFightLayoutView:checkNeedSetOffset()
	return true
end

return WeekWalk_2HeroGroupFightLayoutView
