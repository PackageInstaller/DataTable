-- OPENDEBUG()
-----------------------------------------------
BuffMgr = oo.class()
function BuffMgr:Init(card, fightMgr)
	self.card		= card
	self.fightMgr	= fightMgr
	self.list		= {} -- 所有buff
	self.map		= {} -- 所有buff
	self.ctrlEvent	= {} -- 控制类buffer
	self.log = fightMgr.log
	ASSERT(self.log)
end

function BuffMgr:Destroy()
	LogDebugEx("BuffMgr:Destroy()")
	for i,buffer in ipairs(self.list) do
		buffer:Destroy()
	end

    for k,v in pairs(self) do
        self[k] = nil
    end
end

-- 断线恢复战斗buff
function BuffMgr:Restore()

	for i,buffer in ipairs(self.list) do

		local log = 
		{
			api          = "AddBuff", 
			uuid         = buffer.uuid,
			round        = buffer.round,
			id           = buffer.creater.oid, 
			targetID     = buffer.owner.oid, 
			bufferID     = buffer.id, 
			shield       = buffer.shield,
			nShieldCount = buffer.nPhysicsShield,
			sneer        = buffer.sneer,
			silence      = buffer.silence,
			nCount       = buffer.nCount,

			-- effectID	= buffer.effectID
		}
		self.log:Add(log)
		FightActionMgr:PushSkill(self.log:GetAndClean())
	end

end

g_mapBufferLoaded = {}


function BuffMgr:Create(target, caster, id)

	local cbuffer = g_mapBufferLoaded["Buffer"..id]
	if not cbuffer then
		if g_BufferList["Buffer"..id] then
			require(g_BufferPath.."Buffer"..id)
			cbuffer = _G["Buffer"..id]
			g_mapBufferLoaded["Buffer"..id] = _G["Buffer"..id]
			_G["Buffer"..id] = nil
			package.loaded[g_BufferPath.."Buffer"..id] = nil
		else
			cbuffer = BuffBase
		end
	end

	local buffer = cbuffer(self, id, target, caster)	
	return buffer
end

function BuffMgr:Add(target, caster, id, nRoundNum, effectID)
	LogDebugEx("BuffMgr:Add", "Buffer"..id,target.name, caster.name, id)
	--LogTrace()

	local buffer = self:Create(target, caster, id)

	self.log:StartSub("OnCreate")
	if nRoundNum then
		buffer.round = nRoundNum
	end
	
	buffer.effectID = effectID
	self:DealOverlay(buffer)

	local bufferID = buffer.uuid
	self.map[bufferID] = buffer
	table.insert(self.list, buffer)
	ASSERT(buffer)

	buffer:OnCreate(caster, target)
	self.log:EndSub("OnCreate")
	LogDebugEx("BuffMgr:Add", self.card.name, "Buffer"..id, buffer.uuid)

	self.oLastBuffer = buffer
	buffer.fightMgr:DoEventWithLog("OnAddBuff", caster, target, nil, buffer)
	return buffer
end

-- 增加层数
function BuffMgr:AddCount(target, caster, id, nCount, limit, effectID)
	LogDebugEx("BuffMgr:AddCount", "Buffer"..id,target.name, caster.name, id, nCount, limit, effectID)
	--LogTrace()
	local oldBuff = nil
	-- 先删除同个buff
	for i,v in ipairs(self.list) do
		--LogDebugEx("AddCount", v.id , id)
		if v.id == id then
			-- buffer.nCount = v.nCount or 0
			oldBuff = v
			break
		end
	end

	local buffer = nil

	if oldBuff then
		buffer = oldBuff
		buffer.nCount = buffer.nCount or 0

		if nCount > 0 and buffer.nCount >= limit then --buffer本身已经达到上限, 不需要处理了
			return
		end	

		-- [4.2 Buffer400600201buff报错]
		buffer.caster = buffer.caster or caster
	else
		buffer = self:Create(target, caster, id)
		buffer.effectID = effectID
		buffer.nCount = 0
	end

	buffer.nCount = buffer.nCount + nCount

	-- 上限
	if buffer.nCount >= limit then
		buffer.nCount = limit
	end	

	LogDebugEx("buffer.nCount=",buffer.nCount)

	if buffer.nCount > 0 then

		local log = {api="AddBuff", id = caster.oid, targetID = target.oid, bufferID = buffer.id, effectID = effectID, 
		uuid = buffer.uuid, nCount = buffer.nCount} 

		if oldBuff then -- 已有的buff就更新
			log = {api="UpdateBuffer", bufferID = buffer.id, uuid = buffer.uuid, targetID = target.oid, nCount = buffer.nCount, add=nCount, effectID = effectID}
		else
			local bufferID = buffer.uuid
			self.map[bufferID] = buffer
			table.insert(self.list, buffer)
			ASSERT(buffer)			
		end

		self.log:Add(log)
		self.log:StartSub("OnCreate")

		-- if oldBuff then
		-- 	--LogDebugEx("oldBuff", oldBuff.id , oldBuff.nCount, buffer.nCount)
		-- 	self:DelBuffer(oldBuff, caster, target)
		-- end

		-- LogDebugEx("buffer:OnCreate----", target.name, caster.name, buffer.caster.name)
		buffer:OnPreDelete()-- 删除之前的属性
		buffer:OnCreate(caster, target) -- 重新加属性

		self.log:EndSub("OnCreate")
		LogDebugEx("BuffMgr:AddCount2", self.card.name, "Buffer"..id, buffer.uuid)

		self.oLastBuffer = buffer
		buffer.fightMgr:DoEventWithLog("OnAddBuff", caster, target, nil, buffer)
		return buffer
	else
		-- if oldBuff then
			self:DelBuffer(buffer, caster, target)
		-- end
	end
end


function BuffMgr:DelBuffer(buffer, caster, target)
	LogDebugEx("BuffMgr:DelBuffer", buffer.id, buffer.uuid, buffer.name, buffer.owner.name)
	-- LogTrace()
	local bufferID = buffer.uuid
	self.map[bufferID] = nil

	for i,v in ipairs(self.list) do
		if v == buffer then
			table.remove(self.list, i)
			break
		end
	end

	-- if buffer.OnRemoveBuff then
	-- 	-- self.fightMgr:DoEventWithLog("OnRemoveBuff", self.owner)

	-- 	self.log:StartSub("OnRemoveBuff")
	-- 	buffer.caster = caster or buffer.caster
	-- 	--LogDebugEx("OnRemoveBuff", buffer.caster.name)
	-- 	buffer:OnRemoveBuff(self.owner)
	-- 	self.log:EndSub("OnRemoveBuff")
	-- end

	-- self.fightMgr.oFightEventMgr:DelBuffer(buffer, caster, target)

	buffer:OnDelete(true)
	-- ASSERT(nil, "BuffMgr:DelBuffer" .. buffer.name)
end

-- 清空buff(复活时)
function BuffMgr:RemoveAll()
	-- LogTrace()
	self.map = {}

	self.fightMgr.oFightEventMgr:PrintBuffer()

	for i,buffer in ipairs(CopyIpairs(self.list)) do
		self.fightMgr.oFightEventMgr:DelBuffer(buffer)
		buffer:OnDelete()
	end

	self.fightMgr.oFightEventMgr:PrintBuffer()

	self.list = {}

	self.card.bRemove = nil
end

-- 获取buff数量(按组)
function BuffMgr:GetBufferCountGroup(group)

	local num = 0
	for i,v in ipairs(self.list) do
		if v.group == group then
			num = num + 1
		end
	end
	return num
end

-- 获取buff数量(按好坏的性质)
function BuffMgr:GetBufferCountQuality(group)

	local num = 0
	for i,v in ipairs(self.list) do
		if v.goodOrBad == group then
			num = num + 1
		end
	end
	return num
end

-- 获取buff数量(按ID)
function BuffMgr:GetBufferCountID(group)
	local num = 0
	for i,v in ipairs(self.list) do
		if v.id == group then
			num = num + 1
		end
	end
	LogDebugEx("BuffMgr:GetBufferCountID", group, num)
	return num
end

-- 获取buff数量(按type)
function BuffMgr:GetBufferCountType(group)

	local num = 0
	for i,v in ipairs(self.list) do
		if v.type == group then
			num = num + 1
		end
	end
	return num
end

-- 获取buff回合数(按ID)
function BuffMgr:GetBufferRound(group)
	local num = 0
	for i,v in ipairs(self.list) do
		if v.id == group then
			num = num + (v.round or 0)
		end
	end
	LogDebugEx("-----------GetBufferRound--------------------------------------",num)
	return num
end


-- 可以偷取的buff
function BuffMgr:StealBufferGroup(group, num)

	num = num or 1
	local list = {}
	for i,v in ipairs(self.list) do
		if v.canSteal and v.group == group then
			table.insert(list, v)
			if #list >= num then
				break
			end
		end
	end

	return list
end

function BuffMgr:GetBufferByGroup(group, num)

	num = num or 1
	local list = {}
	for i,v in ipairs(self.list) do
		if v.group == group then
			table.insert(list, v)
			if #list >= num then
				break
			end
		end
	end

	return list
end

function BuffMgr:GetBufferByType(group, num)

	num = num or 1
	local list = {}
	for i,v in ipairs(self.list) do
		if v.type == group then
			table.insert(list, v)
			if #list >= num then
				break
			end
		end
	end

	return list
end


function BuffMgr:GetBufferByID(group, num)

	num = num or 1
	local list = {}
	for i,v in ipairs(self.list) do
		if v.id == group then
			table.insert(list, v)
			if #list >= num then
				break
			end
		end
	end

	return list
end

-- 获取buff层数
function BuffMgr:GetCount(buffID)

	local num = 0
	for i,v in ipairs(self.list) do
		if v.id == buffID then
			return v.nCount
		end
	end
	return num
end

-- 反射buff
function BuffMgr:ReflectBuff(eType, group, targets)
	LogDebugEx("BuffMgr:ReflectBuff", self.card.name)
	-- LogDebugEx("BuffMgr:ReflectBuff", self.card.name, self.oLastBuffer)
	-- LogTable(targets, "targets")
	if not self.oLastBuffer then return end
	
	if eType == 1 then
		if self.oLastBuffer.group ~= group then return end
	elseif eType == 2 then
		if self.oLastBuffer.type ~= group then return end
	elseif eType == 3 then
		if self.oLastBuffer.id ~= group then return end
	else
		ASSERT(nil, "反射类型不正确")
	end

	for i,target in ipairs(targets) do
		local config = BufferConfig[self.oLastBuffer.id]
		local round = config.round
		target:AddBuff(target, self.oLastBuffer.id,(round or 1)+1,eBufferAddType.Reflect)
	end
	
	self:DelBuffer(self.oLastBuffer)
	self.oLastBuffer = nil
end

-- 驱散buff(按好坏的性质)
function BuffMgr:DelBufferQuality(caster, card, quality, num, effect)

	num = num or 1
	local delList = {}
	for i,v in ipairs(self.list) do
		if v.owner == card and v.canDel and v.goodOrBad == quality then
			table.insert(delList, v)
			if #delList >= num then
				break
			end
		end
	end

	if #delList == 0 then return end
	self.log:Add({api="Piaozi", targetID = card.oid, floatID = 86, effectID = effect.apiSetting})

	for i,v in ipairs(delList) do
		self:DelBuffer(v)
		v.fightMgr:DoEventWithLog("OnDelBuff", caster, card)
	end
end

-- 驱散buff(按id)
function BuffMgr:DelBufferID(caster, card, id, num, effect)

	num = num or 1
	local delList = {}
	for i,v in ipairs(self.list) do
		if v.owner == card and v.canDel and v.id == id then
			table.insert(delList, v)
			if #delList >= num then
				break
			end
		end
	end

	if #delList == 0 then return end
	self.log:Add({api="Piaozi", targetID = card.oid, floatID = 86, effectID = effect.apiSetting})

	for i,v in ipairs(delList) do
		self:DelBuffer(v)
		v.fightMgr:DoEventWithLog("OnDelBuff", caster, card)
	end
end

-- 驱散buff(按组)
function BuffMgr:DelBufferGroup(caster, card, group, num, effect)

	num = num or 1
	local delList = {}
	for i,v in ipairs(self.list) do
		if v.owner == card and v.canDel and v.group == group then
			table.insert(delList, v)
			if #delList >= num then
				break
			end
		end
	end

	if #delList == 0 then return end
	self.log:Add({api="Piaozi", targetID = card.oid, floatID = 86, effectID = effect.apiSetting})

	for i,v in ipairs(delList) do
		self:DelBuffer(v)
		v.fightMgr:DoEventWithLog("OnDelBuff", caster, card)
	end
end

-- 驱散buff(按type)
function BuffMgr:DelBufferType(caster, card, group, num, effect)

	num = num or 1
	local delList = {}
	for i,v in ipairs(self.list) do
		if v.owner == card and v.canDel and v.type == group then
			table.insert(delList, v)
			if #delList >= num then
				break
			end
		end
	end

	if #delList == 0 then return end
	self.log:Add({api="Piaozi", targetID = card.oid, floatID = 86, effectID = effect.apiSetting})

	for i,v in ipairs(delList) do
		self:DelBuffer(v)
		v.fightMgr:DoEventWithLog("OnDelBuff", caster, card)
	end
end

-- 强制删除buff(按id,不飘字, 不调事件)
function BuffMgr:DelBufferIDForce(caster, card, id, num)

	num = num or 1
	local delList = {}
	for i,v in ipairs(self.list) do
		if v.owner == card and v.id == id then
			table.insert(delList, v)
			if #delList >= num then
				break
			end
		end
	end

	for i,v in ipairs(delList) do
		self:DelBuffer(v)
	end
end

-- 强制驱散buff(按组, 不飘字, 不调事件)
function BuffMgr:DelBufferGroupForce(caster, card, group, num, effect)
	LogDebugEx("DelBufferGroupForce", group, num)
	num = num or 1
	local delList = {}
	for i,v in ipairs(self.list) do
		if v.owner == card and v.group == group then
			table.insert(delList, v)
			if #delList >= num then
				break
			end
		end
	end

	if #delList == 0 then return end

	for i,v in ipairs(delList) do
		self:DelBuffer(v)
	end
end

-- 强制删除buff(按type, 不飘字, 不调事件)
function BuffMgr:DelBufferTypeForce(caster, card, group, num)

	num = num or 1
	local delList = {}
	for i,v in ipairs(self.list) do
		if v.owner == card and v.type == group then
			table.insert(delList, v)
			if #delList >= num then
				break
			end
		end
	end

	if #delList == 0 then return end

	for i,v in ipairs(delList) do
		self:DelBuffer(v)
	end
end

-- 处理叠加方式:
-- 1 共存
-- 2 顶掉
-- 3 共存互顶(达到上限顶掉)
function BuffMgr:DealOverlay(buffer)

	local delList = {}
	-- 同个buffer处理
	if buffer.overlay == 2 then
		-- 顶掉
		for i,v in ipairs(self.list) do
			if v.id == buffer.id then
				table.insert(delList, 1, v)
			end
		end
	elseif buffer.overlay == 3 and buffer.limit and buffer.limit > 0 then
		for i,v in ipairs(self.list) do
			if v.id == buffer.id then
				table.insert(delList, 1, v)
			end
		end
		-- print("----", buffer.overlay , buffer.limit, #delList)
		-- local len = #delList - buffer.limit
		-- print(#delList, #delList +1 - buffer.limit, -1)
		if #delList < buffer.limit then
			delList = {}
		else
			for i=1,buffer.limit-1 do
				table.remove(delList, #delList)
			end
		end
	end

	for i,v in ipairs(delList) do
		self:DelBuffer(v)
	end

	delList = {}
	-- 同类buffer处理
	if buffer.overlayGroup == 2 then
		-- 顶掉
		for i,v in ipairs(self.list) do
			if v.type == buffer.type then
				table.insert(delList, 1, v)
			end
		end
	elseif buffer.overlayGroup == 3 and buffer.limitGroup and buffer.limitGroup > 0 then
		for i,v in ipairs(self.list) do
			if v.type == buffer.type then
				table.insert(delList, 1, v)
			end
		end
		-- LogDebugEx("----", buffer.overlayGroup , buffer.limitGroup, #delList)

		if #delList < buffer.limitGroup then
			delList = {}
		else
			for i=1,buffer.limitGroup-1 do
				table.remove(delList, #delList)
			end
		end
	end

	for i,v in ipairs(delList) do
		self:DelBuffer(v)
	end
end

function BuffMgr:CallTargetFun(fun, bufferID)
	local buffer = self.map[bufferID]
	if not buffer then return end

	target = buffer.owner
	caster = buffer.caster
	buffer[fun](buffer, target, caster)
end

-- 更新CD
function BuffMgr:OnUpdateBuffer()
	-- self.log:Add({api="OnRoundOver"})
	-- self.log:StartSub("datas")
	for i,buffer in ipairs(CopyIpairs(self.list)) do
		local l = buffer:OnUpdateBuffer()
	end
end

-- 其他玩家死亡
function BuffMgr:OnOtherDeath(card)

	LogDebugEx("------BuffMgr:OnOtherDeath------", self.card.name ,card.name, " 死了")

	for i,buffer in ipairs(CopyIpairs(self.list)) do 
		if buffer.sneer and buffer.sneer == card then
			self:DelBuffer(buffer)
		end
	end

end

-- 自己死亡
function BuffMgr:OnSelfDeath()

	LogDebugEx("------BuffMgr:OnSelfDeath------", self.card.name , " 死了")

	-- 删除关联buff
	local delList = {}
	for i,buffer in ipairs(self.list) do
		if buffer.tRelevanceBuff then
			table.insert(delList, buffer)
		end
	end

	for i,buffer in ipairs(delList) do
		buffer.mgr:DelBuffer(buffer)
	end
end

function BuffMgr:AddEvent(event, buffer)
	-- LogDebugEx("注册buffer事件", event, buffer.id)
	-- if not self.events[event] then return end
	-- table.insert(self.events[event], buffer)
	-- LogDebugEx("注册buffer事件成功", event, buffer.id, #self.events[event])
	self.fightMgr.oFightEventMgr:AddBufferEvent(event, buffer)
end

-- 控制类buff
function BuffMgr:GetCtrlBuff()
	local list = {}
	for i,buffer in ipairs(self.list) do
		-- local buffer = self.map[v]
		if buffer and buffer.group == BuffGroup.Ctrl then
			table.insert(list, buffer)
		end
	end
	-- if #list > 0 then
	-- 	return list
	-- end
	return list
end

-- 是否无法行动, 跳过回合
function BuffMgr:IsMotionless()

	-- 麻痹
	if self.card:GetTempSign("Palsy") then
		return eMotionlessType.Palsy
	end

	-- 过热
	if self.card:GetTempSign("PalsyOverLoad") then
		return eMotionlessType.Common
	end

	-- 牢笼
	local cage = self.card:GetSign("Cage") 
	if cage and cage.val > 0 then
		return eMotionlessType.Cage
	end

	local list = {}
	for i,buffer in ipairs(self.list) do
		-- local buffer = self.map[v]
		--LogDebugEx("buffer"..i, buffer.name, buffer.effect)
		if --[[buffer.group == BuffGroup.Ctrl and]] buffer.effect == BuffEffectType.Motionless then
			return eMotionlessType.Common
		end
	end
end

-- 更换buff主人
function BuffMgr:ChangeOwner(target)

end


-- 增加或减少buff回合
function BuffMgr:AlterBufferByGroup(caster, card, group, num)
	LogDebugEx("BuffMgr:AlterBufferByGroup", self.card.name, group, num)
	
	local list = {}

	for i,v in ipairs(self.list) do
		if v.goodOrBad == group and v.round then
			v.round = v.round + num
			table.insert(list,v)
		end
	end

	for i,v in ipairs(list) do
		-- v:OnUpdateBuffer()
		self.log:Add({api="UpdateBuffer", bufferID = v.id, uuid = v.uuid, round = v.round})
	end	
end
function BuffMgr:AlterBufferByID(caster, card, group, num)
	LogDebugEx("BuffMgr:AlterBufferByID", self.card.name, group, num)
	
	local list = {}

	for i,v in ipairs(self.list) do
		if v.id == group and v.round then
			v.round = v.round + num
			table.insert(list,v)
		end
	end

	for i,v in ipairs(list) do
		-- v:OnUpdateBuffer()
		self.log:Add({api="UpdateBuffer", bufferID = v.id, uuid = v.uuid, round = v.round})
	end	
end


-- 增加或减少随机一个buff的回合
function BuffMgr:AlterRandBufferByGroup(caster, card, group, num)
	LogDebugEx("BuffMgr:AlterRandBufferByGroup", self.card.name, group, num)
	
	local list = {}

	for i,v in ipairs(self.list) do
		if v.goodOrBad == group and v.round then
			table.insert(list,v)
		end
	end

	if #list > 0 then
		local rNum = self.card:Rand(#list)+1
		local bf = list[rNum]
		if bf then
			bf.round = bf.round + num
			self.log:Add({api="UpdateBuffer", bufferID = bf.id, uuid = bf.uuid, round = bf.round})
		end
	end
end


function BuffMgr:AlterRandBufferByID(caster, card, group, num)
	LogDebugEx("BuffMgr:AlterRandBufferByID", self.card.name, group, num)
	
	local list = {}

	for i,v in ipairs(self.list) do
		if v.id == group and v.round then
			table.insert(list,v)
		end
	end

	if #list > 0 then
		local rNum = self.card:Rand(#list)+1
		local bf = list[rNum]
		if bf then
			bf.round = bf.round + num
			self.log:Add({api="UpdateBuffer", bufferID = bf.id, uuid = bf.uuid, round = bf.round})
		end
	end
end

function BuffMgr:AlterRandBufferByType(caster, card, type, num)
	LogDebugEx("BuffMgr:AlterRandBufferByType", self.card.name, type, num)
	
	local list = {}

	for i,v in ipairs(self.list) do
		if v.type == type and v.round then
			table.insert(list,v)
		end
	end

	if #list > 0 then
		local rNum = self.card:Rand(#list)+1
		local bf = list[rNum]
		if bf then
			bf.round = bf.round + num
			self.log:Add({api="UpdateBuffer", bufferID = bf.id, uuid = bf.uuid, round = bf.round})
		end
	end
end
-----------------------------------------------
-- buffer基类
BuffBase = oo.class(FightAPI)
function BuffBase:Init(mgr, id, target, caster)
	self.mgr         = mgr
	self.id          = id
	self.uuid        = UUID(8)
	self.card        = target
	self.team        = target.team
	self.fightMgr    = target.team.fightMgr
	self.owner       = target -- 拥有者
	self.creater     = caster -- buffer创建者
	self.caster      = caster -- 施法者
	self.count       = 0
	self.addAttrattr = {} -- buff的属性
	self.attrPercent = {} -- buff的加成属性
	self.arrValue    = {} -- 临时变量
	self.log         = mgr.log
	ASSERT(self.log)
	self:LoadConfig()

	--self.arrDelEvent = {} -- 删除事件

	for k,v in ipairs(arrPassiveTiming) do
		if self[v] then
			self.mgr:AddEvent(v, self)
		end
	end

	-- if not self.onRoundOver then
	-- 	self.mgr:AddEvent("onRoundOver", self)
	-- end
end

function BuffBase:LoadConfig()
	local config = BufferConfig[self.id]
	ASSERT(config, self.id)
	--LogTable(config)

	self.name				= config.name 			-- 名称
	self.group				= config.group 			-- 群组
	self.type				= config.type 			-- 类别
	-- self.range				= config.range 			-- 作用域(个人或群组)
	-- self.effect				= config.effect 		-- 效果类型
	self.goodOrBad			= config.goodOrBad 		-- 性质
	self.canDel				= config.canDel 		-- 能否驱散
	self.canSteal			= config.canSteal		-- 能否偷取
	self.round				= config.round 			-- 持续回合
	self.overlay			= config.overlay 		-- 同个buff叠加方式
	self.limit				= config.limit 			-- 叠加上限
	self.overlayGroup		= config.overlayGroup 	-- 同类buff叠加方式
	self.limitGroup			= config.limitGroup		-- 同类叠加上限
	
	for k,v in pairs(config) do
		if self[k] and type(self[k]) == "function" then
		else
			self[k] = v
		end
	end
end

-- 删除回调
function BuffBase:AddTodoOnDelete(cb, arg)
	self.todoOnDel = self.todoOnDel or {}
	table.insert(self.todoOnDel, {cb = cb, arg = arg})
end

function BuffBase:DoDeathEvent(caster, target)
	local log = {api="OnDeath", id = caster.oid, targetID = target.oid}
	self.log:Add(log)
	self.log:StartSub("datas")
	self.fightMgr:DoEvent("OnDeath", caster, target, data)
	self.log:EndSub("datas")
end

----------------------------------------------------------------------------------------------
-- 增加血量
function BuffBase:AddHp(effect, caster, target, data, hp, bNotDeathEvent)
	LogDebugEx("BuffBase:AddHp", hp, target.name)
	--LogTrace()
	-- local target = self.owner
	-- local caster = self.caster
	-- local apiSetting = BufferEffect[effectID].apiSetting

	-- if not target:IsLive() then return end -- 死了就不要伤害否则会重复掉死亡事件

	if target:GetTempSign("ImmuneDamage") then  
		return
	end
	
	local isdeath, shield, num = target:AddHpNoShield(hp, caster, bNotDeathEvent)
	local log = {api="AddHp", death = isdeath, bufferID = self.id, targetID = target.oid, 
		uuid = self.uuid, attr = "hp", hp = target:Get("hp"), add = num, effectID = effect.apiSetting}
	if hp < 0 then 
		log.isReal = true
	end
	self.log:Add(log)

	if not isdeath or bNotDeathEvent then return end

	self:DoDeathEvent(caster, target)
end

-- 增加血量百分比
function BuffBase:AddHpPercent(effect, caster, target, data, val)
	local hp = target:Get("maxhp")*val
	target:AddHp(hp, caster)

	self.log:Add({api="AddHpPercent", bufferID = self.id, targetID = target.oid, uuid = self.uuid, 
		attr = "hp", hp = target:Get("hp"), add = hp, val = val, effectID = effect.apiSetting})
end

-- 属性直加
function BuffBase:AddAttr(effect, caster, target, data, attr, val, val2)
	if val2 then
		val = self:RandEx(val, val2, 1)
	end
	LogDebugEx("BuffBase:AddAttr", self.id, target.name, attr, val, self.nCount)
	-- LogTrace()
	local todo = function(data)
		local tCard = data.tCard 
		-- if tCard and tCard:IsLive() and data.val ~= 0 then  
		if tCard and data.val ~= 0 then  --and tCard:IsLive() 死了可以复活, 所以这个属性必须得扣回去  --合体的时候原角色要处理
			tCard:AddBuffAttr(data.attr, -data.val)
		end
	end
	if target == self.owner then -- 给自己加的属性删除时自动删掉
		self.addAttrattr[attr] = self.addAttrattr[attr] or 0
		self.addAttrattr[attr] = self.addAttrattr[attr] + val
	else							 -- 给其他人加的属性删除时自动删掉
		self:AddTodoOnDelete(todo,{tCard = target,attr = attr,val = val})
	end
	target:AddBuffAttr(attr, val)

	local log = {api="AddAttr", bufferID = self.id, targetID = target.oid, uuid = self.uuid, attr = attr, 
	add = val, effectID = effect.apiSetting}
	log[attr] = target:Get(attr)
	self.log:Add(log)
end

-- 属性加成
function BuffBase:AddAttrPercent(effect, caster, target, data, attr, val, val2, e)
	if val2 then
		val = self:RandEx(val, val2, e)
	end
	local todo = function(data)
		local tCard = data.tCard 
		-- if tCard and tCard:IsLive() and data.val ~= 0 then  
		if tCard and data.val ~= 0 then  --and tCard:IsLive() 死了可以复活, 所以这个属性必须得扣回去  --合体的时候原角色要处理
			tCard:AddAttrPercent(data.attr, -data.val)
		end
	end

	if target == self.owner then -- 给自己加的属性删除时自动删掉
		self.attrPercent[attr] = self.attrPercent[attr] or 0
		self.attrPercent[attr] = self.attrPercent[attr] + val
	else							 -- 给其他人加的属性删除时自动删掉
		self:AddTodoOnDelete(todo,{tCard = target,attr = attr,val = val})
	end

	target:AddAttrPercent(attr, val)

	local log = {api="AddAttrPercent", bufferID = self.id, targetID = target.oid, uuid = self.uuid, 
	attr = attr, add = val, effectID = effect.apiSetting}
	log[attr] = target:Get(attr)
	self.log:Add(log)
end

-- 增加或减少最大血量, 同时修改
function BuffBase:AddMaxHpPercent(effect, caster, target, data, val, limit)

	if self.owner.isInvincible == 2 then 
		return 
	end

	local add = math.floor(target.maxhp * val)
	if limit then 
		if val > 0 then
			add = math.min(add, limit)
		else
			add = math.max(add, limit)
		end
	end

	if target == self.owner then -- 给自己加的属性删除时自动删掉
		self.addAttrattr.maxhp = self.addAttrattr.maxhp or 0
		self.addAttrattr.maxhp = self.addAttrattr.maxhp + add
	end

	target:AddBuffAttr("maxhp", add)

	if val>0 then
		target.hp =  target.hp + add
	else
		if target.hp > target:Get("maxhp") then
			target.hp = math.floor(target:Get("maxhp"))
		end
	end

	local todo = function(target)
		if target.hp > target:Get("maxhp") then
			target.hp = math.floor(target:Get("maxhp"))
		end

		local log = {api="AddAttrPercent", bufferID = self.id, targetID = target.oid, uuid = self.uuid, 
		attr = "maxhp", add = -add}
		log.maxhp = target:Get("maxhp")
		log.hp = target:Get("hp")
		self.log:Add(log)
	end
	
	self:AddTodoOnDelete(todo, target)

	local log = {api="AddAttrPercent", bufferID = self.id, targetID = target.oid, uuid = self.uuid, 
	attr = "maxhp", add = add, effectID = effect.apiSetting}
	log.maxhp = target:Get("maxhp")
	log.hp = target:Get("hp")
	self.log:Add(log)
end
-- -- 无法行动
-- function BuffBase:Motionless(target, caster)
-- 	LogDebugEx("-----无法行动-----", self.owner.name)
-- end

-- 嘲讽
function BuffBase:Sneer(effect, caster, target, data)
	LogDebugEx("-----嘲讽-----", self.owner.name)
	self.sneer = caster
	target:Sneer(caster)

	local log = {api="Sneer", bufferID = self.id, targetID = target.oid, casterID = caster.oid, 
	uuid = self.uuid, effectID = effect.apiSetting}
	self.log:Add(log)


	local todo = function(target)
		target:Sneer(nil)
	end
	
	self:AddTodoOnDelete(todo, target)
end

function BuffBase:Silence(effect, caster, target, data)
	LogDebugEx("-----沉默-----", self.owner.name)
	self.silence = true
	target:Silence(true)

	local log = {api="Silence", bufferID = self.id, targetID = target.oid, casterID = caster.oid, 
	uuid = self.uuid, effectID = effect.apiSetting}
	self.log:Add(log)


	local todo = function(target)
		target:Silence(nil)
	end
	
	self:AddTodoOnDelete(todo, target)
end

-- 加盾(吸收盾)
function BuffBase:AddShield(effect, caster, target, data, cureTy, percent)
	LogDebugEx("-----加盾-----", self.owner.name)
	local val = self:CalcCure(caster, target, cureTy, percent)
	self:AddShieldValue(effect, caster, target, data, val)
end

-- 加盾(固定值)
function BuffBase:AddShieldValue(effect, caster, target, data, val)
	LogDebugEx("-----加盾值-----", self.owner.name, val)
	-- local val = self:CalcCure(caster, target, cureTy, percent)
	if val <= 0 then return end

	self.shield = val
	target:AddShield(self)

	local log = {api="AddShield", bufferID = self.id, targetID = target.oid, shield = val, 
		uuid = self.uuid, effectID = effect.apiSetting}
	self.log:Add(log)


	local todo = function(target)
		target:DelShield(self)
	end
	
	self:AddTodoOnDelete(todo, target)
end

-- 减伤护盾
function BuffBase:AddReduceShield(effect, caster, target, data, damage, cureTy, percent)
	LogDebugEx("-----减伤护盾-----", self.owner.name, damage, cureTy, percent)

	local val = self:CalcCure(caster, target, cureTy, percent)
	self.oReduceShield = {}

	self.oReduceShield.shield = val
	self.oReduceShield.damage = damage

	target:AddReduceShield(self)

	local todo = function(target)
		target:DelReduceShield(self)
	end
	
	self:AddTodoOnDelete(todo, target)

	-- local log = {api="AddShield", bufferID = self.id, targetID = target.oid, shield = self.oReduceShield.shield, 
	-- 	uuid = self.uuid, effectID = effect.apiSetting}
	-- self.log:Add(log)
end

-- 加盾墙
function BuffBase:AddShieldWall(effect, caster, target, data, cureTy, percent)
	local val = self:CalcCure(caster, target, cureTy, percent)
	LogDebugEx("-----加盾墙-----", self.owner.name, cureTy, percent, val)
	if val <= 0 then return end

	self.shieldWall = val
	local fightMgr = self.fightMgr
	fightMgr:AddShieldWall(self)
	-- target:AddShield(self)

	local log = {api="AddShield", bufferID = self.id, targetID = target.oid, shield = val, 
		uuid = self.uuid, effectID = effect.apiSetting}
	self.log:Add(log)
end

-- 物理护盾(不可定义OnActionOver2事件)
function BuffBase:AddPhysicsShield(effect, caster, target, data, round, uplimit)
	LogDebugEx("-----物理护盾-----", target.name, round)
	-- LogTrace()

	local oPhysicsShield = target.oPhysicsShield
	target.oPhysicsShield	= self
	target.GetDamage		= target.GetDamageShield

	if self.nPhysicsShield then
		self.nPhysicsShield = self.nPhysicsShield + round
		if uplimit and self.nPhysicsShield > uplimit then -- 护盾上限值
			self.nPhysicsShield = uplimit
		end
		self.log:Add({api="UpdateBuffer", bufferID = self.id, targetID = target.oid, uuid = self.uuid, 
				nShieldCount = self.nPhysicsShield, effectID = effect.apiSetting, add = round})
	else
		self.nPhysicsShield = round

		local todo = function(target)
			-- self.nLightShield = nil
			target.oPhysicsShield	= nil
			if not target.oLightShield then
				target.GetDamage = target.GetDamageCommon
				-- 破盾
				self.log:Add({api="DeleteShield", bufferID = self.id, targetID = target.oid, uuid = self.uuid, effectID = effect.apiSetting})
			end
		end
		
		self:AddTodoOnDelete(todo, target)
	end

	self.nCount = self.nPhysicsShield
end

-- 光束护盾(不可定义OnActionOver2事件)
function BuffBase:AddLightShield(effect, caster, target, data, round, uplimit)
	LogDebugEx("-----光束护盾-----", target.name, round)

	local oLightShield = target.oLightShield

	target.oLightShield	= self
	target.GetDamage	= target.GetDamageShield

	if self.nLightShield then
		self.nLightShield = self.nLightShield + round
		if uplimit and self.nLightShield > uplimit then -- 护盾上限值
			self.nLightShield = uplimit
		end

		self.log:Add({api="UpdateBuffer", bufferID = self.id, targetID = target.oid, uuid = self.uuid, 
				nShieldCount = self.nLightShield, effectID = effect.apiSetting, add = round})
	else
		self.nLightShield = round

		local todo = function(target)
			-- self.nLightShield = nil
			target.oLightShield	= nil
			if not target.oPhysicsShield then
				target.GetDamage = target.GetDamageCommon
				-- 破盾
				self.log:Add({api="DeleteShield", bufferID = self.id, targetID = target.oid, uuid = self.uuid, effectID = effect.apiSetting})
			end
		end
		
		self:AddTodoOnDelete(todo, target)
	end

	self.nCount = self.nLightShield
end

-- 持续治疗
function BuffBase:Cure(effect, caster, target, data, cureTy, percent)
	LogDebugEx("-----持续治疗-----", self.owner.name)
	local hp = self:CalcCure(caster, target, cureTy, percent)
	local damageAdjust = self.creater:Get("cure") * target:Get("becure")
	hp = math.floor(hp * damageAdjust)

	target:AddHp(hp, caster)
	self.log:Add({api="BufferCure", bufferID = self.id, targetID = target.oid, uuid = self.uuid, 
		attr = "hp", hp = target:Get("hp"), add = hp, effectID = effect.apiSetting})

	local fightMgr = self.fightMgr
	target.currCureHp = hp -- 当前治疗量
	fightMgr:DoEventWithLog("OnCure", caster, target, data)
	target.currCureHp = nil
end

-- 持续伤害
function BuffBase:Damage(effect, caster, target, data, cureTy, percent)
	LogDebugEx("-----持续伤害-----", self.owner.name)

	if target:GetTempSign("ImmuneDamage") then  
		return
	end

	if not target:IsLive() then return end -- 死了就不要伤害否则会重复掉死亡事件
	
	local hp = self:CalcCure(caster, target, cureTy, percent)
	local damageAdjust = caster:Get("damage") * target:Get("bedamage")
	hp = math.floor(hp * damageAdjust)

	local isdeath, shield, num = target:AddHpNoShield(-hp, caster)
	self.log:Add({api="BufferDamage", death = isdeath, bufferID = self.id, targetID = target.oid, 
		uuid = self.uuid, attr = "hp", hp = target:Get("hp"), add = -num, effectID = effect.apiSetting})

	if not isdeath or bNotDeathEvent then return end
	self:DoDeathEvent(caster, target)
end

-- 伤害(取小保护)
function BuffBase:LimitDamage(effect, caster, target, data, percenthp, percentatt)
	LogDebugEx("-----限制最大伤害LimitDamage-----", self.id, self.owner.name, percenthp, percentatt)
	LogDebugEx("target目标",target.name, caster.name)
	--LogTrace()
	caster = self.creater
	target = self.card

	-- local isdeathPre = target:IsLive()
	if not target:IsLive() then return end -- 死了就不要伤害否则会重复掉死亡事件

	if target:GetTempSign("ImmuneDamage") then  
		return
	end

	local hp2 = self:CalcCure(caster, target, 2, percenthp) -- 持有者血量
	local hp3 = self:CalcCure(caster, target, 3, percentatt) -- 创建者攻击

	-- [4.2版本]
	local coefficient = 1+(caster:GetValue("LimitDamage") or 0) -- 限制真实伤害
	local damageAdjust = caster:Get("damage") * target:Get("bedamage") * coefficient

	local hp = math.floor(math.min(hp2, hp3) * damageAdjust)
	LogDebugEx(string.format("hp=%s, attack=%s damage=%s bedamage=%s damageAdjust= %s",
	hp2, hp3, caster:Get("damage") , target:Get("bedamage"), damageAdjust))

	local isdeath, shield, num = target:AddHpNoShield(-hp, caster)
	self.log:Add({api="BufferDamage", death = isdeath, bufferID = self.id, targetID = target.oid, 
		uuid = self.uuid, attr = "hp", hp = target:Get("hp"), add = -num, effectID = effect.apiSetting, isReal = true}) --isReal真实伤害

	if not isdeath or bNotDeathEvent then return end
	self:DoDeathEvent(caster, target)
end


-- 伤害(取小保护)
function BuffBase:LimitDamage2(effect, caster, target, data, percenthp, percentatt)
	LogDebugEx("-----限制最大伤害LimitDamage2-----", self.id, self.owner.name, percenthp, percentatt)
	LogDebugEx("target目标",target.name, caster.name, self.uuid)
	-- LogTrace()
	caster = self.creater
	target = self.card

	if not target:IsLive() then return end -- 死了就不要伤害否则会重复掉死亡事件

	if target:GetTempSign("ImmuneDamage") then  
		return
	end

	local hp2 = self:CalcCure(caster, target, 2, percenthp) -- 持有者血量
	local hp3 = self:CalcCure(caster, target, 3, percentatt) -- 创建者攻击
	-- FightCardBase:SetValue(key, {"buffid1":系数1, "buffid2":系数2}, data)

	-- [4.2版本]
	local coefficient = 1+(caster:GetValue("LimitDamage"..self.id) or 0) -- buff持续伤害强化系数
	local coefficient2 = 1+(caster:GetValue("LimitDamage") or 0) -- 限制真实伤害
	local damageAdjust = caster:Get("damage") * target:Get("bedamage") * coefficient * coefficient2
	local hp = math.floor(math.min(hp2, hp3) * damageAdjust)
	LogDebugEx(string.format("hp=%s, attack=%s damage=%s bedamage=%s damageAdjust= %s",
	hp2, hp3, caster:Get("damage") , target:Get("bedamage"), damageAdjust))

	local isdeath, shield, num = target:AddHpNoShield(-hp, caster)
	self.log:Add({api="BufferDamage", death = isdeath, bufferID = self.id, targetID = target.oid, 
		uuid = self.uuid, attr = "hp", hp = target:Get("hp"), add = -num, effectID = effect.apiSetting, isReal = true}) --isReal真实伤害

	if not isdeath or bNotDeathEvent then return end
	self:DoDeathEvent(caster, target)
end

-- 伤害(取小保护) 被施法方攻击
function BuffBase:LimitDamage3(effect, caster, target, data, percenthp, percentatt)
	LogDebugEx("-----限制最大伤害LimitDamage-----", self.id, self.owner.name, percenthp, percentatt)
	LogDebugEx("target目标",target.name, caster.name)
	--LogTrace()
	caster = self.creater
	target = self.card

	-- local isdeathPre = target:IsLive()
	if not target:IsLive() then return end -- 死了就不要伤害否则会重复掉死亡事件

	if target:GetTempSign("ImmuneDamage") then  
		return
	end

	local hp2 = self:CalcCure(caster, target, 2, percenthp) -- 持有者血量
	local hp3 = self:CalcCure(target, target, 3, percentatt) -- 目标攻击

	-- [4.2版本]
	local coefficient = 1+(caster:GetValue("LimitDamage") or 0) -- 限制真实伤害
	local damageAdjust = caster:Get("damage") * target:Get("bedamage") * coefficient

	local hp = math.floor(math.min(hp2, hp3) * damageAdjust)
	LogDebugEx(string.format("hp=%s, attack=%s damage=%s bedamage=%s damageAdjust= %s",
	hp2, hp3, caster:Get("damage") , target:Get("bedamage"), damageAdjust))

	local isdeath, shield, num = target:AddHpNoShield(-hp, caster)
	self.log:Add({api="BufferDamage", death = isdeath, bufferID = self.id, targetID = target.oid, 
		uuid = self.uuid, attr = "hp", hp = target:Get("hp"), add = -num, effectID = effect.apiSetting, isReal = true}) --isReal真实伤害

	if not isdeath or bNotDeathEvent then return end
	self:DoDeathEvent(caster, target)
end


-- 牢笼(创建buff调用)
function BuffBase:Cage(effect, caster, target, data, cureTy, percent)
	caster = self.creater
	target = self.card
	local hp = self:CalcCure(caster, target, cureTy, percent)
	hp = math.floor(hp)
	if hp <= 0 then return end
	target:SetSign("Cage",hp,{hp=hp, caster = caster}) 

	self.log:Add({api="AddCage", bufferID = self.id, targetID = target.oid, 
		uuid = self.uuid, cage = hp, effectID = effect.apiSetting})
end

-- 攻击牢笼(回合开始调用)
function BuffBase:AttackCage(effect, caster, target, data, percent)
	LogDebugEx("-----对牢笼的伤害-----", self.id, self.owner.name, percenthp, percentatt)
	-- LogDebugEx("target目标",target.name, caster.name)
	-- 这里攻击方应该是buff所有者,受击方是buff创建者, 所以需要反过来
	caster = self.card
	target = self.creater
	local cage = caster:GetSign("Cage")
	if not cage then return end

	local crit = target:IsCrit(caster)
	local damage = target:GetDamage(caster, percent, crit)
	cage.val = cage.val - damage
	
	local effectID = effect and effect.apiSetting or 0
	self.log:Add({api="UpdateCage", bufferID = self.id, targetID = caster.oid, 
		uuid = self.uuid, cage = cage.val, damage = damage, effectID = effectID, crit = crit})

	--LogDebugEx("-----对牢笼的伤害--222---", damage, cage.val)
	if cage.val <= 0 then
		-- 删除牢笼
		self.mgr:DelBuffer(self, caster, target)
	end
end
------------------------
-- buffer事件
function BuffBase:AddDelEvent(key, fun)
	self.arrDelEvent[key] = fun
end

--盾吸收伤害
function BuffBase:OnShield(num, caster)
	LogDebugEx("-----盾吸收伤害-----", self.owner.name)
	local target = self.owner
	local caster = caster or self.caster

	local oshield = self.shield
	self.shield = self.shield + num
	LogDebugEx(string.format("盾抵消伤害%s, oshield = [%s], add = [%s], res = [%s]", self.name, oshield, num, self.shield))
	if self.shield > 0 then
		self.log:Add({api="UpdateBuffer", bufferID = self.id, targetID = target.oid, uuid = self.uuid, shield = self.shield})
		return false, -num, 0
	end
	num = self.shield
	self.shield = 0
	self.log:Add({api="UpdateBuffer", bufferID = self.id, targetID = target.oid, uuid = self.uuid, shield = self.shield})
	self.caster = caster -- 处理删除事件攻击方问题
	self.mgr:DelBuffer(self, caster)
	-- self:OnDelShield(caster)
	return true, oshield, num
end

function BuffBase:OnShieldWall(num, caster)
	LogDebugEx("-----盾吸收伤害-----", self.owner.name)
	local target = self.owner
	local caster = self.caster

	local oshield = self.shieldWall
	self.shieldWall = self.shieldWall + num
	LogDebugEx(string.format("盾抵消伤害%s, oshield = [%s], add = [%s], res = [%s]", self.name, oshield, num, self.shieldWall))
	if self.shieldWall > 0 then
		self.log:Add({api="UpdateBuffer", bufferID = self.id, targetID = target.oid, uuid = self.uuid, shield = self.shieldWall})
		return false, -num, 0
	end
	num = self.shieldWall
	self.shieldWall = 0
	self.log:Add({api="UpdateBuffer", bufferID = self.id, targetID = target.oid, uuid = self.uuid, shield = self.shieldWall})
	-- self:OnDelShield(caster)
	self.mgr:DelBuffer(self, caster)
	return true, oshield, num
end

--减伤盾吸收伤害
function BuffBase:OnReduceShield(num, caster)
	LogDebugEx("-----减伤盾吸收伤害-----", self.owner.name, num, self.owner.hp)
	local target = self.owner
	local caster = caster or self.caster

	-- self.oReduceShield.shield = math.floor(target:Get("maxhp")*percent)
	-- self.oReduceShield.damage = damage

	local damage = math.floor(-self.oReduceShield.damage*num)

	local oshield = self.oReduceShield.shield
	self.oReduceShield.shield = self.oReduceShield.shield - damage
	LogDebugEx(string.format("减伤盾抵消伤害%s, oshield = [%s], add = [%s], res = [%s]", self.name, oshield, damage, self.oReduceShield.shield))
	if self.oReduceShield.shield > 0 then
		-- self.log:Add({api="UpdateBuffer", bufferID = self.id, targetID = target.oid, uuid = self.uuid, shield = self.oReduceShield.shield})
		LogDebugEx(string.format("减伤盾抵消伤害1xx%s, [%s],[%s],[%s]", self.name, false, damage, num+damage))
		return true, damage, num+damage
	end

	-- num = self.oReduceShield.shield
	-- local remain = self.oReduceShield.shield
	self.oReduceShield.shield = 0
	-- self.log:Add({api="UpdateBuffer", bufferID = self.id, targetID = target.oid, uuid = self.uuid, shield = self.oReduceShield.shield})
	LogDebugEx(string.format("减伤盾抵消伤害2xx%s, [%s],[%s],[%s]", self.name, true, oshield, num+oshield))
	self.mgr:DelBuffer(self, caster)
	return true, oshield, num+oshield --self.oReduceShield.shield
end


-- 物理盾
function BuffBase:OnPhysicsShield()
	LogDebugEx("-----盾吸收伤害-----", self.owner.name)
	local target = self.owner
	local caster = self.caster

	self.nPhysicsShield = self.nPhysicsShield - 1
	self.nCount = self.nPhysicsShield
	self.log:Add({api="UpdateBuffer", bufferID = self.id, targetID = target.oid, uuid = self.uuid, 
				nShieldCount = self.nPhysicsShield})

	-- if not self.OnActionOver2 then
	-- 	self.OnActionOver2 = function(self)
	-- 		if self.nPhysicsShield <= 0 then
	-- 			-- target.GetDamage = target.GetDamageCommon
	-- 			self.nPhysicsShield = nil
	-- 			target.oPhysicsShield	= nil
	-- 			self.mgr:DelBuffer(self, caster, target)
	-- 		end
	-- 	end
	-- 	self.mgr:AddEvent("OnActionOver2", self)
	-- end

	if self.nPhysicsShield <= 0 then
		self.nPhysicsShield = nil
		target.oPhysicsShield	= nil
	end
end

-- 光束盾
function BuffBase:OnLightShield()
	LogDebugEx("-----盾吸收伤害-----", self.owner.name)
	local target = self.owner
	local caster = self.caster

	self.nLightShield = self.nLightShield - 1
	self.nCount = self.nLightShield
	self.log:Add({api="UpdateBuffer", bufferID = self.id, targetID = target.oid, uuid = self.uuid, 
				nShieldCount = self.nLightShield})

	-- if not self.OnActionOver2 then
	-- 	self.OnActionOver2 = function(self)
	-- 		if self.nLightShield <= 0 then
	-- 			-- target.GetDamage = target.GetDamageCommon
	-- 			self.nLightShield = nil
	-- 			target.oLightShield	= nil
	-- 			self.mgr:DelBuffer(self, caster, target)
	-- 		end
	-- 	end

	-- 	self.mgr:AddEvent("OnActionOver2", self)
	-- end
	
	if self.nLightShield <= 0 then
		self.nLightShield = nil
		target.oLightShield	= nil
	end
end

function BuffBase:OnCreate(target, caster)
end

-- 删除事件前
function BuffBase:OnPreDelete()
	local target = self.owner
	local caster = self.caster
	-- 删除buff属性
	for k,v in pairs(self.addAttrattr) do
		if v ~= 0 then
			target:AddBuffAttr(k, -v)
		end
	end
	self.addAttrattr = {}

	for k,v in pairs(self.attrPercent) do
		if v ~= 0 then
			target:AddAttrPercent(k, -v)
		end
	end	
	self.attrPercent = {}

	-- if self.sneer then
	-- 	target:Sneer(nil)
	-- end

	-- if self.silence then
	-- 	target:Silence(nil)
	-- end	

	if self.bIgnoreSingleAttack then
		target:IgnoreSingleAttack(nil)
		self.bIgnoreSingleAttack = nil
	end

	if self.bIgnoreShield then
		target:IgnoreShield(nil)
		self.bIgnoreShield = nil
	end	

	-- if self.shield then
	-- 	target:DelShield(self)
	-- end

	-- if self.oReduceShield then
	-- 	target:DelReduceShield(self)
	-- end	

	if self.shieldWall then
		local fightMgr = self.fightMgr
		fightMgr:DelShieldWall(self)
		self.shieldWall = nil
	end	

	-- if self.nPhysicsShield or self.nLightShield then
	-- 	target.GetDamage = target.GetDamageCommon
	-- end

	if self.type == 3008 then -- 牢笼buff才需要处理, 其他buff不调用
		-- 删除牢笼
		local cage = target:GetSign("Cage")
		if cage then
			target:DelSign("Cage")
			self.log:Add({api="DelCage", bufferID = self.id, targetID = target.oid, 
				uuid = self.uuid, cage = cage.val, damage = damage})
		end
		--LogTrace()
	end

	-- if self.bSignAddNp then
	-- 	target:DelSign("signAddNp")
	-- end

	-- if self.bSignAddSP then
	-- 	target:DelSign("signAddSP")
	-- end

	-- if self.bSignAddXp then
	-- 	target:DelSign("signAddXp")
	-- end	

	if self.todoOnDel then
		for i,v in ipairs(self.todoOnDel) do
			v.cb(v.arg)
		end
		self.todoOnDel = nil
	end
end

-- 删除事件
function BuffBase:OnDelete(bRemoveEvent,eBuffDeleteType)
	LogDebugEx("BuffBase:OnDelete", self.id, bRemoveEvent,eBuffDeleteType)
	local target = self.owner
	local caster = self.caster
	self:OnPreDelete()

	local log = {api="DelBuffer", bufferID = self.id, uuid = self.uuid, type = eBuffDeleteType}--, effectID = self.effectID
	self.log:Add(log)

	if bRemoveEvent then
		if self.OnRemoveBuff then
			-- self.fightMgr:DoEventWithLog("OnRemoveBuff", self.owner)

			self.log:StartSub("OnRemoveBuff")
			-- self.caster = caster or self.caster
			--LogDebugEx("OnRemoveBuff", self.caster.name)
			-- local caster = self.caster
			-- self.caster = self.owner
			self:OnRemoveBuff(self.owner)
			-- self.caster = caster
			-- self:OnRemoveBuff(caster, target)
			self.log:EndSub("OnRemoveBuff")
		end

		self.fightMgr.oFightEventMgr:DelBuffer(self, caster, target)
	end

	-- 删除关联buff
	if self.tRelevanceBuff then
		local buffer = self.tRelevanceBuff
		buffer.tRelevanceBuff = nil -- 防止重复删除
		buffer.mgr:DelBuffer(buffer)
	end

	self.bIsDelete = true  -- 在事件中如果删除buff,  仍旧有可能存在上一次事件循环中, 此处记个标记, 事件中遇到则不处理
end

-- -- 回合开始
-- function BuffBase:OnRoundBegin()
-- 	LogDebugEx("BuffBase:OnRoundBegin", self.owner.name, self.caster.name)
-- end

-- 更新CD
function BuffBase:OnUpdateBuffer()
	LogDebugEx("BuffBase:OnUpdateBuffer", self.owner.name, self.id, self.round)
	if self.round then
		if self.round > 0 then
			self.round = self.round - 1
			self.log:Add({api="UpdateBuffer", bufferID = self.id, uuid = self.uuid, round = self.round})
		end
		if self.round <= 0 then
			-- 删除buffer
			self.mgr:DelBuffer(self)
		end
	end
end

-- 设置关联的buff
function BuffBase:SetRelevanceBuff(buffer)
	LogDebugEx("BuffBase:SetRelevanceBuff")
	self.tRelevanceBuff = buffer 
end

-- 结算伤害并删除buff
function BuffBase:ClosingBuff()
	LogDebugEx("BuffBase:ClosingBuff")
	local round = self.round or 0

	-- 模拟round次回合开始
	local caster = self.caster
	self.caster = self.owner
	for i=1,round do
		-- 结算伤害
		if self.owner:IsLive() then
			if self.OnRoundBegin then 
				self:OnRoundBegin(self.owner)
			end
			if self.OnAfterRoundBegin then 
				self:OnAfterRoundBegin(self.owner)
			end			
		end
	end
	self.caster = caster

	-- 删除buffer
	self.mgr:DelBuffer(self)
end

function BuffBase:ChangeSkill(effect, caster, target, data, nIndex, skillID)
	FightAPI.ChangeSkill(self, effect, self.owner, target, data, nIndex, skillID)
end

-- 无法加np
function BuffBase:UnableAddNp(effect, caster, target, data, val)
	local target = self.owner
	val = val or 1000
	target:SetSign("signAddNp", val)
	self.bSignAddNp = true

	local todo = function(target)
		target:DelSign("signAddNp")
	end
	
	self:AddTodoOnDelete(todo, target)
end

-- 无法加sp
function BuffBase:UnableAddSP(effect, caster, target, data, val)
	local target = self.owner
	val = val or 1000
	target:SetSign("signAddSP", val)
	self.bSignAddSP = true

	local todo = function(target)
		target:DelSign("signAddSP")
	end
	
	self:AddTodoOnDelete(todo, target)
end

-- 无法加sp
function BuffBase:UnableAddXp(effect, caster, target, data, val)
	local target = self.owner
	val = val or 1
	target:SetSign("signAddXp", val)
	self.bSignAddXp = true

	local todo = function(target)
		target:DelSign("signAddXp")
	end
	
	self:AddTodoOnDelete(todo, target)
end

-- buff拥有者给目标加buff
function BuffBase:OwnerAddBuff(effect, caster, target, data, buffID, nRoundNum)
	local caster = self.owner
	if target:IsLive() then
		local buff = target:AddBuff(caster, buffID, nRoundNum, effect.apiSetting)
	end
	LogDebug("OwnerAddBuff = %s, %s, %s, %s", effectID, self.name, caster.name, target.name)
end

-- buff创建者给目标加buff
function BuffBase:CreaterAddBuff(effect, caster, target, data, buffID, nRoundNum)
	local caster = self.creater
	if target:IsLive() then
		local buff = target:AddBuff(caster, buffID, nRoundNum, effect.apiSetting)
	end
	LogDebug("CreaterAddBuff = %s, %s, %s, %s", effectID, self.name, caster.name, target.name)
end

-- 通用伤害 eDamageType 攻击类型
function BuffBase:SkillDamage(effect, caster, target, data, percent, count, maxcount, eDamage, careerAdjust)
	-- LogDebugEx("BuffBase:SkillDamage",  caster.name, target.name)

	local isdeath = false
	if maxcount and maxcount > count then
		local r = self.card:Rand(maxcount - count)
		count = count + r
	end

	count = count or 1
	for i=1,count do
		local crit = target:IsCrit(caster)
		local attack = target:GetDamage(caster, percent, crit, eDamage, careerAdjust)
		local isAdjust, corpsAdjust= CorpsAdjust(caster, target)

		if isAdjust then -- 兵种克制
			if corpsAdjust == 0 then
				isMiss = true
				attack = 0
			else
				attack = math.floor(attack * corpsAdjust)
			end
		end
		-- LogDebugEx("isAdjust", totlehit, totlemiss)
		
		local tisdeath, shield, num, abnormalities = target:AddHp(-attack, caster)
		self.log:Add({api="BufferDamage", death = tisdeath, bufferID = self.id, targetID = target.oid, 
			uuid = self.uuid, attr = "hp", hp = target:Get("hp"), add = -num, shieldDamage = shield,effectID = effect.apiSetting})
		
		if tisdeath then
			isdeath = true
			break
		end
	end
	return attack, crit, isdeath
end

-- 物理伤害
function BuffBase:DamagePhysics(effect, caster, target, data, percent, count, maxcount)

	LogDebugEx("BuffBase:DamagePhysics", percent, self.percent, g_careerAdjust)
	LogDebugEx("career", caster.career, target.career, caster:Get("damagePhysics"))
	percent = percent * caster:Get("damagePhysics")
	local careerAdjust = nil
	if target.career == eCareer.Light then
		-- 光束克制
		careerAdjust = true
	end
	return self:SkillDamage(effect, caster, target, data, percent, count, maxcount, eDamageType.Physics, careerAdjust)
end

-- 光束伤害
function BuffBase:DamageLight(effect, caster, target, data, percent, count, maxcount)

	LogDebugEx("BuffBase:DamageLight", percent, self.percent, g_careerAdjust)
	LogDebugEx("career", caster.career, target.career)

	percent = percent * caster:Get("damageLight")
	local careerAdjust = nil
	if target.career == eCareer.Physics then
		-- 物理克制
		careerAdjust = true
	end
	return self:SkillDamage(effect, caster, target, data, percent, count, maxcount, eDamageType.Light, careerAdjust)
end

-- 特殊伤害
function BuffBase:DamageSpecial(effect, caster, target, data, percent, count, maxcount)

	LogDebugEx("BuffBase:DamageSpecial", percent, self.percent, g_careerAdjust)
	LogDebugEx("career", caster.career, target.career)

	percent = percent * caster:Get("damageSpecial")
	local careerAdjust = nil

	--  特殊克特殊
	if target.career == eCareer.Special then
		careerAdjust = true
	end
	return self:SkillDamage(effect, caster, target, data, percent, count, maxcount, eDamageType.Special, careerAdjust)
end


--设置标记
function BuffBase:SetBuffValue(effect, caster, target, data, key, val)
	LogDebugEx("--设置标记", self.name, key, val)
	self.arrValue[key] = val
end

--获取标记数据
function BuffBase:GetBuffValue(effect, caster, target, data, key)
	LogDebugEx("--获取标记数据", self.name, key, self.arrValue[key])
	return self.arrValue[key]
end

--删除标记
function BuffBase:DelBuffValue(effect, caster, target, data, key)
	LogDebugEx("--删除标记", self.name, key)
	self.arrValue[key] = nil
end


-- -- 判断buffer是否免疫
-- function BuffBase:IsImmuneBuff(effect, caster, target, data, buffID)
-- 	local config = BufferConfig[buffID]
-- 	ASSERT(config)
-- 	if target:GetTempSign("ImmuneBuffQuality"..config.goodOrBad) then return true end
-- 	if target:GetTempSign("ImmuneBufferGroup"..config.group) then return true end
-- end

-- -- 免疫buff(所有)
-- function BuffBase:ImmuneBuffer(effect, caster, target, data)
-- 	target:SetTempSign("ImmuneBuffer")
-- end


-- 调用免疫
function BuffBase:ImmuneBuffFun(effect, caster, target, data, key)
	-- target:SetTempSign("ImmuneBuffQuality"..buffID)
	-- local key = "ImmuneBuffQuality"..buffID

	--LogDebugEx("BuffBase:ImmuneBuffFun", key, target.name)
	target.arrTempBuffEffct[key] = target.arrTempBuffEffct[key] or {}
	table.insert(target.arrTempBuffEffct[key], self)
	
	local todo = function(target)
		-- local key = "ImmuneBuffQuality"..buffID
		local arr = target.arrTempBuffEffct[key]
		if not arr then return end

		for i,v in ipairs(arr) do
			if v == self then
				table.remove(arr, i)
				if #arr == 0 then
					target.arrTempBuffEffct[key] = nil
				end
				return
			end
		end
	end
	
	self:AddTodoOnDelete(todo, target)
end

-- 免疫buff id
function BuffBase:ImmuneBuffID(effect, caster, target, data, buffID, num)
	-- target:SetTempSign("ImmuneBuffID"..buffID)
	local key = "ImmuneBuffID"..buffID
	LogDebugEx("免疫buff id", buffID)
	self:ImmuneBuffFun(effect, caster, target, data, key)
end

-- 免疫buff(按好坏的性质)
function BuffBase:ImmuneBuffQuality(effect, caster, target, data, buffID)
	-- target:SetTempSign("ImmuneBuffQuality"..buffID)
	local key = "ImmuneBuffQuality"..buffID
	self:ImmuneBuffFun(effect, caster, target, data, key)
end

-- 免疫buff(按组)
function BuffBase:ImmuneBufferGroup(effect, caster, target, data, buffID)
	-- target:SetTempSign("ImmuneBufferGroup"..buffID)
	local key = "ImmuneBufferGroup"..buffID
	self:ImmuneBuffFun(effect, caster, target, data, key)
end

-- 免疫退条
function BuffBase:ImmuneRetreat(effect, caster, target, data)
	target:SetTempSign("ImmuneRetreat")

	local todo = function(target)
		target.arrTempSign.ImmuneRetreat = nil
	end
	
	self:AddTodoOnDelete(todo, target)
end

-- 免疫拉条
function BuffBase:ImmuneAddProgress(effect, caster, target, data)
	target:SetTempSign("ImmuneAddProgress")

	local todo = function(target)
		target.arrTempSign.ImmuneAddProgress = nil
	end
	
	self:AddTodoOnDelete(todo, target)
end


-- 免疫伤害
function BuffBase:ImmuneDamage(effect, caster, target, data)
	target:SetTempSign("ImmuneDamage")
	local todo = function(target)
		target.arrTempSign.ImmuneDamage = nil
	end
	
	self:AddTodoOnDelete(todo, target)
end

-- 免疫死亡
function BuffBase:ImmuneDeath(effect, caster, target, data)
	target:SetTempSign("ImmuneDeath")
	local todo = function(target)
		target.arrTempSign.ImmuneDeath = nil
	end
	
	self:AddTodoOnDelete(todo, target)
end

-- 免疫伤害
function BuffBase:ImmuneBeatBack(effect, caster, target, data)
	target:SetSign("ImmuneBeatBack", 1)
	local todo = function(target)
		target:DelSign("ImmuneBeatBack")
	end
	
	self:AddTodoOnDelete(todo, target)
end

-- 麻痹
function BuffBase:Palsy(effect, caster, target, data)
	target:SetTempSign("Palsy")
	local todo = function(target)
		target.arrTempSign.Palsy = nil
	end
	
	self:AddTodoOnDelete(todo, target)
end


-- 过热
function BuffBase:PalsyOverLoad(effect, caster, target, data)
	target:SetTempSign("PalsyOverLoad")
	local todo = function(target)
		target.arrTempSign.PalsyOverLoad = nil
	end
	
	self:AddTodoOnDelete(todo, target)
end


-- 无视分摊伤害
function BuffBase:IgnoreShareDamage(effect, caster, target, data)
	-- self.bIgnoreShareDamage = res
	target:IgnoreShareDamage(true)
	local todo = function(target)
		target:IgnoreShareDamage(nil)
	end
	
	self:AddTodoOnDelete(todo, target)
end

-- 设置回血上限比例
function BuffBase:SetCurePercent(effect, caster, target, data, percent)
	if not percent then ASSERT(nil, "回血比例:nil") return end
	if percent > 1 or percent <= 0 then ASSERT(nil, "回血比例范围有误:"..percent) end
	-- target:SetTempSign("CurePercent", percent)
	-- 可回血最大血量
	-- target.maxCureHp = math.floor(self:Get("maxhp") * percent) 
	target.fCurePercent = percent
	local todo = function(target)
		target.fCurePercent = nil
	end
	
	self:AddTodoOnDelete(todo, target)
end

-- 减少拉条比例
function BuffBase:ReduceProgressPercent(effect, caster, target, data, percent)
	if self.nAddProgressPercent then ASSERT(nil, "一个buff只能设置一次拉条比例") end
	self.nAddProgressPercent = percent
	target.tAddProgressBuffer = target.tAddProgressBuffer or {} -- 存放拉条buff
	target.tAddProgressBuffer[self.uuid] = percent

	local todo = function(target)
		target.tAddProgressBuffer[self.uuid] = nil
	end
	
	self:AddTodoOnDelete(todo, target)
end

-- 删除技能事件
function BuffBase:DeleteEvent(effect, caster, target, data)
	LogDebugEx("-----删除技能事件-----", self.owner.name)

	-- local log = {api="DeleteEvent", bufferID = self.id, targetID = self.owner, casterID = caster.oid, 
	-- uuid = self.uuid, effectID = effect.apiSetting}
	-- self.log:Add(log)

	self.owner.skillMgr:BufferDeleteEvent()
	local todo = function(target)
		target.skillMgr:RegisterEvent()
	end
	
	self:AddTodoOnDelete(todo, self.owner)
end