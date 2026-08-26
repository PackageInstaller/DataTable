-- chunkname: @modules/logic/versionactivity3_3/marsha/controller/MarshaSkillHelper.lua

module("modules.logic.versionactivity3_3.marsha.controller.MarshaSkillHelper", package.seeall)

local MarshaSkillHelper = class("MarshaSkillHelper")

function MarshaSkillHelper.CollideTriggerSkill(a, b, hitPos)
	local skillCoList = MarshaConfig.instance:getSkillCoList(a.config.skillIds)

	for _, skillCo in ipairs(skillCoList) do
		local condition = string.splitToNumber(skillCo.condition, "#")

		if skillCo.skillType == MarshaEnum.SkillType.Passive and tabletool.indexOf(condition, b.unitType) then
			local params = string.split(skillCo.effects, "#")
			local func = MarshaSkillHelper[params[1]]

			if func then
				func(a, b, params, hitPos)
			else
				logError("不存在技能效果" .. params[1])
			end
		end
	end
end

function MarshaSkillHelper.CompareWeight(a, b, param)
	if b.weight >= a.weight then
		local weight

		if tonumber(param[2]) == 1 then
			weight = b.weight + a.weight
		elseif tonumber(param[2]) == 2 then
			weight = b.weight - a.weight
		end

		b:setWeight(weight)
		a:setDead()
	else
		b:setDead()
	end
end

function MarshaSkillHelper.AddSpeed(a, b, param)
	local speed = tonumber(param[2])
	local time = tonumber(param[3]) / 1000

	b:setAddSpeed(speed, time)
end

function MarshaSkillHelper.AddBuff(a, b, param)
	local layer = tonumber(param[2])
	local time = tonumber(param[3]) / 1000

	b:addDeBuff(layer, time)
end

function MarshaSkillHelper.UnControl(a, b, param, hitPos)
	local time = tonumber(param[2]) / 1000
	local speed = tonumber(param[3])

	a:playAnim("shake")
	a:setUnControl(time, hitPos)
	b:setUnControl(time, hitPos, speed)
	AudioMgr.instance:trigger(AudioEnum3_3.Marsha.play_ui_yuanzheng_mrs_hit)
end

function MarshaSkillHelper.Kill(a, b)
	a:setDead()
	b:setDead()
end

function MarshaSkillHelper.AddWeight(a, b)
	local weight = b.weight + a.weight

	b:setWeight(weight)
	a:setDead()
end

function MarshaSkillHelper.Weightadd(a, b, param)
	local weight = a.weight + tonumber(param[2])

	a:setWeight(weight)
	b:setDead()
end

function MarshaSkillHelper.Adsorb(_, b, param, conditions)
	local dis = tonumber(param[2])
	local time = tonumber(param[3]) / 1000

	b:setAdsorb(time, dis, conditions)
end

function MarshaSkillHelper.UseSkill(skillId)
	local skillCo = MarshaConfig.instance:getSkillConfig(skillId)

	if skillCo then
		local conditions = string.splitToNumber(skillCo.condition, "#")
		local params = string.split(skillCo.effects, "#")
		local func = MarshaSkillHelper[params[1]]

		if not func then
			logError("不存在技能效果" .. params[1])

			return
		end

		local playerEntity = MarshaEntityMgr.instance:getPlayerEntity()

		func(nil, playerEntity, params, conditions)
	end
end

return MarshaSkillHelper
