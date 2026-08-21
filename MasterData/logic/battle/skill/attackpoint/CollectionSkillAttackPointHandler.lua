-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/attackpoint/CollectionSkillAttackPointHandler.lua

module("logic.battle.skill.attackpoint.CollectionSkillAttackPointHandler", package.seeall)

local CollectionSkillAttackPointHandler = class("CollectionSkillAttackPointHandler", AbstractGlobalReusable, ISkillAttackPointHandler)

function CollectionSkillAttackPointHandler:ctor()
	self._cmdContext = BattleCmdRunningContext.New()
	self._entityId = false
	self._isExecuted = false

	self:reuse()
end

function CollectionSkillAttackPointHandler:reuse(...)
	self._sequence = BattleParallelCommand:createInstance()
end

function CollectionSkillAttackPointHandler:reset()
	self._entityId = false
	self._isExecuted = false

	self._cmdContext:clear()

	if self._sequence then
		self._sequence:stop()

		self._sequence = false
	end
end

function CollectionSkillAttackPointHandler:destroy()
	self:reset()
end

function CollectionSkillAttackPointHandler:collectEntityIds(entityIdList)
	table.insert(entityIdList, self._entityId)
end

function CollectionSkillAttackPointHandler:build(context)
	return
end

function CollectionSkillAttackPointHandler:handleAttackPoint(context, weight)
	if self._isExecuted then
		return
	end

	self._isExecuted = true

	local battleFlow = BattleMgr.instance:getActiveBattleFlow()

	self._sequence:setCommandHandler(self)
	self._sequence:execute(battleFlow, self._cmdContext)
end

function CollectionSkillAttackPointHandler:onCommandFinish(cmd, success)
	self._sequence = false
end

function CollectionSkillAttackPointHandler:toString()
	return string.format("[collection skill attack handler,entityId = %s,count = %s]", self._entityId, #self._sequence)
end

function CollectionSkillAttackPointHandler:addFromEventNO(cmdParser, eventNO)
	self:_trySetEntityId(eventNO)
	cmdParser:pushCmdContainer(self._sequence)
	BattleCmdUtil.parseServerCommand(cmdParser, eventNO)
	cmdParser:popCmdContainer()
end

function CollectionSkillAttackPointHandler:addFromEventNOList(cmdParser, eventNOList)
	for _, eventNO in ipairs(eventNOList) do
		self:addFromEventNO(cmdParser, eventNO)
	end
end

function CollectionSkillAttackPointHandler:_trySetEntityId(eventNO)
	if not self._entityId then
		local activeEventNO = BattleCmdUtil.getActiveEventNO(eventNO)

		for descriptor, value in activeEventNO:ListFields() do
			if descriptor.name == "entity" then
				self._entityId = value

				return
			end
		end
	end
end

return CollectionSkillAttackPointHandler
