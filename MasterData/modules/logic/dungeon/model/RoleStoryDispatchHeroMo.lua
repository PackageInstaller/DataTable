-- chunkname: @modules/logic/dungeon/model/RoleStoryDispatchHeroMo.lua

module("modules.logic.dungeon.model.RoleStoryDispatchHeroMo", package.seeall)

local RoleStoryDispatchHeroMo = pureTable("RoleStoryDispatchHeroMo")

function RoleStoryDispatchHeroMo:ctor()
	self.id = 0
	self.heroId = 0
	self.config = nil
	self.storyId = 0
	self.isEffect = false
end

function RoleStoryDispatchHeroMo:init(heroMo, storyId, isEffect)
	self.id = heroMo.id
	self.heroId = heroMo.heroId
	self.config = heroMo.config
	self.level = heroMo.level
	self.rare = self.config.rare
	self.storyId = storyId
	self.isEffect = isEffect
end

function RoleStoryDispatchHeroMo:isDispatched()
	return RoleStoryModel.instance:isHeroDispatching(self.heroId, self.storyId)
end

function RoleStoryDispatchHeroMo:isEffectHero()
	return self.isEffect
end

return RoleStoryDispatchHeroMo
