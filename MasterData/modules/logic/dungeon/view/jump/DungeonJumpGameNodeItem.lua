-- chunkname: @modules/logic/dungeon/view/jump/DungeonJumpGameNodeItem.lua

module("modules.logic.dungeon.view.jump.DungeonJumpGameNodeItem", package.seeall)

local DungeonJumpGameNodeItem = class("DungeonJumpGameNodeItem", ListScrollCellExtend)

function DungeonJumpGameNodeItem:onInitView()
	self._goFightObj = gohelper.findChild(self.viewGO, "#go_Fight")
	self._imageNodeBg = gohelper.findChildImage(self.viewGO, "#image_Floor")
	self._btnFight = gohelper.findChildClickWithAudio(self.viewGO, "#go_Fight")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonJumpGameNodeItem:addEvents()
	self._btnFight:AddClickListener(self._clickFight, self)
end

function DungeonJumpGameNodeItem:removeEvents()
	self._btnFight:RemoveClickListener()
end

function DungeonJumpGameNodeItem:_clickFight()
	if self._onClickFightAction then
		self._onClickFightAction(self._onClickActionObj)
	end
end

function DungeonJumpGameNodeItem:setFightAction(action, obj)
	self._onClickFightAction = action
	self._onClickActionObj = obj
end

function DungeonJumpGameNodeItem:_editableInitView()
	return
end

function DungeonJumpGameNodeItem:onUpdateData(nodeData)
	self._x = nodeData.x
	self._y = nodeData.y
	self._type = nodeData.type

	UISpriteSetMgr.instance:setUiFBSprite(self._imageNodeBg, DungeonJumpGameEnum.JumoNodeBg[nodeData.bg])
	gohelper.setActive(self._goFightObj, nodeData.isBattle)
end

function DungeonJumpGameNodeItem:initNode()
	recthelper.setAnchor(self.viewGO.transform, self._x, self._y)
end

function DungeonJumpGameNodeItem:setNodeActive(active)
	gohelper.setActive(self.viewGO, active)
end

function DungeonJumpGameNodeItem:setNodeScale(x, y)
	transformhelper.setLocalScale(self._imageNodeBg.transform, x, y, 1)
end

function DungeonJumpGameNodeItem:_editableAddEvents()
	return
end

function DungeonJumpGameNodeItem:_editableRemoveEvents()
	return
end

function DungeonJumpGameNodeItem:onDestroyView()
	return
end

return DungeonJumpGameNodeItem
