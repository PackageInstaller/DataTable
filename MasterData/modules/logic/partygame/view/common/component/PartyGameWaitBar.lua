-- chunkname: @modules/logic/partygame/view/common/component/PartyGameWaitBar.lua

module("modules.logic.partygame.view.common.component.PartyGameWaitBar", package.seeall)

local PartyGameWaitBar = class("PartyGameWaitBar", PartyGameCompBase)

function PartyGameWaitBar:onInit()
	self._txtplayerslider = gohelper.findChildText(self.viewGO, "#txt_player_slider")
	self._slider1 = gohelper.findChildImage(self.viewGO, "#img_wait")
	self._slider2 = gohelper.findChildImage(self.viewGO, "#img_wait2")
	self._anim = gohelper.findComponentAnim(self.viewGO)

	self:onUpdatePlayerCount(true)
end

function PartyGameWaitBar:onAddListeners()
	PartyGameController.instance:registerCallback(PartyGameEvent.readyPlayerNumPush, self.onUpdatePlayerCount, self)
end

function PartyGameWaitBar:onRemoveListeners()
	PartyGameController.instance:unregisterCallback(PartyGameEvent.readyPlayerNumPush, self.onUpdatePlayerCount, self)
end

function PartyGameWaitBar:onUpdatePlayerCount(isFirst)
	if self._isStartGame then
		return
	end

	local curCount = PartyGameModel.instance.curLoadedPlayerCount
	local maxCount = tabletool.len(PartyGameModel.instance:getCurGamePlayerList())

	self._txtplayerslider.text = string.format("%d/%d", curCount, maxCount)

	if isFirst and maxCount <= curCount then
		gohelper.setActive(self.viewGO, false)
	else
		self._anim:Play(maxCount <= curCount and "out" or "in")
	end

	if not self._prePlayerCount then
		self._prePlayerCount = curCount

		if curCount < maxCount then
			self._slider1.fillAmount = curCount / maxCount
			self._slider2.fillAmount = 0
		else
			self._slider1.fillAmount = 0
			self._slider2.fillAmount = 1
		end
	else
		ZProj.TweenHelper.KillByObj(self._slider1)
		ZProj.TweenHelper.KillByObj(self._slider2)

		if curCount < maxCount then
			ZProj.TweenHelper.DOFillAmount(self._slider1, curCount / maxCount, 0.2)

			self._slider2.fillAmount = 0
		else
			self._slider1.fillAmount = 0
			self._slider2.fillAmount = self._prePlayerCount / maxCount

			ZProj.TweenHelper.DOFillAmount(self._slider2, 1, 0.2)
		end
	end
end

function PartyGameWaitBar:onViewUpdate(logicFrame)
	if self._isStartGame then
		return
	end

	if logicFrame and logicFrame > 10 then
		PartyGameModel.instance.curLoadedPlayerCount = tabletool.len(PartyGameModel.instance:getCurGamePlayerList())

		self:onUpdatePlayerCount()

		self._isStartGame = true
	end
end

return PartyGameWaitBar
