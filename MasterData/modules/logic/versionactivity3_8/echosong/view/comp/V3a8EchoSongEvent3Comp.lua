-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongEvent3Comp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongEvent3Comp", package.seeall)

local V3a8EchoSongEvent3Comp = class("V3a8EchoSongEvent3Comp", V3a8EchoSongBaseComp)

function V3a8EchoSongEvent3Comp:_onInitComp()
	local path = self._view.viewContainer:getSetting().otherRes.event2Mask

	self._eventMaskGo = self._view:getResInst(path, self._go)
end

function V3a8EchoSongEvent3Comp:getRecordInfo()
	return nil
end

function V3a8EchoSongEvent3Comp:_checkMainPlayerInBounds()
	return true
end

function V3a8EchoSongEvent3Comp:_mainPlayerInBounds()
	if self._inBounds then
		return
	end

	self._inBounds = true

	local params = self._paramList[4]
	local triggerType = params and params[1]

	if not triggerType then
		logError("V3a8EchoSongEvent3Comp triggerType is nil id:", tostring(self._id))

		return
	end

	if triggerType >= V3a8EchoSongEnum.TrapTriggerType.Auto and triggerType <= V3a8EchoSongEnum.TrapTriggerType.Close then
		for _, trapId in ipairs(self._params) do
			V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.Event3Trigger, trapId, triggerType)
		end
	else
		logError("V3a8EchoSongEvent3Comp triggerType error id:", tostring(self._id), tostring(triggerType))
	end
end

function V3a8EchoSongEvent3Comp:_mainPlayerOutOfBounds()
	self._inBounds = false
end

function V3a8EchoSongEvent3Comp:_showTriggerEffect()
	return true
end

return V3a8EchoSongEvent3Comp
