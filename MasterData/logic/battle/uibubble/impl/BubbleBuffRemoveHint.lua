-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uibubble/impl/BubbleBuffRemoveHint.lua

module("logic.battle.uibubble.impl.BubbleBuffRemoveHint", package.seeall)

local BubbleBuffRemoveHint = class("BubbleBuffRemoveHint", BubbleBase)

function BubbleBuffRemoveHint:_getBubbleResourcePath()
	return BattleResourceName.UIBubbleBuffRemoveHint
end

function BubbleBuffRemoveHint:buildUI()
	self._buffGroup = UIBattleBuffGroup.New(goutil.findChild(self.mainGO, "lay"))

	self._buffGroup:setLimitCount(99)
end

function BubbleBuffRemoveHint:destroyUI()
	self._buffGroup:destroy()
end

function BubbleBuffRemoveHint:getHeight()
	return 35
end

function BubbleBuffRemoveHint:resetUI()
	return
end

function BubbleBuffRemoveHint:setBubbleContent(buffTable)
	self._buffGroup:updateBuffTable(buffTable)
end

return BubbleBuffRemoveHint
