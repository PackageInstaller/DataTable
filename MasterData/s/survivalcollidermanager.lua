require "class"
---碰撞管理器：基于地格的空间索引，负责角色/子弹的粗筛与精确碰撞判定
---地格 key 格式为 "x_z"（floor 坐标），每帧 RebuildGrids 后供本帧及区域效果查询使用
---@class SurvivalColliderManager
local SurvivalColliderManager = class("SurvivalColliderManager")

function SurvivalColliderManager:ctor(...)
	---@type table<string, SurvivalRole[]> 敌方角色地格 grid["x_z"] = { role, ... }
	self._enemyRoleGrid = {}
	---@type table<string, SurvivalRole[]> 友军角色地格
	self._friendRoleGrid = {}
	---@type table<string, SurvivalBullet[]> 友军子弹地格
	self._friendBulletGrid = {}
	---@type table<string, SurvivalBullet[]> 敌方子弹地格
	self._enemyBulletGrid = {}
	---@type table<string, SurvivalItem[]> 掉落道具地格
	self._itemGrid = {}
	---地格查询结果缓存（复用，避免每帧分配）
	self._queryResult = {}
	---地格查询去重表，同一实体跨多格只返回一次
	self._querySeen = {}
	---碰撞配对结果缓存
	self._collisionResult = {}
end

---@return SurvivalColliderManager
function SurvivalColliderManager:instance()
	if not SurvivalColliderManager._instance then
		SurvivalColliderManager._instance = SurvivalColliderManager:new()
	end
	return SurvivalColliderManager._instance
end

---地格坐标转 key
---@param x integer
---@param z integer
---@return string
function SurvivalColliderManager:GetGridKey(x, z)
	return x .. "_" .. z
end

---清空指定地格表
---@param grid table<string, table>
function SurvivalColliderManager:ClearGrid(grid)
	for k in pairs(grid) do
		grid[k] = nil
	end
end

---清空地格查询缓存（_queryResult / _querySeen）
function SurvivalColliderManager:ClearQueryCache()
	for i = 1, #self._queryResult do
		self._queryResult[i] = nil
	end
	for k in pairs(self._querySeen) do
		self._querySeen[k] = nil
	end
end

---遍历矩形地格范围，从 grid 中收集实体（底层通用，grid 由调用方指定查哪张表）
---@param grid table<string, table> 目标地格表（角色/子弹、敌/友之一）
---@param minX integer
---@param maxX integer
---@param minZ integer
---@param maxZ integer
---@return table
function SurvivalColliderManager:QueryGridCells(grid, minX, maxX, minZ, maxZ)
	local outList = self._queryResult
	local seen = self._querySeen
	self:ClearQueryCache()

	for x = minX, maxX do
		for z = minZ, maxZ do
			local cell = grid[self:GetGridKey(x, z)]
			if cell then
				for j = 1, #cell do
					local entity = cell[j]
					if not seen[entity] then
						seen[entity] = true
						outList[#outList + 1] = entity
					end
				end
			end
		end
	end
	return outList
end

---按阵营取角色地格表（区域效果等外部调用）
---@param team GE.SurvivalTeam
---@return table<string, SurvivalRole[]>
function SurvivalColliderManager:GetRoleGrid(team)
	if team == GE.SurvivalTeam.enemy then
		return self._enemyRoleGrid
	end
	return self._friendRoleGrid
end

---掉落道具地格表
---@return table<string, SurvivalItem[]>
function SurvivalColliderManager:GetItemGrid()
	return self._itemGrid
end

---重建道具地格（由 SurvivalItemManager 每帧调用）
---@param itemList SurvivalItem[]
function SurvivalColliderManager:RebuildItemGrid(itemList)
	self:ClearGrid(self._itemGrid)
	for i = 1, #itemList do
		self:RegisterEntity(self._itemGrid, itemList[i])
	end
end

---将实体注册到地格（使用 entity.block 即 floor 后的坐标）
---@param grid table<string, table>
---@param entity SurvivalRole|SurvivalBullet|SurvivalItem
function SurvivalColliderManager:RegisterEntity(grid, entity)
	local key = self:GetGridKey(entity.block.x, entity.block.z)
	local cell = grid[key]
	if not cell then
		cell = {}
		grid[key] = cell
	end
	cell[#cell + 1] = entity
end

---重建四张地格表（每帧 Update 开始时调用）
---@param enemyList SurvivalRole[]
---@param friendList SurvivalRole[]
---@param friendBulletList SurvivalBullet[]
---@param enemyBulletList SurvivalBullet[]
function SurvivalColliderManager:RebuildGrids(enemyList, friendList, friendBulletList, enemyBulletList)
	self:ClearGrid(self._enemyRoleGrid)
	self:ClearGrid(self._friendRoleGrid)
	self:ClearGrid(self._friendBulletGrid)
	self:ClearGrid(self._enemyBulletGrid)

	for i = 1, #enemyList do
		self:RegisterEntity(self._enemyRoleGrid, enemyList[i])
	end
	for i = 1, #friendList do
		self:RegisterEntity(self._friendRoleGrid, friendList[i])
	end
	for i = 1, #friendBulletList do
		self:RegisterEntity(self._friendBulletGrid, friendBulletList[i])
	end
	for i = 1, #enemyBulletList do
		self:RegisterEntity(self._enemyBulletGrid, enemyBulletList[i])
	end
end

---以实体为中心查地格（碰撞用）
---搜索范围 = 实体半宽 + otherMaxHalfRange（对方阵营最大半宽，防止大体型漏检）
---@param grid table<string, table> 要查的目标地格表，如 _enemyRoleGrid / _friendBulletGrid
---@param target SurvivalRole|SurvivalBullet
---@param otherMaxHalfRange number
---@return table
function SurvivalColliderManager:QueryGrid(grid, target, otherMaxHalfRange)
	local position = target.position
	local halfRange = target:GetHalfRange() + otherMaxHalfRange
	return self:QueryGridCells(grid,
		math.floor(position.x - halfRange), math.floor(position.x + halfRange),
		math.floor(position.z - halfRange), math.floor(position.z + halfRange))
end

---以任意圆心+半径查地格（区域效果用，粗筛后仍需调用方做精确圆距判定）
---@param grid table<string, table> 目标角色地格，通常 GetRoleGrid(team) 取得
---@param centerX number
---@param centerZ number
---@param radius number 当前或最大作用半径
---@param extraHalfRange number 目标最大半宽，用于扩大地格搜索范围
---@return SurvivalRole[]
function SurvivalColliderManager:QueryGridByRange(grid, centerX, centerZ, radius, extraHalfRange)
	local halfRange = radius + extraHalfRange
	return self:QueryGridCells(grid,
		math.floor(centerX - halfRange), math.floor(centerX + halfRange),
		math.floor(centerZ - halfRange), math.floor(centerZ + halfRange))
end

---以轴对齐矩形查地格（激光束等，粗筛后仍需精确判定）
---@param grid table<string, table>
---@param minX number
---@param maxX number
---@param minZ number
---@param maxZ number
---@return SurvivalRole[]
function SurvivalColliderManager:QueryGridByAABB(grid, minX, maxX, minZ, maxZ)
	return self:QueryGridCells(grid,
		math.floor(minX), math.floor(maxX),
		math.floor(minZ), math.floor(maxZ))
end

---每帧：重建地格 → 玩家撞敌 → 友弹撞敌 → 敌弹撞友
function SurvivalColliderManager:Update()
	local roleMgr = SurvivalManager.instance():GetRoleMgr()
	local bulletMgr = SurvivalManager.instance():GetBulletMgr()
	local player = roleMgr:GetPlayerRole()
	local enemyList = roleMgr:GetRoleList(GE.SurvivalTeam.enemy, true)
	local friendList = roleMgr:GetRoleList(GE.SurvivalTeam.friend, true)
	local enemyBulletList = bulletMgr:GetEnemyBulletList()
	local friendBulletList = bulletMgr:GetFriendBulletList()
	local aliveEnemyList = {}
	local aliveFriendList = {}
	local aliveEnemyBulletList = {}
	local aliveFriendBulletList = {}
	local alivePlayerList = {}

	for _, enemy in pairs(enemyList) do
		if self:IsAvaliable(enemy) then
			aliveEnemyList[#aliveEnemyList + 1] = enemy
		end
	end
	for _, friend in pairs(friendList) do
		if self:IsAvaliable(friend) then
			aliveFriendList[#aliveFriendList + 1] = friend
		end
	end
	for _, bullet in pairs(enemyBulletList) do
		if self:IsAvaliable(bullet) then
			aliveEnemyBulletList[#aliveEnemyBulletList + 1] = bullet
		end
	end
	for _, bullet in pairs(friendBulletList) do
		if self:IsAvaliable(bullet) then
			aliveFriendBulletList[#aliveFriendBulletList + 1] = bullet
		end
	end
	if self:IsAvaliable(player) then
		alivePlayerList[#alivePlayerList + 1] = player
	end

	self:RebuildGrids(aliveEnemyList, aliveFriendList, aliveFriendBulletList, aliveEnemyBulletList)

	-- 玩家 ↔ 敌方角色
	if #alivePlayerList > 0 and #aliveEnemyList > 0 then
		local result = self:GetRoleColliderRoleResult(alivePlayerList, roleMgr:GetEnemyMaxRange(GE.SurvivalTeam.friend)/2)
		self:DoCollider(result)
	end
	-- 友方子弹 ↔ 敌方角色
	if #aliveFriendBulletList > 0 and #aliveEnemyList > 0 then
		local result = self:GetBulletColliderRoleResult(
			aliveFriendBulletList, aliveEnemyList,
			self._enemyRoleGrid, self._friendBulletGrid, roleMgr, bulletMgr
		)
		if #result > 0 then
			-- LuaLogger.ds("SurvivalColliderManager 玩家阵营子弹碰撞敌方角色结果", tablex.dump(result))
		end
		self:DoCollider(result)
	end
	-- 敌方子弹 ↔ 友方角色
	if #aliveEnemyBulletList > 0 and #aliveFriendList > 0 then
		local result = self:GetBulletColliderRoleResult(
			aliveEnemyBulletList, aliveFriendList,
			self._friendRoleGrid, self._enemyBulletGrid, roleMgr, bulletMgr
		)
		if #result > 0 then
			-- LuaLogger.ds("SurvivalColliderManager 敌方阵营子弹碰撞玩家阵营结果", tablex.dump(result))
		end
		self:DoCollider(result)
	end
end

---实体是否参与碰撞（角色需存活且受击 CD 结束，子弹需存活）
---@param target SurvivalRole|SurvivalBullet
---@return boolean
function SurvivalColliderManager:IsAvaliable(target)
	if target and target.isRole then
		return target:IsAlive() and target:GetHitCdRemain() <= 0
	elseif target and target.isBullet then
		return target:IsAlive()
	end
	return false
end

---执行碰撞结果：角色撞角色 / 子弹撞角色
---@param result table
function SurvivalColliderManager:DoCollider(result)
	for _, pair in pairs(result) do
		local target1 = pair.target1
		local target2 = pair.target2
		if self:IsAvaliable(target1) and self:IsAvaliable(target2) then
			local roleNum = 0
			local bulletNum = 0
			if target1.isRole then
				roleNum = roleNum + 1
			else
				bulletNum = bulletNum + 1
			end
			if target2.isRole then
				roleNum = roleNum + 1
			else
				bulletNum = bulletNum + 1
			end
			if roleNum == 2 then
				if target1:IsPlayer() then
					target1:BeHitByRole(target2)
				else
					target2:BeHitByRole(target1)
				end
			elseif roleNum == 1 and bulletNum == 1 then
				if target1.isRole then
					target1:BeHitByBullet(target2)
				else
					target2:BeHitByBullet(target1)
				end
			end
		end
	end
end

---子弹与角色碰撞检测，数量少的一方做地格查询以优化性能
---@param bulletList SurvivalBullet[]
---@param roleList SurvivalRole[]
---@param roleGrid table 对方角色地格
---@param bulletGrid table 对方子弹地格（role 多时反向查弹用）
---@param roleMgr SurvivalRoleManager
---@param bulletMgr SurvivalBulletManager
---@return table
function SurvivalColliderManager:GetBulletColliderRoleResult(bulletList, roleList, roleGrid, bulletGrid, roleMgr, bulletMgr)
	local result = self._collisionResult
	for i = 1, #result do
		result[i] = nil
	end

	local bulletNum = #bulletList
	local roleNum = #roleList
	if bulletNum <= roleNum then
		-- 子弹少：以子弹为中心查角色地格
		for i = 1, bulletNum do
			local bullet = bulletList[i]
			if self:IsAvaliable(bullet) then
				local roleMaxHalfRange = roleMgr:GetEnemyMaxRange(bullet:GetTeam())/2
				local roleInBlocks = self:QueryGrid(roleGrid, bullet, roleMaxHalfRange)
				self:CheckCollider(result, bullet, roleInBlocks)
			end
		end
	else
		-- 角色少：以角色为中心查子弹地格
		for i = 1, roleNum do
			local role = roleList[i]
			if self:IsAvaliable(role) then
				local bulletMaxHalfRange = bulletMgr:GetEnemyMaxRange(role:GetTeam())/2
				local bulletInBlocks = self:QueryGrid(bulletGrid, role, bulletMaxHalfRange)
				self:CheckCollider(result, role, bulletInBlocks)
			end
		end
	end
	return result
end

---玩家角色与敌方角色的碰撞检测
---@param role1List SurvivalRole[]
---@param otherMaxHalfRange number 敌方最大半宽
---@return table
function SurvivalColliderManager:GetRoleColliderRoleResult(role1List, otherMaxHalfRange)
	local result = self._collisionResult
	for i = 1, #result do
		result[i] = nil
	end

	for i = 1, #role1List do
		local role1 = role1List[i]
		if self:IsAvaliable(role1) then
			local roleInBlocks = self:QueryGrid(self._enemyRoleGrid, role1, otherMaxHalfRange)
			self:CheckCollider(result, role1, roleInBlocks)
		end
	end
	return result
end

---对地格粗筛出的候选做精确距离判定，写入碰撞结果
---@param result table
---@param target SurvivalRole|SurvivalBullet
---@param targetList SurvivalRole[]|SurvivalBullet[]
function SurvivalColliderManager:CheckCollider(result, target, targetList)
	for i = 1, #targetList do
		local target2 = targetList[i]
		if self:IsAvaliable(target2) then
			local role
			local bullet
			if target.isRole and target2.isBullet then
				role = target
				bullet = target2
			elseif target.isBullet and target2.isRole then
				role = target2
				bullet = target
			end
			if role and bullet and not self:IsValidForHitRule(bullet, role) then
				goto continue
			end
			if role and bullet and bullet:HasHitRole(role) then
				goto continue
			end

			local dx = target.position.x - target2.position.x
			local dz = target.position.z - target2.position.z
			local sumRange = target:GetHalfRange() + target2:GetHalfRange()
			if dx * dx + dz * dz <= sumRange * sumRange then
				result[#result + 1] = {
					target1 = target,
					target2 = target2,
				}
			end
		end
		::continue::
	end
end

---子弹舰装类型命中规则（onlyList / forbiddenList）
---@param bullet SurvivalBullet
---@param role SurvivalRole
---@return boolean
function SurvivalColliderManager:IsValidForHitRule(bullet, role)
	local shipType = role:GetShipType()
	local onlyList = bullet:GetOnlyList()
	local forbiddenList = bullet:GetForbiddenList()
	if #onlyList > 0 then
		if not tablex.contains(onlyList, shipType) then
			return false
		end
	end
	if #forbiddenList > 0 then
		if tablex.contains(forbiddenList, shipType) then
			return false
		end
	end
	return true
end

function SurvivalColliderManager:Clear()
	self:ClearGrid(self._enemyRoleGrid)
	self:ClearGrid(self._friendRoleGrid)
	self:ClearGrid(self._friendBulletGrid)
	self:ClearGrid(self._enemyBulletGrid)
	self:ClearGrid(self._itemGrid)
	self:ClearQueryCache()
	for i = 1, #self._collisionResult do
		self._collisionResult[i] = nil
	end
end

return SurvivalColliderManager
