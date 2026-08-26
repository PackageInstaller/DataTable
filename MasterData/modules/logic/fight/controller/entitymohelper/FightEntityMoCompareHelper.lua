-- chunkname: @modules/logic/fight/controller/entitymohelper/FightEntityMoCompareHelper.lua

module("modules.logic.fight.controller.entitymohelper.FightEntityMoCompareHelper", package.seeall)

local FightEntityMoCompareHelper = _M

FightEntityMoCompareHelper.DeepMaxStack = 100
FightEntityMoCompareHelper.CompareFilterAttrDict = {
	stanceDic = true,
	playCardExPoint = true,
	buffFeaturesSplit = true,
	_playCardAddExpoint = true,
	isOnlyData = true,
	_last_clone_mo = true,
	moveCardExPoint = true,
	passiveSkillDic = true,
	_combineCardAddExpoint = true,
	custom_refreshNameUIOp = true,
	stanceIndex = true,
	__cname = true,
	skillList = true,
	_moveCardAddExpoint = true
}

function FightEntityMoCompareHelper.compareEntityMo(entityMo1, entityMo2)
	FightEntityMoCompareHelper.initCompareHandleDict()

	for key, value in pairs(entityMo1) do
		if not FightEntityMoCompareHelper.CompareFilterAttrDict[key] then
			local compareHandle = FightEntityMoCompareHelper.compareHandleDict[key]

			compareHandle = compareHandle or FightEntityMoCompareHelper.defaultTableDeepCompare

			local same = compareHandle(value, entityMo2[key])

			if not same then
				return false
			end
		end
	end

	return true
end

function FightEntityMoCompareHelper.initCompareHandleDict()
	FightEntityMoCompareHelper.compareHandleDict = FightEntityMoCompareHelper.compareHandleDict or {
		buffModel = FightEntityMoCompareHelper.defaultTableDeepCompare,
		_powerInfos = FightEntityMoCompareHelper.defaultTableDeepCompare,
		summonedInfo = FightEntityMoCompareHelper.summonedInfoCompare,
		attrMO = FightEntityMoCompareHelper.attrMoCompare
	}
end

function FightEntityMoCompareHelper.defaultCompare(valueA, valueB)
	if valueA == valueB then
		return true
	end

	if not valueA or not valueB then
		return false
	end

	local typeA, typeB = type(valueA), type(valueB)

	if typeA ~= typeB then
		return false
	end

	if typeA == "table" then
		return FightEntityMoCompareHelper.defaultTableCompare(valueA, valueB)
	end

	return valueA == valueB
end

FightEntityMoCompareHelper.CompareStatus = {
	CompareFinish = 2,
	WaitCompare = 1
}

function FightEntityMoCompareHelper._innerTableCompare(tableA, tableB)
	if tableA == tableB then
		return FightEntityMoCompareHelper.CompareStatus.CompareFinish, true
	end

	if not tableA or not tableB then
		return FightEntityMoCompareHelper.CompareStatus.CompareFinish, false
	end

	local typeA, typeB = type(tableA), type(tableB)

	if typeA ~= typeB then
		return FightEntityMoCompareHelper.CompareStatus.CompareFinish, false
	end

	return FightEntityMoCompareHelper.CompareStatus.WaitCompare, true
end

function FightEntityMoCompareHelper.defaultTableCompare(tableA, tableB)
	local status, same = FightEntityMoCompareHelper._innerTableCompare(tableA, tableB)

	if status == FightEntityMoCompareHelper.CompareStatus.CompareFinish then
		return same
	end

	for key, value in pairs(tableB) do
		if not FightEntityMoCompareHelper.CompareFilterAttrDict[key] and value ~= tableA[key] then
			return false
		end
	end

	return true
end

function FightEntityMoCompareHelper.defaultTableDeepCompare(tableA, tableB, level, preKey)
	level = level or 0

	if level > FightEntityMoCompareHelper.DeepMaxStack then
		logError("stackoverflow")

		return true, preKey
	end

	local status, same = FightEntityMoCompareHelper._innerTableCompare(tableA, tableB)

	if status == FightEntityMoCompareHelper.CompareStatus.CompareFinish then
		return same, preKey
	end

	for key, aValue in pairs(tableA) do
		if preKey then
			if not (preKey .. key) then
				local curKey = key

				if not FightEntityMoCompareHelper.CompareFilterAttrDict[key] then
					local bValue = tableB[key]
					local typeA, typeB = type(aValue), type(bValue)

					if typeA ~= typeB then
						return false, curKey
					end

					if typeA == "table" then
						same, curKey = FightEntityMoCompareHelper.defaultTableDeepCompare(aValue, bValue, level + 1, curKey)

						if not same then
							return false, curKey
						end
					elseif aValue ~= bValue then
						return false, curKey
					end
				end
			end
		end
	end

	return true
end

function FightEntityMoCompareHelper.summonedInfoCompare(summonedInfoA, summonedInfoB)
	local status, same = FightEntityMoCompareHelper._innerTableCompare(summonedInfoA, summonedInfoB)

	if status == FightEntityMoCompareHelper.CompareStatus.CompareFinish then
		return same
	end

	if summonedInfoA.getDataDic then
		local aData = summonedInfoA:getDataDic()

		if summonedInfoB.getDataDic then
			local bData = summonedInfoB:getDataDic()

			return FightEntityMoCompareHelper.defaultTableDeepCompare(aData, bData)
		end
	end
end

function FightEntityMoCompareHelper.attrMoCompare(attrMo1, attrMo2)
	local status, same = FightEntityMoCompareHelper._innerTableCompare(attrMo1, attrMo2)

	if status == FightEntityMoCompareHelper.CompareStatus.CompareFinish then
		return same
	end

	if attrMo1.hp ~= attrMo2.hp then
		return false
	end

	if attrMo1.multiHpIdx ~= attrMo2.multiHpIdx then
		return false
	end

	if attrMo1.multiHpNum ~= attrMo2.multiHpNum then
		return false
	end

	return true
end

return FightEntityMoCompareHelper
