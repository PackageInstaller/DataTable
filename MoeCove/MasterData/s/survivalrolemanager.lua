require "class"
---@class SurvivalRoleManager
local SurvivalRoleManager = class("SurvivalRoleManager")
local SurvivalRole = require("SurvivalRole")
local insert = table.insert
local remove = table.remove
local MAX_SQUAD_SIZE = 3	--编队最大数量
local SWITCH_CD_DURATION = 1	--切换角色CD时长

function SurvivalRoleManager:ctor(...)
	---角色列表
	---SurvivalRole
	---table<integer, SurvivalRole>
	self._enemyList = {}
	---敌人舰装类型数量列表
	---table<integer, integer<integer, integer>>
	self._enemyTypeList = {}
	---玩家角色（当前主控）
	---SurvivalRole
	self._playerRole = nil
	---玩家编队槽位角色 table<integer, SurvivalRole>
	self._playerSquad = {}
	---当前主控槽位
	self._activeSlot = 1
	---切换角色剩余CD（秒）
	self._switchCdRemain = 0
	---玩家舰装类型数量列表
	---table<integer, integer<integer, integer>>
	self._playerTypeList = {}
	---友军列表 包括玩家
	---table<integer, SurvivalRole>
	self._friendList = {}
	---角色实例化id计数
	self._roleIndex = 0
	---敌人最大碰撞范围
	self._enemyRoleMaxRange = 0
	---友军最大碰撞范围
	self._friendRoleMaxRange = 0
end

--帧同步
function SurvivalRoleManager:Update(deltaTime)
	if self._switchCdRemain > 0 then
		self._switchCdRemain = self._switchCdRemain - deltaTime
		if self._switchCdRemain < 0 then
			self._switchCdRemain = 0
		end
	end
	for _, role in pairs(self._friendList) do
		role:Update(deltaTime)
	end
	for _, role in pairs(self._enemyList) do
		role:Update(deltaTime)
	end
end

---获取玩家角色
---@return SurvivalRole
function SurvivalRoleManager:GetPlayerRole()
	return self._playerRole
end

---获取编队槽位角色
---@param slot integer 槽位 1~3
---@return SurvivalRole|nil
function SurvivalRoleManager:GetSquadRole(slot)
	return self._playerSquad[slot]
end

---获取当前主控槽位
---@return integer
function SurvivalRoleManager:GetActiveSlot()
	return self._activeSlot
end

---获取切换角色剩余CD
---@return number
function SurvivalRoleManager:GetSwitchCdRemain()
	return self._switchCdRemain
end

---获取切换角色CD时长
---@return number
function SurvivalRoleManager:GetSwitchCdDuration()
	return SWITCH_CD_DURATION
end

---是否为编队成员
---@param role SurvivalRole
---@return boolean
function SurvivalRoleManager:IsSquadMember(role)
	if not role or not role:GetPlayerSlot() then
		return false
	end
	return self._playerSquad[role:GetPlayerSlot()] == role
end

---切换主控角色
---@param slot integer 槽位 1~3
---@param ignoreCd boolean|nil 是否忽略CD（死亡自动切换时使用）
---@return boolean 是否切换成功
function SurvivalRoleManager:SwitchPlayerRole(slot, ignoreCd)
	if slot < 1 or slot > MAX_SQUAD_SIZE then
		return false
	end
	if slot == self._activeSlot and self._playerRole then
		return false
	end
	if not ignoreCd and self._switchCdRemain > 0 then
		return false
	end

	local target = self._playerSquad[slot]
	if not target or not target:IsAlive() then
		return false
	end

	local oldRole = self._playerRole
	local pos = oldRole and oldRole.position or target.position
	local dir = oldRole and oldRole.direction or Vector3.zero
	if oldRole then
		oldRole:SetIsPlayer(false)
		oldRole:SetOnField(false)
		oldRole._isSkillActing = false
		oldRole._skillDirection = nil
		self._friendList[oldRole.id] = nil
	end

	target:SetIsPlayer(true)
	target:SetOnField(true)
	target:ChangePos(pos)
	target.direction = dir -- 切换朝向
	--切换模型朝向（同步主控角色方向）
	local syncDir = dir
	if syncDir == Vector3.zero and oldRole and oldRole.roleRoot then
		local forward = oldRole.roleRoot.transform.forward
		syncDir = Vector3(forward.x, 0, forward.z)
	end
	if syncDir ~= Vector3.zero then
		target:SyncRoleRootDirection(syncDir)
	end
	self._playerRole = target
	self._activeSlot = slot
	self._friendList[target.id] = target

	if not ignoreCd then
		self._switchCdRemain = SWITCH_CD_DURATION
	end

	self:ReCalMaxRange(GE.SurvivalTeam.friend)
	SurvivalManager.instance():GetEventMgr():AddEvent(0, GE.SurvivalEventType.PlayerHpChange)
	local ui = SurvivalManager.instance():GetMainUI()
	if ui and ui.UpdateSkillButtons then
		ui:UpdateSkillButtons()
	end
	return true
end

---编队成员死亡处理
---@param role SurvivalRole
function SurvivalRoleManager:OnSquadMemberDie(role)
	self:RemoveRoleTypeList(role:GetTeam(), role:GetShipType(), role.id)
	local roleRange = role:GetAttr(GE.SurvivalAttribType.Range)
	if roleRange >= self:GetTeamMaxRange(role:GetTeam()) then
		self:ReCalMaxRange(role:GetTeam())
	end
	if role.obj then
		role.obj:SetActive(false)
	end
	self._friendList[role.id] = nil
	if role == self._playerRole then
		self:TrySwitchToAliveSquadMember()
	end
	SurvivalManager.instance():GetMainUI():UpdateRoleIconsState()
end

---尝试切换到存活编队成员，全部阵亡则游戏结束
function SurvivalRoleManager:TrySwitchToAliveSquadMember()
	for i = 1, MAX_SQUAD_SIZE do
		local squadRole = self._playerSquad[i]
		if squadRole and squadRole:IsAlive() then
			self:SwitchPlayerRole(i, true)
			return
		end
	end
	self._playerRole = nil
	SurvivalManager.instance():ChangeState(GE.SurvivalStateEnum.GameOver)
end

---是否可作为战斗索敌目标（存活且在场；编队下场角色不算）
---@param role SurvivalRole|nil
---@return boolean
function SurvivalRoleManager:IsCombatTarget(role)
	return role ~= nil and role:IsAlive() and role:IsOnField()
end

---获取舰装类型数量列表
---@return table<integer, integer<integer, integer>>
function SurvivalRoleManager:GetRoleTypeList(team)
	if team == GE.SurvivalTeam.enemy then
		return self._enemyTypeList
	else
		return self._playerTypeList
	end
end

---添加角色类型列表
---@param team GE.SurvivalTeam 阵营
---@param type integer 舰装类型
---@param id integer 角色id
function SurvivalRoleManager:AddRoleTypeList(team, type, id)
	if team == GE.SurvivalTeam.enemy then
		if not self._enemyTypeList[type] then
			self._enemyTypeList[type] = {}
		end
		table.insert(self._enemyTypeList[type], id)
	elseif team == GE.SurvivalTeam.friend then
		if not self._playerTypeList[type] then
			self._playerTypeList[type] = {}
		end
		table.insert(self._playerTypeList[type], id)
	end
end

---移除角色类型列表

---@param team GE.SurvivalTeam 阵营
---@param type integer 舰装类型
---@param id integer 角色id
function SurvivalRoleManager:RemoveRoleTypeList(team, type, id)
	local targetList = nil
	if team == GE.SurvivalTeam.enemy then
		targetList = self._enemyTypeList[type]
	elseif team == GE.SurvivalTeam.friend then
		targetList = self._playerTypeList[type]
	end
	if not targetList then
		-- LuaLogger.ds("SurvivalRoleManager:RemoveRoleTypeList 角色类型列表不存在", team, type, id)
		return
	end
	for i, v in pairs(targetList) do
		if v == id then
			table.remove(targetList, i)
			break
		end
	end
end

---获取敌人列表
---@param allowDie boolean 是否允许死亡
---@return table<integer, SurvivalRole>
function SurvivalRoleManager:GetEnemyList(allowDie)
	local list = {}
	if allowDie then
		list = self._enemyList
	else
		for _, role in pairs(self._enemyList) do
			if role:IsAlive() then
				insert(list, role)
			end
		end
	end
	return list
end

---获取友军列表
---@param allowDie boolean 是否允许死亡
---@return table<integer, SurvivalRole>
function SurvivalRoleManager:GetFriendList(allowDie)
	local list = {}
	if allowDie then
		list = self._friendList
	else
		for _, role in pairs(self._friendList) do
			if role:IsAlive() then
				insert(list, role)
			end
		end
	end
	return list
end

---获取角色列表
---@param team GE.SurvivalTeam 阵营
---@param allowDie boolean 是否允许死亡
---@return table<integer, SurvivalRole>
function SurvivalRoleManager:GetRoleList(team, allowDie)
	if team == GE.SurvivalTeam.enemy then
		return self:GetEnemyList(allowDie)
	else
		return self:GetFriendList(allowDie)
	end
end

---获取角色
---@param id integer 角色id
---@return SurvivalRole
function SurvivalRoleManager:GetRole(id)
	local role = self._enemyList[id]
	if role then
		return role
	end
	role = self._friendList[id]
	if role then
		return role
	end
	for slot = 1, MAX_SQUAD_SIZE do
		role = self._playerSquad[slot]
		if role and role.id == id then
			return role
		end
	end
	return nil
end

---重新计算最大碰撞范围（直径）
---@param team GE.SurvivalTeam 阵营
---@return number 最大碰撞范围
function SurvivalRoleManager:ReCalMaxRange(team)
	local targetList = {}
	if team == GE.SurvivalTeam.friend then
		targetList = self:GetFriendList(false)
	elseif team == GE.SurvivalTeam.enemy then
		targetList = self:GetEnemyList(false)
	end
	local maxRange = 0
	for _, role in pairs(targetList) do
		local range = role:GetAttr(GE.SurvivalAttribType.Range)
		if range > maxRange then
			maxRange = range
		end
	end
	self:SetTeamMaxRange(team, maxRange)
	return maxRange
end

---获取指定阵营场上角色的最大碰撞范围（直径）
---@param team GE.SurvivalTeam 阵营
---@return number
function SurvivalRoleManager:GetTeamMaxRange(team)
	if team == GE.SurvivalTeam.enemy then
		return self._enemyRoleMaxRange
	else
		return self._friendRoleMaxRange
	end
end

---设置最大碰撞范围
---@param team GE.SurvivalTeam 阵营
---@param maxRange number 最大碰撞范围
function SurvivalRoleManager:SetTeamMaxRange(team, maxRange)
	if team == GE.SurvivalTeam.friend then
		self._friendRoleMaxRange = maxRange
	elseif team == GE.SurvivalTeam.enemy then
		self._enemyRoleMaxRange = maxRange
	end
end

---获取敌方最大碰撞范围
---@param team GE.SurvivalTeam 阵营
---@return number 最大碰撞范围
function SurvivalRoleManager:GetEnemyMaxRange(team)
	if team == GE.SurvivalTeam.enemy then
		return self._friendRoleMaxRange
	else
		return self._enemyRoleMaxRange
	end
end

---创建角色
---@class roleCreateData 角色创建数据
---@field baseAttr baseAttribute 角色基础属性
---@field skillList table 技能id列表
---@field spawnType number 生成类型 GE.SurvivalSpawnType
---@field spawnParam table 生成参数
---@field team number 阵营 GE.SurvivalTeam
---@field isPlayer boolean 是否为主控角色
---@field playerSlot integer|nil 玩家编队槽位 1~3
---@field roleCfgId integer|nil 角色skin配置id
---@field survivorRoleId integer|nil SurvivorRoleTable id
---@field shipType integer 舰装类型
---@field roleModel string 角色模型
---@param roleCreateData roleCreateData 角色数据
function SurvivalRoleManager:CreateRole(roleCreateData)
	local prefabPath = Config.PrefabPath.SurvivalRole
	local modelPath = string.format(Config.PrefabPath.RoleModelPrefab, roleCreateData.roleModel, roleCreateData.roleModel)
	--动态加载对应模型
	PoolMgr:Get(prefabPath, function (obj)
		--动态加载人物对应模型
		PoolMgr:Get(modelPath, function (modelObj)
			self._roleIndex = self._roleIndex + 1
			local role = SurvivalRole:new()
			role:SetId(self._roleIndex)
			role:InitBaseAttr(roleCreateData.baseAttr)
			role:SetTeam(roleCreateData.team)
			role:SetShipType(roleCreateData.shipType)
			role:SetIsPlayer(roleCreateData.isPlayer)
			if roleCreateData.roleCfgId then
				role:SetRoleCfgId(roleCreateData.roleCfgId)
			end
			if roleCreateData.survivorRoleId then
				role:SetSurvivorRoleId(roleCreateData.survivorRoleId)
			end
			role:BindObj(obj)
			role:BindModel(modelObj)
			--生成位置
			local spawnPos = Vector3.New(0, 0.75, 0)
			if roleCreateData.team == GE.SurvivalTeam.friend then
				
			else
				if roleCreateData.spawnType == GE.SurvivalSpawnType.FarRandom then
					local dis = roleCreateData.spawnParam and roleCreateData.spawnParam[1] or 5
					dis = dis + math.random(0, 10)
					local playerPos = self._playerRole and self._playerRole.position or Vector3.zero
					-- 水平面随机方向（Y 轴不变）
					local randomAngle = math.random() * 2 * math.pi  -- 0~360度随机
					local offsetX = math.cos(randomAngle) * dis
					local offsetZ = math.sin(randomAngle) * dis
					-- 新位置：玩家位置 + 随机偏移，Y 轴保持和玩家一样
					spawnPos = Vector3.New(
						playerPos.x + offsetX,
						0.75,          -- Y 轴不变
						playerPos.z + offsetZ
					)
				end
			end
			role:ChangePos(spawnPos)
			--区分阵营与编队
			if roleCreateData.playerSlot then
				local slot = roleCreateData.playerSlot
				self._playerSquad[slot] = role
				role:SetPlayerSlot(slot)
				local isActive = roleCreateData.isPlayer == true
				role:SetIsPlayer(isActive)
				role:SetOnField(isActive)
				if isActive then
					self._playerRole = role
					self._activeSlot = slot
					self._friendList[role.id] = role
				else
					role._isOnField = false
					if role.obj then
						role.obj:SetActive(false)
					end
				end
				--ui更新角色按钮状态 选中框 编队头像
				SurvivalManager.instance():GetEventMgr():AddEvent(0, GE.SurvivalEventType.PlayerHpChange)
				if roleCreateData.roleCfgId then
					local ui = SurvivalManager.instance():GetMainUI()
					ui:UpdateSquadRoleIcon(roleCreateData.playerSlot, roleCreateData.roleCfgId)
					ui:UpdateRoleIconsState()
				end
			elseif roleCreateData.team == GE.SurvivalTeam.friend then
				self._friendList[role.id] = role
			else
				self._enemyList[role.id] = role
			end
			-- 须在 _playerRole 注册后再加技能，否则 AddSkillList 触发的 UI 刷新拿不到主控角色
			role:AddSkillList(roleCreateData.skillList)
			role:RefreshAttr(true)
			--更新舰装类型数量列表
			self:AddRoleTypeList(roleCreateData.team, roleCreateData.shipType, role.id)
		end, SurvivalManager.instance().cameraObj)
	end, SurvivalManager.instance().cameraObj)
end

---移除角色
---@param id integer 角色id
function SurvivalRoleManager:RemoveRole(id)
	local role = self._enemyList[id] or self._friendList[id]
	if role then
		--角色死亡且曾为该阵营最大碰撞体时，重新计算
		local roleRange = role:GetAttr(GE.SurvivalAttribType.Range)
		if roleRange >= self:GetTeamMaxRange(role:GetTeam()) then
			self:ReCalMaxRange(role:GetTeam())
		end
		--移除角色类型列表
		self:RemoveRoleTypeList(role:GetTeam(), role:GetShipType(), id)
		role:Clear()
		if role:GetTeam() == GE.SurvivalTeam.enemy then
			self._enemyList[id] = nil
		else
			self._friendList[id] = nil
		end
		return
	end
	-- LuaLogger.ds("SurvivalRoleManager:RemoveRole 角色不存在", id)
end

---杀死所有敌人
function SurvivalRoleManager:KillAllEnemies()
	for k, v in pairs(self._enemyList) do
		v:Die()
	end
end

---实例化
---@return SurvivalRoleManager SurvivalRoleManager
function SurvivalRoleManager.instance()
	if (SurvivalRoleManager._instance == nil) then
		SurvivalRoleManager._instance = SurvivalRoleManager:new()
	end
	return SurvivalRoleManager._instance
end

function SurvivalRoleManager:Clear()
	local cleared = {}
	local function safeClear(role)
		if role and not cleared[role] then
			cleared[role] = true
			role:Clear()
		end
	end
	for k, v in pairs(self._enemyList) do
		safeClear(v)
	end
	self._enemyList = {}
	for k, v in pairs(self._friendList) do
		safeClear(v)
	end
	self._friendList = {}
	for k, v in pairs(self._playerSquad) do
		safeClear(v)
		self._playerSquad[k] = nil
	end
	self._playerSquad = {}
	self._playerRole = nil
	self._activeSlot = 1
	self._switchCdRemain = 0
	self._roleIdIndex = 0 --角色实例化id计数
	self._enemyTypeList = {}
	self._playerTypeList = {}
	self._enemyRoleMaxRange = 0
	self._friendRoleMaxRange = 0
end

return SurvivalRoleManager