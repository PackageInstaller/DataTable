-- chunkname: @modules/logic/versionactivity3_7/anniversary3/model/GuessGameUtil.lua

module("modules.logic.versionactivity3_7.anniversary3.model.GuessGameUtil", package.seeall)

local GuessGameUtil = class("GuessGameUtil")

function GuessGameUtil.extractTab(tabs, fromIndex, toIndex)
	if not tabs or fromIndex > #tabs or toIndex > #tabs then
		return tabs, {}
	end

	local targetTabs = {}
	local remainTabs = {}

	for index, tab in ipairs(tabs) do
		if fromIndex <= index and index <= toIndex then
			table.insert(targetTabs, tab)
		else
			table.insert(remainTabs, tab)
		end
	end

	return targetTabs, remainTabs
end

function GuessGameUtil.extractTabByIndexs(tabs, indexs)
	if not tabs then
		return tabs, {}
	end

	local targetTabs = {}
	local remainTabs = {}

	for index, tab in ipairs(tabs) do
		local contain = LuaUtil.tableContains(indexs, index)

		if contain then
			targetTabs[index] = tab
		else
			remainTabs[index] = tab
		end
	end

	return targetTabs, remainTabs
end

function GuessGameUtil.mergeTabs(tabs)
	local results = {}

	for i = 1, #tabs do
		for j = 1, #tabs[i] do
			table.insert(results, tabs[i][j])
		end
	end

	return results
end

function GuessGameUtil.mergeIndexTabs(tabs)
	local results = {}

	for i = 1, #tabs do
		for index, tab in pairs(tabs[i]) do
			results[index] = tab
		end
	end

	return results
end

function GuessGameUtil.equalDivideTabs(tabs, num)
	if not tabs then
		return
	end

	if #tabs % num ~= 0 then
		logError("table could not equal divide !")

		return tabs
	end

	local results = {}

	for i = 1, #tabs do
		local curIndex = 1 + math.floor((i * num - 0.5) / #tabs)

		results[curIndex] = results[curIndex] or {}

		table.insert(results[curIndex], tabs[i])
	end

	return results
end

function GuessGameUtil.getRandomValueInTabs(tabs)
	local randomValue = math.random(1, 100)

	if not tabs then
		return 0
	end

	if #tabs <= 1 then
		return tabs[1][2] or 0
	end

	local total = 0

	for i = 1, #tabs - 1 do
		if #tabs[i] ~= 2 then
			logError("please input correct table!")

			return 0
		end

		total = total + tabs[i][1]

		if randomValue <= total then
			return tabs[i][2]
		end
	end

	return tabs[#tabs][2]
end

function GuessGameUtil.getMaxSameValue(tabs, typeCount)
	local counts = {}

	for i = 1, typeCount do
		local tab = {}

		tab.id = i
		tab.indexs = {}

		table.insert(counts, tab)
	end

	for index, tab in pairs(tabs) do
		table.insert(counts[tab].indexs, index)
	end

	table.sort(counts, function(a, b)
		if a.indexs then
			if not #a.indexs then
				local aCount = 0

				if b.indexs then
					if not #b.indexs then
						local bCount = 0

						return bCount < aCount
					end
				end
			end
		end
	end)

	local items = {}

	for index, tab in pairs(tabs) do
		if tab == counts[1].id then
			table.insert(items, index)
		end
	end

	return items, #counts[1].indexs
end

function GuessGameUtil.randomPickElements(tabs, num)
	if not tabs then
		return
	end

	local eleTabs = {}
	local indexs = {}

	for index, _ in pairs(tabs) do
		table.insert(indexs, index)
	end

	if num > #indexs then
		return
	end

	indexs = GameUtil.randomTable(indexs)

	for i = 1, num do
		eleTabs[indexs[i]] = tabs[indexs[i]]
	end

	return eleTabs
end

function GuessGameUtil.findIndexsInTab(tab, value)
	for index, v in pairs(tab) do
		if v == value then
			return index
		end
	end

	return 1
end

return GuessGameUtil
