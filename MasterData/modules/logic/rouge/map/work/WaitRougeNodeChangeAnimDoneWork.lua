-- chunkname: @modules/logic/rouge/map/work/WaitRougeNodeChangeAnimDoneWork.lua

module("modules.logic.rouge.map.work.WaitRougeNodeChangeAnimDoneWork", package.seeall)

local WaitRougeNodeChangeAnimDoneWork = class("WaitRougeNodeChangeAnimDoneWork", BaseWork)

function WaitRougeNodeChangeAnimDoneWork:ctor()
	return
end

function WaitRougeNodeChangeAnimDoneWork:onStart()
	local mapInfo = RougeMapModel.instance:getFinalMapInfo()

	if not mapInfo then
		return self:onDone(true)
	end

	RougeMapModel.instance:updateMapInfo(mapInfo)
	RougeMapModel.instance:setFinalMapInfo(nil)

	return self:onDone(true)
end

return WaitRougeNodeChangeAnimDoneWork
