-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongTrapComp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongTrapComp", package.seeall)

local V3a8EchoSongTrapComp = class("V3a8EchoSongTrapComp", V3a8EchoSongBaseComp)

function V3a8EchoSongTrapComp:_onInitComp()
	self._recordInfo.isShow = self._go.activeSelf

	gohelper.setActive(self._go, true)

	local path = self._view.viewContainer:getSetting().otherRes.trapMask

	self._trapMaskGo = self._view:getResInst(path, self._go)

	gohelper.setActive(self._trapMaskGo, self._recordInfo.isShow)

	self._passStatus = V3a8EchoSongEnum.TrapPassStatus.None

	TaskDispatcher.cancelTask(self._frameUpdate, self)
	TaskDispatcher.runRepeat(self._frameUpdate, self, 0)
end

function V3a8EchoSongTrapComp:onDestroy()
	TaskDispatcher.cancelTask(self._frameUpdate, self)
end

function V3a8EchoSongTrapComp:_frameUpdate()
	if not self._recordInfo.isShow or not self._passTime then
		return
	end

	if self._passStatus == V3a8EchoSongEnum.TrapPassStatus.None and self._passTime then
		self._passStatus = V3a8EchoSongEnum.TrapPassStatus.Open

		self:_addSwitchEffect()

		if self._switchEffectAnimator then
			self._switchEffectAnimator:Play("red_open")
		end

		return
	end

	if self._passStatus == V3a8EchoSongEnum.TrapPassStatus.Open then
		if Time.time - self._passTime > 1 then
			self._passStatus = V3a8EchoSongEnum.TrapPassStatus.Close
			self._passTime = Time.time

			if self._switchEffectAnimator then
				self._switchEffectAnimator:Play("red_close")
			end
		end

		return
	end

	if self._passStatus == V3a8EchoSongEnum.TrapPassStatus.Close and Time.time - self._passTime >= 0.3 then
		self._passTime = nil
		self._passStatus = V3a8EchoSongEnum.TrapPassStatus.None

		gohelper.setActive(self._switchEffectGo, false)
	end
end

function V3a8EchoSongTrapComp:isActivated()
	return self._recordInfo.isShow
end

function V3a8EchoSongTrapComp:rollback(info)
	self._rawRecordInfo = self._rawRecordInfo or self:getRecordInfo()
	info = info or tabletool.copy(self._rawRecordInfo)
	self._recordInfo = info
	self._isFailed = false
	self._passStatus = V3a8EchoSongEnum.TrapPassStatus.None
	self._passTime = nil

	gohelper.setActive(self._trapMaskGo, self._recordInfo.isShow)
	gohelper.setActive(self._switchEffectGo, false)
end

function V3a8EchoSongTrapComp:_checkMainPlayerInBounds()
	if V3a8EchoSongController.instance:isGameOver() then
		return false
	end

	return not self._isFailed and self._recordInfo.isShow
end

function V3a8EchoSongTrapComp:_mainPlayerInBounds()
	self._isFailed = true

	V3a8EchoSongController.instance:dispatchGameResult(false)
end

function V3a8EchoSongTrapComp:_showTriggerEffect()
	return true
end

function V3a8EchoSongTrapComp:setTrigger(type)
	if type == V3a8EchoSongEnum.TrapTriggerType.Auto then
		self._recordInfo.isShow = not self._recordInfo.isShow
	elseif type == V3a8EchoSongEnum.TrapTriggerType.Open then
		self._recordInfo.isShow = true
	elseif type == V3a8EchoSongEnum.TrapTriggerType.Close then
		self._recordInfo.isShow = false
	end

	gohelper.setActive(self._trapMaskGo, self._recordInfo.isShow)

	if self._recordInfo.isShow then
		self._passStatus = V3a8EchoSongEnum.TrapPassStatus.None
		self._passTime = Time.time
	else
		self:_addSwitchEffect(nil, "unlock")

		self._passStatus = V3a8EchoSongEnum.TrapPassStatus.None
		self._passTime = nil
	end
end

function V3a8EchoSongTrapComp:_onSwitchEffectUnlock()
	gohelper.setActive(self._switchNodeRed, self._recordInfo.isShow)

	local showGreenEffect = V3a8EchoSongModel.instance:getBgType() == V3a8EchoSongEnum.BgType.Green

	gohelper.setActive(self._switchNodeGreen, not self._recordInfo.isShow and showGreenEffect)
	gohelper.setActive(self._switchNodePurple, not self._recordInfo.isShow and not showGreenEffect)
end

function V3a8EchoSongTrapComp:checkBallInBounds(ballItem)
	if not self._recordInfo.isShow then
		return
	end

	if self._passStatus == V3a8EchoSongEnum.TrapPassStatus.Close then
		return
	end

	if self._passStatus == V3a8EchoSongEnum.TrapPassStatus.Open and self._passTime and Time.time - self._passTime <= 0.8 then
		return
	end

	local worldPos = ballItem:getPos()
	local target = self:_getBoundsTarget()

	if not target then
		return
	end

	local localPos = target:InverseTransformPoint(worldPos.x, worldPos.y, 0)

	self._tempCheckPos.x = localPos.x
	self._tempCheckPos.y = localPos.y

	if self._checkRect:Contains(self._tempCheckPos) then
		self._passTime = Time.time
	end
end

return V3a8EchoSongTrapComp
