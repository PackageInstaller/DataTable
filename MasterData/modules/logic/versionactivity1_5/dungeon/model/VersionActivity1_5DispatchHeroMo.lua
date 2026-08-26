-- chunkname: @modules/logic/versionactivity1_5/dungeon/model/VersionActivity1_5DispatchHeroMo.lua

module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5DispatchHeroMo", package.seeall)

local VersionActivity1_5DispatchHeroMo = pureTable("VersionActivity1_5DispatchVersionActivity1_5DispatchHeroMo")

function VersionActivity1_5DispatchHeroMo:ctor()
	self.id = 0
	self.heroId = 0
	self.config = nil
end

function VersionActivity1_5DispatchHeroMo:init(heroMo)
	self.id = heroMo.id
	self.heroId = heroMo.heroId
	self.config = heroMo.config
	self.level = heroMo.level
	self.rare = self.config.rare
end

function VersionActivity1_5DispatchHeroMo:isDispatched()
	return VersionActivity1_5DungeonModel.instance:isDispatched(self.heroId)
end

return VersionActivity1_5DispatchHeroMo
