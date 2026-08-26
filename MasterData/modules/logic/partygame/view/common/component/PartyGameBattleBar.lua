-- chunkname: @modules/logic/partygame/view/common/component/PartyGameBattleBar.lua

module("modules.logic.partygame.view.common.component.PartyGameBattleBar", package.seeall)

local PartyGameBattleBar = class("PartyGameBattleBar", PartyGameCompBase)

function PartyGameBattleBar:onInit()
	self._anim = gohelper.findChildAnim(self.viewGO, "root")
end

function PartyGameBattleBar:onSetData(data)
	if not data then
		return
	end

	self.partyGameCountDownData = data.partyGameCountDownData

	if self.partyGameCountDownData then
		self.getCountDownFunc = self.partyGameCountDownData.getCountDownFunc
		self.context = self.partyGameCountDownData.context
	end

	self:setTimeActive(true)
end

function PartyGameBattleBar:onViewUpdate(logicFrame)
	if self.getCountDownFunc then
		local time = self.getCountDownFunc(self.context)

		if time then
			self:setTimeActive(true, logicFrame and logicFrame <= 10)
		else
			self:setTimeActive(false, logicFrame and logicFrame <= 10)
		end
	else
		self._isActive = true
	end
end

function PartyGameBattleBar:setTimeActive(isActive, isForce)
	if isActive ~= self._isActive or isForce then
		if isActive then
			if self._anim then
				self._anim:Play("in")
			end
		elseif self._anim then
			self._anim:Play("out", 0, isForce and 1 or 0)
		end
	end

	self._isActive = isActive
end

return PartyGameBattleBar
