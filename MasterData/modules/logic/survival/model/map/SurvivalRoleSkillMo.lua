-- chunkname: @modules/logic/survival/model/map/SurvivalRoleSkillMo.lua

module("modules.logic.survival.model.map.SurvivalRoleSkillMo", package.seeall)

local SurvivalRoleSkillMo = pureTable("SurvivalRoleSkillMo")

function SurvivalRoleSkillMo:init(data)
	self.useCount = data.useCount
	self.maxUseCount = data.maxUseCount

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local roleInfo = weekInfo:getRoleInfo()
	local cfg = lua_survival_role.configDict[roleInfo.roleId]

	self.skillName = cfg.talentName
	self.skillId = cfg.skill
	self.skillCfg = lua_survival_role_skill.configDict[self.skillId]
	self.isUsing = false

	local effectStr = self.skillCfg.effect1
	local arr = string.split(effectStr, "#")

	self.skillEffectType = arr[1]
	self.skillEffectParam = arr
end

function SurvivalRoleSkillMo:onUseRoleSkill(info)
	if info.useCount then
		self.useCount = info.useCount
	end

	if info.maxUseCount then
		self.maxUseCount = info.maxUseCount
	end

	self:handleSkillFinish()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRoleSkillUpdate)
end

function SurvivalRoleSkillMo:handleSkillFinish()
	return
end

function SurvivalRoleSkillMo:getSkillRemainTimes()
	return self.useCount
end

function SurvivalRoleSkillMo:getSkillMaxTimes()
	return self.maxUseCount
end

function SurvivalRoleSkillMo:canUseSkill()
	if self:isSkillUsing() then
		return false
	end

	local remainTimes = self:getSkillRemainTimes()

	if remainTimes == 0 then
		return false
	end

	return true
end

function SurvivalRoleSkillMo:setIsUsing(isUsing)
	self.isUsing = isUsing
end

function SurvivalRoleSkillMo:isSkillUsing()
	return self.isUsing
end

function SurvivalRoleSkillMo:getSkillUseRange()
	local effectType = self.skillEffectType
	local arr = self.skillEffectParam
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local rangeAttr = weekInfo:getAttr(SurvivalEnum.AttrType.RangeFix)
	local skillRangeAttr = weekInfo:getAttr(SurvivalEnum.AttrType.SkillRangeFix)
	local useRange

	if effectType == SurvivalEnum.RoleSkillEffect.FindDrop then
		local range = tonumber(arr[3]) or 0

		if range == 0 then
			range = weekInfo:getAttr(SurvivalEnum.AttrType.Vision)
		end

		useRange = range + skillRangeAttr
	elseif effectType == SurvivalEnum.RoleSkillEffect.NoiseAttract or effectType == SurvivalEnum.RoleSkillEffect.DestroyBlock or effectType == SurvivalEnum.RoleSkillEffect.KillMonster or effectType == SurvivalEnum.RoleSkillEffect.SnatchItem or effectType == SurvivalEnum.RoleSkillEffect.ReplaceBlockUnit then
		local range = tonumber(arr[2]) or 0

		if range == 0 then
			range = weekInfo:getAttr(SurvivalEnum.AttrType.Vision)
		end

		useRange = range + rangeAttr
	end

	return useRange
end

function SurvivalRoleSkillMo:getSkillUseRangePoints(point, range, walkables)
	local list = SurvivalHelper.instance:getAllPointsByDis(point, range)

	for i = #list, 1, -1 do
		if not SurvivalHelper.instance:getValueFromDict(walkables, list[i]) then
			table.remove(list, i)
		elseif not self:isTarget_Skill_ReplaceBlockUnit(list[i]) then
			table.remove(list, i)
		end
	end

	return list
end

function SurvivalRoleSkillMo:isTarget_Skill_ReplaceBlockUnit(pos)
	if self.skillEffectType == SurvivalEnum.RoleSkillEffect.ReplaceBlockUnit then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()

		if self.skillEffectParam[5] == "0" then
			return true
		else
			local typesStr = self.skillEffectParam[5]

			self.tarTypes = self.tarTypes or string.splitToNumber(typesStr, ",")

			local blockType = sceneMo:getBlockTypeByPos(pos)

			if tabletool.indexOf(self.tarTypes, blockType) then
				return false
			else
				local units = sceneMo:getUnitByPos(pos, true, true)

				for _, unitMo in ipairs(units) do
					local subType = unitMo:getSubType()

					if tabletool.indexOf(self.tarTypes, subType) then
						return false
					end
				end
			end

			return true
		end
	end

	return true
end

function SurvivalRoleSkillMo:getSkillEffectRange()
	local effectType = self.skillEffectType

	if not SurvivalEnum.SelectPointSkill[effectType] then
		return
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local skillRangeAttr = weekInfo:getAttr(SurvivalEnum.AttrType.SkillRangeFix)
	local arr = self.skillEffectParam
	local range = tonumber(arr[2]) or 0

	if effectType == SurvivalEnum.RoleSkillEffect.SnatchItem then
		range = tonumber(arr[3]) or 0
	else
		if effectType == SurvivalEnum.RoleSkillEffect.KillMonster or effectType == SurvivalEnum.RoleSkillEffect.ReplaceBlockUnit then
			range = tonumber(arr[3]) or 0
		end

		if range == 0 then
			range = weekInfo:getAttr(SurvivalEnum.AttrType.Vision)
		end
	end

	return range + skillRangeAttr
end

function SurvivalRoleSkillMo:getSkillEffectRangePoints(point, range, walkables)
	local effectType = self.skillEffectType

	if effectType == SurvivalEnum.RoleSkillEffect.DestroyBlock then
		local playerPos = SurvivalMapModel.instance:getSceneMo().player.pos

		return (SurvivalHelper.instance:getLine(playerPos, point))
	end

	if range == 0 then
		return {
			point
		}
	else
		local list = SurvivalHelper.instance:getAllPointsByDis(point, range)

		for i = #list, 1, -1 do
			if not SurvivalHelper.instance:getValueFromDict(walkables, list[i]) then
				table.remove(list, i)
			elseif not self:isTarget_Skill_ReplaceBlockUnit(list[i]) then
				table.remove(list, i)
			end
		end

		return list
	end
end

function SurvivalRoleSkillMo:confirmUseSkill(point)
	if not self:isSkillUsing() then
		return
	end

	local effectType = self.skillEffectType

	if SurvivalEnum.SelectPointSkill[effectType] then
		if point then
			SurvivalInteriorRpc.instance:sendSurvivalUseRoleSkillRequest(string.format("%d#%d", point.q, point.r))
		end
	else
		SurvivalInteriorRpc.instance:sendSurvivalUseRoleSkillRequest("")
	end

	if effectType == SurvivalEnum.RoleSkillEffect.NoiseAttract then
		AudioMgr.instance:trigger(AudioEnum3_4.Survival.play_ui_bulaochun_tansuo_wuerlixi)

		local entity = SurvivalMapHelper.instance:getEntity(0)

		if entity then
			local effectPath = SurvivalConst.UnitEffectPath.WelxEffect
			local effectTime = SurvivalConst.UnitEffectTime[effectPath]

			entity:addEffectTiming(effectPath, effectTime)
		end
	elseif effectType == SurvivalEnum.RoleSkillEffect.FindDrop then
		AudioMgr.instance:trigger(AudioEnum3_4.Survival.play_ui_bulaochun_tansuo_marcus)
	elseif effectType == SurvivalEnum.RoleSkillEffect.SnatchItem then
		AudioMgr.instance:trigger(AudioEnum3_5.Survival.play_ui_lusongshi_tansuo_xingti)
	end
end

return SurvivalRoleSkillMo
