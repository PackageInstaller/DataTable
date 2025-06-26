-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\ROFruitCleanGame\\ROFruitCleanGameData.lua

local m = {
	rightCount = 0,
	startTime = 0,
	fruits = {}
}
local ROFruitData = require("IQIGame.Module.CommonActivity.RestaurantOperation.ROFruitCleanGame.ROFruitData")

function m.New(cid)
	local o = Clone(m)

	o:Init(cid)

	return o
end

function m:Init(cid)
	self.cid = cid
	self.fruits = self:CreateFruits()

	self:RandomPosData()

	self.startTime = 0
	self.rightCount = 0
end

function m:CreateFruits()
	local tab = {}
	local num = 0
	local fruitGroup = table.clone(self:GetCfgData().FruitGroup)

	for i = 1, #self:GetCfgData().FruitComposition, 2 do
		local type = self:GetCfgData().FruitComposition[i]
		local typeCount = self:GetCfgData().FruitComposition[i + 1]
		local typeTab = self:GetRandomElements(fruitGroup, type)

		for j, cid in pairs(typeTab) do
			for count = 1, typeCount do
				num = num + 1

				local fruitData = ROFruitData.New(cid, false)

				table.insert(tab, fruitData)
			end

			log("水果连连看 卡组..=" .. cid .. " 数量： " .. typeCount .. "  -- type =" .. type)
		end
	end

	local emptyNum = ROFruitCleanGameModule.maxNum - num

	for i = 1, emptyNum do
		local fruitData = ROFruitData.New(-1, true)

		table.insert(tab, fruitData)
	end

	return tab
end

function m:RandomPosData()
	for i = #self.fruits, 2, -1 do
		local random_index = math.random(i)

		self.fruits[i], self.fruits[random_index] = self.fruits[random_index], self.fruits[i]
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
	return CfgRestaurantOperationFruitCleanControlTable[self.cid]
end

return m
