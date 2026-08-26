-- chunkname: @modules/logic/meilanni/controller/MeilanniAnimationController.lua

module("modules.logic.meilanni.controller.MeilanniAnimationController", package.seeall)

local MeilanniAnimationController = class("MeilanniAnimationController", BaseController)

MeilanniAnimationController.historyLayer = 1
MeilanniAnimationController.excludeRulesLayer = 2
MeilanniAnimationController.epilogueLayer = 3
MeilanniAnimationController.changeMapLayer = 4
MeilanniAnimationController.changeWeatherLayer = 5
MeilanniAnimationController.showElementsLayer = 6
MeilanniAnimationController.prefaceLayer = 7
MeilanniAnimationController.enemyLayer = 8
MeilanniAnimationController.endLayer = 9
MeilanniAnimationController.maxLayer = 9

function MeilanniAnimationController:onInit()
	self._isPlaying = nil
	self._isPlayingDialogItemList = nil
	self._delayCallList = {}
end

function MeilanniAnimationController:onInitFinish()
	return
end

function MeilanniAnimationController:addConstEvents()
	return
end

function MeilanniAnimationController:reInit()
	self._isPlaying = nil
	self._isPlayingDialogItemList = nil
	self._delayCallList = {}
end

function MeilanniAnimationController:startDialogListAnim()
	self._isPlayingDialogItemList = true
end

function MeilanniAnimationController:endDialogListAnim()
	self._isPlayingDialogItemList = nil
end

function MeilanniAnimationController:isPlayingDialogListAnim()
	return self._isPlayingDialogItemList
end

function MeilanniAnimationController:addDelayCall(callback, callbackTarget, param, time, layer)
	if not self._isPlaying then
		callback(callbackTarget, param)

		return
	end

	local param = {
		callback,
		callbackTarget,
		param,
		time
	}

	if not self._delayCallList[layer] then
		self._delayCallList[layer] = self._delayCallList[layer]

		table.insert(self._delayCallList[layer], param)
	end
end

function MeilanniAnimationController:startAnimation()
	self._isPlaying = true

	TaskDispatcher.runRepeat(self._frame, self, 0)
	self:dispatchEvent(MeilanniEvent.dialogListAnimChange, self._isPlaying)
end

function MeilanniAnimationController:_frame()
	if self._isPlayingDialogItemList or ViewMgr.instance:isOpen(ViewName.MeilanniBossInfoView) then
		return
	end

	local firstObj = self:_getFirstCall()

	if not firstObj then
		return
	end

	if not firstObj._startTime then
		firstObj._startTime = Time.realtimeSinceStartup

		return
	end

	if not firstObj[4] then
		local callback, callbackTarget, param, time = firstObj[1], firstObj[2], firstObj[3], 0

		if firstObj[4] <= Time.realtimeSinceStartup - firstObj._startTime then
			firstObj = self:_getFirstCall(true)

			callback(callbackTarget, param)
		end
	end
end

function MeilanniAnimationController:_getFirstCall(remove)
	for i = 1, MeilanniAnimationController.maxLayer do
		local list = self._delayCallList[i]

		if list and #list > 0 then
			if remove then
				return table.remove(list, 1)
			else
				return list[1]
			end
		end
	end

	return nil
end

function MeilanniAnimationController:endAnimation(layer)
	self.addDelayCall(self, self._endAnimation, self, nil, nil, layer)
end

function MeilanniAnimationController:_endAnimation()
	self._isPlaying = false

	TaskDispatcher.cancelTask(self._frame, self)
	self:dispatchEvent(MeilanniEvent.dialogListAnimChange, self._isPlaying)
end

function MeilanniAnimationController:isPlaying()
	return self._isPlaying
end

function MeilanniAnimationController:close()
	TaskDispatcher.cancelTask(self._frame, self)
	self:reInit()
end

MeilanniAnimationController.instance = MeilanniAnimationController.New()

return MeilanniAnimationController
