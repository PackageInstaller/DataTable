-- chunkname: @IQIGame\\Scene\\FlightChallenge\\FlightGameEnemy.lua

local m = {
	blood = 0,
	moveSpeed = 5,
	lastAttackTime = 0,
	deathEffectEnd = false,
	attackSpeed = 1,
	hurt = 0,
	entityId = 0,
	active = false,
	born = false
}
local FlightGameBulletData = require("IQIGame.Module.CommonActivity.FlightChallenge.FlightGame.FlightGameBulletData")
local FlightGameEnemyHpView = require("IQIGame.Scene.FlightChallenge.FlightGameEnemyHpView")

function m.New(view, gameScene)
	local obj = Clone(m)

	obj:Init(view, gameScene)

	return obj
end

function m:Init(view, gameScene)
	self.View = view
	self.rootScene = gameScene

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnShowEntitySuccess(sender, args)
		self:OnShowEntitySuccess(sender, args)
	end

	self.enemyHpView = FlightGameEnemyHpView.New(self.Hp)

	self:AddListener()
	self:Reset()
end

function m:AddListener()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowEntitySuccess)
end

function m:RemoveListener()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowEntitySuccess)
end

function m:FrameUpdate()
	if self.blood > 0 and self.born then
		local playerPos = self.rootScene.gamePlayer.View.transform.position

		if self.enemyData:GetConfigData().Type == FlightGameConstant.MonsterType.MonsterType_Boss then
			playerPos.x = Mathf.Clamp(playerPos.x, 3, 7)
		end

		local direction = playerPos - self.View.transform.position

		self.View.transform:Translate(direction.normalized * self.moveSpeed * UnityEngine.Time.deltaTime)

		if UnityEngine.Time.realtimeSinceStartup - self.lastAttackTime > self.attackSpeed then
			self.lastAttackTime = UnityEngine.Time.realtimeSinceStartup

			for i = 1, #self.enemyData:GetConfigData().BulletPath do
				local id = self.enemyData:GetConfigData().BulletPath[i]

				self:AttackBulletPath(id, 0)
			end

			self:PlayAction("attack01")
		end
	end
end

function m:AttackBulletPath(cid, angle)
	local cfgData = CfgFlightChallengeBulletPathTable[cid]

	if cfgData.Angle == nil or cfgData.Angle == 0 then
		self:AttackDoubleLine(cfgData.Id, cfgData.BulletNum, cfgData.BulletSpeed, angle)
	else
		self:AttackRange(cfgData.Id, cfgData.BulletNum, cfgData.Angle, cfgData.BulletSpeed, angle)
	end
end

function m:AttackDoubleLine(cid, num, bulletSpeed, angle)
	local offset = 0
	local spacing = 0.6

	if num % 2 == 0 then
		offset = spacing / 2
	end

	for i = 0, num - 1 do
		local firePos = self.FirePos.transform.position

		if self.FireTr and not LuaCodeInterface.GameObjIsDestroy(self.FireTr) then
			firePos = self.FireTr.position
		end

		local bulletCell = self.rootScene.gameManager:GetBullet()

		bulletCell.View.transform:SetParent(self.rootScene.RootNode.transform, false)
		bulletCell.View.transform:Rotate(0, 0, angle)

		if i == 0 then
			firePos = Vector3.New(firePos.x, firePos.y + spacing * i - offset, firePos.z)
		elseif i % 2 == 1 then
			firePos = Vector3.New(firePos.x, firePos.y + spacing * math.ceil(i / 2) - offset, firePos.z)
		else
			firePos = Vector3.New(firePos.x, firePos.y - spacing * math.ceil(i / 2) - offset, firePos.z)
		end

		local bulletData = FlightGameBulletData.New(self.enemyData.monsterID, self.hurt, FlightGameConstant.ObjectType.FlightGame_Enemy, Vector2.New(-bulletSpeed, 0), cid)

		bulletCell:SetData(firePos, bulletData, function(bullet)
			self.rootScene.gameManager:RecycleBullet(bullet)
		end)
	end
end

function m:AttackRange(cid, num, angle, bulletSpeed, an)
	local offset = 0

	if num % 2 == 0 then
		offset = angle / 2
	end

	offset = offset + an

	for i = 0, num - 1 do
		local bulletCell = self.rootScene.gameManager:GetBullet()

		bulletCell.View.transform:SetParent(self.rootScene.RootNode.transform, false)

		if i == 0 then
			bulletCell.View.transform:Rotate(0, 0, angle * i - offset)
		elseif i % 2 == 1 then
			bulletCell.View.transform:Rotate(0, 0, angle * math.ceil(i / 2) - offset)
		else
			bulletCell.View.transform:Rotate(0, 0, -angle * math.ceil(i / 2) - offset)
		end

		local firePos = self.FirePos.transform.position

		if self.FireTr then
			firePos = self.FireTr.position
		end

		local bulletData = FlightGameBulletData.New(self.enemyData.monsterID, self.hurt, FlightGameConstant.ObjectType.FlightGame_Enemy, Vector2.New(-bulletSpeed, 0), cid)

		bulletCell:SetData(firePos, bulletData, function(bullet)
			self.rootScene.gameManager:RecycleBullet(bullet)
		end)
	end
end

function m:SetData(pos, enemyData, callback)
	self.enemyData = enemyData
	self.blood = self.enemyData:GetChallengeEnemyAttr(FlightGameConstant.Attribute.Flight_Shield_Value)
	self.attackSpeed = self.enemyData:GetChallengeEnemyAttr(FlightGameConstant.Attribute.Flight_Attack_Interval)
	self.moveSpeed = self.enemyData:GetChallengeEnemyAttr(FlightGameConstant.Attribute.Flight_Element_Move_Speed)
	self.hurt = self.enemyData:GetChallengeEnemyAttr(FlightGameConstant.Attribute.Flight_Hurt)
	self.View.transform.position = pos
	self.recycleEnemyCallBack = callback
	self.active = true

	self.View:SetActive(true)
	self:PlayBurnEffect(self.enemyData:GetConfigData().Type, enemyData)
end

function m:PlayBurnEffect(type, enemyData)
	if type == FlightGameConstant.MonsterType.MonsterType_Boss then
		self.BurnBoss:SetActive(false)
		self.BurnBoss:SetActive(true)
	else
		self.Burn:SetActive(false)
		self.Burn:SetActive(true)
	end

	local tim = Timer.New(function()
		if self.View ~= nil and not LuaCodeInterface.GameObjIsDestroy(self.View) then
			self:ShowElement(self.enemyData:GetConfigData().MonsterSpine)
			self.enemyHpView:SetData(enemyData)

			self.born = true
		end
	end, 0.5)

	tim:Start()
end

function m:ShowElement(entityCid)
	self:HideEntity()

	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.entityId, entityCid, 0, self.SpineNode.transform, Vector3.zero)
end

function m:HideEntity()
	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end
end

function m:OnShowEntitySuccess(sender, args)
	if self.entityId == args.Entity.Id then
		if not self.born then
			return
		end

		args.Entity.gameObject.transform.localScale = Vector3(0.3, 0.3, 0.3)
		self.collider2D = self.View:GetComponentInChildren(typeof(UnityEngine.Collider2D))
		self.collider2D.enabled = true

		setGameObjectLayers(args.Entity.gameObject.transform, "Default")

		local renderers = args.Entity:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			renderers[i].sortingLayerID = LuaCodeInterface.SortingLayerNameToID("Default")
		end

		self.monsterSkeletonAnimation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		self:PlayAction("idle")

		self.FireTr = args.Entity.gameObject.transform:Find("Fire")

		if self.enemyData:GetConfigData().Type == FlightGameConstant.MonsterType.MonsterType_Boss then
			-- block empty
		end
	end
end

function m:PlayAction(actionName)
	if self.monsterSkeletonAnimation then
		self.monsterSkeletonAnimation.state:SetAnimation(0, actionName, true)
	end
end

function m:IsPlayDamageEnd()
	return self.DamageNode.transform.childCount == 0
end

function m:Reset()
	self.collider2D = self.View:GetComponentInChildren(typeof(UnityEngine.Collider2D))

	if self.collider2D then
		self.collider2D.enabled = false
	end

	self.recycleEnemyCallBack = nil
	self.active = false
	self.born = false
	self.blood = 0

	self.View:SetActive(false)
	self.EffectHit:SetActive(false)
	self.EffectDeath:SetActive(false)
	self.Burn:SetActive(false)
	self.BurnBoss:SetActive(false)
	self.enemyHpView:Reset()
	self:HideEntity()
end

function m:ReduceBlood(num, bulletPath)
	if self.blood <= 0 then
		return
	end

	GameEntry.Sound:PlaySound(10704, Constant.SoundGroup.ENVIRONMENT)

	local path = bulletPath

	if path == nil then
		path = ""
	end

	if GameEntry.Base.DevMode then
		log("怪物ID：" .. self.enemyData.monsterID .. "怪物总血量：" .. self.blood .. " 扣血： " .. num .. " 弹道ID：" .. path .. " 时间：" .. PlayerModule.GetServerTime())
	end

	self.blood = self.blood - num

	if self.blood > 0 then
		self.EffectHit:SetActive(false)
		self.EffectHit:SetActive(true)
	else
		GameEntry.Sound:PlaySound(10705, Constant.SoundGroup.ENVIRONMENT)
		self.EffectDeath:SetActive(false)
		self.EffectDeath:SetActive(true)

		local timer = Timer.New(function()
			self.active = false

			if self.recycleEnemyCallBack then
				self.recycleEnemyCallBack(self)
			end
		end, 0.3)

		timer:Start()
	end

	local damageCell = self.rootScene.gameManager:GetFlightGameDamageCell(FlightGameConstant.DamageType.Monster_Damage)

	damageCell.View.transform.localScale = Vector3.New(0.01, 0.01, 0.01)

	damageCell:SetData(num)
	damageCell.View.transform:SetParent(self.DamageNode.transform, false)

	if self.enemyData:GetConfigData().Type == FlightGameConstant.MonsterType.MonsterType_Boss then
		-- block empty
	end

	self.enemyHpView:RefreshHp(self.blood)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)

	self.recycleEnemyCallBack = nil
	self.monsterSkeletonAnimation = nil
	self.collider2D = nil

	self:RemoveListener()
	self:HideEntity()

	self.FireTr = nil

	self.enemyHpView:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
