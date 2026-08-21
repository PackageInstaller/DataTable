-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleHaloRefreshedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleHaloRefreshedCommand", package.seeall)

local BattleHaloRefreshedCommand = class("BattleHaloRefreshedCommand", BattleCommandBase)

function BattleHaloRefreshedCommand:parseServerCommand(cmdParser, haloRefreshedEventNO)
	local linedNOList = haloRefreshedEventNO.linked
	local unlinkedNOList = haloRefreshedEventNO.unlinked

	for _, linkedNO in ipairs(linedNOList) do
		local cmd = BattleHaloRefreshedCommand:createInstance()

		cmd:setAdd(true)
		cmd:addFromHaloLinkedNO(linkedNO)
		cmdParser:addCommand(cmd)
		BattleCmdUtil.parseServerCommandBatch(cmdParser, linkedNO.effects)
	end

	for _, linkedNO in ipairs(unlinkedNOList) do
		local cmd = BattleHaloRefreshedCommand:createInstance()

		cmd:setAdd(false)
		cmd:addFromHaloLinkedNO(linkedNO)
		cmdParser:addCommand(cmd)
		BattleCmdUtil.parseServerCommandBatch(cmdParser, linkedNO.effects)
	end
end

function BattleHaloRefreshedCommand:createAddFromLinkedNO(linkedNO)
	local cmd = BattleHaloRefreshedCommand:createInstance()

	cmd:setAdd(true)
	cmd:addFromHaloLinkedNO(linkedNO)

	return cmd
end

function BattleHaloRefreshedCommand:onInit()
	self._isAdd = false
	self._fromEntityId = false
	self._toEntityId = false
end

function BattleHaloRefreshedCommand:onClear()
	self._isAdd = false
	self._fromEntityId = false
	self._toEntityId = false
end

function BattleHaloRefreshedCommand:execute(battleFlow)
	local haloLinks = battleFlow.haloLinks

	if self._isAdd then
		haloLinks:addLink(self._fromEntityId, self._toEntityId, self._fromSkillId)
	else
		haloLinks:removeLink(self._fromEntityId, self._toEntityId, self._fromSkillId)
	end

	self:finish(true)
end

function BattleHaloRefreshedCommand:toString()
	return string.format("[halo refreshed command isAdd = %s, fromEntityId = %s,toEntityId = %s]", tostring(self._isAdd), tostring(self._fromEntityId), tostring(self._toEntityId))
end

function BattleHaloRefreshedCommand:setAdd(isAdd)
	self._isAdd = isAdd

	return self
end

function BattleHaloRefreshedCommand:addFromHaloLinkedNO(haloLinkedNO)
	self._fromEntityId = haloLinkedNO.fromEntity
	self._toEntityId = haloLinkedNO.toEntity
	self._fromSkillId = haloLinkedNO.fromSkill

	return self
end

return BattleHaloRefreshedCommand
