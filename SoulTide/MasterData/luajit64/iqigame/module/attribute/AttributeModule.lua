-- chunkname: @IQIGame\\Module\\Attribute\\AttributeModule.lua

AttributeModule = {}

function AttributeModule.GetAttName(attID)
	if attID == nil then
		logError("attID is nil.")

		return ""
	end

	return getTipText(Constant.TipConst.TIP_ATTR_START + attID)
end

function AttributeModule.GetAttNameEng(attID)
	if attID == nil then
		logError("attID is nil.")

		return ""
	end

	return getTipText(Constant.TipConst.TIP_ATTR_ENG_START + attID)
end

function AttributeModule.GetAttShowValue(attID, attValue)
	local ret = 0

	if UIGlobalApi.RoundMap[attID] then
		ret = AttributeModule.FloatRound(attValue, UIGlobalApi.DigitMap[attID])
	elseif UIGlobalApi.CutMap[attID] then
		ret = AttributeModule.Float(attValue, UIGlobalApi.DigitMap[attID])
	end

	if UIGlobalApi.PercentMap[attID] then
		ret = ret * 100 .. "%"
	end

	return ret
end

function AttributeModule.GetAttShowNumberValue(attID, attValue)
	local ret = 0

	if UIGlobalApi.RoundMap[attID] then
		ret = AttributeModule.FloatRound(attValue, UIGlobalApi.DigitMap[attID])
	elseif UIGlobalApi.CutMap[attID] then
		ret = AttributeModule.Float(attValue, UIGlobalApi.DigitMap[attID])
	end

	return ret
end

function AttributeModule.GetAttRateUp(attID)
	if attID == Constant.Attribute.TYPE_HP_MAX then
		return Constant.Attribute.TYPE_HP_RATE_UP
	elseif attID == Constant.Attribute.TYPE_ATK then
		return Constant.Attribute.TYPE_ATK_RATE_UP
	elseif attID == Constant.Attribute.TYPE_PHYSICS_DEF then
		return Constant.Attribute.TYPE_PHYSICS_DEF_RATE_UP
	end

	return nil
end

function AttributeModule.GetAttChangeDic(skillIds)
	local attChangesDic = {}

	for i, v in pairs(skillIds) do
		local cfgData = CfgSkillTable[v]

		for m, n in pairs(cfgData.AttrChangeType) do
			if attChangesDic[n] == nil then
				attChangesDic[n] = 0
			end

			attChangesDic[n] = attChangesDic[n] + cfgData.AttrChangeValue[m]
		end
	end

	return attChangesDic
end

function AttributeModule.GetAttChangeList(skillIds)
	local ret = {}
	local attChangesDic = AttributeModule.GetAttChangeDic(skillIds)

	for i, v in pairs(attChangesDic) do
		ret[#ret + 1] = {
			i,
			v
		}
	end

	table.sort(ret, function(a, b)
		return a[1] > b[1]
	end)

	return ret
end

function AttributeModule.Round(value)
	value = tonumber(value) or 0

	return math.floor(value + 0.5)
end

function AttributeModule.Float(v, n)
	if v > math.floor(v) then
		return tonumber(string.format("%." .. n .. "f", v))
	else
		return v
	end
end

function AttributeModule.FloatRound(decimal, n)
	local temp1 = 1

	for i = 1, n do
		temp1 = temp1 * 10
	end

	local temp2 = 1 / temp1

	decimal = decimal * temp1 + 0.5
	decimal = math.floor(decimal)
	decimal = decimal * temp2

	return decimal
end

function AttributeModule.GetPabilityDescs(pabilityCid, isSignedNumber)
	if isSignedNumber == nil then
		isSignedNumber = true
	end

	local returnValue = {}
	local cfgPabilityData = CfgPabilityTable[pabilityCid]
	local descData

	if cfgPabilityData.AttShowType == 1 then
		descData = {
			cfgPabilityData.Describe,
			""
		}

		table.insert(returnValue, descData)
	elseif cfgPabilityData.AttShowType == 2 then
		descData = {
			cfgPabilityData.Describe,
			cfgPabilityData.DescribeValve
		}

		table.insert(returnValue, descData)
	elseif cfgPabilityData.AttShowType == 3 then
		for i = 1, #cfgPabilityData.AttType do
			local attrType = cfgPabilityData.AttType[i]

			if attrType ~= 0 then
				local attrValue = cfgPabilityData.AttValve[i]
				local attrValueStr = AttributeModule.GetAttShowValue(attrType, attrValue)

				if isSignedNumber and attrValue > 0 then
					attrValueStr = "+" .. attrValueStr
				end

				descData = {
					getTipText(Constant.TipConst.TIP_ATTR_START + attrType),
					attrValueStr
				}

				table.insert(returnValue, descData)
			end
		end
	end

	return returnValue
end
