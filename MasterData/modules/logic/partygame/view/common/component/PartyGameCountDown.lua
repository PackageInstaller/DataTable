-- chunkname: @modules/logic/partygame/view/common/component/PartyGameCountDown.lua

module("modules.logic.partygame.view.common.component.PartyGameCountDown", package.seeall)

local PartyGameCountDown = class("PartyGameCountDown", PartyGameCompBase)

function PartyGameCountDown:onInit()
	self._anim = gohelper.findComponentAnim(self.viewGO)
	self._txtnumcountdown1 = gohelper.findChildText(self.viewGO, "#go_TimeBG1/#txt_num_countdown")
	self._txtnumcountdown2 = gohelper.findChildText(self.viewGO, "#go_TimeBG2/#txt_num_countdown")
	self._txtnumcountdown3 = gohelper.findChildText(self.viewGO, "#go_TimeBG3/#txt_num_countdown")
end

function PartyGameCountDown:onAddListeners()
	return
end

function PartyGameCountDown:onRemoveListeners()
	return
end

function PartyGameCountDown:onSetData(data)
	if not data then
		return
	end

	self.getCountDownFunc = data.getCountDownFunc
	self.context = data.context

	self:setTimeActive(true)
	self:updateStyle()
end

function PartyGameCountDown:onViewUpdate(logicFrame)
	local timeStr

	if self.getCountDownFunc then
		local time = self.getCountDownFunc(self.context)

		if time then
			self:setTimeActive(true, logicFrame and logicFrame <= 10)

			timeStr = TimeUtil.second2TimeString(time)

			self:setCountDownTxt(timeStr)
			self:updateBg(time)
		else
			self:setTimeActive(false, logicFrame and logicFrame <= 10)
		end
	else
		local gameTime = self.gameInterfaceBaseCS.GetGameCountDownTime()

		timeStr = TimeUtil.second2TimeString(gameTime)

		self:setCountDownTxt(timeStr)
		self:setTimeActive(true)
		self:updateBg(gameTime)
	end

	if self._isTimeBgLimit and timeStr and self.timeStr ~= timeStr then
		AudioMgr.instance:trigger(AudioEnum3_4.PartyGameCommon.play_ui_bulaochun_countdown_once)
	end

	self.timeStr = timeStr
end

function PartyGameCountDown:updateBg(time)
	local gameCo = PartyGameController.instance:getCurPartyGame():getGameConfig()

	if not gameCo then
		return
	end

	local limitTime = gameCo.limitTime
	local isBlack = not limitTime or limitTime <= 0 or limitTime < time

	if isBlack ~= self._isTimeBgBlack then
		self._isTimeBgLimit = not isBlack

		self:updateStyle()
	end
end

function PartyGameCountDown:setIsAcc(isAcc)
	if self._isAcc == isAcc then
		return
	end

	self._isAcc = isAcc

	self:updateStyle()
end

function PartyGameCountDown:setTimeActive(isActive, isForce)
	self._isActive = isActive
end

function PartyGameCountDown:updateStyle()
	local style = self._isAcc and 2 or self._isTimeBgLimit and 1 or 3

	if self._isActive then
		if self._style == 1 and style == 2 then
			self._anim:Play("switch", 0, 0)
		elseif self._style == 2 and style == 1 then
			self._anim:Play("switch2", 0, 0)
		elseif self._style == 3 and style == 2 then
			self._anim:Play("switch3", 0, 0)
		elseif self._style == 2 and style == 3 then
			self._anim:Play("switch4", 0, 0)
		elseif self._style == 3 and style == 1 then
			self._anim:Play("switch5", 0, 0)
		end
	end

	self._style = style
end

function PartyGameCountDown:setCountDownTxt(txt)
	for i = 1, 3 do
		local countDown = self["_txtnumcountdown" .. i]

		countDown.text = txt
	end
end

return PartyGameCountDown
