-- chunkname: @modules/logic/guide/controller/GuidePriorityController.lua

module("modules.logic.guide.controller.GuidePriorityController", package.seeall)

local GuidePriorityController = class("GuidePriorityController", BaseController)

function GuidePriorityController:onInit()
	self._guideIdList = {}
	self._guideObjDict = {}
end

function GuidePriorityController:reInit()
	self._guideIdList = {}
	self._guideObjDict = {}

	TaskDispatcher.cancelTask(self._onFrame, self)
end

function GuidePriorityController:add(guideId, callback, callbackObj, delay)
	local delay = delay and delay > 0 and delay or 0.01
	local now = Time.time

	self._guideObjDict[guideId] = {
		guideId = guideId,
		callback = callback,
		callbackObj = callbackObj,
		time = now + delay
	}

	if not tabletool.indexOf(self._guideIdList, guideId) then
		table.insert(self._guideIdList, guideId)
	end

	local tdelay = delay

	for _, one in pairs(self._guideObjDict) do
		if tdelay < one.time - now then
			tdelay = one.time - now
		end
	end

	TaskDispatcher.cancelTask(self._onTimeEnd, self)
	TaskDispatcher.runDelay(self._onTimeEnd, self, tdelay)
end

function GuidePriorityController:remove(guideId)
	self._guideObjDict[guideId] = nil

	tabletool.removeValue(self._guideIdList, guideId)
end

function GuidePriorityController:_onTimeEnd()
	if #self._guideIdList == 0 then
		return
	end

	local guideIdList = self._guideIdList
	local guideObjDict = self._guideObjDict

	self._guideIdList = {}
	self._guideObjDict = {}

	local highestGuideId = GuideConfig.instance:getHighestPriorityGuideId(guideIdList)
	local highestGuideObj = guideObjDict[highestGuideId]

	if highestGuideObj then
		highestGuideObj.callback(highestGuideObj.callbackObj)
	end
end

GuidePriorityController.instance = GuidePriorityController.New()

return GuidePriorityController
