-- chunkname: @modules/logic/bossrush/model/v2a9/V2a9BossRushAssassinMO.lua

module("modules.logic.bossrush.model.v2a9.V2a9BossRushAssassinMO", package.seeall)

local V2a9BossRushAssassinMO = class("V2a9BossRushAssassinMO")

function V2a9BossRushAssassinMO:init(mo, stage)
	self.stage = stage
	self.id = mo.id
	self.count = mo.count
	self.itemType = AssassinConfig.instance:getAssassinItemType(self.id)
end

function V2a9BossRushAssassinMO:getCount()
	return self.count
end

function V2a9BossRushAssassinMO:getId()
	return self.id
end

return V2a9BossRushAssassinMO
