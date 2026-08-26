-- chunkname: @modules/logic/partygame/view/carddrop/timeline/timelinebehaviour/CardDropTimelineBehaviourBase.lua

module("modules.logic.partygame.view.carddrop.timeline.timelinebehaviour.CardDropTimelineBehaviourBase", package.seeall)

local CardDropTimelineBehaviourBase = class("CardDropTimelineBehaviourBase", UserDataDispose)

function CardDropTimelineBehaviourBase:init()
	self:__onInit()

	self.interface = PartyGameCSDefine.CardDropInterfaceCs
end

function CardDropTimelineBehaviourBase:setPlayerUid(uid)
	self.uid = uid
	self.entity = CardDropGameController.instance:getEntity(uid)
end

function CardDropTimelineBehaviourBase:getEntity(attackSide)
	local entity

	if attackSide == CardDropEnum.AttackSide.Attacker then
		entity = self.entity
	else
		local defenderUid = self.interface.GetOppositeUid(self.uid)

		entity = CardDropGameController.instance:getEntity(defenderUid)
	end

	return entity
end

function CardDropTimelineBehaviourBase:getType()
	return CardDropBehaviourType.Type.Move
end

function CardDropTimelineBehaviourBase:onBehaviourStart(type, id, duration, paramStr)
	return
end

function CardDropTimelineBehaviourBase:getTypeName()
	local type = self:getType()

	for name, value in pairs(CardDropBehaviourType.Type) do
		if value == type then
			return name
		end
	end
end

function CardDropTimelineBehaviourBase:onBehaviourEnd()
	return
end

function CardDropTimelineBehaviourBase:onTimelineEnd()
	return
end

function CardDropTimelineBehaviourBase:destroy()
	self:__onDispose()
end

return CardDropTimelineBehaviourBase
