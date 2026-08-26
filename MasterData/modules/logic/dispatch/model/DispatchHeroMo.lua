-- chunkname: @modules/logic/dispatch/model/DispatchHeroMo.lua

module("modules.logic.dispatch.model.DispatchHeroMo", package.seeall)

local DispatchHeroMo = pureTable("DispatchHeroMo")

function DispatchHeroMo:ctor()
	self.id = 0
	self.heroId = 0
	self.config = nil
end

function DispatchHeroMo:init(heroMo)
	self.id = heroMo.id
	self.heroId = heroMo.heroId
	self.config = heroMo.config
	self.level = heroMo.level
	self.rare = self.config.rare
end

function DispatchHeroMo:isDispatched()
	return DispatchModel.instance:isDispatched(self.heroId)
end

return DispatchHeroMo
