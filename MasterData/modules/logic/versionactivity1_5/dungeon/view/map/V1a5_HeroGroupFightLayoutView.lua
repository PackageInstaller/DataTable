-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/map/V1a5_HeroGroupFightLayoutView.lua

module("modules.logic.versionactivity1_5.dungeon.view.map.V1a5_HeroGroupFightLayoutView", package.seeall)

local V1a5_HeroGroupFightLayoutView = class("V1a5_HeroGroupFightLayoutView", HeroGroupFightLayoutView)

function V1a5_HeroGroupFightLayoutView:checkNeedSetOffset()
	return DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId)
end

return V1a5_HeroGroupFightLayoutView
