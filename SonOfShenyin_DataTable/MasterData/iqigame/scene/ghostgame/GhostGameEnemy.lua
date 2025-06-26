-- chunkname: @IQIGame\\Scene\\GhostGame\\GhostGameEnemy.lua

local GhostGameCharacter = require("IQIGame.Module.GhostGame.GhostGameCharacter")
local ghostEnemyHpBarView = require("IQIGame.Scene.GhostGame.GhostEnemyHpBarView")
local m = Clone(GhostGameCharacter)

m.skinEntityGo = nil
m.ghostEnemyHpBarView = nil
m.buttonTrigger = nil
m.PlayerSpineAnimations = {
	idle = "idle",
	die = "die"
}

function m:_Init(parent, enemyData)
	function self.delegateOnShowEntitySuccess(sender, args)
		self:OnShowEntitySuccess(args)
	end

	function self.delegatePlayAnimationListFinish()
		self:PlayAnimationListFinish()
	end

	self.isReady = false
	self.isDead = false
	self.skinEntityGo = nil
	self.ghostEnemyData = enemyData
	self.parent = parent

	self:LoadEntity(self.ghostEnemyData.monsterCfg.Entity)
end

function m:_SaveServerTime(serverTime)
	self.serverTime = serverTime
end

function m:LoadEntity(enemyCid)
	self.uniqueEntityID = GameEntry.Entity:GenerateEntityID()

	GameEntry.LuaEvent:Subscribe(ShowEntitySuccessEventArgs.EventId, self.delegateOnShowEntitySuccess)
	GameEntry.Entity:ShowBattleElement(self.uniqueEntityID, enemyCid, 0, nil, Vector3.New(0, 0, 0))
end

function m:OnShowEntitySuccess(args)
	if self.uniqueEntityID ~= args.Entity.Id then
		return
	end

	GameEntry.LuaEvent:Unsubscribe(ShowEntitySuccessEventArgs.EventId, self.delegateOnShowEntitySuccess)
	self:OnInitGameobject(args.Entity.gameObject)
	self:LoadHpBar()
end

function m:OnInitGameobject(gameObject)
	self.skinEntityGo = gameObject

	self.skinEntityGo.transform:SetParent(self.parent, false)

	self.skinEntityGo.transform.localScale = Vector3.one
	self.skinEntityGo.transform.localPosition = Vector3.zero
	self.isReady = true
	self.isDead = false
	self.skeletonAnimation = self.skinEntityGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation), true)

	self.skeletonAnimation:Initialize(true)
	self:SetFlipX(false)
	self:PlayAnimation(self.PlayerSpineAnimations.idle, true)

	self.boxCollider = self.skinEntityGo:GetComponent(typeof(UnityEngine.BoxCollider))

	if self.boxCollider then
		self.boxCollider.enabled = true
	end

	self.buttonTrigger = self.skinEntityGo:GetComponent(typeof(ButtonTrigger))

	if self.buttonTrigger == nil then
		self.buttonTrigger = self.skinEntityGo:AddComponent(typeof(ButtonTrigger))
	end

	self.buttonTrigger.valueString = self.serverTime
end

function m:LoadHpBar()
	AssetUtil.LoadAsset(self, GhostGameApi:GetGhostGameHpBarPrefabPath(), function(_, _assetUrl, _asset, _duration, _userData)
		self:OnLoadHpBarSuccess(_asset)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("加载血条失败")
	end)
end

function m:OnLoadHpBarSuccess(_asset)
	local hpBarObj = GameObject.Instantiate(_asset)

	self.ghostEnemyHpBarView = ghostEnemyHpBarView.New(hpBarObj)

	hpBarObj.transform:SetParent(self.skinEntityGo.transform:Find("Ui"), false)
	self.ghostEnemyHpBarView:Hide()
	self.ghostEnemyHpBarView:SetData(self.ghostEnemyData)
end

function m:_Update()
	if self.isReady == false or self.skinEntityGo == nil or self.isDead then
		return
	end

	if self.ghostEnemyData:IsDead() then
		self:TriggerBuff()
		self:Dead()

		return
	end

	self.skinEntityGo.transform:Translate(Vector3.New(-1, 0, 0) * Time.deltaTime * self.moveSpeed)

	if self.skinEntityGo.transform.localPosition.x < -20 then
		GhostGameModule.ghostGameScene:RemoveEnemy(self.serverTime)
	end
end

function m:TriggerBuff()
	if self.ghostEnemyData.defaultBuff ~= -1 then
		GhostGameBuffManager.TriggerBuff(self.ghostEnemyData.defaultBuff)
	end
end

function m:UpdateHP(attackPower)
	local curHp = self.ghostEnemyData:UpdateHp(attackPower)

	self:Affected()
end

function m:Affected()
	local effectPos = self.skinEntityGo.transform:Find("EffectPoint").position

	GameEntry.Effect:PlayNormalEffect(40015, effectPos)
end

function m:Dead()
	GhostGameModule.AddKillData(self)

	self.boxCollider.enabled = false
	self.isDead = true
	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete + self.delegatePlayAnimationListFinish

	self.skeletonAnimation.state:ClearTracks()
	self:PlayAnimation(self.PlayerSpineAnimations.die, false)
	self.ghostEnemyHpBarView:Hide()
end

function m:PlayAnimation(animationName, isLoop)
	if animationName == nil then
		animationName = self.PlayerSpineAnimations.idle
		isLoop = true
	end

	local animData = self.skeletonAnimation.state.Data.SkeletonData:FindAnimation(animationName)

	if animData ~= nil then
		if isLoop == nil then
			isLoop = false
		end

		if self.skeletonAnimation.AnimationName ~= animationName then
			self.skeletonAnimation.state:SetAnimation(0, animationName, isLoop)
		else
			local trackEntry = self.skeletonAnimation.AnimationState:GetCurrent(0)

			if not trackEntry.Loop then
				self.skeletonAnimation.state:AddAnimation(0, animationName, isLoop, 0)
			end
		end
	else
		logError("不存在" .. animationName .. "动画")
	end
end

function m:PlayAnimationListFinish()
	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete - self.delegatePlayAnimationListFinish

	GhostGameModule.ghostGameScene:RemoveEnemy(self.serverTime)
end

function m:SetFlipX(isRight)
	if self.skeletonAnimation then
		local scaleX = isRight and 1 or -1

		if self.skeletonAnimation.Skeleton.ScaleX ~= scaleX then
			self.skeletonAnimation.Skeleton.ScaleX = scaleX
		end
	else
		self.transform.localScale.x = isRight
	end
end

function m:_Dispose()
	self.isReady = false
	self.buttonTrigger = nil

	self.ghostEnemyHpBarView:Dispose()

	self.ghostEnemyHpBarView = nil
	self.boxCollider = nil

	GameEntry.Entity:HideEntity(self.uniqueEntityID)

	self.ghostEnemyData = nil
end

return m
