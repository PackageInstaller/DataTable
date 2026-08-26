-- chunkname: @modules/logic/partygame/view/common/component/PartyGameRoundTip.lua

module("modules.logic.partygame.view.common.component.PartyGameRoundTip", package.seeall)

local PartyGameRoundTip = class("PartyGameRoundTip", PartyGameCompBase)

function PartyGameRoundTip:onInit()
	self._anim = gohelper.findComponentAnim(self.viewGO)
	self._txtnum1 = gohelper.findChildText(self.viewGO, "node_number/#txt_num1")
	self._txtnum3 = gohelper.findChildText(self.viewGO, "node_number/#txt_num3")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "node_number/#txt_num2")

	self:setIsShow(false)
end

function PartyGameRoundTip:onAddListeners()
	return
end

function PartyGameRoundTip:onRemoveListeners()
	return
end

function PartyGameRoundTip:setContent(content)
	return
end

function PartyGameRoundTip:setRoundData(now, total)
	if now and now >= 0 then
		self:setIsShow(true)

		if self._now ~= now then
			self._now = now

			if now == 1 then
				AudioMgr.instance:trigger(AudioEnum3_4.PartyGame.roundfirst)
			else
				TaskDispatcher.runDelay(self._delayPlayAudio, self, 0.5)
			end

			if now > 1 then
				self._anim:Play("go_round", 0, 0)
			end

			self._txtnum1.text = math.max(1, now - 1)
			self._txtnum3.text = now
			self._txtnum2.text = total
		end
	else
		self:setIsShow(false)
	end
end

function PartyGameRoundTip:_delayPlayAudio()
	AudioMgr.instance:trigger(AudioEnum3_4.PartyGame.roundchange)
end

function PartyGameRoundTip:onDestroy()
	TaskDispatcher.cancelTask(self._delayPlayAudio, self)
	PartyGameRoundTip.super.onDestroy(self)
end

return PartyGameRoundTip
