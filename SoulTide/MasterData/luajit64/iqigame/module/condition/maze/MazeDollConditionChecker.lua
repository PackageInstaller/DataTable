-- chunkname: @IQIGame\\Module\\Condition\\Maze\\MazeDollConditionChecker.lua

local m = {}

function m.Check(type, subType, params, comparison, targetValue)
	local checkResult = false
	local checkFailedReasonType
	local dolls = MazeDataModule.GetActiveDollDataList()

	if subType == Constant.ConditionConstant.SUB_TYPE_DOLL_SOUL_CID then
		local dollSoulIdList = {}

		for i, v in pairs(dolls) do
			table.insert(dollSoulIdList, v.soulCid)
		end

		checkResult = ConditionModule.ComparisonValueIn(dollSoulIdList, targetValue, comparison)

		local cfgSoulData = CfgSoulTable[targetValue]

		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_DOLL_SOUL_ID, cfgSoulData.Name)
	elseif subType == Constant.ConditionConstant.SUB_TYPE_DOLL_ATTR then
		for i, v in pairs(dolls) do
			if v.finalAttributes[Constant.Attribute.TYPE_HP] > 0 then
				checkResult = ConditionModule.ComparisonValue(math.floor(v.finalAttributes[params[1]] + 0.5), targetValue, comparison)

				if checkResult then
					break
				end
			end
		end

		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_DOLL_ATTR, getTipText(Constant.TipConst.TIP_ATTR_START + params[1]), targetValue)
	elseif subType == Constant.ConditionConstant.SUB_TYPE_ALL_DOLL_ATTR then
		local sumAttValue = 0

		for i, v in pairs(dolls) do
			if v.finalAttributes[Constant.Attribute.TYPE_HP] > 0 then
				sumAttValue = sumAttValue + v.finalAttributes[params[1]]
			end
		end

		checkResult = ConditionModule.ComparisonValue(math.floor(sumAttValue + 0.5), targetValue, comparison)
		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_DOLL_ATTR, getTipText(Constant.TipConst.TIP_ATTR_START + params[1]), targetValue)
	elseif subType == Constant.ConditionConstant.SUB_TYPE_DOLL_EQUIP then
		local count = 0

		for i, v in pairs(dolls) do
			for i2, v2 in pairs(v.equipments) do
				if v2.Cid == params[1] then
					count = count + 1
				end
			end
		end

		checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)

		local cfgItemData = CfgItemTable[params[1]]

		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_DOLL_EQUIP, cfgItemData.Name)
	elseif subType == Constant.ConditionConstant.SUB_TYPE_DOLL_SKILL then
		local count = 0

		for i, v in pairs(dolls) do
			for i2, v2 in pairs(v.initSkills) do
				if v2 == params[1] then
					count = count + 1
				end
			end
		end

		checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)

		local cfgSkillData = CfgSkillTable[params[1]]

		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_DOLL_SKILL, cfgSkillData.Name)
	elseif subType == Constant.ConditionConstant.SUB_TYPE_FORMATION_DOLL_NUM then
		local count = #dolls

		checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or "unknown error"
	elseif subType == Constant.ConditionConstant.SUB_TYPE_ALL_DOLL_ATTR_PER then
		local attrId = 0
		local sumAttValue = 0
		local sumMaxAttValue = 0

		for i, v in pairs(dolls) do
			if v.finalAttributes[Constant.Attribute.TYPE_HP] > 0 then
				if params[1] == 1 then
					attrId = Constant.Attribute.TYPE_HP
					sumAttValue = sumAttValue + v.finalAttributes[attrId]
					sumMaxAttValue = sumMaxAttValue + v.finalAttributes[Constant.Attribute.TYPE_HP_MAX]
				elseif params[1] == 2 then
					attrId = Constant.Attribute.TYPE_SKILL_ENERGY
					sumAttValue = sumAttValue + v.finalAttributes[attrId]
					sumMaxAttValue = sumMaxAttValue + 100
				end
			end
		end

		local attrName

		if attrId == 0 then
			if params[1] == 1 then
				attrName = getTipText(Constant.TipConst.TIP_ATTR_START + Constant.Attribute.TYPE_HP)
			elseif params[1] == 2 then
				attrName = getTipText(Constant.TipConst.TIP_ATTR_START + Constant.Attribute.TYPE_SKILL_ENERGY)
			end
		end

		if sumMaxAttValue == 0 then
			sumAttValue = 0
			sumMaxAttValue = 1
		end

		local percent = sumAttValue / sumMaxAttValue * 100

		checkResult = ConditionModule.ComparisonValue(percent, targetValue, comparison)
		checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_DOLL_ATTR, tostring(attrName), targetValue .. "%%")
	else
		logError("error condition type : " .. type .. ", subType : " .. subType)
	end

	return checkResult, checkFailedReasonType
end

return m
