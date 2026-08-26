-- chunkname: @modules/logic/fight/model/datahelper/FightDataUtil.lua

module("modules.logic.fight.model.datahelper.FightDataUtil", package.seeall)

local FightDataUtil = {}

function FightDataUtil.copyData(data)
	if type(data) ~= "table" then
		return data
	else
		local table = {}

		for k, v in pairs(data) do
			table[k] = FightDataUtil.copyData(v)
		end

		local meta = getmetatable(data)

		if meta then
			setmetatable(table, meta)
		end

		return table
	end
end

local defaultFilterCoverKey = {
	class = true
}

function FightDataUtil.coverData(data1, data2, filterKey, coverFunc)
	if data1 == nil then
		return nil
	end

	if data2 == nil then
		data2 = {}

		local meta = getmetatable(data1)

		if meta then
			setmetatable(data2, meta)
		end
	end

	for k, v in pairs(data2) do
		if not ((defaultFilterCoverKey[k] or nil) and true) and data1[k] == nil then
			data2[k] = nil
		end
	end

	for k, v in pairs(data1) do
		if not ((defaultFilterCoverKey[k] or nil) and true) then
			if coverFunc and coverFunc[k] then
				coverFunc[k](data1, data2)
			elseif data2[k] == nil then
				data2[k] = FightHelper.deepCopySimpleWithMeta(data1[k])
			elseif type(v) == "table" then
				FightDataUtil.coverInternal(v, data2[k])
			else
				data2[k] = v
			end
		end
	end

	return data2
end

function FightDataUtil.coverInternal(data1, data2)
	for k, v in pairs(data2) do
		if data1[k] == nil then
			data2[k] = nil
		end
	end

	for k, v in pairs(data1) do
		if type(v) == "table" then
			if data2[k] == nil then
				data2[k] = FightHelper.deepCopySimpleWithMeta(v)
			else
				FightDataUtil.coverInternal(v, data2[k])
			end
		else
			data2[k] = v
		end
	end
end

FightDataUtil.findDiffList = {}
FightDataUtil.findDiffPath = {}

function FightDataUtil.addPathkey(key)
	table.insert(FightDataUtil.findDiffPath, key)
end

function FightDataUtil.removePathKey()
	table.remove(FightDataUtil.findDiffPath)
end

function FightDataUtil.findDiff(data1, data2, filterKey, compareFuncTab)
	FightDataUtil.findDiffList = {}
	FightDataUtil.findDiffPath = {}

	FightDataUtil.doFindDiff(data1, data2, filterKey, compareFuncTab)

	local diffTab = {}

	for i, v in ipairs(FightDataUtil.findDiffList) do
		local rootKey = v.pathList[1]

		diffTab[rootKey] = diffTab[rootKey] or {}

		table.insert(diffTab[rootKey], v)
	end

	return #FightDataUtil.findDiffList > 0, diffTab, FightDataUtil.findDiffList
end

function FightDataUtil.doFindDiff(data1, data2, filterKey, compareFuncTab, compareValueFunc)
	if type(data1) ~= "table" or type(data2) ~= "table" then
		logError("传入的参数必须是表结构,请检查代码")

		return
	end

	FightDataUtil.doCheckMissing(data1, data2, filterKey)

	for k, v in pairs(data1) do
		if not ((filterKey and filterKey[k] or nil) and true) and data2[k] ~= nil then
			FightDataUtil.addPathkey(k)

			if compareFuncTab and compareFuncTab[k] then
				compareFuncTab[k](data1[k], data2[k], data1, data2)
			elseif compareValueFunc then
				compareValueFunc(data1[k], data2[k])
			else
				FightDataUtil.checkDifference(data1[k], data2[k])
			end

			FightDataUtil.removePathKey()
		end
	end
end

function FightDataUtil.checkDifference(data1, data2)
	if type(data1) ~= type(data2) then
		FightDataUtil.addDiff(nil, FightDataUtil.diffType.difference)

		return
	elseif type(data1) == "table" then
		FightDataUtil.doCheckMissing(data1, data2)

		for k, v in pairs(data1) do
			if data2[k] ~= nil then
				FightDataUtil.addPathkey(k)
				FightDataUtil.checkDifference(v, data2[k])
				FightDataUtil.removePathKey()
			end
		end
	elseif data1 ~= data2 then
		FightDataUtil.addDiff(nil, FightDataUtil.diffType.difference)
	end
end

function FightDataUtil.doCheckMissing(data1, data2, filterKey)
	for k, v in pairs(data2) do
		if not ((filterKey and filterKey[k] or nil) and true) and data1[k] == nil then
			FightDataUtil.addDiff(k, FightDataUtil.diffType.missingSource)
		end
	end

	for k, v in pairs(data1) do
		if not ((filterKey and filterKey[k] or nil) and true) and data2[k] == nil then
			FightDataUtil.addDiff(k, FightDataUtil.diffType.missingTarget)
		end
	end
end

FightDataUtil.diffType = {
	missingTarget = 2,
	difference = 3,
	missingSource = 1
}

function FightDataUtil.addDiff(key, diffType)
	local tab = {}

	tab.diffType = diffType or FightDataUtil.diffType.difference

	local pathList = FightDataUtil.coverData(FightDataUtil.findDiffPath)

	if key then
		table.insert(pathList, key)
	end

	tab.pathList = pathList
	tab.pathStr = table.concat(pathList, ".")

	table.insert(FightDataUtil.findDiffList, tab)

	return tab
end

function FightDataUtil.getDiffValue(sourceData, targetData, tab)
	local value1, value2
	local pathList = tab.pathList
	local ref1 = sourceData
	local ref2 = targetData

	for i, v in ipairs(pathList) do
		value1 = ref1[v]
		value2 = ref2[v]
		ref1 = ref1[v]
		ref2 = ref2[v]
	end

	value1 = value1 == nil and "nil" or value1
	value2 = value2 == nil and "nil" or value2

	return value1, value2
end

return FightDataUtil
