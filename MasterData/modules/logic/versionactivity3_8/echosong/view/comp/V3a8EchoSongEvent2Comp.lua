-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongEvent2Comp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongEvent2Comp", package.seeall)

local V3a8EchoSongEvent2Comp = class("V3a8EchoSongEvent2Comp", V3a8EchoSongBaseComp)

function V3a8EchoSongEvent2Comp:getRecordInfo()
	return nil
end

function V3a8EchoSongEvent2Comp:_onInitComp()
	self._tempPos = Vector3()
	self._checkDisance = 20
end

function V3a8EchoSongEvent2Comp:_checkMainPlayerInBounds()
	return true
end

function V3a8EchoSongEvent2Comp:_mainPlayerOutOfBounds()
	self._inBounds = false
end

function V3a8EchoSongEvent2Comp:_mainPlayerInBounds()
	if self._inBounds then
		return
	end

	self._inBounds = true

	local posX, posY = transformhelper.getPos(self._go.transform)

	self._tempPos.x = posX
	self._tempPos.y = posY

	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.EmittedParticle, self._tempPos, V3a8EchoSongEnum.ParticleType.Event2)
end

function V3a8EchoSongEvent2Comp:_showTriggerEffect()
	return true
end

return V3a8EchoSongEvent2Comp
