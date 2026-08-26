-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventSpeed.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventSpeed", package.seeall)

local FightTLEventSpeed = class("FightTLEventSpeed", FightTimelineTrackItem)

function FightTLEventSpeed:onTrackStart(fightStepData, duration, paramsArr)
	local speed = tonumber(paramsArr[1])

	if speed then
		GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.FightTLEventSpeed, speed)
	else
		logError("变速帧参数有误")
	end
end

function FightTLEventSpeed:onTrackEnd()
	self:_resetSpeed()
end

function FightTLEventSpeed:_resetSpeed()
	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.FightTLEventSpeed, 1)
end

function FightTLEventSpeed:onDestructor()
	self:_resetSpeed()
end

return FightTLEventSpeed
