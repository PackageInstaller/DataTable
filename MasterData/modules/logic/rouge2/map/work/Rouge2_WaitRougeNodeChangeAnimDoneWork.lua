-- chunkname: @modules/logic/rouge2/map/work/Rouge2_WaitRougeNodeChangeAnimDoneWork.lua

module("modules.logic.rouge2.map.work.Rouge2_WaitRougeNodeChangeAnimDoneWork", package.seeall)

local Rouge2_WaitRougeNodeChangeAnimDoneWork = class("Rouge2_WaitRougeNodeChangeAnimDoneWork", BaseWork)

function Rouge2_WaitRougeNodeChangeAnimDoneWork:ctor()
	return
end

function Rouge2_WaitRougeNodeChangeAnimDoneWork:onStart()
	local mapInfo = Rouge2_MapModel.instance:getFinalMapInfo()

	if not mapInfo then
		return self:onDone(true)
	end

	Rouge2_MapModel.instance:updateMapInfo(mapInfo)
	Rouge2_MapModel.instance:setFinalMapInfo(nil)

	return self:onDone(true)
end

return Rouge2_WaitRougeNodeChangeAnimDoneWork
