--角色排序工具
local this = {};
local funcs = {}

function this:Init()
	-- local newList = {1, 2, 3, 4, 5}
	-- local list = {}
	-- list[1] = self.ByFavorability
	-- list[2] = self.ByTeam
	-- list[3] = self.BuGenDer
	-- list[4] = self.ByCfgID
	-- list[5] = self.ByAcquireTime
	-- local newList = {1}
	-- local list = {}
	-- list[1] = self.ByIndex
	-- funcs = {}
	-- for i, v in ipairs(newList) do
	-- 	if(i <= #list) then
	-- 		table.insert(funcs, {i, list[v]})
	-- 	end
	-- end
end


--默认排序方式：好感度>阵型>性别>表ID>入手顺序 ==> 改 表中的排序index 20210830
function this:SortByCondition(_cards)
	self.newDatas = _cards or {}
	self:SelectBy1()
	--self:SelectBy2()
	--self:SelectBy3()
	--self:MSort(CRoleMgr:SGetCurSortType())
	--self:MSort()
	if(#self.newDatas > 1) then
		table.sort(self.newDatas, function(a, b)
			return a:GetCfgIndex() < b:GetCfgIndex()
		end)
	end
	return self.newDatas
end

function this:SelectBy1()
	local curDatas = {}
	local rule = CRoleMgr:SGetCurFiltrateType().RoleTeam
	if(rule[1] == 0) then
		return
	end
	local newRule = {}
	for i, v in ipairs(rule) do
		newRule[v] = v
	end
	local len = #self.newDatas
	for i = len, 1, - 1 do
		if(newRule[self.newDatas[i]:GetTeam()] == nil) then
			table.remove(self.newDatas, i)
		end
	end
end

function this:SelectBy2()
	local curDatas = {}
	local rule = CRoleMgr:SGetCurFiltrateType().RoleQuality
	if(rule[1] == 0) then
		return
	end
	local newRule = {}
	for i, v in ipairs(rule) do
		newRule[v] = v
	end
	local len = #self.newDatas
	for i = len, 1, - 1 do
		if(newRule[self.newDatas[i]:GetQuality()] == nil) then
			table.remove(self.newDatas, i)
		end
	end
end

-- function this:SelectBy3()
-- 	local curDatas = {}
-- 	local rule = CRoleMgr:SGetCurFiltrateType() [StringConstant.CRole_textTab4[4]]
-- 	if(rule[1] ~= 1) then
-- 		local len = #self.newDatas
-- 		for i = len, 1, - 1 do
-- 			for k = 1, #rule do
-- 				if(self.newDatas[i]:GetBlood() ==(rule[k] - 1)) then
-- 					table.insert(curDatas, self.newDatas[i])
-- 					break
-- 				end
-- 			end	
-- 		end
-- 		self.newDatas = curDatas
-- 	end
-- end
--function this:MSort()
--local firstIndex = 1
-- for i, v in ipairs(funcs) do
-- 	if(v[1] == rule) then
-- 		firstIndex = i
-- 	end
-- end
-- local func = function(a, b)
-- 	local result = nil
-- 	local firstFunc = funcs[firstIndex]
-- 	if(result == nil) then
-- 		result = firstFunc[2](a, b)
-- 	end
-- 	for i, v in ipairs(funcs) do
-- 		if(i ~= firstIndex) then
-- 			if(result == nil) then
-- 				result = v[2](a, b)
-- 			else
-- 				break
-- 			end
-- 		end
-- 	end
-- 	return result or false
-- end
-- local func = function(a, b)
-- 	for i, v in ipairs(funcs) do
-- 		if(result == nil) then
-- 			result = v[2](a, b)
-- 		else
-- 			break
-- 		end
-- 	end
-- 	return result or false
-- end
-- table.sort(self.newDatas, func)
-- 	table.sort(self.newDatas, function(a, b)
-- 		return a:GetCfgIndex() < b:GetCfgIndex()
-- 	end)
-- end
-- --好感度
-- function this.ByFavorability(a, b)
-- 	if(a:GetLv() == b:GetLv()) then
-- 		return nil
-- 	else
-- 		return a:GetLv() > b:GetLv()
-- 	end
-- end
-- --阵型
-- function this.ByTeam(a, b)
-- 	if(a:GetTeam() == b:GetTeam()) then
-- 		return nil
-- 	else
-- 		return a:GetTeam() > b:GetTeam()
-- 	end
-- end
-- --性别
-- function this.BuGenDer(a, b)
-- 	if(a:GetGender() == b:GetGender()) then
-- 		return nil
-- 	else
-- 		return a:GetGender() > b:GetGender()
-- 	end
-- end
-- --表ID
-- function this.ByCfgID(a, b)
-- 	if(a:GetCfgIndex() == b:GetCfgIndex()) then
-- 		return nil
-- 	else
-- 		return a:GetCfgIndex() > b:GetCfgIndex()
-- 	end
-- end
-- --入手顺序
-- function this.ByAcquireTime(a, b)
-- 	if(a:GetCreateTime() == b:GetCreateTime()) then
-- 		return nil
-- 	else
-- 		return a:GetCreateTime() > b:GetCreateTime()
-- 	end
-- end
this:Init()

return this;
