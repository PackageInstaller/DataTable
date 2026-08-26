-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongSavePointComp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongSavePointComp", package.seeall)

local V3a8EchoSongSavePointComp = class("V3a8EchoSongSavePointComp", V3a8EchoSongBaseComp)

function V3a8EchoSongSavePointComp:_onInitComp()
	self._recordInfo.isShow = true
end

function V3a8EchoSongSavePointComp:isActivated()
	return self._recordInfo.isShow
end

function V3a8EchoSongSavePointComp:rollback(info)
	self._rawRecordInfo = self._rawRecordInfo or self:getRecordInfo()
	info = info or tabletool.copy(self._rawRecordInfo)
	self._recordInfo = info
end

function V3a8EchoSongSavePointComp:_checkMainPlayerInBounds()
	return self._recordInfo.isShow
end

function V3a8EchoSongSavePointComp:_mainPlayerInBounds()
	self._recordInfo.isShow = false

	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.FinishSavePoint, self._id)
end

function V3a8EchoSongSavePointComp:_showTriggerEffect()
	return true
end

return V3a8EchoSongSavePointComp
