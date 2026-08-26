-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_BuffHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_BuffHelper", package.seeall)

local Rouge2_BuffHelper = class("Rouge2_BuffHelper")

function Rouge2_BuffHelper.setBuffDesc(buffId, parent_obj, model_obj)
	local buffCo = Rouge2_BackpackHelper.getItemConfig(buffId)
	local descList = string.split(buffCo.desc, "|")

	gohelper.CreateObjList(Rouge2_BuffHelper, Rouge2_BuffHelper._refreshBuffDesc, descList, parent_obj, model_obj)
end

function Rouge2_BuffHelper:_refreshBuffDesc(obj, desc, index)
	local txtDesc = gohelper.findChildText(obj, "txt_Desc")

	Rouge2_ItemDescHelper.buildAndSetDesc(txtDesc, desc)
end

function Rouge2_BuffHelper.listToMap(list)
	local map = {}

	for _, info in ipairs(list) do
		map[info] = info
	end

	return map
end

return Rouge2_BuffHelper
