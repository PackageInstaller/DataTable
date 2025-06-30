-- chunkname: @IQIGame\\UIExternalApi\\EquipApi.lua

EquipApi = BaseLangApi:Extend()

function EquipApi:Init()
	return
end

function EquipApi:GetEquipSuitPrefab()
	return self:GetResUrl(1100002)
end

function EquipApi:GetDefaultSuitScreenName()
	return self:GetCfgText(6000040)
end

function EquipApi:GetNewEquipSuitPrefab()
	return self:GetResUrl(1100017)
end

function EquipApi:GetNewEquipMainAttriBgPath(quality)
	return string.format(self:GetResUrl(1200106), quality)
end

function EquipApi:EquipPartIconNoingPath(partIndex)
	return string.format(self:GetResUrl(1200102), partIndex)
end

function EquipApi:GetNewEquipOtherAttriActiveBgPath(index)
	return string.format(self:GetResUrl(1200108), index)
end

function EquipApi:GetEquipAttrQualityImagePath(partIndex, quality)
	return string.format(self:GetResUrl(1200109), quality)
end

function EquipApi:GetEquipQualityBgPath(partIndex)
	return self:GetResUrl(1200114)
end

function EquipApi:GetEquipWarehouseQualityImagePath(partIndex, quality)
	return string.format(self:GetResUrl(1200112), quality)
end

function EquipApi:GetEquipCenterHoleBg(partIndex, quality)
	return string.format(self:GetResUrl(1200106), quality)
end

function EquipApi:GetEquipQualityImagePath(quality)
	return string.format(self:GetResUrl(1200109), quality)
end

function EquipApi:EquipSuitColor(Desc, ColorNum)
	return self:SkillValueColor(Desc, ColorNum)
end

function EquipApi:EquipSuitDescribe(name, num)
	return name .. "(" .. num .. "/4)"
end

function EquipApi:GetEquipImagePath(cid)
	local config = CfgItemTable[cid]

	return UIGlobalApi.IconPath .. config.Icon
end

function EquipApi:GetEquipBigIconPath(cid)
	local config = CfgItemTable[cid]

	return UIGlobalApi.IconPath .. config.BigIcon
end

function EquipApi:IntensifyOverFlow(overFlowExps)
	return string.format(self:GetCfgText(6000037), overFlowExps)
end

function EquipApi:GetTextSuitYetEquip(cid)
	return CfgHeroTable[cid].Name .. self:GetCfgText(6000016)
end

function EquipApi:GetTextQuality()
	return self:GetCfgText(1600003)
end

function EquipApi:GetTextGetTime()
	return self:GetCfgText(6000015)
end

function EquipApi:GetTextTitleLv()
	return self:GetCfgText(1600002)
end

function EquipApi:GetTextDidNotHave()
	return self:GetCfgText(6000017)
end

function EquipApi:GetTextNoSuitDescribe()
	return self:GetCfgText(6000018)
end

function EquipApi:GetTextNoWearEquip()
	return self:GetCfgText(6000019)
end

function EquipApi:GetTextSuitAttribute()
	return self:GetCfgText(6000002)
end

function EquipApi:GetTextBaseAttribute()
	return self:GetCfgText(6000001)
end

function EquipApi:GetTextFoldSuitAttribute()
	return self:GetCfgText(6000020)
end

function EquipApi:GetTextFoldBaseAttribute()
	return self:GetCfgText(6000021)
end

function EquipApi:GetTextAdvanceAttribute()
	return self:GetCfgText(6000012)
end

function EquipApi:GetTextIntensify()
	return self:GetCfgText(6000006)
end

function EquipApi:GetTextDischarge()
	return self:GetCfgText(6000005)
end

function EquipApi:GetTextSuitCountDescribe(count)
	return string.format(self:GetCfgText(6000022), count)
end

function EquipApi:GetTextSuitProgressDescribe(curProgress, allProgress)
	return string.format(self:GetCfgText(6000023), curProgress, allProgress)
end

function EquipApi:GetTextAddDescribe(des)
	return string.format(self:GetCfgText(6000024), des)
end

function EquipApi:GetTextLevelDescribe()
	return self:GetCfgText(6000025)
end

function EquipApi:GetTextConsumeDescribe()
	return self:GetCfgText(6000026)
end

function EquipApi:GetTextOneKeyAdd()
	return self:GetCfgText(6000027)
end

function EquipApi:GetTextMultiply(num)
	return string.format(self:GetCfgText(6000028), num)
end

function EquipApi:FormatAttrValue(isPercent, attrValue)
	if isPercent then
		return string.format("%.1f%%", attrValue * 100)
	end

	return math.floor(attrValue)
end

function EquipApi:GetTextAddAttributeNum(addAttributeNum)
	return string.format("%.3f", addAttributeNum)
end

function EquipApi:GetTextNoWearEquipShopAttribute()
	return self:GetCfgText(6000030)
end

function EquipApi:GetTextAddDesNoAttribuate(num)
	return self:GetCfgText(6000031)
end

function EquipApi:GetTextWear()
	return self:GetCfgText(6000032)
end

function EquipApi:GetTextWearIng()
	return self:GetCfgText(6000033)
end

function EquipApi:GetTextReplace()
	return self:GetCfgText(6000034)
end

function EquipApi:GetTextSure()
	return self:GetCfgText(1600037)
end

function EquipApi:GetTextCanel()
	return self:GetCfgText(1600038)
end

function EquipApi:GetTextCanelSelect()
	return self:GetCfgText(6000038)
end

function EquipApi:GetTextLv(lv)
	return "+" .. lv
end

function EquipApi:GetUnLockLvDescribute(lv)
	return string.format(self:GetCfgText(6000039), lv)
end

function EquipApi:GetTextReplaceDescribute(ownHeroName, targetHero)
	return string.format(self:GetCfgText(6000036), ownHeroName, targetHero)
end

function EquipApi:GetSuitScreenTitle()
	return self:GetCfgText(6000041)
end

function EquipApi:GetSuitScreenText(selectSuitName)
	return self:GetCfgText(6000042) .. selectSuitName
end

function EquipApi:GetPopupListButtonStaticText()
	return self:GetCfgText(6000040)
end

function EquipApi:GetPopupListItemSubText(isSelect, id)
	if isSelect then
		return string.format("<color=#909090>%s</color>", BaseLangApi:GetCfgText(id))
	else
		return string.format("<color=#979797>%s</color>", BaseLangApi:GetCfgText(id))
	end
end

function EquipApi:GetShowEffect(quality)
	if quality == 1 then
		return 10002
	elseif quality == 2 then
		return 10003
	elseif quality == 3 then
		return 10004
	elseif quality == 4 then
		return 10005
	elseif quality == 5 then
		return 10006
	end
end

function EquipApi:GetConstantDisplayEffect(quality)
	if quality == 5 then
		return 10009
	elseif quality == 4 then
		return 10008
	else
		return nil
	end
end

function EquipApi:GetEquipPartImg(partIndex)
	return string.format(self:GetResUrl(1200113), partIndex)
end

function EquipApi:GetAwakenEquipDesc(suitIDs)
	local strs = {}

	for k, v in pairs(CfgEquipSuitTable) do
		for i = 1, #suitIDs do
			if v.SuitID == suitIDs[i] and v.SuitType == Constant.Equip.SuitType.Normal and table.indexOf(strs, v.Name) == -1 then
				table.insert(strs, v.Name)
			end
		end
	end

	return strs
end

function EquipApi:AppendSuitNameStr(strs)
	local str = ""

	for i = 1, #strs do
		str = str .. strs[i]

		if i ~= #strs then
			str = str .. "、"
		end
	end

	return string.format(self:GetCfgText(6000048), str)
end

function EquipApi:GetPartName(partIndex)
	if partIndex == Constant.Equip.Part.Tong then
		return self:GetCfgText(1600067)
	elseif partIndex == Constant.Equip.Part.Mian then
		return self:GetCfgText(1600068)
	elseif partIndex == Constant.Equip.Part.Chu then
		return self:GetCfgText(1600069)
	elseif partIndex == Constant.Equip.Part.Xing then
		return self:GetCfgText(1600070)
	elseif partIndex == Constant.Equip.Part.Gu then
		return self:GetCfgText(1600071)
	elseif partIndex == Constant.Equip.Part.Hun then
		return self:GetCfgText(1600072)
	end
end

function EquipApi:GetAllSuitMenuContentData()
	local result = {}

	result.text = self:GetCfgText(6000040)
	result.iconPath = nil

	return result
end

function EquipApi:GetAllMainPropertyMenuContentData()
	local result = {}

	result.text = "全部属性"
	result.iconPath = nil

	return result
end

function EquipApi:GetAllSubPropertyMenuContentData()
	local result = {}

	result.text = "全部属性"
	result.iconPath = nil

	return result
end

function EquipApi:GetEquipSortQualityContentData(quality)
	local result = {}

	if quality == 0 then
		result.text = "全部品质"
		result.iconPath = nil
	elseif quality == 1 then
		result.text = "白色品质"
		result.iconPath = nil
	elseif quality == 2 then
		result.text = "绿色品质"
		result.iconPath = nil
	elseif quality == 3 then
		result.text = "蓝色品质"
		result.iconPath = nil
	elseif quality == 4 then
		result.text = "紫色品质"
		result.iconPath = nil
	elseif quality == 5 then
		result.text = "橙色品质"
		result.iconPath = nil
	end

	return result
end

function EquipApi:GetTextFilter(number)
	if number == 1 then
		return self:GetCfgText(6000103)
	elseif number == 2 then
		return self:GetCfgText(6000102)
	elseif number == 3 then
		return self:GetCfgText(6000101)
	end
end

function EquipApi:GetAwakenBg(isAwaken)
	if isAwaken then
		return CfgUtil.GetCfgResourceUrl(1200116)
	else
		return CfgUtil.GetCfgResourceUrl(1200117)
	end
end

function EquipApi:GetEquipCellQualityEffect(quality)
	if quality == 2 then
		return 10024
	elseif quality == 3 then
		return 10023
	elseif quality == 4 then
		return 10025
	elseif quality == 5 then
		return 10022
	else
		return 0
	end
end

EquipApi:Init()
