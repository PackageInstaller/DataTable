-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongEvent1Comp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongEvent1Comp", package.seeall)

local V3a8EchoSongEvent1Comp = class("V3a8EchoSongEvent1Comp", V3a8EchoSongBaseComp)

function V3a8EchoSongEvent1Comp:_onInitComp()
	self._recordInfo.isShow = true

	local path = self._view.viewContainer:getSetting().otherRes.event1Mask

	self._eventMaskGo = self._view:getResInst(path, self._go)

	gohelper.setActive(self._eventMaskGo, self._recordInfo.isShow)
end

function V3a8EchoSongEvent1Comp:isActivated()
	return self._recordInfo.isShow
end

function V3a8EchoSongEvent1Comp:rollback(info)
	self._rawRecordInfo = self._rawRecordInfo or self:getRecordInfo()
	info = info or tabletool.copy(self._rawRecordInfo)
	self._recordInfo = info

	gohelper.setActive(self._eventMaskGo, self._recordInfo.isShow)
end

function V3a8EchoSongEvent1Comp:_checkMainPlayerInBounds()
	return self._recordInfo.isShow
end

function V3a8EchoSongEvent1Comp:_mainPlayerInBounds()
	self._recordInfo.isShow = false

	gohelper.setActive(self._eventMaskGo, self._recordInfo.isShow)
	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.FinishEvent1, self._id)
end

function V3a8EchoSongEvent1Comp:_showTriggerEffect()
	return true
end

return V3a8EchoSongEvent1Comp
