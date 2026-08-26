-- chunkname: @modules/logic/survival/model/outside/SurvivalOutSideRoleMo.lua

module("modules.logic.survival.model.outside.SurvivalOutSideRoleMo", package.seeall)

local SurvivalOutSideRoleMo = pureTable("SurvivalOutSideRoleMo")

function SurvivalOutSideRoleMo:setData(roleBox)
	self.roleBox = roleBox
end

function SurvivalOutSideRoleMo:isRoleLock(roleId)
	local roles = self.roleBox.roles

	for i, v in ipairs(roles) do
		if v.roleId == roleId and v.unlocked then
			return false
		end
	end

	return true
end

function SurvivalOutSideRoleMo:isUnLockFuture(roleId)
	return lua_survival_role.configDict[roleId].isonline ~= 1
end

function SurvivalOutSideRoleMo:getSurvivalRole(roleId)
	local roles = self.roleBox.roles

	for i, v in ipairs(roles) do
		if v.roleId == roleId then
			return v
		end
	end
end

function SurvivalOutSideRoleMo:getUnlockDesc(roleId)
	local cfg = lua_survival_role.configDict[roleId]
	local survivalRole = self:getSurvivalRole(roleId)

	if not string.nilorempty(cfg.conditionsDesc) then
		return GameUtil.getSubPlaceholderLuaLang(cfg.conditionsDesc, {
			survivalRole.maxProgress,
			survivalRole.progress
		})
	end

	return ""
end

function SurvivalOutSideRoleMo:markNew()
	local ids = {}
	local roles = self.roleBox.roles

	for i, v in ipairs(roles) do
		if v.isNew then
			table.insert(ids, v.roleId)
		end
	end

	SurvivalOutSideRpc.instance:sendSurvivalMarkRoleNotNewRequest(ids, function()
		for i, v in ipairs(self.roleBox.roles) do
			v.isNew = false
		end
	end)
end

function SurvivalOutSideRoleMo:markSelectRole(id)
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SurvivalHandbookRoleSelect, id)
end

function SurvivalOutSideRoleMo:getSelectRole()
	return GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.SurvivalHandbookRoleSelect, 1)
end

return SurvivalOutSideRoleMo
