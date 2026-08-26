-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongWallComp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongWallComp", package.seeall)

local V3a8EchoSongWallComp = class("V3a8EchoSongWallComp", V3a8EchoSongBaseComp)

function V3a8EchoSongWallComp:_onInitComp()
	if not self._params then
		logError("V3a8EchoSongWallComp:_onInitComp params is nil", self._type, self._id)
	end

	self._recordInfo.isShow = true
	self._boxCollider = self._go:GetComponent(typeof(UnityEngine.BoxCollider2D))
end

function V3a8EchoSongWallComp:rollback(info)
	self._rawRecordInfo = self._rawRecordInfo or self:getRecordInfo()
	info = info or tabletool.copy(self._rawRecordInfo)
	self._recordInfo = info

	gohelper.setActive(self._go, self._recordInfo.isShow)

	self._boxCollider.enabled = self._recordInfo.isShow

	gohelper.setActive(self._switchEffectGo, false)

	self._unlockGo = nil
end

function V3a8EchoSongWallComp:addEventListeners()
	V3a8EchoSongWallComp.super.addEventListeners(self)
	V3a8EchoSongController.instance:registerCallback(V3a8EchoSongEvent.FinishEvent1, self._onFinishEvent1, self)
end

function V3a8EchoSongWallComp:removeEventListeners()
	V3a8EchoSongWallComp.super.removeEventListeners(self)
	V3a8EchoSongController.instance:unregisterCallback(V3a8EchoSongEvent.FinishEvent1, self._onFinishEvent1, self)
end

function V3a8EchoSongWallComp:_getBoundsTarget()
	return self._unlockGo and self._unlockGo.transform
end

function V3a8EchoSongWallComp:_checkMainPlayerInBounds()
	return not self._recordInfo.isShow and self._unlockGo
end

function V3a8EchoSongWallComp:_mainPlayerInBounds()
	self._unlockGo = nil

	if self._switchEffectAnimator then
		gohelper.setActive(self._switchEffectGo, true)
		self._switchEffectAnimator:Play("close", self._closeAnimDone, self)
	end
end

function V3a8EchoSongWallComp:_onFinishEvent1(id)
	if self._params and tabletool.indexOf(self._params, id) then
		self._recordInfo[id] = true

		for k, v in pairs(self._params) do
			if not self._recordInfo[v] then
				return
			end
		end

		self._recordInfo.isShow = false
		self._boxCollider.enabled = false

		local unlockGo = gohelper.findChild(self._go, "unlock")

		if unlockGo then
			local w, h = recthelper.getWidth(unlockGo.transform), recthelper.getHeight(unlockGo.transform)

			if w <= 0 or h <= 0 then
				logNormal("V3a8EchoSongWallComp: unlockGo w or h <= 0 不显示特效 id:", self._id)

				return
			end
		end

		self._unlockGo = unlockGo or self._go
		self._checkRect = self._unlockGo.transform.rect

		self:_addSwitchEffect(self._unlockGo, "loop")
	end
end

function V3a8EchoSongWallComp:_onSwitchEffectUnlock()
	gohelper.setActive(self._switchNodeRed, false)

	local showGreenEffect = V3a8EchoSongModel.instance:getBgType() == V3a8EchoSongEnum.BgType.Green

	gohelper.setActive(self._switchNodeGreen, not self._recordInfo.isShow and showGreenEffect)
	gohelper.setActive(self._switchNodePurple, not self._recordInfo.isShow and not showGreenEffect)
end

function V3a8EchoSongWallComp:_closeAnimDone()
	gohelper.setActive(self._switchEffectGo, false)
end

function V3a8EchoSongWallComp:_switchUnlockDone()
	return
end

return V3a8EchoSongWallComp
