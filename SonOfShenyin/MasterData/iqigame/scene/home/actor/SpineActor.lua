-- chunkname: @IQIGame\\Scene\\Home\\Actor\\SpineActor.lua

local HomeActor = require("IQIGame/Scene/Home/Actor/HomeActor")
local SpineActor = Clone(HomeActor)

SpineActor.uniqueEntityID = 0
SpineActor.skinEntityGo = nil
SpineActor.skeletonAnimation = nil

function SpineActor:__OnInit()
	self:__SpineActor_LoadSpine(self.actorCid)
end

function SpineActor:__OnInitEventDelegate()
	self:__SpineActor_OnInitEventDelegate()
end

function SpineActor:__SpineActor_OnInitEventDelegate()
	function self.__delegateOnShowEntitySuccess(sender, args)
		self:__OnShowEntitySuccess(args)
	end

	function self.onShowEntityFailed(sender, args)
		logError(string.format("【RPG】实体 = %s 实体显示失败.请策划检查配置，该实体路径是否配置正确", args.EntityAssetName))
	end
end

function SpineActor:__OnDispose()
	self:__SpineActor_OnDispose()
end

function SpineActor:__SpineActor_OnDispose()
	self.skinEntityGo = nil
	self.skeletonAnimation = nil
	self.boxCollider = nil
	self.skeletonData = nil

	if self.actorComponent ~= nil then
		GameObject.Destroy(self.actorComponent)

		self.actorComponent = nil
	end

	GameEntry.Entity:HideEntity(self.uniqueEntityID)
end

function SpineActor:__SpineActor_LoadSpine(elementEntityCid)
	self.uniqueEntityID = GameEntry.Entity:GenerateEntityID()

	GameEntry.LuaEvent:Subscribe(ShowEntitySuccessEventArgs.EventId, self.__delegateOnShowEntitySuccess)
	GameEntry.LuaEvent:Subscribe(ShowEntityFailureEventArgs.EventId, self.onShowEntityFailed)
	GameEntry.Entity:ShowBattleElement(self.uniqueEntityID, elementEntityCid, 0, nil, Vector3.New(999, 999, 999))
end

function SpineActor:__OnShowEntitySuccess(args)
	if self.uniqueEntityID ~= args.Entity.Id then
		return
	end

	GameEntry.LuaEvent:Unsubscribe(ShowEntitySuccessEventArgs.EventId, self.__delegateOnShowEntitySuccess)
	GameEntry.LuaEvent:Unsubscribe(ShowEntityFailureEventArgs.EventId, self.onShowEntityFailed)
	self:__OnInitSpine(args.Entity.gameObject)
end

function SpineActor:__OnInitSpine(gameObject)
	self:__SpineActor_InitSpine(gameObject)
	self:__OnActorPrepareReady()
end

function SpineActor:__SpineActor_InitSpine(gameObject)
	self.skinEntityGo = gameObject
	self.skinEntityGo.name = self.actorCid

	local layerName = self:__GetLayerName()

	setGameObjectLayers(self.skinEntityGo.transform, layerName)

	self.skeletonAnimation = self.skinEntityGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation), true)

	if not self.skeletonAnimation then
		logError(string.format("【RPG】id = %s 的组件不是一个带spine的npc角色", self.actorCid))
	end

	self.skeletonAnimation:Initialize(true)

	self.skeletonData = self.skeletonAnimation.state.Data.SkeletonData
	self.boxCollider = self.skinEntityGo:GetComponent(typeof(UnityEngine.BoxCollider))

	if self.boxCollider == nil then
		self.boxCollider = self.skinEntityGo:AddComponent(typeof(UnityEngine.BoxCollider))
		self.boxCollider.center = Vector3.New(0, 1, 0)
		self.boxCollider.size = Vector3.New(0.7, 1.9, 0.8)
	end

	self.boxCollider.isTrigger = false

	self:__InitActorComponent()
end

function SpineActor:__InitActorComponent()
	self.actorComponent = LuaUtility.GameObjectGetOrAddComponent(self.skinEntityGo, typeof(IQIGame.Onigao.Game.Home.HomeActor))

	self.actorComponent:InitActorData(self:GetSceneActorType(), self.componentId)
end

function SpineActor:GetSceneActorType()
	logError("{0} 继承 SpineActor 未实现 GetSceneActorType 方法", self)

	return Constant.HomeSceneActorType.WorkActor
end

function SpineActor:__GetLayerName()
	logError("{0} 继承 SpineActor 未实现 GetSceneActorType 方法", self)

	return "Default"
end

function SpineActor:PlayAnimation(animName, loop)
	if self.skeletonAnimation == nil then
		return
	end

	if self.skeletonAnimation.state == nil then
		logError("play spine animation error, state is null. Animation name: " .. animName .. " gameObject: " .. self.skinEntityGo.name)

		return
	end

	local animData = self:FindAnimation(animName)

	if not animData then
		return
	end

	local isLoop = loop == true and loop or false

	if self.skeletonAnimation.AnimationName == animName and not isLoop then
		return
	end

	self.skeletonAnimation.state:SetAnimation(0, animName, isLoop)
end

function SpineActor:FindAnimation(animName)
	if not self.skeletonData then
		return
	end

	return self.skeletonData:FindAnimation(animName)
end

function SpineActor:SetFlipX(isRight)
	if self.skeletonAnimation then
		local scaleX = isRight and 1 or -1

		if self.skeletonAnimation.Skeleton.ScaleX ~= scaleX then
			self.skeletonAnimation.Skeleton.ScaleX = scaleX
		end
	else
		if not self.transform then
			logError("not transform id =" .. self.componentId)

			return
		end

		self.transform.localScale.x = isRight
	end
end

return SpineActor
