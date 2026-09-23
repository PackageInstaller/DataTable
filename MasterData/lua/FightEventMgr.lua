-- 战斗事件类型
eFightEventType = {}
eFightEventType.Skill	= 1
eFightEventType.Buffer	= 2
-----------------------------------------------
FightEventMgr = oo.class()
function FightEventMgr:Init(fightMgr)
	self.fightMgr		= fightMgr

	self.events			= {}
	self.events.Skill	= {}
	self.events.Buffer	= {}

	for k,v in pairs(ePassiveTiming) do
		self.events.Skill[k]	= {}
		self.events.Buffer[k]	= {}
	end
end

function FightEventMgr:Destroy()
    for k,v in pairs(self) do
        self[k] = nil
    end
end

-- 注册buffer事件
function FightEventMgr:AddBufferEvent(event, buffer)
	LogDebugEx("注册buffer事件", event, buffer.id)
	if not self.events.Buffer[event] then return end

	if buffer.priority and #self.events.Buffer[event] > 0 then 
		-- 有优先级, 需要比较插入, 大的先
		for i,v in ipairs(self.events.Buffer[event]) do
			if not v.priority or v.priority < buffer.priority then
				table.insert(self.events.Buffer[event], i, buffer)
				LogDebugEx("注册buffer事件插队", event, buffer.id, #self.events.Buffer[event], i)
				return
			end
		end
	end

	table.insert(self.events.Buffer[event], buffer)
	LogDebugEx("注册buffer事件成功", event, buffer.id, #self.events.Buffer[event])
end

function FightEventMgr:DelBuffer(buffer)
	LogDebugEx("FightEventMgr:DelBuffer", buffer.id, buffer.uuid, buffer.name, buffer.owner.name)

	for id,event in ipairs(arrPassiveTiming) do
		for i,tbuff in ipairs(self.events.Buffer[event]) do
			if tbuff == buffer then
				table.remove(self.events.Buffer[event], i)
				break
			end
		end
	end
end

-- 注册技能事件
function FightEventMgr:AddSkillEvent(event, skill)
	LogDebugEx("注册技能事件", event, skill.id)
	if not self.events.Skill[event] then return end

	skill.priority = skill.priority or 0
	if skill.priority and #self.events.Skill[event] > 0 then 
		-- 有优先级, 需要比较插入, 大的先
		for i,v in ipairs(self.events.Skill[event]) do
			if not v.priority or v.priority < skill.priority then
				table.insert(self.events.Skill[event], i, skill)
				LogDebugEx("注册技能事件插队", event, skill.id, #self.events.Skill[event], i)
				return
			end
		end
	end
	
	table.insert(self.events.Skill[event], skill)
	LogDebugEx("注册技能事件", event, skill.id, #self.events.Skill[event])
end

function FightEventMgr:DelSkill(skill)
	LogDebugEx("FightEventMgr:DelSkill", skill.id, skill.name)

	for id,event in ipairs(arrPassiveTiming) do
		for i,tskill in ipairs(self.events.Skill[event]) do
			if tskill == skill then
				table.remove(self.events.Skill[event], i)
				break
			end
		end
	end
end

-- 执行触发事件
function FightEventMgr:DoEvent(event, ...)
	local caster, target, data = ...

	LogDebugEx("执行触发事件", event, caster and caster.name or "", target and target.name or "")

	if caster and caster.bIsCommander then return end -- 指挥官就不要触发事件了


	--local uuid = UUID()
	--LogDebugEx("DoEvent--------------------------",event, uuid)
	--self:PrintBuffer()
	--LogTrace()

	-- 用ipairs时, 可能事件中会删除部分事件导致ipairs循环缺失, 用CopyIpairs确保全部执行
	for i,buffer in ipairs(CopyIpairs(self.events.Buffer[event])) do
		LogDebugEx("buffer事件", event, buffer.id)


		-- 由于上面使用CopyIpairs, 导致如果事件中删除buff,  仍旧会执行已删除的buff, 所以加个标志判断一下
		if buffer.bIsDelete then
		else
			buffer.caster = caster -- 当前事件行为的施法者
			buffer[event](buffer, ...)
			buffer.caster = nil
		end
	end

	for i,skill in ipairs(CopyIpairs(self.events.Skill[event])) do
		LogDebugEx("技能事件", event, skill.id)
		skill[event](skill, ...)
	end

	--LogDebugEx("--------------------------DoEvent",event, uuid)

	-- if event == "OnDeath" then
	-- 	local caster, target, data = ...
	-- 	target.skillMgr:DoDeathEvent(...)
	-- end
end

function FightEventMgr:PrintBuffer()
	LogDebugEx("PrintBuffer--------------")
	for id,event in ipairs(arrPassiveTiming) do
		for i,tbuff in ipairs(self.events.Buffer[event]) do
			LogDebug("buff id=%s, uuid=%s, event=%s", tbuff.id, tbuff.uuid, event)
		end
	end
	LogDebugEx("--------------PrintBuffer")
end