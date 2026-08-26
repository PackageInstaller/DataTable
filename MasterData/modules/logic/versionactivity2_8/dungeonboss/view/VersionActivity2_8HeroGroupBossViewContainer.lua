-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/view/VersionActivity2_8HeroGroupBossViewContainer.lua

module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8HeroGroupBossViewContainer", package.seeall)

local VersionActivity2_8HeroGroupBossViewContainer = class("VersionActivity2_8HeroGroupBossViewContainer", HeroGroupFightViewContainer)

function VersionActivity2_8HeroGroupBossViewContainer:defineFightView()
	self._heroGroupFightView = VersionActivity2_8HeroGroupBossFightView.New()
	self._heroGroupFightListView = HeroGroupListView.New()
end

return VersionActivity2_8HeroGroupBossViewContainer
