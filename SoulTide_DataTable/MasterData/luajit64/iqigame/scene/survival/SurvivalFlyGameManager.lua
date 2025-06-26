-- chunkname: @IQIGame\\Scene\\Survival\\SurvivalFlyGameManager.lua

local m = {
	survivalFlyGameBulletPool = {},
	survivalFlyGameEnemyPool = {},
	survivalFlyGameRewardBoxCellPool = {},
	survivalFlyGameDamageCellPool = {}
}
local SurvivalFlyGameBullet = require("IQIGame.Scene.Survival.SurvivalFlyGameBullet")
local SurvivalFlyGameEnemy = require("IQIGame.Scene.Survival.SurvivalFlyGameEnemy")
local SurvivalFlyGameRewardBoxCell = require("IQIGame.Scene.Survival.SurvivalFlyGameRewardBoxCell")
local FlyGameEnemyData = require("IQIGame.Module.CommonActivity.Survival.FlyGame.FlyGameEnemyData")
local FlyGameRewardBoxData = require("IQIGame.Module.CommonActivity.Survival.FlyGame.FlyGameRewardBoxData")
local SurvivalFlyGameDamageCell = require("IQIGame.Scene.Survival.SurvivalFlyGameDamageCell")

function m.New(view, gameScene)
	local obj = Clone(m)

	obj:Init(view, gameScene)

	return obj
end

function m:Init(view, gameScene)
	self.View = view
	self.rootScene = gameScene

	LuaCodeInterface.BindOutlet(self.View, self)

	self.survivalFlyGameBulletPool = {}
	self.survivalFlyGameEnemyPool = {}
	self.flightGameRewardBoxPool = {}
	self.survivalFlyGameDamageCellPool[FlyGameConstant.DamageType.Monster_Damage] = {}
	self.survivalFlyGameDamageCellPool[FlyGameConstant.DamageType.Hero_Damage] = {}
	self.survivalFlyGameDamageCellPool[FlyGameConstant.DamageType.Hero_Health] = {}
end

function m:GetFlightGameDamageCell(type)
	for i, v in pairs(self.survivalFlyGameDamageCellPool[type]) do
		if not v.active and v:IsFinished() then
			return v
		end
	end

	local obj

	if type == FlyGameConstant.DamageType.Monster_Damage then
		obj = self.MonsterDamagePrefab
	elseif type == FlyGameConstant.DamageType.Hero_Damage then
		obj = self.HeroDamagePrefab
	elseif type == FlyGameConstant.DamageType.Hero_Health then
		obj = self.HeroHealthPrefab
	end

	local SurvivalFlyGameDamageCell = SurvivalFlyGameDamageCell.New(UnityEngine.Object.Instantiate(obj), type)

	self.survivalFlyGameDamageCellPool[type][SurvivalFlyGameDamageCell.View:GetInstanceID()] = SurvivalFlyGameDamageCell

	return SurvivalFlyGameDamageCell
end

function m:RecycleFlightGameDamage(SurvivalFlyGameDamageCell)
	SurvivalFlyGameDamageCell.View.transform:SetParent(self.RecoveryNode.transform, false)
	SurvivalFlyGameDamageCell:Reset()

	self.survivalFlyGameDamageCellPool[SurvivalFlyGameDamageCell.type][SurvivalFlyGameDamageCell.View:GetInstanceID()] = SurvivalFlyGameDamageCell
end

function m:GetRewardBoxCell()
	for i, v in pairs(self.survivalFlyGameRewardBoxCellPool) do
		if not v.active then
			return v
		end
	end

	local rewardBoxCell = SurvivalFlyGameRewardBoxCell.New(UnityEngine.Object.Instantiate(self.RewardModel))

	self.survivalFlyGameRewardBoxCellPool[rewardBoxCell.View:GetInstanceID()] = rewardBoxCell

	return rewardBoxCell
end

function m:RecycleRewardBoxCell(rewardBoxCell)
	rewardBoxCell.View.transform:SetParent(self.RecoveryNode.transform, false)
	rewardBoxCell:Reset()

	self.survivalFlyGameRewardBoxCellPool[rewardBoxCell.View:GetInstanceID()] = rewardBoxCell
end

function m:GetBullet()
	for i, v in pairs(self.survivalFlyGameBulletPool) do
		if not v.active then
			return v
		end
	end

	local bulletCell = SurvivalFlyGameBullet.New(UnityEngine.Object.Instantiate(self.BulletModel))

	self.survivalFlyGameBulletPool[bulletCell.View:GetInstanceID()] = bulletCell

	return bulletCell
end

function m:RecycleBullet(bullet)
	bullet.View.transform:SetParent(self.RecoveryNode.transform, false)
	bullet:Reset()

	self.survivalFlyGameBulletPool[bullet.View:GetInstanceID()] = bullet
end

function m:GetEnemy()
	for i, v in pairs(self.survivalFlyGameEnemyPool) do
		if not v.active and v:IsPlayDamageEnd() then
			return v
		end
	end

	local enemy = SurvivalFlyGameEnemy.New(UnityEngine.Object.Instantiate(self.EnemyModel), self.rootScene)

	self.survivalFlyGameEnemyPool[enemy.View:GetInstanceID()] = enemy

	return enemy
end

function m:RecycleEnemy(enemy)
	enemy.View.transform:SetParent(self.RecoveryNode.transform, false)
	enemy:Reset()

	self.survivalFlyGameEnemyPool[enemy.View:GetInstanceID()] = enemy
end

function m:FrameUpdate()
	for i, v in pairs(self.survivalFlyGameBulletPool) do
		if v.active then
			if self:CheckBeyondBoundaries(v) then
				self:RecycleBullet(v)
			end

			v:FrameUpdate()
		end
	end

	for i, v in pairs(self.survivalFlyGameEnemyPool) do
		if v.active and v.born then
			if self:CheckBeyondBoundaries(v) then
				self:RecycleEnemy(v)
			end

			v:FrameUpdate()
			self:CheckCollisionEnemy(v)
		end
	end

	for i, v in pairs(self.survivalFlyGameRewardBoxCellPool) do
		if v.active then
			if self:CheckBeyondBoundaries(v) then
				self:RecycleRewardBoxCell(v)
			end

			v:FrameUpdate()
		end
	end

	for i, v in pairs(self.survivalFlyGameDamageCellPool) do
		for k, cell in pairs(v) do
			if cell:IsFinished() then
				self:RecycleFlightGameDamage(cell)
			end
		end
	end

	self:CheckPlayerCollision()
end

function m:CheckCollisionEnemy(enemy)
	if enemy.active and enemy.born and enemy.blood > 0 and enemy.collider2D then
		for i, v in pairs(self.survivalFlyGameBulletPool) do
			if v.active and v.bulletData.launcher == FlyGameConstant.ObjectType.FlyGame_Player then
				local res = v.collider2D.bounds:Intersects(enemy.collider2D.bounds)

				if res then
					local hurt = v.bulletData.hurt

					enemy:ReduceBlood(hurt, v.bulletData.bulletPathID)
					self:RecycleBullet(v)
				end
			end
		end

		if enemy.active and enemy.born and enemy.blood > 0 then
			local result = self.rootScene.gamePlayer:CheckPlayerBoundsIntersects(enemy.collider2D)

			if result then
				local hurt = enemy.enemyData:GetChallengeEnemyAttr(FlyGameConstant.Attribute.FlyGame_Collision_Damage)

				if GameEntry.Base.DevMode then
					log("敌人与玩家碰撞扣血 " .. hurt .. " 敌人ID " .. enemy.enemyData.monsterID)
				end

				self.rootScene.gamePlayer:ReduceBlood(hurt)
				enemy:ReduceBlood(hurt)
			end
		end
	end
end

function m:CheckPlayerCollision()
	for i, v in pairs(self.survivalFlyGameBulletPool) do
		if v.active and v.bulletData.launcher == FlyGameConstant.ObjectType.FlyGame_Enemy then
			local res = self.rootScene.gamePlayer:CheckPlayerBoundsIntersects(v.collider2D)

			if res then
				if GameEntry.Base.DevMode then
					log("受到敌人子弹伤害 " .. v.bulletData.hurt .. " 敌人ID " .. v.bulletData.cid)
				end

				self.rootScene.gamePlayer:ReduceBlood(v.bulletData.hurt)
				self:RecycleBullet(v)
			end
		end
	end

	for i, v in pairs(self.survivalFlyGameRewardBoxCellPool) do
		if v.active and not v.picked then
			local res = self.rootScene.gamePlayer:CheckPlayerBoundsIntersects(v.collider2D)

			if res then
				local rewardBoxData = FlyGameRewardBoxData.New(v.rewardBoxData.specialCid, v.rewardBoxData.createTime)

				rewardBoxData:SetStartEffectTime(PlayerModule.GetServerTime())
				self.rootScene.gamePlayer:AddRewardBoxEffect(rewardBoxData)
				v:Pickup()
			end
		end
	end
end

function m:CheckBeyondBoundaries(sceneElement)
	if sceneElement.View.transform.position.x < self.rootScene.LimitLeft.transform.position.x or sceneElement.View.transform.position.x > self.rootScene.LimitRight.transform.position.x or sceneElement.View.transform.position.y > self.rootScene.LimitUp.transform.position.y or sceneElement.View.transform.position.y < self.rootScene.LimitDown.transform.position.y then
		return true
	end

	return false
end

function m:MonsterGenerator(monsterID)
	local pos = self:GetRandomPos()
	local enemyData = FlyGameEnemyData.New(monsterID)
	local enemyCell = self:GetEnemy()

	enemyCell.View.transform:SetParent(self.rootScene.RootNode.transform, false)
	enemyCell:SetData(pos, enemyData, function(enemy)
		self:RecycleEnemy(enemy)
	end)
end

function m:RewardBoxGenerator()
	local rewardBoxData = self:GetRandomRewardBoxData()
	local pos = self:GetRandomPos()
	local rewardBoxCell = self:GetRewardBoxCell()

	rewardBoxCell.View.transform:SetParent(self.rootScene.RootNode.transform, false)
	rewardBoxCell:SetData(pos, rewardBoxData, function(enemy)
		self:RecycleRewardBoxCell(enemy)
	end)
end

function m:GetRandomPos()
	math.randomseed(tostring(os.time()):reverse():sub(1, 7) + math.random(-10000, 10000))

	local index = math.random(0, self.rootScene.PosRandom.transform.childCount - 1)
	local posTrans = self.rootScene.PosRandom.transform:GetChild(index)

	if posTrans then
		return posTrans.position
	end

	return Vector3.New(0, 0, 0)
end

function m:GetRandomRewardBoxData()
	local randomValue = math.random() * FlyGameModule.specialItemTotalWeight
	local cumulative = 0
	local cfgSpecialItemData

	for i, v in ipairs(FlyGameModule.specialItemTab) do
		cumulative = cumulative + v.Weight

		if randomValue <= cumulative then
			cfgSpecialItemData = v

			break
		end
	end

	local rewardBoxData = FlyGameRewardBoxData.New(cfgSpecialItemData.Id, PlayerModule.GetServerTime())

	return rewardBoxData
end

function m:UseBombs()
	if self.rootScene.gamePlayer.energyValue < 100 then
		return
	end

	GameEntry.Sound:PlaySound(10711, Constant.SoundGroup.ENVIRONMENT)

	self.rootScene.gamePlayer.energyValue = self.rootScene.gamePlayer.energyValue - 100

	local cfgDate = FlyGameModule.GetBombCfgData()

	for i, v in pairs(self.survivalFlyGameEnemyPool) do
		if v.active and v.born and v.blood > 0 then
			v:ReduceBlood(cfgDate.Parameter)
		end
	end

	for i, v in pairs(self.survivalFlyGameBulletPool) do
		if v.active and v.bulletData.launcher == FlyGameConstant.ObjectType.FlyGame_Enemy then
			self:RecycleBullet(v)
		end
	end
end

function m:GetRandomEnemy(bulletType)
	local monsters = {}

	for i, v in pairs(self.survivalFlyGameEnemyPool) do
		if v.active and v.born and v.blood > 0 then
			if bulletType == FlyGameConstant.BulletType.Bullet_Slow_Speed then
				if #v.bulletInstanceIDs == 0 then
					table.insert(monsters, v.selfInstanceID)
				end
			elseif bulletType == FlyGameConstant.BulletType.Bullet_Fast then
				table.insert(monsters, v.selfInstanceID)
			end
		end
	end

	if #monsters > 0 then
		local index = math.random(1, #monsters)

		return monsters[index]
	end

	return nil
end

function m:GetEnemyByInstanceID(instanceID)
	local enemy = self.survivalFlyGameEnemyPool[instanceID]

	if enemy and enemy.active and enemy.born and enemy.blood > 0 then
		return enemy
	end

	return nil
end

function m:CleanData()
	for i, v in pairs(self.survivalFlyGameBulletPool) do
		self:RecycleBullet(v)
	end

	for i, v in pairs(self.survivalFlyGameEnemyPool) do
		self:RecycleEnemy(v)
	end

	for i, v in pairs(self.survivalFlyGameRewardBoxCellPool) do
		self:RecycleRewardBoxCell(v)
	end

	for i, v in pairs(self.survivalFlyGameDamageCellPool) do
		for k, value in pairs(v) do
			self:RecycleFlightGameDamage(value)
		end
	end
end

function m:Dispose()
	self:CleanData()

	for i, v in pairs(self.survivalFlyGameBulletPool) do
		v:Dispose()
	end

	self.survivalFlyGameBulletPool = {}

	for i, v in pairs(self.survivalFlyGameEnemyPool) do
		v:Dispose()
	end

	self.survivalFlyGameEnemyPool = {}

	for i, v in pairs(self.survivalFlyGameRewardBoxCellPool) do
		v:Dispose()
	end

	self.survivalFlyGameRewardBoxCellPool = {}

	for i, v in pairs(self.survivalFlyGameDamageCellPool) do
		for k, value in pairs(v) do
			value:Dispose()
		end
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
