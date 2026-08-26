-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongEnemy1Comp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongEnemy1Comp", package.seeall)

local V3a8EchoSongEnemy1Comp = class("V3a8EchoSongEnemy1Comp", V3a8EchoSongBaseComp)

function V3a8EchoSongEnemy1Comp:getRecordInfo()
	return nil
end

function V3a8EchoSongEnemy1Comp:_onInitComp()
	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.Enemy1Init, {
		go = self._go,
		id = self._id
	})
end

return V3a8EchoSongEnemy1Comp
