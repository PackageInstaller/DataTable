-- chunkname: @modules/logic/rouge/model/RougeAssistHeroSingleGroupMO.lua

module("modules.logic.rouge.model.RougeAssistHeroSingleGroupMO", package.seeall)

local RougeAssistHeroSingleGroupMO = pureTable("RougeAssistHeroSingleGroupMO")

function RougeAssistHeroSingleGroupMO:ctor()
	self.id = nil
	self.heroUid = nil
	self.heroId = nil
	self.heroMO = nil
end

function RougeAssistHeroSingleGroupMO:init(id, heroUid, heroMo)
	self.id = id
	self.heroUid = heroUid or "0"
	self.heroMO = heroMo

	if heroMo then
		self.heroId = heroMo.heroId or 0
	end
end

function RougeAssistHeroSingleGroupMO:getHeroMO()
	return self.heroMO
end

function RougeAssistHeroSingleGroupMO:isTrial()
	return true
end

function RougeAssistHeroSingleGroupMO:setEmpty()
	self.heroUid = "0"
	self.heroId = 0
end

return RougeAssistHeroSingleGroupMO
