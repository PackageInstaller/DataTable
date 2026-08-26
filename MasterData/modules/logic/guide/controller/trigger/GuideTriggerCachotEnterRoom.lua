-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerCachotEnterRoom.lua

module("modules.logic.guide.controller.trigger.GuideTriggerCachotEnterRoom", package.seeall)

local GuideTriggerCachotEnterRoom = class("GuideTriggerCachotEnterRoom", BaseGuideTrigger)

function GuideTriggerCachotEnterRoom:ctor(triggerKey)
	GuideTriggerCachotEnterRoom.super.ctor(self, triggerKey)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, self._onUpdateRogueInfo, self)
end

function GuideTriggerCachotEnterRoom:_onUpdateRogueInfo()
	self:checkStartGuide()
end

function GuideTriggerCachotEnterRoom:assertGuideSatisfy(param, configParam)
	if not ViewMgr.instance:isOpen(ViewName.V1a6_CachotRoomView) then
		return
	end

	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not rogueInfo then
		return
	end

	local roomIndex, total = V1a6_CachotRoomConfig.instance:getRoomIndexAndTotal(rogueInfo.room)
	local paramList = string.splitToNumber(configParam, "_")
	local paramLayer = paramList[1]
	local paramRoomIndex = paramList[2]

	return paramLayer == rogueInfo.layer and paramRoomIndex == roomIndex
end

function GuideTriggerCachotEnterRoom:_onOpenView(viewName, viewParam)
	if viewName == ViewName.V1a6_CachotRoomView then
		self:checkStartGuide()
	end
end

return GuideTriggerCachotEnterRoom
