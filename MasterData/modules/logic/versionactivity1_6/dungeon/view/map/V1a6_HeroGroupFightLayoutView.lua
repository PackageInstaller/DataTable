-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/map/V1a6_HeroGroupFightLayoutView.lua

module("modules.logic.versionactivity1_6.dungeon.view.map.V1a6_HeroGroupFightLayoutView", package.seeall)

local V1a6_HeroGroupFightLayoutView = class("V1a6_HeroGroupFightLayoutView", HeroGroupFightLayoutView)

function V1a6_HeroGroupFightLayoutView:checkNeedSetOffset()
	return (OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101))
end

return V1a6_HeroGroupFightLayoutView
