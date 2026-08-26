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

	local totWeight = 0
	local weightParam = CommonConfig.instance:getConstStr(ConstEnum.V3a7SkinConfigWeight)
	local constParam = string.splitToNumber(weightParam, "#")
	local st = #refList

	for _, CO in ipairs(COList) do
		if V3a7_SkinGiftEnum.UniqueSkinDic[CO.materialId] then
			if not constParam[1] then
				local weight = constParam[2]

				totWeight = totWeight + weight

				table.insert(refList, {
					weight = weight,
					materialType = CO.materialType,
					materialId = CO.materialId
				})
			end
		end
	end

	local ed = #refList

	for i = st + 1, ed do
		local rateInfo = refList[i]

		rateInfo.rate = totWeight == 0 and 0 or rateInfo.weight / totWeight
	end
end

return V3a7_SkinGiftHelper
