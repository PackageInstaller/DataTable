-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventSetTimelineTime.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventSetTimelineTime", package.seeall)

local FightTLEventSetTimelineTime = class("FightTLEventSetTimelineTime", FightTimelineTrackItem)

function FightTLEventSetTimelineTime:onTrackStart(fightStepData, duration, paramsArr)
	local time = tonumber(paramsArr[1])
	local canJump = time
	local entityMO = FightDataHelper.entityMgr:getById(fightStepData.fromId)

	if entityMO then
		local buffs = string.splitToNumber(paramsArr[2], "#")

		if #buffs > 0 then
			for i, v in ipairs(buffs) do
				for index, buffMO in pairs(entityMO:getBuffDic()) do
					if buffMO.buffId == v then
						canJump = false

						break
					end
				end

				if not canJump then
					break
				end
			end
		end
	end

	if not string.nilorempty(paramsArr[3]) then
		local skillArr = string.splitToNumber(paramsArr[3], "#")
		local find = false

		for i, skillId in ipairs(skillArr) do
			if skillId == fightStepData.actId then
				find = true
			end
		end

		if not find then
			canJump = false
		end
	end

	if canJump then
		self.binder:SetTime(time)
	end
end

function FightTLEventSetTimelineTime:onTrackEnd()
	return
end

function FightTLEventSetTimelineTime:onDestructor()
	return
end

return FightTLEventSetTimelineTime
