-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uibubble/impl/BubbleBuffAddGroup.lua

module("logic.battle.uibubble.impl.BubbleBuffAddGroup", package.seeall)

local BubbleBuffAddGroup = class("BubbleBuffAddGroup", BubbleBase)

function BubbleBuffAddGroup:_getBubbleResourcePath()
	return BattleResourceName.UIBubbleBuffAddHint
end

function BubbleBuffAddGroup:buildUI()
	self._goodBubbleBuff = BubbleBuffAddHint.New(goutil.findChild(self.mainGO, "pos/blue"))
	self._badBubbleBuff = BubbleBuffAddHint.New(goutil.findChild(self.mainGO, "pos/red"))
	self._canvasGroup = self.mainGO:GetComponent(ComponentType.CanvasGroup)
end

function BubbleBuffAddGroup:destroyUI()
	self._goodBubbleBuff:destroyUI()
	self._badBubbleBuff:destroyUI()
end

function BubbleBuffAddGroup:getHeight()
	return 30
end

function BubbleBuffAddGroup:resetUI()
	self.mainGO.transform:DOKill(false)

	self._canvasGroup.alpha = 1
end

function BubbleBuffAddGroup:doBubble(dotweenHeight, time, ease)
	local mainGO = self.mainGO

	mainGO.transform:DOKill(false)
	mainGO.transform:DOAnchorPosY(self._posY + dotweenHeight, time):SetEase(ease)

	self._canvasGroup.alpha = 1

	self._canvasGroup:DOFade(0, time)
end

function BubbleBuffAddGroup:setBubbleContent(buffCode)
	local buffCO = BuffConfig.instance:getBuffCO(buffCode)
	local isGood = buffCO.isGood == 1

	self._goodBubbleBuff:setVisible(isGood)
	self._badBubbleBuff:setVisible(not isGood)

	if isGood then
		self._goodBubbleBuff:setBubbleContent(buffCode)
	else
		self._badBubbleBuff:setBubbleContent(buffCode)
	end
end

function BubbleBuffAddGroup:setPositionXY(x, y)
	self.super.setPositionXY(self, x, y)

	self._posY = y
end

return BubbleBuffAddGroup
