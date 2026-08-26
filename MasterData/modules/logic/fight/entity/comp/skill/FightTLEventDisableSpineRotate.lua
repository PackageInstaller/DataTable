-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventDisableSpineRotate.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventDisableSpineRotate", package.seeall)

local FightTLEventDisableSpineRotate = class("FightTLEventDisableSpineRotate", FightTimelineTrackItem)

function FightTLEventDisableSpineRotate:onTrackStart(fightStepData, duration, paramsArr)
	self:_disable()
end

function FightTLEventDisableSpineRotate:onTrackEnd()
	self:_enable()
end

function FightTLEventDisableSpineRotate:_enable()
	self:_do(true)
end

function FightTLEventDisableSpineRotate:_disable()
	self:_do(false)
end

function FightTLEventDisableSpineRotate:_do(enable)
	local entityMgr = FightGameMgr.entityMgr

	entityMgr.enableSpineRotate = enable
end

return FightTLEventDisableSpineRotate
