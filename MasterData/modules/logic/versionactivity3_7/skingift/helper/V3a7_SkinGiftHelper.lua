-- chunkname: @modules/logic/versionactivity3_7/skingift/helper/V3a7_SkinGiftHelper.lua

module("modules.logic.versionactivity3_7.skingift.helper.V3a7_SkinGiftHelper", package.seeall)

local V3a7_SkinGiftHelper = _M

function V3a7_SkinGiftHelper.getSkinGiftRareDesc(itemId, rateDescId, descFormatId)
	local itemConfig = ItemConfig.instance:getItemCo(itemId)
	local rateInfoList = {}

	V3a7_SkinGiftHelper.calcRewardGroupRateInfoList(rateInfoList, itemConfig.effect)

	local skinsS = {}

	for _, info in ipairs(rateInfoList) do
		local rate = info.rate * 100

		rate = string.format("%g", rate)

		local skinId = info.materialId
		local skinCO = lua_skin.configDict[skinId]
		local characterId = skinCO.characterId
		local characterCO = lua_character.configDict[characterId]
		local fillParams = {
			characterCO.name,
			skinCO.characterSkin,
			rate
		}
		local desc = GameUtil.getSubPlaceholderLuaLang(luaLang(rateDescId), fillParams)

		table.insert(skinsS, desc)
	end

	return formatLuaLang(descFormatId, table.concat(skinsS, "\n"))
end

function V3a7_SkinGiftHelper.calcRewardGroupRateInfoList(refList, itemEffect)
	local COList = StoreHelper.getRewardGroupRateInfoList(itemEffect)

	if not COList or #COList == 0 then
		return
	end

	local weightParam = CommonConfig.instance:getConstStr(ConstEnum.V3a7SkinConfigWeight)
	local constParam = string.splitToNumber(weightParam, "#")
	local uniqueCount, normalCount = 0, 0

	for _, CO in ipairs(COList) do
		local skinConfig = SkinConfig.instance:getSkinCo(CO.materialId)

		if skinConfig.skinLevel == CharacterEnum.SkinRare.Unique then
			uniqueCount = uniqueCount + 1
		else
			normalCount = normalCount + 1
		end
	end

	for _, CO in ipairs(COList) do
		local skinConfig = SkinConfig.instance:getSkinCo(CO.materialId)
		local isUnique = skinConfig.skinLevel == CharacterEnum.SkinRare.Unique

		if isUnique then
			if not constParam[1] then
				local groupRate = constParam[2]
				local groupCount = isUnique and uniqueCount or normalCount

				table.insert(refList, {
					rate = groupCount == 0 and 0 or groupRate / 100 / groupCount,
					materialType = CO.materialType,
					materialId = CO.materialId
				})
			end
		end
	end
end

return V3a7_SkinGiftHelper
