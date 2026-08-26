-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapNodeIconHelper.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapNodeIconHelper", package.seeall)

local Rouge2_MapNodeIconHelper = class("Rouge2_MapNodeIconHelper")

function Rouge2_MapNodeIconHelper.active()
	return
end

function Rouge2_MapNodeIconHelper.createMultiParamKey(...)
	local list = {
		...
	}

	return table.concat(list, "#")
end
