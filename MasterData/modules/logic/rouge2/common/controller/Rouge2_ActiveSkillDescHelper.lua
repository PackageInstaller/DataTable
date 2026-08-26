-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_ActiveSkillDescHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_ActiveSkillDescHelper", package.seeall)

local Rouge2_ActiveSkillDescHelper = class("Rouge2_ActiveSkillDescHelper", Rouge2_ItemDescBaseHelper)

function Rouge2_ActiveSkillDescHelper:_initDefaultIncludeTypeList(includeTypeList)
	table.insert(includeTypeList, Rouge2_Enum.RelicsDescType.Desc)
	table.insert(includeTypeList, Rouge2_Enum.RelicsDescType.NarrativeDesc)
end

function Rouge2_ActiveSkillDescHelper:_initGetDescFuncMap(funcMap)
	Rouge2_ActiveSkillDescHelper.super._initGetDescFuncMap(self, funcMap)

	funcMap[Rouge2_Enum.RelicsDescType.LevelUp] = self._getDesc_LevelUp
end

function Rouge2_ActiveSkillDescHelper:_getDesc_LevelUp(model, config, descType, descMode, resultDescList)
	if string.nilorempty(config.newDesc) then
		return
	end

	local descMo = Rouge2_ItemDescHelper._buildDescMo(descType, descMode, Rouge2_Enum.RelicsDescParam.Desc, config.newDesc)

	table.insert(resultDescList, descMo)
end

return Rouge2_ActiveSkillDescHelper
