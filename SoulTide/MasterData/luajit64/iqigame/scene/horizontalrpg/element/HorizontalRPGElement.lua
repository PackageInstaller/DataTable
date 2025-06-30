-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\Element\\HorizontalRPGElement.lua

local m = {
	CollisionWithPlayer = false,
	EnterTheScope = false,
	IsStepOn = false,
	EffectId = 0,
	EntityId = 0,
	Active = false,
	CollisionWithPlayerTimer = 0,
	MovePaths = {},
	ElementState = {}
}
local HorizontalRPGBulletData = require("IQIGame.Module.CommonActivity.HorizontalRPG.HorizontalRPGBulletData")
local HorizontalRPGFireCtrl = require("IQIGame.Scene.HorizontalRPG.Controller.HorizontalRPGFireCtrl")
local HorizontalRPGElementBtnView = require("IQIGame.Scene.HorizontalRPG.Element.HorizontalRPGElementBtnView")
local HorizontalRPGChatView = require("IQIGame.Scene.HorizontalRPG.Element.HorizontalRPGChatView")
local HorizontalRPGElementMoveCtrl = require("IQIGame.Scene.HorizontalRPG.Controller.HorizontalRPGElementMoveCtrl")
local HorizontalRPGStateCtrl = require("IQIGame.Scene.HorizontalRPG.Controller.HorizontalRPGStateCtrl")
local HorizontalRPGStateData = require("IQIGame.Scene.HorizontalRPG.HorizontalRPGStateData")

function m.New(view, objManager)
	local obj = Clone(m)

	obj:Init(view, objManager)

	return obj
end

function m:Init(view, objManager)
	self.View = view
	self.GameObjManager = objManager

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ElementState = {}
	self.ElementState[HorizontalRPGConstant.ElementState.die] = {
		"die",
		false
	}
	self.ElementState[HorizontalRPGConstant.ElementState.born] = {
		"born",
		false
	}
	self.ElementState[HorizontalRPGConstant.ElementState.idle] = {
		"idle",
		true
	}
	self.ElementState[HorizontalRPGConstant.ElementState.move] = {
		"move",
		true
	}
	self.ElementState[HorizontalRPGConstant.ElementState.action] = {
		"action",
		false
	}
	self.ElementFireCtrl = HorizontalRPGFireCtrl.New(self.goFirePos, HorizontalRPGModule.horizontalRPGScene.AreaNode.transform.parent, self)
	self.ElementMoveCtrl = HorizontalRPGElementMoveCtrl.New(self, function(isMove)
		self:MoveStateChange(isMove)
	end)
	self.ElementBodyCollider2D = self.View:GetComponent(typeof(UnityEngine.Collider2D))
	self.ElementHeadCollider2D = self.goHead:GetComponent(typeof(UnityEngine.Collider2D))
	self.ElementRigidBody2D = self.View:GetComponent(typeof(UnityEngine.Rigidbody2D))
	self.ElementRigidBody2D.simulated = false
	self.ElementBtnView = HorizontalRPGElementBtnView.New(self.goElementBtn)
	self.ChatView = HorizontalRPGChatView.New(self.goTalk)

	function self.OnShowSpineSuccessDelegate(sender, args)
		self:OnShowSpineSuccess(sender, args)
	end

	self.Active = false

	self.View:SetActive(false)
	self:CloseEffect()
	self:AddListener()
end

function m:AddListener()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.OnShowSpineSuccessDelegate)
end

function m:RemoveListener()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.OnShowSpineSuccessDelegate)
end

function m:FrameUpdate()
	if self.Active then
		self.ElementFireCtrl:FrameUpdate()
		self.ElementMoveCtrl:FrameUpdate()
		self.ChatView:FrameUpdate()
		self.GameObjManager:CheckBulletCollision({
			self.ElementBodyCollider2D,
			self.ElementHeadCollider2D
		}, HorizontalRPGConstant.ObjectType.HorizontalRPG_Element, self.ElementData)
	end

	if self.ElementStateCtrl then
		self.ElementStateCtrl:FrameUpdate()
	end

	self:ChangeElementState()
end

function m:FixedUpdate()
	if not self.Active then
		return
	end

	if self.ElementMoveCtrl then
		self.ElementMoveCtrl:FixedUpdate()
	end

	local enterScope = false

	if HorizontalRPGModule.horizontalRPGScene.HorizontalGamePaler then
		local disY = math.abs(HorizontalRPGModule.horizontalRPGScene.HorizontalGamePaler.View.transform.position.y - self.View.transform.position.y)
		local disX = math.abs(HorizontalRPGModule.horizontalRPGScene.HorizontalGamePaler.View.transform.position.x - self.View.transform.position.x)

		if disX < self.ElementData:GetCfgData().ElementRange and disY < 2 then
			enterScope = true
		end

		self:CheckCollisionWithPlayer()
	end

	if self.EnterTheScope ~= enterScope then
		self.EnterTheScope = enterScope

		if self.EnterTheScope then
			HorizontalRPGModule.TriggerElementService(HorizontalRPGConstant.ElementTriggerType.EnterElementScope, self.ElementData.cid)

			local haveService, successfulService = self.ElementData:GetSuccessfulService(HorizontalRPGConstant.ElementTriggerType.ClickElementBtn)
			local isCase = self.ElementData:GetCfgData().ElementType == HorizontalRPGConstant.ElementType.HorizontalRPG_Case

			self.ElementBtnView:ShowBtnElement(haveService or isCase)
		else
			self.ElementBtnView:ShowBtnElement(false)
		end
	end
end

function m:CheckCollisionWithPlayer()
	local res = self.ElementBodyCollider2D.bounds:Intersects(HorizontalRPGModule.horizontalRPGScene.HorizontalGamePaler.collider2D.bounds)

	if res then
		local nowTime = PlayerModule.GetServerTime()

		if nowTime - self.CollisionWithPlayerTimer >= HorizontalRPGModule.continuedTriggerCD then
			self.CollisionWithPlayerTimer = nowTime

			log("触发碰撞 " .. nowTime .. "  " .. self.ElementData.cid)
			HorizontalRPGModule.TriggerElementService(HorizontalRPGConstant.ElementTriggerType.CollisionElementBody, self.ElementData.cid)
		end
	end
end

function m:Reset()
	if self.RestTimer then
		self.RestTimer:Stop()
	end

	self.Active = false

	if self.ElementStateCtrl and self.ElementStateCtrl.HorizontalRPGStatePool[HorizontalRPGConstant.ElementState.die] then
		self:ChangeState(HorizontalRPGConstant.ElementState.die)
		GameEntry.Sound:PlaySound(HorizontalRPGConstant.Sound.ElementDie, Constant.SoundGroup.ENVIRONMENT)

		if GameEntry.Base.DevMode then
			log("播放元素死亡音效 " .. HorizontalRPGConstant.Sound.ElementDie)
		end

		local rpgState = self.ElementStateCtrl.HorizontalRPGStatePool[HorizontalRPGConstant.ElementState.die]

		self.RestTimer = Timer.New(function()
			self.View:SetActive(false)
			self:CloseEffect()
			self:ChangeState(HorizontalRPGConstant.ElementState.idle)
		end, rpgState.stateData.playTime)

		self.RestTimer:Start()
	else
		self.View:SetActive(false)
		self:CloseEffect()
	end
end

function m:SetData(elementData, pathNode)
	self.IsStepOn = false
	self.ElementData = elementData

	if self.ElementStateCtrl then
		self.ElementStateCtrl:Dispose()
	end

	local elementStates = {}

	if #self.ElementData:GetCfgData().DefaultAction > 0 then
		for i = 1, #self.ElementData:GetCfgData().DefaultAction do
			local stateKey = self.ElementData:GetCfgData().DefaultAction[i]
			local playTime = self.ElementData:GetCfgData().DefaultActionTime[i]
			local stateTab = self.ElementState[stateKey]
			local rpgState = HorizontalRPGStateData.New(stateKey, stateTab[1], playTime, stateTab[2])

			table.insert(elementStates, rpgState)
		end
	end

	if #elementStates > 0 then
		self.ElementStateCtrl = HorizontalRPGStateCtrl.New(self, elementStates)
	end

	self.View:SetActive(self.ElementData.isShow)

	self.View.name = self.ElementData.cid

	self.ElementBtnView:SetData(elementData)
	self.ChatView:SetData(elementData.cid)

	self.Active = self.ElementData.isShow

	local isTrigger = self.ElementData:GetCfgData().Trigger

	if self.ElementData:GetCfgData().ElementType == HorizontalRPGConstant.ElementType.HorizontalRPG_Case then
		self.ElementRigidBody2D.isKinematic = false
		self.ElementBodyCollider2D.isTrigger = false
		self.ElementHeadCollider2D.isTrigger = false
	else
		self.ElementRigidBody2D.isKinematic = not isTrigger
		self.ElementBodyCollider2D.isTrigger = not isTrigger
		self.ElementHeadCollider2D.isTrigger = not isTrigger
	end

	self:ShowSpine()

	if elementData:GetCfgData().ElementType == HorizontalRPGConstant.ElementType.HorizontalRPG_Line_Move_Element or elementData:GetCfgData().ElementType == HorizontalRPGConstant.ElementType.HorizontalRPG_Annular_Move_Element then
		self.ElementMoveCtrl:RefreshPath(elementData:GetCfgData().ElementType, pathNode, self.goChangeDir)
		self.ElementMoveCtrl:StartMovie()
	end

	local simulated = elementData:GetCfgData().ElementType == HorizontalRPGConstant.ElementType.HorizontalRPG_Line_Move_Element

	self.ElementRigidBody2D.simulated = simulated

	if elementData:GetCfgData().ElementType == HorizontalRPGConstant.ElementType.HorizontalRPG_Case then
		self.ElementRigidBody2D.simulated = true
	end

	local bullet = self.ElementData:GetCfgData().ElementBullteControl

	if bullet > 0 then
		local dir = self.View.transform.localScale.x * -1
		local bulletData = HorizontalRPGBulletData.New(self.ElementData.cid, HorizontalRPGConstant.ObjectType.HorizontalRPG_Element, bullet, dir)

		self.ElementFireCtrl:SetBulletData(bulletData)
	end

	self:CloseEffect()

	if self.ElementData.horizontalRPGElementPOD and self.ElementData.horizontalRPGElementPOD.effect > 0 and self.Active then
		self:ShowEffect()
	end

	self.View.transform:Find("Canvas/GMText").gameObject:SetActive(GameEntry.Base.DevMode)
	UGUIUtil.SetText(self.View.transform:Find("Canvas/GMText/Text").gameObject, "元素ID:" .. self.ElementData.cid .. "\n服务ID：" .. tableToString(self.ElementData:GetCfgData().ServiceID))
end

function m:OnShowSpineSuccess(sender, args)
	if self.EntityId ~= args.Entity.Id then
		return
	end

	self.ElementSkeletonAnimation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

	self:ChangeState(HorizontalRPGConstant.ElementState.born)

	self.ElementSpineCollider2D = args.Entity.gameObject:GetComponent(typeof(UnityEngine.Collider2D))

	if self.ElementData.horizontalRPGElementPOD and self.ElementData.horizontalRPGElementPOD.effect > 0 and self.Active then
		self:ShowEffect()
	end
end

function m:ShowSpine()
	if self.LastShowElement and self.LastShowElement == self.ElementData:GetCfgData().Element then
		return
	end

	if self.ElementData:GetCfgData().Element <= 0 then
		return
	end

	self:OnHideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.EntityId, self.ElementData:GetCfgData().Element, 0, self.goSpineRoot.transform, Vector3.zero, nil, false)

	self.LastShowElement = self.ElementData:GetCfgData().Element
end

function m:OnHideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end

	self.LastShowElement = nil
end

function m:ShowEffect()
	local renderer = self.View:GetComponentInChildren(typeof(UnityEngine.Renderer))

	if renderer then
		self.EffectId = GameEntry.Effect:PlayNormalEffect(self.ElementData.horizontalRPGElementPOD.effect, self.View.transform:Find("Point_Root").position, 0, 0, 0, renderer.sortingLayerID, renderer.sortingOrder + 1, 10, true)

		log("ShowEffect " .. self.ElementData.horizontalRPGElementPOD.effect .. " self.EffectId " .. self.EffectId)
	end
end

function m:CloseEffect()
	if self.EffectId ~= 0 then
		GameEntry.Effect:StopEffect(self.EffectId)

		self.EffectId = 0
	end
end

function m:MoveStateChange(isMove)
	if self.ElementSkeletonAnimation and isMove then
		self:ChangeState(HorizontalRPGConstant.ElementState.move)
	end
end

function m:ChangeElementState()
	if self.ElementStateCtrl then
		local isEnter = false
		local isMoving = false
		local isDeath = false
		local isShooting = false
		local isBorn = false

		if self.ElementStateCtrl.CurrentState then
			isEnter = self.ElementStateCtrl.CurrentState.isEnter
			isMoving = isEnter and self.ElementStateCtrl.CurrentState.stateData.state == HorizontalRPGConstant.ElementState.move
			isDeath = isEnter and self.ElementStateCtrl.CurrentState.stateData.state == HorizontalRPGConstant.ElementState.die
			isShooting = isEnter and self.ElementStateCtrl.CurrentState.stateData.state == HorizontalRPGConstant.ElementState.action
			isBorn = isEnter and self.ElementStateCtrl.CurrentState.stateData.state == HorizontalRPGConstant.ElementState.born
		end

		if not isMoving and not isShooting and not isDeath and not isBorn then
			self:ChangeState(HorizontalRPGConstant.ElementState.idle)
		end
	end
end

function m:ChangeState(state)
	if self.ElementStateCtrl and self.ElementStateCtrl.HorizontalRPGStatePool[state] then
		self.ElementStateCtrl:ChangeState(state)
	end
end

function m:PlayAction(actionName, top)
	if self.ElementSkeletonAnimation and self.ElementSkeletonAnimation.AnimationName ~= actionName then
		self.ElementSkeletonAnimation.state:SetEmptyAnimation(0, 0)
		self.ElementSkeletonAnimation.state:SetAnimation(0, actionName, top)
	end
end

function m:Dispose()
	self:RemoveListener()

	self.Active = false

	AssetUtil.UnloadAsset(self)

	if self.ElementStateCtrl then
		self.ElementStateCtrl:Dispose()

		self.ElementStateCtrl = nil
	end

	if self.RestTimer then
		self.RestTimer:Stop()

		self.RestTimer = nil

		self:ChangeState(HorizontalRPGConstant.ElementState.idle)
	end

	self:OnHideEntity()
	self:CloseEffect()
	self.ElementFireCtrl:Dispose()

	self.ElementFireCtrl = nil

	self.ElementMoveCtrl:Dispose()

	self.ElementMoveCtrl = nil

	self.ElementBtnView:Dispose()

	self.ElementBtnView = nil

	self.ChatView:Dispose()

	self.ChatView = nil
	self.ElementData = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
