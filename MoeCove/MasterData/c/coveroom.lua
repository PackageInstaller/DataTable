require "class"

---@class CoveRoom
local CoveRoom = class("CoveRoom")

function CoveRoom:ctor(roomData)
	self.id = roomData.constructCfg.id
	self.constructCfg = roomData.constructCfg
	self._roleList = {} --房间中的角色列表
	self._targetList = roomData.targetList
	self._maxRoleNum = math.min(roomData.maxRoleNum, self.constructCfg.characterAll) --房间最大容纳人数
	self._PathCfgList = {} --房间所属路径配置
	self._inUsePathList = {}
	-- LuaLogger.ds("CoveRoom ctor:", self.id)
	self:initPathData()
end

function CoveRoom:initPathData()
	self._PathCfgList = Config.GetHomeMoveInfoByBelongArea(self.constructCfg.workLocation)
end

function CoveRoom:setRole(role)
	local isIn = false
	for _, v in pairs(self._roleList) do
		if v.cid == role.cid then
			isIn = true
		end
	end
	if isIn == false then
		table.insert(self._roleList, role)
	end
end

function CoveRoom:removeRole(role)
	if self._roleList == nil then
		return
	end
	for i = #self._roleList, 1, -1 do
		if (self._roleList[i].cid == role.cid) then
			table.remove(self._roleList, i)
		end
	end
end

---路径随机
function CoveRoom:getRandomPath(roleId, homeWorkIndex)
	if self._PathCfgList == nil then
		return
	end
	local tempList = {}
	for _, pathCfg in pairs(self._PathCfgList) do
		if self:inInUse(pathCfg.id) == false then
			--专属角色逻辑
			if pathCfg.exclusive and #pathCfg.exclusive > 0 then
				if roleId then
					for _, id in pairs(pathCfg.exclusive) do
						if id == roleId then
							table.insert(tempList, pathCfg)
						end
					end
				end
			elseif pathCfg.jobExclusive and #pathCfg.jobExclusive > 0 then
				if homeWorkIndex and homeWorkIndex == pathCfg.jobExclusive[2] and pathCfg.jobExclusive[1] == self.id then
					table.insert(tempList, pathCfg)
				end
			else
				table.insert(tempList, pathCfg)
			end
		end
	end
	if #tempList == 0 then
		LuaLogger.ds("getRandomPath empty, roldId:"..roleId.."roomId:"..self.id)
		for _, pathCfg in pairs(self._PathCfgList) do
			LuaLogger.ds("pathId:"..pathCfg.id)
			if self:inInUse(pathCfg.id) then
				LuaLogger.ds("isUse")
			else
				LuaLogger.ds("canUse")
			end
		end
		return nil
	end
	local index = math.random(1, #tempList)
	table.insert(self._inUsePathList, tempList[index].id)
	return tempList[index]
end


function CoveRoom:getRandomPathWithOutCondition(roleId, homeWorkIndex)
	local tempList = {}

	for _, pathCfg in pairs(self._PathCfgList) do
		if not self:inInUse(pathCfg.id) then
			table.insert(tempList, pathCfg)
		end
	end
	if #tempList == 0 then
		for _, pathCfg in pairs(self._PathCfgList) do
			table.insert(tempList, pathCfg)
		end
	end

	local index = math.random(1, #tempList)
	table.insert(self._inUsePathList, tempList[index].id)
	return tempList[index]
end

function CoveRoom:inInUse(pathId)
	for _, id in pairs(self._inUsePathList) do
		if id == pathId then
			return true
		end
	end
	return false
end

function CoveRoom:onPathUseEnd(pathInfo)
	if not pathInfo then
		return
	end
	for i = #self._inUsePathList, 1, -1 do
		if (self._inUsePathList[i] == pathInfo.id) then
			table.remove(self._inUsePathList, i)
		end
	end
end

function CoveRoom:getRoleNum()
	local num = 0
	for _, v in pairs(self._roleList) do
		if (v and v ~= nil) then
			num = num + 1
		end
	end
	return num
end

function CoveRoom:isFull()
	return self:getRoleNum() >= self._maxRoleNum
end

---房间随机权重
function CoveRoom:getRandomWight(roleId)
	local base = Config.GetConfigInfo("constructionWeightBasic")
	if self:isFavour(roleId) then
		base = base + Config.GetConfigInfo("constructionWeightRise")
	end
	if self:getRoleNum() >= self.constructCfg.characterWeightDown then
		base = base - Config.GetConfigInfo("constructionWeightDecrease")
	end
	return base
end

--随机角色停留房间时间
function CoveRoom:randomStayTime()
	if #self.constructCfg.CharacterStayTime == 0 then
		return 5
	end
	return math.random(self.constructCfg.CharacterStayTime[1], self.constructCfg.CharacterStayTime[2])
end

---是否为角色喜欢的房间
function CoveRoom:isFavour(roleId)
	for _, id in pairs(self.constructCfg.weightUpCharacter) do
		if roleId == id then
			return true
		end
	end
	return false
end

function CoveRoom:getTargetByPointId(pointId)
	-- if index > self._targetList.Length - 1 then
	-- 	LuaLogger.e("getTargetByIndex empty:"..self.id..","..pointId)
	-- 	return nil
	-- end
	return self._targetList[pointId]
end

function CoveRoom:isWorkArea()
	return self.constructCfg.isWork == 1
end

function CoveRoom:removeRoom()
	self = nil
end

return CoveRoom