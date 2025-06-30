-- chunkname: @IQIGame\\Module\\Transform\\TransformModule.lua

TransformModule = {}

local this = TransformModule

function this.GetCombinationArrayWithType(type)
	local repeatList = {}
	local data = {}

	for _, v in pairsCfg(CfgCombinationTable) do
		if v.Type == type and not repeatList[v.Output[1]] and v.Order == 1 and ConditionModule.Check(v.TransCondition) then
			table.insert(data, v)

			repeatList[v.Output[1]] = 1
		end
	end

	this.BeginCheckPrepare()
	table.sort(data, function(a, b)
		local cfgCombinationA = a
		local cfgCombinationB = b

		if not cfgCombinationA or not cfgCombinationB then
			return false
		end

		if cfgCombinationA.Id == cfgCombinationB.Id then
			return false
		end

		local enoughA = this.CheckItemArrayIsEnough(cfgCombinationA.Combination)
		local enoughB = this.CheckItemArrayIsEnough(cfgCombinationB.Combination)

		if enoughA ~= enoughB then
			return enoughA
		end

		local cfgItemA = CfgUtil.GetItemCfgDataWithID(cfgCombinationA.Output[1])
		local cfgItemB = CfgUtil.GetItemCfgDataWithID(cfgCombinationB.Output[1])

		if cfgItemA.ItemSubTypes ~= cfgItemB.ItemSubTypes then
			return cfgItemA.ItemSubTypes < cfgItemB.ItemSubTypes
		end

		return cfgItemA.Id < cfgItemB.Id
	end)
	this.EndCheckPrepare()

	return data
end

function this.GetAllRecipeArray(type, itemID)
	local array = {}

	for _, v in pairsCfg(CfgCombinationTable) do
		local len = #v.Output

		for i = 1, len - 1, 2 do
			if v.Type == type and v.Output[i] == itemID then
				table.insert(array, v)
			end
		end
	end

	table.sort(array, function(a, b)
		return a.Id < b.Id
	end)

	return array
end

function this.BeginCheckPrepare()
	this.tempItemIsEnoughSet = {}
	this.tempCfgItemSet = {}
end

function this.EndCheckPrepare()
	this.tempItemIsEnoughSet = {}
	this.tempCfgItemSet = {}
end

function this.CheckItemIsEnough(itemID, num)
	if this.tempItemIsEnoughSet[itemID] then
		return num <= this.tempItemIsEnoughSet[itemID]
	end

	local haveNum = WarehouseModule.GetItemNumByCfgID(itemID)

	this.tempItemIsEnoughSet[itemID] = haveNum

	return num <= haveNum
end

function this.CheckItemArrayIsEnough(itemArray)
	local len = #itemArray

	for i = 1, len - 1, 2 do
		local flag = this.CheckItemIsEnough(itemArray[i], itemArray[i + 1])

		if not flag then
			return false
		end
	end

	return true
end
