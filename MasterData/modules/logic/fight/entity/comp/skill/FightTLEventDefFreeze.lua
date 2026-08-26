-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventDefFreeze.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventDefFreeze", package.seeall)

local FightTLEventDefFreeze = class("FightTLEventDefFreeze", FightTimelineTrackItem)
local FreezeEffectActType = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.HEAL] = true,
	[FightEnum.EffectType.HEALCRIT] = true,
	[FightEnum.EffectType.BUFFADD] = true,
	[FightEnum.EffectType.BUFFUPDATE] = true,
	[FightEnum.EffectType.SHIELD] = true
}

function FightTLEventDefFreeze:onTrackStart(fightStepData, duration, paramsArr)
	local durationFix = duration * FightModel.instance:getSpeed()

	self._action = paramsArr[1]

	local startTime = tonumber(paramsArr[2]) or 0

	self._defenders = self:_getDefenders(fightStepData, paramsArr[3])

	if not string.nilorempty(self._action) then
		for _, oneDefender in ipairs(self._defenders) do
			oneDefender.spine:play(self._action, false, true)
		end
	end

	if startTime < durationFix then
		if startTime == 0 then
			self:_startFreeze()
		else
			local startTimeFix = startTime / FightModel.instance:getSpeed()

			TaskDispatcher.runDelay(self._startFreeze, self, startTimeFix)
		end
	else
		logWarn("Skill Freeze param invalid, startTime >= duration")
	end
end

function FightTLEventDefFreeze:onTrackEnd()
	self:_onDurationEnd()
end

function FightTLEventDefFreeze:_getDefenders(fightStepData, filter_type)
	local _type = 2
	local target_dic = {}

	if not string.nilorempty(filter_type) then
		_type = tonumber(string.split(filter_type, "#")[1])
	end

	local defenders = {}

	for _, actEffectData in ipairs(fightStepData.actEffect) do
		if FreezeEffectActType[actEffectData.effectType] then
			if _type == 1 then
				local oneDefender = FightHelper.getEntity(fightStepData.fromId)

				target_dic[oneDefender.id] = oneDefender
			elseif _type == 2 then
				local self_side = FightHelper.getEntity(fightStepData.fromId):getSide()
				local oneDefender = FightHelper.getEntity(actEffectData.targetId)

				if self_side ~= oneDefender:getSide() then
					target_dic[oneDefender.id] = oneDefender
				end
			elseif _type == 3 then
				local oneDefender = FightHelper.getEntity(fightStepData.fromId)
				local list = FightHelper.getSideEntitys(oneDefender:getSide())

				for i, v in ipairs(list) do
					target_dic[v.id] = v
				end
			elseif _type == 4 then
				local oneDefender = FightHelper.getEntity(fightStepData.toId)

				if oneDefender then
					local list = FightHelper.getSideEntitys(oneDefender:getSide())

					for i, v in ipairs(list) do
						target_dic[v.id] = v
					end
				end
			elseif _type == 5 then
				local list = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)

				for i, v in ipairs(list) do
					target_dic[v.id] = v
				end

				list = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)

				for i, v in ipairs(list) do
					target_dic[v.id] = v
				end
			elseif _type == 6 then
				local oneDefender = FightHelper.getEntity(fightStepData.toId)

				target_dic[oneDefender.id] = oneDefender
			elseif _type == 7 then
				local list = string.splitToNumber(filter_type, "#")

				for i = 2, #list do
					local oneDefender = FightHelper.getEntity(list[i])

					target_dic[oneDefender.id] = oneDefender
				end
			end
		end
	end

	for k, v in pairs(target_dic) do
		table.insert(defenders, v)
	end

	return defenders
end

function FightTLEventDefFreeze:_startFreeze()
	for _, defender in ipairs(self._defenders) do
		defender.spine:setFreeze(true)
	end
end

function FightTLEventDefFreeze:_onDurationEnd()
	for _, defender in ipairs(self._defenders) do
		if defender.spine:getAnimState() == self._action then
			defender:resetAnimState()
		end
	end

	self:onDestructor()
end

function FightTLEventDefFreeze:onDestructor()
	if self._defenders then
		for _, defender in ipairs(self._defenders) do
			defender.spine:setFreeze(false)
		end
	end

	self._defenders = nil

	TaskDispatcher.cancelTask(self._startFreeze, self)
end

return FightTLEventDefFreeze
