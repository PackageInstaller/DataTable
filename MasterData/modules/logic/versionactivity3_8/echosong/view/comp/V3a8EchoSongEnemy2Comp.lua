-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongEnemy2Comp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongEnemy2Comp", package.seeall)

local V3a8EchoSongEnemy2Comp = class("V3a8EchoSongEnemy2Comp", V3a8EchoSongBaseComp)

function V3a8EchoSongEnemy2Comp:getRecordInfo()
	return nil
end

function V3a8EchoSongEnemy2Comp:_onInitComp()
	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.Enemy2Init, {
		go = self._go,
		id = self._id,
		wayPointList = self._params
	})
end

return V3a8EchoSongEnemy2Comp
