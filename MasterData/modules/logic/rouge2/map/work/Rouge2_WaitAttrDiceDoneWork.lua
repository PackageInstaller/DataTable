-- chunkname: @modules/logic/rouge2/map/work/Rouge2_WaitAttrDiceDoneWork.lua

module("modules.logic.rouge2.map.work.Rouge2_WaitAttrDiceDoneWork", package.seeall)

local Rouge2_WaitAttrDiceDoneWork = class("Rouge2_WaitAttrDiceDoneWork", BaseWork)

function Rouge2_WaitAttrDiceDoneWork:ctor()
	return
end

function Rouge2_WaitAttrDiceDoneWork:onStart()
	local isAttrCheck = Rouge2_MapAttrCheckHelper.isAttrCheckInteract()

	if not isAttrCheck then
		return self:onDone(true)
	end

	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onClearInteract, self.onClearInteract, self)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onUpdateMapInfo, self.onUpdateMapInfo, self)
	Rouge2_MapInteractHelper.triggerInteractive()
end

function Rouge2_WaitAttrDiceDoneWork:onClearInteract()
	self:clearAllEvents()
	self:onDone(true)
end

function Rouge2_WaitAttrDiceDoneWork:onUpdateMapInfo()
	local isAttrCheck = Rouge2_MapAttrCheckHelper.isAttrCheckInteract()

	if not isAttrCheck then
		return self:onDone(true)
	end
end

function Rouge2_WaitAttrDiceDoneWork:clearWork()
	self:clearAllEvents()
end

function Rouge2_WaitAttrDiceDoneWork:clearAllEvents()
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onClearInteract, self.onClearInteract, self)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onUpdateMapInfo, self.onUpdateMapInfo, self)
end

return Rouge2_WaitAttrDiceDoneWork
