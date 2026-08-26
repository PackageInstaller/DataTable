-- chunkname: @modules/logic/fight/controller/entitymohelper/FightEntityMoDiffHelper.lua

module("modules.logic.fight.controller.entitymohelper.FightEntityMoDiffHelper", package.seeall)

local FightEntityMoDiffHelper = _M

FightEntityMoDiffHelper.DeepMaxStack = 100

local diffMsgTab = {}
local entityMo1Name = "entityMo1"
local entityMo2Name = "[表现层数据] entityMo2"
local errorNumber = 0

function FightEntityMoDiffHelper.getDiffMsg(entityMo1, entityMo2)
	FightEntityMoDiffHelper.initGetDiffHandleDict()
	tabletool.clear(diffMsgTab)

	errorNumber = 0

	for key, value in pairs(entityMo1) do
		if not FightEntityMoCompareHelper.CompareFilterAttrDict[key] then
			local diffHandle = FightEntityMoDiffHelper.diffHandleDict[key]

			diffHandle = diffHandle or FightEntityMoDiffHelper.defaultDiff

			diffHandle(value, entityMo2[key], key)
		end
	end

	return table.concat(diffMsgTab, "\n")
end

function FightEntityMoDiffHelper.getTypeDiffMsg(key, entity1Name, type1, entity2Name, type2)
	errorNumber = errorNumber + 1

	table.insert(diffMsgTab, string.format("\n[error %s] key : %s, \n%s.%s type is %s, \n%s.%s type is %s", errorNumber, key, entity1Name, key, type1, entity2Name, key, type2))
end

function FightEntityMoDiffHelper.getValueDiffMsg(key, entity1Name, value1, entity2Name, value2)
	errorNumber = errorNumber + 1

	table.insert(diffMsgTab, string.format("\n[error %s] key : %s, \n%s.%s = %s, \n%s.%s = %s", errorNumber, key, entity1Name, key, value1, entity2Name, key, value2))
end

function FightEntityMoDiffHelper.addDiffMsg(msg)
	table.insert(diffMsgTab, "\n" .. tostring(msg))
end

function FightEntityMoDiffHelper.initGetDiffHandleDict()
	FightEntityMoDiffHelper.diffHandleDict = FightEntityMoDiffHelper.diffHandleDict or {
		buffModel = FightEntityMoDiffHelper.buffModelDiff,
		_powerInfos = FightEntityMoDiffHelper.defaultTableDeepDiff,
		summonedInfo = FightEntityMoDiffHelper.summonedInfoDiff
	}
end

function FightEntityMoDiffHelper.defaultDiff(valueA, valueB, key)
	if valueA == valueB then
		return
	end

	if not valueA or not valueB then
		FightEntityMoDiffHelper.getValueDiffMsg(key, entityMo1Name, valueA, entityMo2Name, valueB)

		return
	end

	local typeA, typeB = type(valueA), type(valueB)

	if typeA ~= typeB then
		FightEntityMoDiffHelper.getTypeDiffMsg(key, entityMo1Name, typeA, entityMo2Name, typeB)

		return
	end

	if typeA == "table" then
		return FightEntityMoDiffHelper.defaultTableDiff(valueA, valueB, key)
	end

	if valueA ~= valueB then
		FightEntityMoDiffHelper.getValueDiffMsg(key, entityMo1Name, valueA, entityMo2Name, valueB)
	end
end

FightEntityMoDiffHelper.CompareStatus = {
	CompareFinish = 2,
	WaitCompare = 1
}

function FightEntityMoDiffHelper._innerTableDiff(tableA, tableB, key)
	if tableA == tableB then
		return FightEntityMoDiffHelper.CompareStatus.CompareFinish
	end

	if not tableA or not tableB then
		FightEntityMoDiffHelper.getValueDiffMsg(key, entityMo1Name, tableA, entityMo2Name, tableB)

		return FightEntityMoDiffHelper.CompareStatus.CompareFinish
	end

	local typeA, typeB = type(tableA), type(tableB)

	if typeA ~= typeB then
		FightEntityMoDiffHelper.getTypeDiffMsg(key, entityMo1Name, typeA, entityMo2Name, typeB)

		return FightEntityMoDiffHelper.CompareStatus.CompareFinish
	end

	return FightEntityMoDiffHelper.CompareStatus.WaitCompare
end

function FightEntityMoDiffHelper.defaultTableDiff(tableA, tableB, key)
	local status = FightEntityMoDiffHelper._innerTableDiff(tableA, tableB, key)

	if status == FightEntityMoDiffHelper.CompareStatus.CompareFinish then
		return
	end

	local same = true

	for innerKey, value in pairs(tableB) do
		if value ~= tableA[innerKey] then
			same = false

			FightEntityMoDiffHelper.getValueDiffMsg(key .. innerKey, entityMo1Name, value, entityMo2Name, tableA[key])
		end
	end

	if not same then
		FightEntityMoDiffHelper.addDiffMsg(GameUtil.logTab(tableA))
		FightEntityMoDiffHelper.addDiffMsg(GameUtil.logTab(tableB))
	end
end

function FightEntityMoDiffHelper.defaultTableDeepDiff(tableA, tableB, key, level)
	level = level or 0

	if level > FightEntityMoDiffHelper.DeepMaxStack then
		logError("stackoverflow")

		return
	end

	local status = FightEntityMoDiffHelper._innerTableDiff(tableA, tableB, key)

	if status == FightEntityMoDiffHelper.CompareStatus.CompareFinish then
		return
	end

	local same = true

	for innerKey, aValue in pairs(tableA) do
		local curLogKey = key .. "." .. innerKey
		local bValue = tableB[innerKey]
		local typeA, typeB = type(aValue), type(bValue)

		if typeA ~= typeB then
			same = false

			FightEntityMoDiffHelper.getTypeDiffMsg(curLogKey, entityMo1Name, typeA, entityMo2Name, typeB)
		elseif typeA == "table" then
			FightEntityMoDiffHelper.defaultTableDeepDiff(aValue, bValue, curLogKey, level + 1)
		elseif aValue ~= bValue then
			same = false

			FightEntityMoDiffHelper.getValueDiffMsg(curLogKey, entityMo1Name, aValue, entityMo2Name, bValue)
		end
	end

	if not same then
		FightEntityMoDiffHelper.addDiffMsg(GameUtil.logTab(tableA))
		FightEntityMoDiffHelper.addDiffMsg(GameUtil.logTab(tableB))
	end
end

function FightEntityMoDiffHelper.buffModelDiff(modelA, modelB, key)
	local status = FightEntityMoDiffHelper._innerTableDiff(modelA, modelB, key)

	if status == FightEntityMoDiffHelper.CompareStatus.CompareFinish then
		return
	end

	if modelA.getDict then
		local aBuffDict = modelA:getDict()

		if modelB.getDict then
			local bBuffDict = modelB:getDict()

			status = FightEntityMoDiffHelper._innerTableDiff(aBuffDict, bBuffDict, key .. "._dict")

			if status == FightEntityMoDiffHelper.CompareStatus.CompareFinish then
				return
			end

			local same = true

			for buffUid, buffMoA in pairs(aBuffDict) do
				local curKey = key .. "._dict." .. buffUid
				local buffMoB = bBuffDict[buffUid]
				local tempSame, diffKey = FightEntityMoCompareHelper.defaultTableDeepCompare(buffMoA, buffMoB)

				if not tempSame then
					same = false
					curKey = diffKey and curKey .. diffKey or curKey

					FightEntityMoDiffHelper.getValueDiffMsg(curKey, entityMo1Name, GameUtil.logTab(buffMoA), entityMo2Name, GameUtil.logTab(buffMoB))
				end
			end

			if not same then
				FightEntityMoDiffHelper.addDiffMsg(FightLogHelper.getFightBuffDictString(aBuffDict))
				FightEntityMoDiffHelper.addDiffMsg(FightLogHelper.getFightBuffDictString(bBuffDict))
			end
		end
	end
end

function FightEntityMoDiffHelper.summonedInfoDiff(summonedInfoA, summonedInfoB, key)
	local status = FightEntityMoDiffHelper._innerTableDiff(summonedInfoA, summonedInfoB, key)

	if status == FightEntityMoDiffHelper.CompareStatus.CompareFinish then
		return
	end

	if summonedInfoA.getDataDic then
		local aData = summonedInfoA:getDataDic()

		if summonedInfoA.getDataDic then
			local bData = summonedInfoB:getDataDic()

			status = FightEntityMoDiffHelper._innerTableDiff(aData, bData, key .. ".dataDic")

			if status == FightEntityMoDiffHelper.CompareStatus.CompareFinish then
				return
			end

			local same = true

			for uid, dataA in pairs(aData) do
				local curKey = key .. ".dataDic." .. uid
				local dataB = bData[uid]

				if not FightEntityMoCompareHelper.defaultTableDeepCompare(dataA, dataB) then
					FightEntityMoDiffHelper.getValueDiffMsg(curKey, entityMo1Name, GameUtil.logTab(dataA), entityMo2Name, GameUtil.logTab(dataB))
				end
			end

			if not same then
				FightEntityMoDiffHelper.addDiffMsg(GameUtil.logTab(aData))
				FightEntityMoDiffHelper.addDiffMsg(GameUtil.logTab(bData))
			end
		end
	end
end

return FightEntityMoDiffHelper
