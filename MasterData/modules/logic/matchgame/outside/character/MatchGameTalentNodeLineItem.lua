-- chunkname: @modules/logic/matchgame/outside/character/MatchGameTalentNodeLineItem.lua

module("modules.logic.matchgame.outside.character.MatchGameTalentNodeLineItem", package.seeall)

local MatchGameTalentNodeLineItem = class("MatchGameTalentNodeLineItem", LuaCompBase)

function MatchGameTalentNodeLineItem:init(go)
	self.viewGO = go
	self.transform = self.viewGO.transform
	self._goActive = gohelper.findChild(self.viewGO, "go_Active")
	self._goUnactive = gohelper.findChild(self.viewGO, "go_Unactive")

	gohelper.setAsFirstSibling(self.viewGO)
end

function MatchGameTalentNodeLineItem:onUpdateMO(preTalentNodeItem, curTalentNodeItem)
	self._preTalentNodeItem = preTalentNodeItem
	self._curTalentNodeItem = curTalentNodeItem
	self._curNodeCo = curTalentNodeItem and curTalentNodeItem.data

	self:refreshStatus()
	self:setPosition()
end

function MatchGameTalentNodeLineItem:refreshStatus()
	self._status = MatchGameModel.instance:getTalentNodeStatus(self._curNodeCo.nodeId)

	gohelper.setActive(self._goActive, self._status >= MatchGameEnum.TalentNodeStatus.Unlock)
	gohelper.setActive(self._goUnactive, self._status < MatchGameEnum.TalentNodeStatus.Unlock)
	gohelper.setActive(self.viewGO, true)
end

function MatchGameTalentNodeLineItem:playUnlockEffect()
	gohelper.setActive(self._goActive, true)
	gohelper.setActive(self._goUnactive, false)
end

function MatchGameTalentNodeLineItem:setPosition()
	if not self._preTalentNodeItem or not self._curTalentNodeItem then
		return
	end

	local preTalentNodeX, preTalentNodeY = self._preTalentNodeItem:getPosition()
	local curTalentNodeX, curTalentNodeY = self._curTalentNodeItem:getPosition()
	local linePosX = (preTalentNodeX + curTalentNodeX) / 2
	local linePosY = (preTalentNodeY + curTalentNodeY) / 2
	local lineRotationZ = math.atan2(curTalentNodeY - preTalentNodeY, curTalentNodeX - preTalentNodeX) * 180 / math.pi

	recthelper.setAnchor(self.transform, linePosX, linePosY)
	transformhelper.setLocalRotation(self.transform, 0, 0, lineRotationZ)

	local lineLengthen = math.sqrt((curTalentNodeX - preTalentNodeX)^2 + (curTalentNodeY - preTalentNodeY)^2)

	recthelper.setWidth(self.transform, lineLengthen)
end

function MatchGameTalentNodeLineItem:onDestroy()
	return
end

return MatchGameTalentNodeLineItem
