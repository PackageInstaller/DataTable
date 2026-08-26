-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9DungeonMapNodeItem.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapNodeItem", package.seeall)

local VersionActivity2_9DungeonMapNodeItem = class("VersionActivity2_9DungeonMapNodeItem", LuaCompBase)

function VersionActivity2_9DungeonMapNodeItem:ctor(params)
	self._index = params and params.index
	self._gomesh = params and params.meshGO
end

function VersionActivity2_9DungeonMapNodeItem:init(go)
	self.go = go
	self._goselectnode = gohelper.findChild(self.go, "select")
	self._gounselectnode = gohelper.findChild(self.go, "unselect")
	self._gonode = gohelper.cloneInPlace(self._gounselectnode, "current")
	self._trannode = self._gonode.transform
	self._transelectnode = self._goselectnode.transform
	self._tranunselectnode = self._gounselectnode.transform
	self._animator = gohelper.onceAddComponent(self._gomesh, gohelper.Type_Animator)
end

function VersionActivity2_9DungeonMapNodeItem:addEventListeners()
	return
end

function VersionActivity2_9DungeonMapNodeItem:removeEventListeners()
	return
end

function VersionActivity2_9DungeonMapNodeItem:brocastPosition()
	local posX, posY, posZ = self:getNodeWorldPos()

	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnUpdateEpisodeNodePos, self._index, posX, posY, posZ)
end

function VersionActivity2_9DungeonMapNodeItem:getNodeLocalPos()
	return transformhelper.getLocalPos(self._trannode)
end

function VersionActivity2_9DungeonMapNodeItem:getNodeWorldPos()
	return transformhelper.getPos(self._trannode)
end

function VersionActivity2_9DungeonMapNodeItem:onSelect(isSelect)
	local animClicpName = isSelect and "selection_open" or "selection_close"

	self._animator:Play(animClicpName, 0, 0)
	self:tweenMoveNodePos(isSelect)

	if isSelect then
		AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_selectEpisode)
	end
end

function VersionActivity2_9DungeonMapNodeItem:tweenMoveNodePos(isSelect)
	self:_killNodeMoveTween()

	local curLocalPosX, curLocalPosY, curLocalPosZ = self:getNodeLocalPos()

	if isSelect then
		if not self._transelectnode then
			local targetNodeTran = self._tranunselectnode
			local targetLocalPosX, targetLocalPosY, targetLocalPosZ = transformhelper.getLocalPos(targetNodeTran)
			local duration = VersionActivity2_9DungeonEnum.EpisodeSelectDuration

			self._tweenId_x = ZProj.TweenHelper.DOTweenFloat(curLocalPosX, targetLocalPosX, duration, self._tweenMoveNodePosXFrameCb, self._tweenMoveNodePosDone, self)
			self._tweenId_y = ZProj.TweenHelper.DOTweenFloat(curLocalPosY, targetLocalPosY, duration, self._tweenMoveNodePosYFrameCb, self._tweenMoveNodePosDone, self)
			self._tweenId_z = ZProj.TweenHelper.DOTweenFloat(curLocalPosZ, targetLocalPosZ, duration, self._tweenMoveNodePosZFrameCb, self._tweenMoveNodePosDone, self)
		end
	end
end

function VersionActivity2_9DungeonMapNodeItem:_tweenMoveNodePosXFrameCb(nodeLocalPosX)
	local _, curLocalPosY, curLocalPosZ = self:getNodeLocalPos()

	transformhelper.setLocalPos(self._trannode, nodeLocalPosX, curLocalPosY, curLocalPosZ)
	self:brocastPosition()
end

function VersionActivity2_9DungeonMapNodeItem:_tweenMoveNodePosYFrameCb(nodeLocalPosY)
	local curLocalPosX, _, curLocalPosZ = self:getNodeLocalPos()

	transformhelper.setLocalPos(self._trannode, curLocalPosX, nodeLocalPosY, curLocalPosZ)
	self:brocastPosition()
end

function VersionActivity2_9DungeonMapNodeItem:_tweenMoveNodePosZFrameCb(nodeLocalPosZ)
	local curLocalPosX, curLocalPosY = self:getNodeLocalPos()

	transformhelper.setLocalPos(self._trannode, curLocalPosX, curLocalPosY, nodeLocalPosZ)
	self:brocastPosition()
end

function VersionActivity2_9DungeonMapNodeItem:_tweenMoveNodePosDone()
	return
end

function VersionActivity2_9DungeonMapNodeItem:_killNodeMoveTween()
	if self._tweenId_x then
		ZProj.TweenHelper.KillById(self._tweenId_x)

		self._tweenId_x = nil
	end

	if self._tweenId_y then
		ZProj.TweenHelper.KillById(self._tweenId_y)

		self._tweenId_y = nil
	end

	if self._tweenId_z then
		ZProj.TweenHelper.KillById(self._tweenId_z)

		self._tweenId_z = nil
	end
end

function VersionActivity2_9DungeonMapNodeItem:onDestroy()
	self:_killNodeMoveTween()

	self._gomesh = nil
end

return VersionActivity2_9DungeonMapNodeItem
