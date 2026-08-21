require "class"
---@class SurvivalBulletManager
local SurvivalBulletManager = class("SurvivalBulletManager")
local SurvivalBullet = require("SurvivalBullet")

function SurvivalBulletManager:ctor(...)
	---敌方子弹列表
	self._enemyBulletList = {}
	---友军子弹列表
	self._friendBulletList = {}
	---子弹列表
	self._bulletIndex = 0

	---敌人最大碰撞范围
	self._enemyBulletMaxRange = 0
	---友军最大碰撞范围
	self._friendBulletMaxRange = 0
end

function SurvivalBulletManager:Update(deltaTime)
	for _, bullet in pairs(self._enemyBulletList) do
		bullet:Update(deltaTime)
	end
	for _, bullet in pairs(self._friendBulletList) do
		bullet:Update(deltaTime)
	end
end

function SurvivalBulletManager:GetEnemyBulletList()
	return self._enemyBulletList
end

function SurvivalBulletManager:GetFriendBulletList()
	return self._friendBulletList
end

---获取敌人子弹最大半径
---@param team 当前角色阵营
---@return number 最大碰撞半径
function SurvivalBulletManager:GetEnemyMaxHalfRange(team)
	return self:GetEnemyMaxRange(team) / 2
end

---获取敌人最大碰撞范围（直径）
---@param team GE.SurvivalTeam 阵营
---@return number 最大碰撞范围
function SurvivalBulletManager:GetEnemyMaxRange(team)
	if team == GE.SurvivalTeam.enemy then
		return self._friendBulletMaxRange
	else
		return self._enemyBulletMaxRange
	end
end

---重新计算指定阵营子弹最大碰撞范围（直径）
---@param team GE.SurvivalTeam 阵营
---@return number
function SurvivalBulletManager:ReCalMaxRange(team)
	local maxRange = self:_GetMaxRange(team)
	self:SetTeamMaxRange(team, maxRange)
	return maxRange
end

---设置最大碰撞范围
---@param team GE.SurvivalTeam 阵营
---@param maxRange number 最大碰撞范围
function SurvivalBulletManager:SetTeamMaxRange(team, maxRange)
	if team == GE.SurvivalTeam.friend then
		self._friendBulletMaxRange = maxRange
	elseif team == GE.SurvivalTeam.enemy then
		self._enemyBulletMaxRange = maxRange
	end
end

---刷新敌人最大碰撞范围
function SurvivalBulletManager:RefreshEnemyMaxRange()
	self:ReCalMaxRange(GE.SurvivalTeam.enemy)
end

---刷新友军最大碰撞范围
function SurvivalBulletManager:RefreshFriendMaxRange()
	self:ReCalMaxRange(GE.SurvivalTeam.friend)
end

function SurvivalBulletManager:_GetMaxRange(team)
	local targetList = {}
	if team == GE.SurvivalTeam.friend then
		targetList = self._friendBulletList
	elseif team == GE.SurvivalTeam.enemy then
		targetList = self._enemyBulletList
	end
	local maxRange = 0
	for _, bullet in pairs(targetList) do
		if not bullet:IsAlive() then
			goto continue
		end
		local range = bullet:GetAttr(GE.SurvivalAttribType.BulletRange) or 0
		if range > maxRange then
			maxRange = range
		end
		::continue::
	end
	return maxRange
end

---实例化
---@return SurvivalBulletManager SurvivalBulletManager
function SurvivalBulletManager.instance()
	if (SurvivalBulletManager._instance == nil) then
		SurvivalBulletManager._instance = SurvivalBulletManager:new()
	end
	return SurvivalBulletManager._instance
end

---创建子弹
---@class bulletCreateData 子弹创建数据
---@field direction Vector3 射击方向
---@field position Vector3 起始位置
---@field roleAttribute table<SurvivalAttribType, number> 角色属性
---@field ownerRoleId integer 发射者角色实例id
---@field skillId integer 技能id
---@field team GE.SurvivalTeam 阵营
---@field damageType GE.SurvivalBulletDamageType 伤害类型
---@field onlyList table<string> 仅目标列表
---@field forbiddenList table<string> 禁止目标列表
---@field bulletName string 子弹预制体名称
---@field chargeBonus table<integer, number>|nil 蓄力属性倍率

---@param bulletCreateData bulletCreateData 子弹创建数据
function SurvivalBulletManager:CreateBullet(bulletCreateData)
	-- LuaLogger.ds("SurvivalBulletManager:CreateBullet: bulletCreateData: ", tablex.dump(bulletCreateData))
	--子弹路径
	local prefabPath = Config.PrefabPath.SurvivalBullet
	--子弹模型路径
	local bulletName = bulletCreateData.bulletName or "Bullet_Y"
	local bulletPrefab = string.format(Config.PrefabPath.SurvivalBulletPrefab, bulletName)
	PoolMgr:Get(prefabPath, function (obj)
		PoolMgr:Get(bulletPrefab, function (modelObj)
			self._bulletIndex = self._bulletIndex + 1
			local bullet = SurvivalBullet:new()
			bullet:SetId(self._bulletIndex)
			bullet:SetSkillId(bulletCreateData.skillId)
			bullet:SetOwnerRoleId(bulletCreateData.ownerRoleId or 0)
			bullet:SetDamageType(bulletCreateData.damageType)
			bullet:SetChargeBonus(bulletCreateData.chargeBonus)
			bullet:InitRoleAttr(bulletCreateData.roleAttribute)
			bullet:RefreshAttr()
			bullet:SetTeam(bulletCreateData.team)
			bullet:SetOnlyList(bulletCreateData.onlyList)
			bullet:SetForbiddenList(bulletCreateData.forbiddenList)
			bullet:BindObj(obj, modelObj)
			bullet:ChangeDirection(bulletCreateData.direction)
			bullet:ChangePos(bulletCreateData.position)
			bullet:SetAlive(true)
			--todo 子弹模型
			--区分阵营 最后插入
			if bulletCreateData.team == GE.SurvivalTeam.friend then
				self._friendBulletList[self._bulletIndex] = bullet
			else
				self._enemyBulletList[self._bulletIndex] = bullet
			end
			local bulletRange = bullet:GetAttr(GE.SurvivalAttribType.BulletRange) or 0
			if bulletRange > self:GetTeamMaxRange(bulletCreateData.team) then
				self:SetTeamMaxRange(bulletCreateData.team, bulletRange)
			end
		end, SurvivalManager.instance().cameraObj)
	end, SurvivalManager.instance().cameraObj)
end

function SurvivalBulletManager:GetTeamMaxRange(team)
	if team == GE.SurvivalTeam.enemy then
		return self._enemyBulletMaxRange
	else
		return self._friendBulletMaxRange
	end
end

---清除子弹
---@param id integer ID
function SurvivalBulletManager:DestroyBullet(id)
	local bullet = self._friendBulletList[id] or self._enemyBulletList[id]
	if not bullet then
		return
	end
	local team = bullet:GetTeam()
	local bulletRange = bullet:GetAttr(GE.SurvivalAttribType.BulletRange) or 0
	local needRecal = bulletRange >= self:GetTeamMaxRange(team)
	bullet:OnDestroy()
	self._friendBulletList[id] = nil
	self._enemyBulletList[id] = nil
	if needRecal then
		self:ReCalMaxRange(team)
	end
end

function SurvivalBulletManager:Clear()
	for _, bullet in pairs(self._friendBulletList) do
		bullet:Clear()
	end
	for _, bullet in pairs(self._enemyBulletList) do
		bullet:Clear()
	end
	self._friendBulletList = {}
	self._enemyBulletList = {}
	self._bulletIndex = 0
	self._enemyBulletMaxRange = 0
	self._friendBulletMaxRange = 0
end

return SurvivalBulletManager