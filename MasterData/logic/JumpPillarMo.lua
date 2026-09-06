-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpgame/model/JumpPillarMo.lua

module("logic.extensions.jumpgame.model.JumpPillarMo", package.seeall)

local JumpPillarMo = class("JumpPillarMo")

function JumpPillarMo:ctor()
	self._pillars = nil
	self._space = 0
	self._idx = 1
	self._items = {}
end

function JumpPillarMo:initPillar(dat, platformInited)
	self._idx = platformInited

	if dat.rate and #dat.rate > 2 then
		self._pillars = JumpGameConfig.instance:getPillarCfgById(self:_caculateRate(dat.rate))
	else
		local pillarIdx = math.random(1, #dat.pillar)

		self._pillars = JumpGameConfig.instance:getPillarCfgById(dat.pillar[pillarIdx])
	end

	local space = JumpGameConfig.instance:getSpaceCfgById(dat.spaceType)

	self._space = math.random(space.range[1], space.range[2]) * JumpGameConfig.instance:getGameInfoCfgByKey("space")

	self:_initItems()
end

function JumpPillarMo:_caculateRate(rates)
	local rateCount = 0
	local rate = math.random(1, 100)

	for i, v in ipairs(rates) do
		rateCount = rateCount + v

		if rate < rateCount then
			return i
		end
	end
end

function JumpPillarMo:getPillarLen()
	return self._space + self._pillars.pillars * 100
end

function JumpPillarMo:getSpace()
	return self._space
end

function JumpPillarMo:_initItems()
	for i = 1, #self._pillars.rate do
		local random = UnityEngine.Random.Range(1, 100)

		self._items[i] = nil

		if random <= self._pillars.rate[i] then
			local item = JumpItemMO.New()

			item:initType(self._pillars.itemType)

			self._items[i] = item
		end
	end
end

function JumpPillarMo:getItems()
	return self._items
end

return JumpPillarMo
