-- chunkname: @modules/logic/fight/controller/FightStressHelper.lua

module("modules.logic.fight.controller.FightStressHelper", package.seeall)

local FightStressHelper = _M

function FightStressHelper.getStressUiType(entityId)
	if FightDataHelper.fieldMgr.customData then
		local customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act183]

		if customData then
			local identityList = customData.stressIdentity[entityId]

			if identityList then
				table.sort(identityList, FightStressHelper.sortIdentity)

				return FightStressHelper.getIdentityUiType(identityList[1])
			end
		end

		local identityId
		local entityMo = FightDataHelper.entityMgr:getById(entityId)

		if not entityMo then
			return FightNameUIStressMgr.UiType.Normal
		end

		if entityMo.side == FightEnum.EntitySide.MySide then
			identityId = FightNameUIStressMgr.HeroDefaultIdentityId
		else
			local co = entityMo:getCO()
			local monsterTemplateCo = co and lua_monster_skill_template.configDict[co.skillTemplate]

			identityId = monsterTemplateCo and monsterTemplateCo.identity or FightNameUIStressMgr.HeroDefaultIdentityId
			identityId = tonumber(identityId)
		end

		return FightStressHelper.getIdentityUiType(identityId)
	end
end

function FightStressHelper.sortIdentity(identity1, identity2)
	return identity1 < identity2
end

function FightStressHelper.getIdentityUiType(identityId)
	local co = lua_stress_identity.configDict[identityId]

	if not co then
		logError(string.format("身份类型表，identityId : %s, 不存在", identityId))

		return FightNameUIStressMgr.UiType.Normal
	end

	return co.uiType
end

return FightStressHelper
