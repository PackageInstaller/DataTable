-- chunkname: @modules/logic/sp02/dungeon/view/V3A10_HeroGroupFightViewContainer.lua

module("modules.logic.sp02.dungeon.view.V3A10_HeroGroupFightViewContainer", package.seeall)

local V3A10_HeroGroupFightViewContainer = class("V3A10_HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function V3A10_HeroGroupFightViewContainer:getFightLevelView()
	return V3A10_HeroGroupFightViewLevel.New()
end

return V3A10_HeroGroupFightViewContainer
