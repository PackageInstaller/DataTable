--角色排序工具
RoleSortUtil = {}
local this = RoleSortUtil
local funcs = {}
local teamID = 1

function this:Init()
	local newList = g_CardSortOrder or {1, 2, 3, 4, 5, 8, 9}
	local list = {}
	list[1] = self.ByQuality
	list[2] = self.ByLv
	list[3] = self.ByFavorability
	list[4] = self.ByAcquireTime
	list[5] = self.ByBreakLevel
	-- list[6] = self.ByProtectState
	-- list[7] = self.ByHot	
	list[8] = self.ByPro
	list[9] = self.ByCfgID		
	list[10] = self.ByNew
	funcs = {}
	for i, v in ipairs(newList) do
		if(i <= #list) then
			table.insert(funcs, {v, list[v]})
		end
	end
	table.insert(funcs, {10, self.ByIsNew})
end

--默认排序方式：有队伍标签>稀有度>等级>好感度>入手顺序>性能>上锁>表ID 
--_byTeam 队伍id 有值时，该队伍在最前
--_isFormat 是否是编队筛选
function this:SortByCondition(_roleListType, _cards, _byTeam, _isFormat)
	self.newDatas = _cards
	--self.byHot = _byHot
	self.byLeader = RoleMgr:CheckIsSortByLeader()
	teamID = _byTeam == nil and 1 or _byTeam
	self.defaultTeamIdx = _isFormat and - 1 or 1000;
	proName = nil
	local mulID = RoleMgr:GetMultiID(_roleListType)
	if(mulID) then
		proName = Cfgs.CfgCardPropertyEnum:GetByID(mulID).sFieldName
	end
	
	self.sortType = RoleMgr:GetSortType(_roleListType)
	self:SelectByQuality()
	--self:SelectByRoleType()
	self:SelectByFormation()
	self:SelectByRolePos()
	self:MSort()
	return self.newDatas
end

--稀有度筛选
function this:SelectByQuality()
	local rule = self.sortType.RoleQuality
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

--类型筛选
function this:SelectByRoleType()
	--local curDatas = {}
	local rule = self.sortType.RoleType
	if(rule[1] == 0) then
		return
	end
	local newRule = {}
	for i, v in ipairs(rule) do
		newRule[v] = v
	end
	local len = #self.newDatas
	for i = len, 1, - 1 do
		if(newRule[self.newDatas[i]:GetMainType()] == nil) then
			table.remove(self.newDatas, i)
		end
	end
end

--小队筛选
function this:SelectByFormation()
	local rule = self.sortType.RoleTeam
	if(rule[1] == 0) then
		return
	end
	local newRule = {}
	for i, v in ipairs(rule) do
		newRule[v] = v
	end
	local len = #self.newDatas
	for i = len, 1, - 1 do
		if(newRule[self.newDatas[i]:GetCamp()] == nil) then
			table.remove(self.newDatas, i)
		end
	end	
end

--定位筛选
function this:SelectByRolePos()
	local rule = self.sortType.RolePosEnum
	if(rule[1] == 0) then
		return
	end
	local newRule = {}
	for i, v in ipairs(rule) do
		newRule[v] = v
	end
	local len = #self.newDatas
	for i = len, 1, - 1 do
		local posEnum = self.newDatas[i]:GetPosEnum()
		if(posEnum == nil) then
			table.remove(self.newDatas, i)
		else
			local isContain = false
			for k, m in ipairs(posEnum) do
				if(newRule[m] ~= nil) then
					isContain = true
					break
				end
			end
			if(not isContain) then
				table.remove(self.newDatas, i)
			end
		end
	end	
end

function this:MSort()
	firstIndex = 1
	for i, v in ipairs(funcs) do
		if(v[1] == self.sortType.Sort[1]) then
			firstIndex = i
		end
	end
	
	table.sort(self.newDatas, function(a, b)
		return self:SortFunc(a, b)
	end)
end

function this:SortFunc(a, b)
	local result = nil
	if(self.byLeader) then
		result = self.ByLeader(a, b)
	end
	-- if(result == nil and self.byHot) then
	-- 	result = self.ByHot(a, b)
	-- end
	if(result == nil) then
		result = self.ByTeamID(a, b)
	end
	local firstFunc = funcs[firstIndex]
	if(result == nil) then
		result = firstFunc[2](a, b)
	end
	if(result == nil) then
		for i, v in ipairs(funcs) do
			if(i ~= firstIndex) then
				if(result == nil) then
					result = v[2](a, b)
				else
					break
				end
			end
		end
	end
	return result or false
end

--属性
function this.ByPro(a, b)
	if(proName) then
		if(a:GetCurDataByKey(proName) == b:GetCurDataByKey(proName)) then
			return nil
		else
			return a:GetCurDataByKey(proName) > b:GetCurDataByKey(proName)
		end
	else
		return nil
	end
end

--热值
function this.ByHot(a, b)
	if(a:GetHot() == b:GetHot()) then
		return nil
	else
		return a:GetHot() > b:GetHot()
	end
end

--有队伍标签
function this.ByTeamID(a, b)
	local i1 = TeamMgr:GetCardTeamIndex(a:GetID(),eTeamType.DungeonFight,true)
	local i2 = TeamMgr:GetCardTeamIndex(b:GetID(),eTeamType.DungeonFight,true)
	local index1 =(i1 == nil or i1 == - 1) and this.defaultTeamIdx or tonumber(i1)
	local index2 =(i2 == nil or i2 == - 1) and this.defaultTeamIdx or tonumber(i2)
	
	if(index1 == index2) then
		return nil
	else
		if(teamID == index1 and teamID ~= index2) then
			return true
		elseif(teamID ~= index1 and teamID == index2) then
			return false
		else
			return index1 < index2
		end
	end
end

--等级
function this.ByLv(a, b)
	if(a:GetLv() == b:GetLv()) then
		return nil
	else
		return a:GetLv() > b:GetLv()
	end
end
--表ID
function this.ByCfgID(a, b)
	if(a:GetCfgID() == b:GetCfgID()) then
		return nil
	else
		return a:GetCfgID() < b:GetCfgID()
	end
end

function this.ByNew(a, b)
	if(a:IsNew() == b:IsNew()) then
		return nil
	else
		return a:IsNew()
	end
end

--稀有度
function this.ByQuality(a, b)
	if(a:GetQuality() == b:GetQuality()) then
		return nil
	else
		return a:GetQuality() > b:GetQuality()
	end
end
--上锁
function this.ByProtectState(a, b)
	if(a:GetLockNum() == b:GetLockNum()) then
		return nil
	else
		return a:GetLockNum() > b:GetLockNum()
	end
end
--入手顺序
function this.ByAcquireTime(a, b)
	if(a:GetAcquireTime() == b:GetAcquireTime()) then
		return nil
	else
		return a:GetAcquireTime() > b:GetAcquireTime()
	end
end

--突破
function this.ByBreakLevel(a, b)
	if(a:GetBreakLevel() == b:GetBreakLevel()) then
		return nil
	else
		return a:GetBreakLevel() > b:GetBreakLevel()
	end
end

--性能
function this.ByProperty(a, b)
	if(a:GetProperty() == b:GetProperty()) then
		return nil
	else
		return a:GetProperty() > b:GetProperty()
	end
end
--好感度
function this.ByFavorability(a, b)
	if(a:GetFavorability() == b:GetFavorability()) then
		return nil
	else
		return a:GetFavorability() > b:GetFavorability()
	end
end

--是否新获得
function this.ByIsNew(a, b)
	if(a:IsNewNum() == b:IsNewNum()) then
		return nil
	else
		return a:IsNewNum() > b:IsNewNum()
	end
end

--是否是队长
function this.ByLeader(a, b)
	if(a:LeaderSortNum() == b:LeaderSortNum()) then
		return nil
	else
		return a:LeaderSortNum() > b:LeaderSortNum()
	end
end


this:Init()

return this
