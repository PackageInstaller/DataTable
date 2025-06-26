-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\ROCardGame\\ROCardGameData.lua

local m = {
	rightCount = 0,
	createTime = 0,
	stepCounts = 0,
	startTime = 0,
	cards = {}
}
local ROCardData = require("IQIGame.Module.CommonActivity.RestaurantOperation.ROCardGame.ROCardData")

function m.New(cid)
	local o = Clone(m)

	o:Init(cid)

	return o
end

function m:Init(cid)
	self.cid = cid
	self.cards = self:CreateCards()

	self:RandomPosData()

	self.createTime = PlayerModule.GetServerTime()
	self.stepCounts = 0
	self.rightCount = 0
	self.startTime = 0
end

function m:CreateCards()
	local tab = {}
	local cardGroupTab = table.clone(self:GetCfgData().CardGroup)

	for i = 1, #self:GetCfgData().CardComposition, 2 do
		local type = self:GetCfgData().CardComposition[i]
		local typeCount = self:GetCfgData().CardComposition[i + 1]
		local typeTab = self:GetRandomElements(cardGroupTab, type)

		for j, cid in pairs(typeTab) do
			for count = 1, typeCount do
				local cardData = ROCardData.New(cid, false)

				table.insert(tab, cardData)
			end

			log("卡组..=" .. cid .. " 数量： " .. typeCount .. "  -- type =" .. type)
		end
	end

	return tab
end

function m:RandomPosData()
	for i = #self.cards, 2, -1 do
		local random_index = math.random(i)

		self.cards[i], self.cards[random_index] = self.cards[random_index], self.cards[i]
	end
end

function m:GetRandomElements(randTab, n)
	local randomElements = {}

	for i = 1, n do
		local randomIndex = math.random(1, #randTab)
		local value = randTab[randomIndex]

		table.remove(randTab, randomIndex)
		table.insert(randomElements, value)
	end

	return randomElements
end

function m:GetCfgData()
	return CfgRestaurantOperationMemoryCardControlTable[self.cid]
end

return m
