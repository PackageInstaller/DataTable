-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/model/RogueFieldInfo.lua

module("logic.extensions.roguelike.flow.model.RogueFieldInfo", package.seeall)

local M = class("RogueFieldInfo", AbstractGlobalReusable)

function M:ctor()
	self.roleMos = {}
end

function M:reset()
	for _, entity in pairs(self.roleMos) do
		entity:returnSelf()
	end

	if self._monsterMo then
		self._monsterMo:returnSelf()
	end

	BattleTableUtil.clearTable(self.roleMos)
end

function M:destroy()
	self:reset()
end

function M:setSelectRoles(roleIds)
	self._selectRoleIds = roleIds
end

function M:addRoleMo(roleMo)
	table.insert(self.roleMos, roleMo)
end

function M:removeRoleMo(roleId)
	for index, roleMo in pairs(self.roleMos) do
		if roleMo.roleId == roleId then
			roleMo:returnSelf()
			table.remove(self.roleMos, index)

			return
		end
	end
end

function M:findRoleMo(roleId)
	for _, roleMo in pairs(self.roleMos) do
		if roleMo.roleId == roleId then
			return roleMo
		end
	end
end

function M:setCurMonsterMo(monsterMo)
	self._monsterMo = monsterMo
end

function M:getCurMonsterMo()
	return self._monsterMo
end

return M
