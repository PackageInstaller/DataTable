-- OPENDEBUG(false)
-- 目标筛选器
Filter = oo.class()
function Filter:Init(team, teamID, row, col)
	self.team = team
	self.teamID = teamID
	self.row = row
	self.col = col
end

function Filter:Destroy()
    for k,v in pairs(self) do
        self[k] = nil
    end
end

function Filter:GetIDList(list)
	list = list or {}
	local res = {}
	-- local t = {}
	for i,v in ipairs(list) do
		-- if not t[v.oid] then
			-- 排除重复对象
			table.insert(res, v.oid)
		-- 	t[v.oid] = true
		-- end
	end
	return res
end

function Filter:MakeUnique(list)
	list = list or {}
	local res = {}
	local t = {}
	for i,v in ipairs(list) do
		if not t[v.oid] then
			-- 排除重复对象
			table.insert(res, v)
			t[v.oid] = true
		end
	end

	-- for i,v in ipairs(res) do
	-- 	LogDebugEx("MakeUnique",i,v)
	-- end

	return res
end
----------------------------------------------------------
-- 目标单体
function Filter:GetCard(row, col)
	local card = self.team:GetCard(row, col)
	if card and card:IsLive() then
		return {card}
	end
end

-- 全体
function Filter:GetAll(exclude)
	local arr = self.team.arrCard
	local res = {}
	for i,v in ipairs(arr) do
		if v:IsLive() and v ~= exclude then
			table.insert(res, v)
		end
	end
	return res
end

-- 目标单体(随机一个)
function Filter:GetRand(rand, exclude,isSummonIn)
	rand = rand or 1
	local arr = self.team.arrCard
	local res = {}
	for i,v in ipairs(arr) do
		if v:IsLive() and (v.type ~= CardType.Summon or isSummonIn) and exclude ~= v then
			table.insert(res, v)
		end
	end

	local len = #res
	if len <= 1 then
		return res
	else
		-- LogDebugEx("=============", len, rand%len)
		local card = res[rand%len+1]
		ASSERT(card)
		return {card}
	end
end

-------------3v3-----------------------------------
-- 单位一排
function Filter:GetRow(row, col)
	local res = {}

	for i=1, self.col do
		local card = self.team:GetCard(row, i)
		--LogDebugEx("Filter:GetRow()", row, col, i, card and card:IsLive() or "nil")
		if card and card:IsLive() then
			table.insert(res, card)
		end
	end

	return self:MakeUnique(res)
end

-- 单位一列(isCall是否包含召唤位)
function Filter:GetCol(row, col, isCall)
	local res = {}

	local start = self.row
	if isCall then
		start = self.row + 1
	end
	for i=1, start do
		local card = self.team:GetCard(i, col)
		if card and card:IsLive() then
			table.insert(res, card)
		end
	end

	return self:MakeUnique(res)
end

-- 两行
function Filter:Get2Row(row, col)
	local res = {}

	for j=0,1 do
		for i=1, self.col do
			local card = self.team:GetCard(row+j, i)
			if card and card:IsLive() then
				table.insert(res, card)
			end
		end
	end

	return self:MakeUnique(res)
end

-- 两列
function Filter:Get2Col(row, col, isCall)
	local res = {}

	local start = self.row
	if isCall then
		start = self.row + 1
	end
	for j=0,1 do
		for i=1, start do
			local card = self.team:GetCard(i, col+j)
			if card and card:IsLive() then
				table.insert(res, card)
			end
		end
	end

	return self:MakeUnique(res)
end


-- 十字
function Filter:GetCross(row, col)
	if not row then
		row = 2
		col = 2
	end

	local pos = {{-1,0},{0,-1},{0,0},{0,1},{1,0}}
	local res = {}

	for i,v in ipairs(pos) do
		local card = self.team:GetCard(row + v[1], col + v[2])
		if card and card:IsLive() then
			table.insert(res, card)
		end
	end

	return self:MakeUnique(res)
end

-- 一行一列(动态十字)
function Filter:DynamicCross(row, col, isCall)
	local res = {}

	local card = self.team:GetCard(row, col)
	if card and card:IsLive() then
		table.insert(res, card)
	end

	for i=1, self.col do
		local card = self.team:GetCard(row, i)
		if card and card:IsLive() then
			table.insert(res, card)
		end
	end

	local start = self.row
	if isCall then
		start = self.row + 1
	end
	for i=1, start do
		local card = self.team:GetCard(i, col)
		if card and card:IsLive() then
			table.insert(res, card)
		end
	end

	return self:MakeUnique(res)
end
-------------5v5-----------------------------------
-- 同排n格
function Filter:GetRowEx(row, col, num)
	local res = {}

	for i=col, col+num-1 do
		local card = self.team:GetCard(row, i)
		if card and card:IsLive() then
			table.insert(res, card)
		end
	end

	return self:MakeUnique(res)
end

-- 同列n格
function Filter:GetColEx(row, col, num)
	local res = {}

	for i=row, row+num-1 do
		local card = self.team:GetCard(i, col)
		if card and card:IsLive() then
			table.insert(res, card)
		end
	end

	return self:MakeUnique(res)
end

-- 矩形范围
function Filter:GetRect(row, col, rownum, colnum)
	local res = {}

	for i=0,rownum-1 do
		for j=0,colnum-1 do
			local card = self.team:GetCard(row+i, col+j)
			if card and card:IsLive() then
				table.insert(res, card)
			end			
		end
	end

	return self:MakeUnique(res)
end

-------------特殊-----------------------------------
-- 尸体(全部)
function Filter:GetDead()
	local arr = self.team.arrCard
	local res = {}
	for i,v in ipairs(arr) do
		if not v:IsLive() and v.type ~= CardType.Unite and not v.isRemove then -- 复活不能取到合体对象还有机神
			table.insert(res, v)
		end
	end
	return res
end

-- 尸体(随机一个)
function Filter:GetOneDead(rand)
	rand = rand or 1
	-- local arr = self.team.arrCard
	local res = self:GetDead()

	local len = #res
	if res == 0 then
		return
	elseif res == 1 then
		return res
	else
		local card = res[rand%len+1]
		return {card}
	end
end

-- 目标外全体
function Filter:GetException(card)
	local arr = self.team.arrCard
	local res = {}
	for i,v in ipairs(arr) do
		if v:IsLive() and card ~= v then
			table.insert(res, v)
		end
	end
	return res
end

-- 召唤物
function Filter:GetCall()
	local arr = self.team.arrCard
	local res = {}
	for i,v in ipairs(arr) do
		if v:IsLive() and v.type == CardType.Summon then
			table.insert(res, v)
		end
	end
	return res
end

-------------属性判断-----------------------------------

local AttrSortFun = function(a, b, attr)
	return a:Get(attr) > b:Get(attr)
end

--获取属性最高
function Filter:GetMaxAttribute(attr, num, exclude)

	local arr = self.team.arrCard
	
	local arrTemp = {}
	for i,v in ipairs(arr) do
		--LogDebugEx("GetMaxAttribute", attr, v.name, v[attr])
		if v:IsLive() and exclude ~= v then
			table.insert(arrTemp, v)
		end
	end	

	local list = SortRankDesc(arrTemp, attr, num, AttrSortFun)
	return list
end

--获取属性最低
function Filter:GetMinAttribute(attr, num, exclude)
	local arr = self.team.arrCard

	local arrTemp = {}
	for i,v in ipairs(arr) do
		--LogDebugEx("GetMaxAttribute", attr, v.name, v[attr], num)
		if v:IsLive() and exclude ~= v then
			table.insert(arrTemp, v)
		end
	end	

	local list = SortRankAsc(arrTemp, attr, num, AttrSortFun)
	return list
end

local PctHpSortFun = function(a, b, attr)
	return a.hp/a:Get("maxhp") > b.hp/b:Get("maxhp")
end

--获取血量百分比最高
function Filter:GetMaxPercentHp(num)
	local arr = self.team.arrCard
	
	local arrTemp = {}
	for i,v in ipairs(arr) do
		if v:IsLive() then
			table.insert(arrTemp, v)
		end
	end	

	local list = SortRankDesc(arrTemp, attr, num, PctHpSortFun)
	return list
end

--获取血量百分比最低
function Filter:GetMinPercentHp(num)
	local arr = self.team.arrCard
	
	local arrTemp = {}
	for i,v in ipairs(arr) do
		if v:IsLive() then
			table.insert(arrTemp, v)
		end
	end	

	local list = SortRankAsc(arrTemp, attr, num, PctHpSortFun)
	return list
end
-------------BUFF判断-----------------------------------
-- 选择（友方/敌方）好坏BUFF优先
-- 选择（友方/敌方）群组BUFF优先
-- 选择（友方/敌方）类别BUFF优先
-- 选择（友方/敌方）BUFF优先
-- 获取血量百分比最高
function Filter:GetHasBuffID(bufferID,num)
	local arr = self.team.arrCard

	for i,v in ipairs(arr) do
		if v:IsLive() then
			local n = v.bufferMgr:GetBufferCountID(bufferID)
			if n > 0 then
				return {v}
			end
		end
	end	
	return {}
end
-------------人数判断-----------------------------------
-- 选择范围覆盖最多优先

-- 人数最多的田字范围
function Filter:GetMaxTian(rand)
	-- LogDebugEx("Filter:GetMaxTian()")
	
	local leng = 0
	local list2d = {} -- 二维数组

	for ir=1, self.row-1 do
		for ic=1, self.col-1 do
			local list = self:GetRect(ir,ic, 2, 2)
			list.pos = {ir, ic}
			local tlen = #list
			-- LogDebugEx("Filter:GetMaxTian()",ir,ic,tlen)
			if tlen > 0 then
				if tlen > leng then
					leng = tlen
					list2d = {list}
				elseif tlen == leng then
					table.insert(list2d, list)
				end
			end
		end
	end
	-- LogTable(list2d, "GetMaxTian")
	if #list2d <= 1 then
		return list2d[1] or {}
	else
		rand = rand or math.random(10000)
		-- 选择随机一个区域
		return list2d[rand%(#list2d)+1]
	end
end

-- 人数最多的十字范围 
function Filter:GetMaxCross(rand)
	local leng = 0
	local list2d = {} -- 二维数组

	for ir=1, self.row do
		for ic=1, self.col do
			local list = self:DynamicCross(ir, ic, true)
			list.pos = {ir, ic}
			local tlen = #list
			--LogDebugEx("Filter:GetMaxCross()",ir,ic,tlen)
			if tlen > 0 then
				if tlen > leng then
					leng = tlen
					list2d = {list}
				elseif tlen == leng then
					table.insert(list2d, list)
				end
			end
		end
	end

	--LogTable(list2d, "GetMaxCross")
	if #list2d <= 1 then
		return list2d[1] or {}
	else
		-- 选择随机一个区域
		rand = rand or 1
		return list2d[rand%(#list2d)+1]
	end
end
-------------强制-----------------------------------
-- 选择嘲讽目标
-- 选择随机目标

-- 选择克制对象(先找盾克制, 再找角色克制)
function Filter:GetRestrain(attackType, rand)
	if not attackType then return {} end
	
	local list = {}
	local arr = self.team.arrCard

	-- 盾克制
	if attackType == eDamageType.Physics then
		for i,v in ipairs(arr) do
			if v:IsLive() and v.oLightShield then
				table.insert(list, v)
			end
		end	
	else
		for i,v in ipairs(arr) do
			if v:IsLive() and v.oPhysicsShield then
				table.insert(list, v)
			end
		end	
	end

	if #list == 0 then
		-- 职业克制
		for i,v in ipairs(arr) do
			if v:IsLive() then
				--local n = v.bufferMgr:GetBufferCountID(bufferID)
				if v.career ~= attackType then
					table.insert(list, v)
				end
			end
		end	
	end

	if #list <= 1 then
		return list
	else
		-- 优先攻击克制单位时，如果有多个目标，选择随机一个打
		rand = rand or math.random(10000)
		return {list[rand%(#list)+1]}
	end

	return {}
end

----------------------------------------------

-- 最多一排
function Filter:GetMaxRow(rand)

	--LogDebugEx("GetMaxRow", rand)
	local leng = 0
	local list2d = {} -- 二维数组

	for i=1, self.row do
		local list = self:GetRow(i,self.col)
		local tlen = #list
		if tlen > 0 then
			list.row = i
			if tlen > leng then
				leng = tlen
				list2d = {list}
			elseif tlen == leng then
				table.insert(list2d, list)
			end
		end
	end
	--LogTable(list2d, "GetMaxRow")
	if #list2d <= 1 then
		return list2d[1] or {}
	else
		-- 选择随机一个排
		rand = rand or math.random(10000)
		return list2d[rand%(#list2d)+1]
	end
end

-- 最多一列(isCall是否包含召唤位)
function Filter:GetMaxCol(isCall, rand)
	local leng = 0
	local list2d = {} -- 二维数组

	for i=1, self.col do
		local list = self:GetCol(self.row,i,isCall)
		local tlen = #list
		if tlen > 0 then
			list.col = i
			if tlen > leng then
				leng = tlen
				list2d = {list}
			elseif tlen == leng then
				table.insert(list2d, list)
			end
		end
	end
	if #list2d <= 1 then
		return list2d[1] or {}
	else
		-- 选择随机一个列
		rand = rand or math.random(10000)
		return list2d[rand%(#list2d)+1]
	end
end

-- 小队
function Filter:GetClass(nClass)
	local arr = self.team.arrCard
	local res = {}
	for i,v in ipairs(arr) do
		if v:IsLive() and v.nClass == nClass then
			table.insert(res, v)
		end
	end
	return res
end

-- 获取尽量不同的对象
function Filter:GetDifferent(num, target)
	num = num or 1
	local arr = self.team.arrCard
	local list = {target}
	for i,v in ipairs(arr) do
		if v:IsLive() and v ~= target then
			table.insert(list, v)
		end
	end

	local res = {}
	local index = 1
	for i=1,num do
		table.insert(res, list[index])
		index = index + 1
		if index > #list then
			index = 1
		end
	end

	return res
end

-- 获取拥有buff的对象
function Filter:HasBuff(buffID, typ, rand)
	num = num or 1
	local arr = self.team.arrCard
	--LogDebugEx("Filter:HasBuff", buffID, typ)
	local list = {}
	for i,v in ipairs(arr) do
		if v:IsLive() and v:HasBuff(buffID, typ) then
			--LogDebugEx("HasBuff", v.name)
			table.insert(list, v)
			-- if #list >= num then return list end
		end
	end	

	if #list <= 1 then
		return list
	else
		-- 如果有多个目标，选择随机一个打
		rand = rand or math.random(10000)
		return {list[rand%(#list)+1]}
	end
end

-- 目标类型(随机一个)
function Filter:GetObjByType(ntype)
	rand = rand or 1
	local arr = self.team.arrCard
	local res = {}
	for i,v in ipairs(arr) do
		if v:IsLive() and v.type == ntype then
			table.insert(res, v)
		end
	end

	local len = #res
	if len <= 1 then
		return res
	else
		-- LogDebugEx("=============", len, rand%len)
		local card = res[rand%len+1]
		ASSERT(card)
		return {card}
	end
end

-- 有盾
function Filter:GetObjHaveShield()
	rand = rand or 1
	local arr = self.team.arrCard
	local res = {}
	for i,v in ipairs(arr) do
		if v:IsLive() and (#v.shield > 0 or v.reduceShield) then
			table.insert(res, v)
		end
	end

	local len = #res
	if len <= 1 then
		return res
	else
		-- LogDebugEx("=============", len, rand%len)
		local card = res[rand%len+1]
		ASSERT(card)
		return {card}
	end
end

-- 获取合体对象
function Filter:GetUnite(card)
	local arr = self.team.arrCard
	local res = {}
	local arrUnite = card.mapUnite or {}
	for i,v in ipairs(arr) do
		if v:IsLive() and v ~= card and v.nClass == card.nClass and v.type ~= CardType.Unite and arrUnite[v.id] then -- 必须是同小队并且不是同调角色
			-- table.insert(res, v)
			LogDebugEx("同队角色:", v.name,v.id)
			return {v}
		end
	end

	-- LogDebugEx("同队角色个数:", )
	return res
end

-- 获取某个角色对象
function Filter:HasRole(cId)
	local arr = self.team.arrCard
	local res = {}
	for i,v in ipairs(arr) do
		if v:IsLive() and v:GetID() == cId then
			return {v}
		end
	end
	return res
end