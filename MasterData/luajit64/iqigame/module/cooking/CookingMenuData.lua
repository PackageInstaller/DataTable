-- chunkname: @IQIGame\\Module\\Cooking\\CookingMenuData.lua

CookingMenuData = {}

function CookingMenuData.New()
	local o = Clone(CookingMenuData)

	return o
end

function CookingMenuData:Init(cid, unlock)
	self.cid = cid
	self.cfgInfo = CfgCookCombinationTable[self.cid]
	self.unlock = unlock
end

function CookingMenuData:CookMaxNum()
	local maxNum = 99
	local needItem = {}

	for i = 1, #self.cfgInfo.NeedItem, 2 do
		local id = self.cfgInfo.NeedItem[i]
		local needNum = self.cfgInfo.NeedItem[i + 1]

		if needItem[id] == nil then
			needItem[id] = needNum
		else
			needItem[id] = needItem[id] + needNum
		end
	end

	local tab = {}

	for i, v in pairs(needItem) do
		local needNum = v
		local have = WarehouseModule.GetItemNumByCfgID(i)
		local count = math.floor(have / needNum)

		table.insert(tab, count)
	end

	for i = 1, #tab do
		local n = tab[i]

		if n < maxNum then
			maxNum = n
		end
	end

	return maxNum
end

function CookingMenuData:IsAmple()
	local ample = true
	local needItem = {}

	for i = 1, #self.cfgInfo.NeedItem, 2 do
		local id = self.cfgInfo.NeedItem[i]
		local needNum = self.cfgInfo.NeedItem[i + 1]

		if needItem[id] == nil then
			needItem[id] = needNum
		else
			needItem[id] = needItem[id] + needNum
		end
	end

	for i, v in pairs(needItem) do
		local needNum = v
		local have = WarehouseModule.GetItemNumByCfgID(i)

		if ample == true then
			ample = needNum <= have
		end
	end

	return ample
end

return CookingMenuData
