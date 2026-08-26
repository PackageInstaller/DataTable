-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongEndPointComp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongEndPointComp", package.seeall)

local V3a8EchoSongEndPointComp = class("V3a8EchoSongEndPointComp", V3a8EchoSongBaseComp)

function V3a8EchoSongEndPointComp:getRecordInfo()
	return nil
end

function V3a8EchoSongEndPointComp:_onInitComp()
	local path = self._view.viewContainer:getSetting().otherRes.endItem

	self._endItemGo = self._view:getResInst(path, self._go)
	self._go.name = "endItem"

	local scale = 1 / V3a8EchoSongEnum.SceneScale

	transformhelper.setLocalScale(self._go.transform, scale, scale, 1)

	local nodeEnd = gohelper.findChild(self._endItemGo, "Image_End/node_end")

	self._projAnimator = ZProj.ProjAnimatorPlayer.Get(nodeEnd)
	self._greenEffect = gohelper.findChild(self._endItemGo, "Image_End/node_end/vx_glow_green")
	self._purpleEffect = gohelper.findChild(self._endItemGo, "Image_End/node_end/vx_glow_purple")

	gohelper.setActive(self._greenEffect, false)
	gohelper.setActive(self._purpleEffect, false)

	self._isWin = false
end

function V3a8EchoSongEndPointComp:rollback(info)
	self._isWin = false
	self._inBoundsState = false

	if self._projAnimator then
		self._projAnimator:Play("open")
	end

	gohelper.setActive(self._greenEffect, false)
	gohelper.setActive(self._purpleEffect, false)
end

function V3a8EchoSongEndPointComp:_checkMainPlayerInBounds()
	return not self._isWin
end

function V3a8EchoSongEndPointComp:_mainPlayerInBounds()
	if V3a8EchoSongController.instance:isGameOver() then
		return
	end

	self._isWin = true

	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.MainPlayerWin)
	V3a8EchoSongController.instance:setGameResult(true)
	self._projAnimator:Play("finish", self._finishAnimDone, self)

	local showGreenEffect = V3a8EchoSongModel.instance:getBgType() == V3a8EchoSongEnum.BgType.Green

	gohelper.setActive(self._greenEffect, showGreenEffect)
	gohelper.setActive(self._purpleEffect, not showGreenEffect)
	AudioMgr.instance:trigger(V3a8EchoSongEnum.Audio.play_ui_shiji3_8_hsy_finish)
end

function V3a8EchoSongEndPointComp:_finishAnimDone()
	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.ShowResultView, true)
end

return V3a8EchoSongEndPointComp
