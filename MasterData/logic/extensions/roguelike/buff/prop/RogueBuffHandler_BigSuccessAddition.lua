-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/prop/RogueBuffHandler_BigSuccessAddition.lua

module("logic.extensions.roguelike.buff.prop.RogueBuffHandler_BigSuccessAddition", package.seeall)

local M = class("RogueBuffHandler_BigSuccessAddition", RogueBaseBuffHandler)

function M:ctor()
	return
end

function M:onAdd(entity, buffMO)
	return
end

function M:onTrigger(triggerEvent, entity, buffMO)
	if M.super.onTrigger(self, triggerEvent) then
		local msg = lang("tip_success_probability_up")

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)

		local roleMos = RogueMgr.instance:getModel():getAllRoleMos()

		for k, v in pairs(roleMos) do
			local heroMO = HeroDepotModel.instance:getHeroInfoByID(v.roleProp:getRoleId())
			local skillIds = heroMO:getRoguelikeSkillIds()
			local isUnlock = RoguelikeConfig.instance:getRoguelikeRoleSkillUnlock(v.roleProp:getRoleId()) and RoguelikeModel.instance:getSkillOpen(v.roleProp:getRoleId())

			if isUnlock then
				for k1, v1 in pairs(skillIds) do
					local buffCo = RoguelikeConfig.instance:getEffectById(v1)

					if buffCo.clientProgram == "BigSuccessAddition" then
						v.meshModel:play(RoguelikeConst.ROGUE_MONSTER_ANI.SKILL, false, true)
					end
				end
			end
		end

		return true, buffMO:getParams()
	end
end

function M:onRemove(entity, buffMO)
	return
end

return M
