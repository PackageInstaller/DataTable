-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_RelicsDescHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_RelicsDescHelper", package.seeall)

local Rouge2_RelicsDescHelper = class("Rouge2_RelicsDescHelper", Rouge2_ItemDescBaseHelper)

function Rouge2_RelicsDescHelper:_initGetDescFuncMap(funcMap)
	Rouge2_RelicsDescHelper.super._initGetDescFuncMap(self, funcMap)

	funcMap[Rouge2_Enum.RelicsDescType.UnlockDesc] = self._getDesc_UnlockDesc
	funcMap[Rouge2_Enum.RelicsDescType.LevelUp] = self._getDesc_LevelUp
end

function Rouge2_RelicsDescHelper:_getDesc_Desc(model, config, descType, descMode, resultDescList)
	local isSimply = descMode == Rouge2_Enum.ItemDescMode.Simply

	if isSimply then
		if not config.descSimply then
			local descStr = config.desc

			if string.nilorempty(descStr) then
				return
			end

			local descList = self:_tryProcessBandRelicsDesc(model, config, descStr)

			descList = descList or string.split(descStr, "|")

			if descList then
				if not #descList then
					local descNum = 0

					for i = 1, descNum do
						local desc = descList[i]
						local descResult = Rouge2_ItemExpressionHelper.getDescResult(model, config, desc)
						local isTrigger = model == nil and true or model:isTriggerEffect(i)
						local descMo = Rouge2_ItemDescHelper._buildDescMo(descType, descMode, Rouge2_Enum.RelicsDescParam.Desc, descResult, Rouge2_Enum.RelicsDescParam.isTrigger, isTrigger)

						Rouge2_ItemDescHelper._addDescMo(resultDescList, descMo)
					end
				end
			end
		end
	end
end

function Rouge2_RelicsDescHelper:_tryProcessBandRelicsDesc(model, config, descStr)
	if config.id == Rouge2_MapConfig.instance:getBandRelicsId() then
		local descList = {}
		local splitDescList = string.split(descStr, "|")

		for _, splitDescStr in ipairs(splitDescList) do
			local splitDescInfo = string.split(splitDescStr, ":")
			local attrId = tonumber(splitDescInfo[1])
			local desc = splitDescInfo[2]

			if not model then
				table.insert(descList, desc)
			elseif model:getAttrValue(attrId) > 0 then
				table.insert(descList, desc)
			end
		end

		return descList
	end
end

function Rouge2_RelicsDescHelper:_getDesc_UnlockDesc(model, config, descType, descMode, resultDescList)
	if string.nilorempty(config.unlockEffectDesc) then
		return
	end

	local isUnlock = model == nil and true or model:isTriggerUnlockEffect()
	local descMo = Rouge2_ItemDescHelper._buildDescMo(descType, descMode, Rouge2_Enum.RelicsDescParam.Desc, config.unlockEffectDesc, Rouge2_Enum.RelicsDescParam.Condition, config.unlockConditionDesc, Rouge2_Enum.RelicsDescParam.isTrigger, isUnlock)

	table.insert(resultDescList, descMo)
end

function Rouge2_RelicsDescHelper:_getDesc_LevelUp(model, config, descType, descMode, resultDescList)
	if string.nilorempty(config.descUpdate) then
		return
	end

	local descMo = Rouge2_ItemDescHelper._buildDescMo(descType, descMode, Rouge2_Enum.RelicsDescParam.LevelUp, config.descUpdate)

	table.insert(resultDescList, descMo)
end

function Rouge2_RelicsDescHelper:_initDefaultIncludeTypeList(includeTypeList)
	table.insert(includeTypeList, Rouge2_Enum.RelicsDescType.LevelUp)
	table.insert(includeTypeList, Rouge2_Enum.RelicsDescType.Desc)
	table.insert(includeTypeList, Rouge2_Enum.RelicsDescType.UnlockDesc)
	table.insert(includeTypeList, Rouge2_Enum.RelicsDescType.NarrativeDesc)
end

return Rouge2_RelicsDescHelper
