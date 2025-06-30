-- chunkname: @IQIGame\\Scene\\Survival\\SurvivalFlyGamePlayer.lua

local m = {
	invincible = false,
	moveSpeed = 15,
	blood = 0,
	attackSpeed = 0.5,
	energyValue = 0,
	hurt = 1,
	entityId = 0,
	buffCD = 0.5,
	totalBlood = 0,
	lastAttackTime = 0,
	lastReduce = 0,
	bulletTrajectory = {},
	rewardBoxDataEffect = {},
	buffEffectSound = {}
}
local FlyGameBulletData = require("IQIGame.Module.CommonActivity.Survival.FlyGame.FlyGameBulletData")

function m.New(view, gameScene)
	local obj = Clone(m)

	obj:Init(view, gameScene)

	return obj
end

function m:Init(view, gameScene)
	self.View = view
	self.rootScene = gameScene

	LuaCodeInterface.BindOutlet(self.View, self)

	self.rigidBody2D = self.View:GetComponent(typeof(UnityEngine.Rigidbody2D))
	self.collider2D = self.View:GetComponent(typeof(UnityEngine.Collider2D))

	function self.DelegateJoystickMove(value)
		self:OnMovePos(value)
	end

	function self.DelegateOnShowEntitySuccess(sender, args)
		self:OnShowEntitySuccess(sender, args)
	end

	self:PlayBuffEffect(FlyGameConstant.SpecialItemType.SpecialItem_Type_Invincible, false)
	self:PlayBuffEffect(FlyGameConstant.SpecialItemType.SpecialItem_Type_Add_MoveSpeed, false)
	self:PlayBuffEffect(FlyGameConstant.SpecialItemType.SpecialItem_Type_Add_Attack, false)
	self:SetDefaultEffect()
	self:AddListener()
end

function m:AddListener()
	EventDispatcher.AddEventListener(EventID.JoystickMove, self.DelegateJoystickMove)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowEntitySuccess)
end

function m:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.JoystickMove, self.DelegateJoystickMove)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowEntitySuccess)
end

function m:SetDefaultEffect()
	self.EffectBorn:SetActive(false)
	self.HpAddEffect:SetActive(false)
	self.BuffEffect1:SetActive(false)
	self.BuffEffect3:SetActive(false)
	self.BuffEffect4:SetActive(false)

	for i = 1, 5 do
		self["AddEffectType" .. i]:SetActive(false)
	end
end

function m:SetPlayerData(data, showBornEffect)
	if showBornEffect then
		self.EffectBorn:SetActive(false)
		self.EffectBorn:SetActive(true)
	end

	self.playerData = data

	self.playerData:RefreshTakeSpecialEffect(true)

	self.totalBlood = self.playerData:GetChallengePlayerAttr(FlyGameConstant.Attribute.FlyGame_Shield_Value)
	self.blood = self.totalBlood
	self.attackSpeed = self.playerData:GetChallengePlayerAttr(FlyGameConstant.Attribute.FlyGame_Attack_Interval)
	self.moveSpeed = self.playerData:GetChallengePlayerAttr(FlyGameConstant.Attribute.FlyGame_Player_Move_Speed)
	self.hurt = self.playerData:GetChallengePlayerAttr(FlyGameConstant.Attribute.FlyGame_Hurt)

	self:ShowElement(self.playerData:GetConfigData().PlayerSpine)

	self.energyValue = 0
end

function m:ShowElement(entityCid)
	self:HideEntity()

	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.entityId, entityCid, 0, self.SpineRoot.transform, Vector3.zero)
end

function m:HideEntity()
	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end
end

function m:OnShowEntitySuccess(sender, args)
	if self.entityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(1, 1, 1)

		setGameObjectLayers(args.Entity.gameObject.transform, "Default")

		local renderers = args.Entity:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			renderers[i].sortingLayerID = LuaCodeInterface.SortingLayerNameToID("Default")
		end

		self.playerSkeletonAnimation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		self:PlayAction(self.playerData:GetConfigData().Animation, true)
	end
end

function m:OnMovePos(value)
	local pos = Vector2.New(self.View.transform.localPosition.x + self.moveSpeed * 0.01 * value.x, self.View.transform.localPosition.y + self.moveSpeed * 0.01 * value.y)

	pos.x = Mathf.Clamp(pos.x, -5.71, 5)
	pos.y = Mathf.Clamp(pos.y, -2.6, 2.8)

	self.rigidBody2D:MovePosition(pos)
end

function m:TimerUpdate()
	self.energyValue = self.energyValue + self.playerData:GetChallengePlayerAttr(FlyGameConstant.Attribute.FlyGame_Add_Energy_Speed)

	local maxEnergyVale = self.playerData:GetChallengePlayerAttr(FlyGameConstant.Attribute.FlyGame_Energy_Value)

	if maxEnergyVale < self.energyValue then
		self.energyValue = maxEnergyVale
	end

	self.playerData:RefreshTakeSpecialEffect(false)
	self:CheckFlyGamePlayerEffect()
end

function m:FrameUpdate()
	if UnityEngine.Time.realtimeSinceStartup - self.lastAttackTime > self.attackSpeed then
		self.lastAttackTime = UnityEngine.Time.realtimeSinceStartup

		local cfgData = self.playerData:GetConfigLevelData(self.playerData.grade)

		if cfgData then
			local cfgBulletGroupData = CfgSurvivalChallengeBulletGroupTable[cfgData.BulletPath]
			local index = math.random(1, #cfgBulletGroupData.BulletId)
			local bulletPath = cfgBulletGroupData.BulletId[index]

			self:AttackBulletPath(bulletPath)
		end

		if #self.bulletTrajectory > 0 then
			for i, v in pairs(self.bulletTrajectory) do
				self:AttackBulletPath(v)
			end
		end
	end
end

function m:CheckFlyGamePlayerEffect()
	local isInvincible = false
	local addSpeed = 0
	local addHurt = 0
	local addBlood = 0

	self.bulletTrajectory = {}
	self.showBuffs = {}
	self.moveSpeed = self.playerData:GetChallengePlayerAttr(FlyGameConstant.Attribute.FlyGame_Player_Move_Speed)
	self.hurt = self.playerData:GetChallengePlayerAttr(FlyGameConstant.Attribute.FlyGame_Hurt)

	self.rootScene.gameBG:SetSpeed(0.1)

	for i, v in pairs(self.rewardBoxDataEffect) do
		if v:IsTakeEffect() then
			if v:GetConfigData().Type == FlyGameConstant.SpecialItemType.SpecialItem_Type_Invincible then
				isInvincible = true
			elseif v:GetConfigData().Type == FlyGameConstant.SpecialItemType.SpecialItem_Type_Add_MoveSpeed then
				addSpeed = math.floor(self.moveSpeed * v:GetConfigData().Parameter / 100)

				self.rootScene.gameBG:SetSpeed(0.25)
			elseif v:GetConfigData().Type == FlyGameConstant.SpecialItemType.SpecialItem_Type_Add_Hurt then
				addHurt = math.floor(self.hurt * v:GetConfigData().Parameter / 100)
			elseif v:GetConfigData().Type == FlyGameConstant.SpecialItemType.SpecialItem_Type_Add_Attack then
				table.insert(self.bulletTrajectory, v:GetConfigData().Parameter)
			end
		else
			self:RemoveRewardBoxEffect(i)
		end
	end

	local effective, cfgData = self.playerData:IsTakeEffectSpecial()

	if effective and cfgData then
		log(cfgData.Type .. " 生效的特性")

		if cfgData.Type == FlyGameConstant.SpecialItemType.SpecialItem_Type_Invincible then
			isInvincible = true
		elseif cfgData.Type == FlyGameConstant.SpecialItemType.SpecialItem_Type_Add_MoveSpeed then
			addSpeed = addSpeed + math.floor(self.moveSpeed * cfgData.Parameter / 100)

			self.rootScene.gameBG:SetSpeed(0.25)
		elseif cfgData.Type == FlyGameConstant.SpecialItemType.SpecialItem_Type_Add_Hurt then
			addHurt = addHurt + math.floor(self.hurt * cfgData.Parameter / 100)
		elseif cfgData.Type == FlyGameConstant.SpecialItemType.SpecialItem_Type_RecoveryBlood then
			addBlood = cfgData.Parameter
			self.blood = self.blood + addBlood
			self.blood = self.blood > self.totalBlood and self.totalBlood or self.blood

			if addBlood then
				self:PlayAddEffect(addBlood)
			end
		elseif cfgData.Type == FlyGameConstant.SpecialItemType.SpecialItem_Type_Add_Attack and table.indexOf(self.bulletTrajectory, cfgData.Parameter) == -1 then
			table.insert(self.bulletTrajectory, cfgData.Parameter)
		end
	end

	if self.invincible ~= isInvincible then
		self.invincible = isInvincible
	end

	self.moveSpeed = self.moveSpeed + addSpeed
	self.hurt = self.hurt + addHurt

	self:PlayBuffEffect(FlyGameConstant.SpecialItemType.SpecialItem_Type_Invincible, self.invincible, 10708)
	self:PlayBuffEffect(FlyGameConstant.SpecialItemType.SpecialItem_Type_Add_MoveSpeed, addSpeed ~= 0 or addHurt ~= 0, 10707)
	self:PlayBuffEffect(FlyGameConstant.SpecialItemType.SpecialItem_Type_Add_Attack, #self.bulletTrajectory > 0, 10706)
	EventDispatcher.Dispatch(EventID.SurvivalUpdatePlayerEvent)
end

function m:PlayBuffEffect(type, isShow, soundCid)
	self["BuffEffect" .. type]:SetActive(isShow)
	self:PlayBuffEffectSound(type, soundCid, isShow)
end

function m:PlayBuffEffectSound(type, cid, isPlay)
	if isPlay then
		self.buffEffectSound[type] = GameEntry.Sound:PlaySound(cid, Constant.SoundGroup.ENVIRONMENT)
	elseif self.buffEffectSound[type] ~= 0 and self.buffEffectSound[type] ~= nil then
		GameEntry.Sound:StopSound(self.buffEffectSound[type])

		self.buffEffectSound[type] = 0
	end
end

function m:CheckPlayerBoundsIntersects(collider2D)
	return self.collider2D.bounds:Intersects(collider2D.bounds)
end

function m:AttackBulletPath(cid)
	GameEntry.Sound:PlaySound(10701, Constant.SoundGroup.ENVIRONMENT)

	local cfgData = CfgSurvivalChallengeBulletPathTable[cid]

	if cfgData.Angle == nil or cfgData.Angle == 0 then
		self:AttackDoubleLine(cfgData.BulletNum, cfgData.BulletSpeed, cid)
	else
		self:AttackRange(cfgData.BulletNum, cfgData.Angle, cfgData.BulletSpeed, cid)
	end
end

function m:AttackDoubleLine(num, bulletSpeed, cid)
	local offset = 0
	local spacing = 0.6

	if num % 2 == 0 then
		offset = spacing / 2
	end

	for i = 0, num - 1 do
		local pos = self.FirePos.transform.position
		local bulletCell = self.rootScene.gameManager:GetBullet()

		bulletCell.View.transform:SetParent(self.rootScene.RootNode.transform, false)

		if i == 0 then
			pos = Vector3.New(pos.x, pos.y + spacing * i - offset, pos.z)
		elseif i % 2 == 1 then
			pos = Vector3.New(pos.x, pos.y + spacing * math.ceil(i / 2) - offset, pos.z)
		else
			pos = Vector3.New(pos.x, pos.y - spacing * math.ceil(i / 2) - offset, pos.z)
		end

		local bulletData = FlyGameBulletData.New(self.playerData.cid, self.hurt, FlyGameConstant.ObjectType.FlyGame_Player, Vector2.New(bulletSpeed, 0), cid)

		bulletCell:SetData(pos, bulletData, function(bullet)
			self.rootScene.gameManager:RecycleBullet(bullet)
		end)
	end
end

function m:AttackRange(num, angle, bulletSpeed, cid)
	local offset = 0

	if num % 2 == 0 then
		offset = angle / 2
	end

	for i = 0, num - 1 do
		local pos = self.FirePos.transform.position
		local bulletCell = self.rootScene.gameManager:GetBullet()

		bulletCell.View.transform:SetParent(self.rootScene.RootNode.transform, false)

		if i == 0 then
			bulletCell.View.transform:Rotate(0, 0, angle * i - offset)
		elseif i % 2 == 1 then
			bulletCell.View.transform:Rotate(0, 0, angle * math.ceil(i / 2) - offset)
		else
			bulletCell.View.transform:Rotate(0, 0, -angle * math.ceil(i / 2) - offset)
		end

		local bulletData = FlyGameBulletData.New(self.playerData.cid, self.hurt, FlyGameConstant.ObjectType.FlyGame_Player, Vector2.New(bulletSpeed, 0), cid)

		bulletCell:SetData(Vector3.New(pos.x, pos.y, pos.z), bulletData, function(bullet)
			self.rootScene.gameManager:RecycleBullet(bullet)
		end)
	end
end

function m:ReduceBlood(num)
	if self.invincible then
		return
	end

	local nowTime = PlayerModule.GetServerTime()

	if nowTime - self.lastReduce < self.buffCD then
		return
	end

	self.lastReduce = nowTime

	GameEntry.Sound:PlaySound(10702, Constant.SoundGroup.ENVIRONMENT)

	local hurt = num
	local damageCell = self.rootScene.gameManager:GetFlightGameDamageCell(FlyGameConstant.DamageType.Hero_Damage)

	damageCell.View.transform:SetParent(self.DamageNode.transform, false)

	damageCell.View.transform.localScale = Vector3.New(-0.01, 0.01, 0.01)

	damageCell:SetData(hurt)

	self.blood = math.floor(self.blood - hurt)

	if self.blood > 0 then
		self.EffectHit:SetActive(false)
		self.EffectHit:SetActive(true)
	end

	if self.blood <= 0 then
		GameEntry.Sound:PlaySound(10702, Constant.SoundGroup.ENVIRONMENT)
		self.EffectDeath:SetActive(false)
		self.EffectDeath:SetActive(true)

		self.blood = 0
		self.rewardBoxDataEffect = {}

		FlyGameModule.GameOver()
	end

	EventDispatcher.Dispatch(EventID.UpdateFlightGamePlayerEvent)
end

function m:PlayAction(actionName, top)
	if self.playerSkeletonAnimation then
		self.playerSkeletonAnimation.state:SetAnimation(0, actionName, top)
	end
end

function m:AddRewardBoxEffect(rewardBoxData)
	GameEntry.Sound:PlaySound(10709, Constant.SoundGroup.ENVIRONMENT)

	if rewardBoxData:GetConfigData().Type == FlyGameConstant.SpecialItemType.SpecialItem_Type_Bomb then
		self.energyValue = self.energyValue + 50
	elseif rewardBoxData:GetConfigData().Type == FlyGameConstant.SpecialItemType.SpecialItem_Type_RecoveryBlood then
		GameEntry.Sound:PlaySound(10710, Constant.SoundGroup.ENVIRONMENT)

		local addValue = math.floor(self.totalBlood * rewardBoxData:GetConfigData().Parameter / 100)

		self.blood = self.blood + addValue
		self.blood = self.blood > self.totalBlood and self.totalBlood or self.blood

		self:PlayAddEffect(addValue)
	elseif self.rewardBoxDataEffect[rewardBoxData.specialCid] == nil then
		self.rewardBoxDataEffect[rewardBoxData.specialCid] = rewardBoxData
	else
		self.rewardBoxDataEffect[rewardBoxData.specialCid].effectEndTime = self.rewardBoxDataEffect[rewardBoxData.specialCid].effectEndTime + rewardBoxData:GetConfigData().Duration
	end

	self:PlayRewardBoxEffect(rewardBoxData:GetConfigData().Type)
	self:CheckFlyGamePlayerEffect()
end

function m:PlayAddEffect(addValue)
	self.HpAddEffect:SetActive(false)
	self.HpAddEffect:SetActive(true)

	local damageCell = self.rootScene.gameManager:GetFlightGameDamageCell(FlyGameConstant.DamageType.Hero_Health)

	damageCell.View.transform:SetParent(self.DamageNode.transform, false)

	damageCell.View.transform.localScale = Vector3.New(-0.01, 0.01, 0.01)

	damageCell:SetData(addValue)
end

function m:PlayRewardBoxEffect(type)
	local showTypes = {
		FlyGameConstant.SpecialItemType.SpecialItem_Type_Invincible,
		FlyGameConstant.SpecialItemType.SpecialItem_Type_RecoveryBlood,
		FlyGameConstant.SpecialItemType.SpecialItem_Type_Add_MoveSpeed,
		FlyGameConstant.SpecialItemType.SpecialItem_Type_Add_Attack,
		FlyGameConstant.SpecialItemType.SpecialItem_Type_Bomb
	}

	if table.indexOf(showTypes, type) ~= -1 then
		self["AddEffectType" .. type]:SetActive(false)
		self["AddEffectType" .. type]:SetActive(true)
	end
end

function m:RemoveRewardBoxEffect(specialCid)
	if self.rewardBoxDataEffect[specialCid] then
		self.rewardBoxDataEffect[specialCid] = nil
	end
end

function m:CleanData()
	for i, v in pairs(self.buffEffectSound) do
		if v ~= 0 and v ~= nil then
			GameEntry.Sound:StopSound(v)
		end
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self:HideEntity()

	self.playerSkeletonAnimation = nil
	self.rigidBody2D = nil
	self.collider2D = nil
	self.rewardBoxDataEffect = {}

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
