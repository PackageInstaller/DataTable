-- chunkname: @IQIGame\\Scene\\FlightChallenge\\FlightGameManager.lua

local m = {
	flightGameBulletPool = {},
	flightGameEnemyPool = {},
	flightGameRewardBoxCellPool = {},
	flightGameDamageCellPool = {}
}
local FlightGameBullet = require("IQIGame.Scene.FlightChallenge.FlightGameBullet")
local FlightGameEnemy = require("IQIGame.Scene.FlightChallenge.FlightGameEnemy")
local FlightGameRewardBoxCell = require("IQIGame.Scene.FlightChallenge.FlightGameRewardBoxCell")
local FlightGameEnemyData = require("IQIGame.Module.CommonActivity.FlightChallenge.FlightGame.FlightGameEnemyData")
local FlightGameRewardBoxData = require("IQIGame.Module.CommonActivity.FlightChallenge.FlightGame.FlightGameRewardBoxData")
local FlightGameDamageCell = require("IQIGame.Scene.FlightChallenge.FlightGameDamageCell")

function m.New(view, gameScene)
	local obj = Clone(m)

	obj:Init(view, gameScene)

	return obj
end

function m:Init(view, gameScene)
	self.View = view
	self.rootScene = gameScene

	LuaCodeInterface.BindOutlet(self.View, self)

	self.flightGameBulletPool = {}
	self.flightGameEnemyPool = {}
	self.flightGameRewardBoxPool = {}
	self.flightGameDamageCellPool[FlightGameConstant.DamageType.Monster_Damage] = {}
	self.flightGameDamageCellPool[FlightGameConstant.DamageType.Hero_Damage] = {}
	self.flightGameDamageCellPool[FlightGameConstant.DamageType.Hero_Health] = {}
end

function m:GetFlightGameDamageCell(type)
	for i, v in pairs(self.flightGameDamageCellPool[type]) do
		if not v.active and v:IsFinished() then
			return v
		end
	end

	local obj

	if type == FlightGameConstant.DamageType.Monster_Damage then
		obj = self.MonsterDamagePrefab
	elseif type == FlightGameConstant.DamageType.Hero_Damage then
		obj = self.HeroDamagePrefab
	elseif type == FlightGameConstant.DamageType.Hero_Health then
		obj = self.HeroHealthPrefab
	end

	local flightGameDamageCell = FlightGameDamageCell.New(UnityEngine.Object.Instantiate(obj), type)

	self.flightGameDamageCellPool[type][flightGameDamageCell.View:GetInstanceID()] = flightGameDamageCell

	return flightGameDamageCell
end

function m:RecycleFlightGameDamage(flightGameDamageCell)
	flightGameDamageCell.View.transform:SetParent(self.RecoveryNode.transform, false)
	flightGameDamageCell:Reset()

	self.flightGameDamageCellPool[flightGameDamageCell.type][flightGameDamageCell.View:GetInstanceID()] = flightGameDamageCell
end

function m:GetRewardBoxCell()
	for i, v in pairs(self.flightGameRewardBoxCellPool) do
		if not v.active then
			return v
		end
	end

	local rewardBoxCell = FlightGameRewardBoxCell.New(UnityEngine.Object.Instantiate(self.RewardModel))

	self.flightGameRewardBoxCellPool[rewardBoxCell.View:GetInstanceID()] = rewardBoxCell

	return rewardBoxCell
end

function m:RecycleRewardBoxCell(rewardBoxCell)
	rewardBoxCell.View.transform:SetParent(self.RecoveryNode.transform, false)
	rewardBoxCell:Reset()

	self.flightGameRewardBoxCellPool[rewardBoxCell.View:GetInstanceID()] = rewardBoxCell
end

function m:GetBullet()
	for i, v in pairs(self.flightGameBulletPool) do
		if not v.active then
			return v
		end
	end

	local bulletCell = FlightGameBullet.New(UnityEngine.Object.Instantiate(self.BulletModel))

	self.flightGameBulletPool[bulletCell.View:GetInstanceID()] = bulletCell

	return bulletCell
end

function m:RecycleBullet(bullet)
	bullet.View.transform:SetParent(self.RecoveryNode.transform, false)
	bullet:Reset()

	self.flightGameBulletPool[bullet.View:GetInstanceID()] = bullet
end

function m:GetEnemy()
	for i, v in pairs(self.flightGameEnemyPool) do
		if not v.active and v:IsPlayDamageEnd() then
			return v
		end
	end

	local enemy = FlightGameEnemy.New(UnityEngine.Object.Instantiate(self.EnemyModel), self.rootScene)

	self.flightGameEnemyPool[enemy.View:GetInstanceID()] = enemy

	return enemy
end

function m:RecycleEnemy(enemy)
	enemy.View.transform:SetParent(self.RecoveryNode.transform, false)
	enemy:Reset()

	self.flightGameEnemyPool[enemy.View:GetInstanceID()] = enemy
end

function m:FrameUpdate()
	for i, v in pairs(self.flightGameBulletPool) do
		if v.active then
			if self:CheckBeyondBoundaries(v) then
				self:RecycleBullet(v)
			end

			v:FrameUpdate()
		end
	end

	for i, v in pairs(self.flightGameEnemyPool) do
		if v.active and v.born then
			if self:CheckBeyondBoundaries(v) then
				self:RecycleEnemy(v)
			end

			v:FrameUpdate()
			self:CheckCollisionEnemy(v)
		end
	end

	for i, v in pairs(self.flightGameRewardBoxCellPool) do
		if v.active then
			if self:CheckBeyondBoundaries(v) then
				self:RecycleRewardBoxCell(v)
			end

			v:FrameUpdate()
		end
	end

	for i, v in pairs(self.flightGameDamageCellPool) do
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
		for i, v in pairs(self.flightGameBulletPool) do
			if v.active and v.bulletData.launcher == FlightGameConstant.ObjectType.FlightGame_Player then
				local res = v.collider2D.bounds:Intersects(enemy.collider2D.bounds)

				if res then
					local hurt = v.bulletData.hurt
					local addHurt = v.bulletData:AddHurtByMonsterType(enemy.enemyData:GetConfigData().Race)

					hurt = math.floor(hurt * (1 + addHurt / 100))

					enemy:ReduceBlood(hurt, v.bulletData.bulletPathID)
					self:RecycleBullet(v)
				end
			end
		end

		if enemy.active and enemy.born and enemy.blood > 0 then
			local result = self.rootScene.gamePlayer:CheckPlayerBoundsIntersects(enemy.collider2D)

			if result then
				local hurt = enemy.enemyData:GetChallengeEnemyAttr(FlightGameConstant.Attribute.Flight_Collision_Damage)

				self.rootScene.gamePlayer:ReduceBlood(hurt)
				enemy:ReduceBlood(hurt)
			end
		end
	end
end

function m:CheckPlayerCollision()
	for i, v in pairs(self.flightGameBulletPool) do
		if v.active and v.bulletData.launcher == FlightGameConstant.ObjectType.FlightGame_Enemy then
			local res = self.rootScene.gamePlayer:CheckPlayerBoundsIntersects(v.collider2D)

			if res then
				self.rootScene.gamePlayer:ReduceBlood(v.bulletData.hurt)
				self:RecycleBullet(v)
			end
		end
	end

	for i, v in pairs(self.flightGameRewardBoxCellPool) do
		if v.active and not v.picked then
			local res = self.rootScene.gamePlayer:CheckPlayerBoundsIntersects(v.collider2D)

			if res then
				local rewardBoxData = FlightGameRewardBoxData.New(v.rewardBoxData.specialCid, v.rewardBoxData.createTime)

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
	local enemyData = FlightGameEnemyData.New(monsterID)
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

	local x = math.random(self.rootScene.RandomPosUp.transform.position.x * 100, self.rootScene.RandomPosDown.transform.position.x * 100) / 100
	local y = math.random(self.rootScene.RandomPosDown.transform.position.y * 100, self.rootScene.RandomPosUp.transform.position.y * 100) / 100

	return Vector3.New(x, y, 0)
end

function m:GetRandomRewardBoxData()
	local randomValue = math.random() * FlightGameModule.specialItemTotalWeight
	local cumulative = 0
	local cfgSpecialItemData

	for i, v in ipairs(FlightGameModule.specialItemTab) do
		cumulative = cumulative + v.Weight

		if randomValue <= cumulative then
			cfgSpecialItemData = v

			break
		end
	end

	local rewardBoxData = FlightGameRewardBoxData.New(cfgSpecialItemData.Id, PlayerModule.GetServerTime())

	return rewardBoxData
end

function m:UseBombs()
	if FlightGameModule.bombNum <= 0 then
		return
	end

	GameEntry.Sound:PlaySound(10711, Constant.SoundGroup.ENVIRONMENT)

	FlightGameModule.bombNum = FlightGameModule.bombNum - 1

	local cfgDate = FlightGameModule.GetBombCfgData()

	for i, v in pairs(self.flightGameEnemyPool) do
		if v.active and v.born and v.blood > 0 then
			v:ReduceBlood(cfgDate.Parameter)
		end
	end
end

function m:CleanData()
	for i, v in pairs(self.flightGameBulletPool) do
		self:RecycleBullet(v)
	end

	for i, v in pairs(self.flightGameEnemyPool) do
		self:RecycleEnemy(v)
	end

	for i, v in pairs(self.flightGameRewardBoxCellPool) do
		self:RecycleRewardBoxCell(v)
	end

	for i, v in pairs(self.flightGameDamageCellPool) do
		for k, value in pairs(v) do
			self:RecycleFlightGameDamage(value)
		end
	end
end

function m:Dispose()
	self:CleanData()

	for i, v in pairs(self.flightGameBulletPool) do
		v:Dispose()
	end

	self.flightGameBulletPool = {}

	for i, v in pairs(self.flightGameEnemyPool) do
		v:Dispose()
	end

	self.flightGameEnemyPool = {}

	for i, v in pairs(self.flightGameRewardBoxCellPool) do
		v:Dispose()
	end

	self.flightGameRewardBoxCellPool = {}

	for i, v in pairs(self.flightGameDamageCellPool) do
		for k, value in pairs(v) do
			value:Dispose()
		end
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
