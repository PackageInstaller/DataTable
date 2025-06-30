-- chunkname: @IQIGame\\Scene\\MemoryStory\\Element\\MemoryStoryElement.lua

local ShowEntitySuccessEventArgs = UnityGameFramework.Runtime.ShowEntitySuccessEventArgs
local MemoryStoryElemTalkComponent = require("IQIGame.Scene.MemoryStory.Element.FunctionComponent.MemoryStoryElemTalkComponent")
local m = {
	elementId = 0,
	isTalking = false,
	entityId = 0,
	curAnimName = "",
	curAnimLoop = false,
	effectIdTab = {}
}

function m.New(controller, view)
	local obj = Clone(m)

	obj:__Init(controller, view)

	return obj
end

function m:__Init(controller, view)
	self.viewRoot = view
	self.controller = controller
	self.elementId = controller.CfgData.Id
	self.viewRoot.name = tostring(self.elementId)

	self:__PrepareEntity(self.controller.CfgData.Element, function()
		self:__OnEntityPrepareSucceed(true)
	end)
end

function m:GetPosition()
	return self.viewRoot.transform.localPosition
end

function m:SetEntityDir(forward)
	if not self.goSpineRoot then
		return
	end

	if forward then
		self.goSpineRoot.transform.localScale = self.forwardScale
	else
		self.goSpineRoot.transform.localScale = self.backScale
	end
end

function m:IsLookForward()
	if not self.goSpineRoot then
		return false
	end

	return self.goSpineRoot.transform.localScale == self.forwardScale
end

function m:__InitPositionByConfig()
	local position

	if #self.controller.CfgData.Position ~= 0 then
		position = Vector3.New(self.controller.CfgData.Position[1], self.controller.CfgData.Position[2], 0)
	else
		position = Vector3.New(0, 0, 0)
	end

	self.viewRoot.transform.localPosition = position
end

function m:__InitOrientations()
	self:__InitSpineRootOrientations()
	self:SetEntityDir(self.controller.CfgData.Orientations)
end

function m:__InitSpineRootOrientations()
	if self.goSpineRoot == nil then
		return
	end

	local scale = self.goSpineRoot.transform.localScale

	self.forwardScale = Vector3.New(math.abs(scale.x) * -1, scale.y, scale.z)
	self.backScale = Vector3.New(math.abs(scale.x), scale.y, scale.z)
end

function m:__PrepareEntity(elementEntityId, successHandler)
	function self.showEntitySuccessEventProxy(sender, args)
		self:__OnShowEntitySuccessEventHandler(sender, args, successHandler)
	end

	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.LuaEvent:Subscribe(ShowEntitySuccessEventArgs.EventId, self.showEntitySuccessEventProxy)
	GameEntry.Entity:ShowElement(self.entityId, elementEntityId, 0, self.viewRoot.transform, Vector3.zero)
end

function m:__OnShowEntitySuccessEventHandler(sender, args, successHandler)
	if args.Entity.Id ~= self.entityId then
		return
	end

	GameEntry.LuaEvent:Unsubscribe(ShowEntitySuccessEventArgs.EventId, self.showEntitySuccessEventProxy)

	self.entityRoot = args.Entity.gameObject

	LuaCodeInterface.BindOutlet(self.entityRoot, self)
	self:__InitAnimationElement()
	self:__InitTipElement()
	self:__InitOrientations()
	self:__InitCollider()
	self:__SetOutlineActive(false)
	self:__SetOutlineLightActive(false)
	successHandler()
end

function m:Transfiguration(elementEntityId)
	self:__DestroyEntity()
	self:__PrepareEntity(elementEntityId, function()
		self:__OnEntityPrepareSucceed(false)
	end)
end

function m:__OnEntityPrepareSucceed(executeService)
	self:__DoEntityPrepareSucceed(executeService)
end

function m:__DoEntityPrepareSucceed(executeService)
	MemoryStoryModule.OnElementReadyInScene(self.elementId, executeService)
end

function m:__HideEntity()
	if self.entityRoot ~= nil then
		LuaCodeInterface.ClearOutlet(self.entityRoot, self)

		self.entityRoot = nil
	end

	if self.entityId == 0 then
		return
	end

	GameEntry.Entity:HideEntity(self.entityId)

	self.entityId = 0
end

function m:__SetOutlineActive(active)
	if self.goOutline == nil then
		return
	end

	if self.goOutline.gameObject.activeSelf ~= active then
		self.goOutline.gameObject:SetActive(active)
	end
end

function m:__SetOutlineLightActive(active)
	if self.goOutlineLight == nil then
		return
	end

	if self.goOutlineLight.gameObject.activeSelf ~= active then
		self.goOutlineLight.gameObject:SetActive(active)
	end
end

function m:__PlayEffect(effectCid, delay)
	if self.goPointRoot == nil then
		return nil
	end

	local effectId = GameEntry.Effect:PlayMountPointEffect(effectCid, Constant.MountPoint.PointRoot, self.entityId, self.goSpineRoot, delay, 0, 0, LuaCodeInterface.SortingLayerNameToID("Element"), self.goSpineRoot:GetComponentInChildren(typeof(UnityEngine.Renderer)).sortingOrder, 1, false)

	self:__AddEffectId(effectCid, effectId)
end

function m:__RemoveEffect(effectCid)
	local effects = self.effectIdTab[effectCid]

	if effects == nil then
		return
	end

	for i = 1, #effects do
		GameEntry.Effect:StopEffect(effects[i])
	end

	self.effectIdTab[effectCid] = nil
end

function m:__RemoveAllEffect()
	for effectCid, effectIds in pairs(self.effectIdTab) do
		for i = 1, #effectIds do
			GameEntry.Effect:StopEffect(effectIds[i])
		end
	end

	self.effectIdTab = {}
end

function m:__AddEffectId(effectCid, effectId)
	local tab = self.effectIdTab[effectCid]

	if tab == nil then
		tab = {}

		table.insert(tab, effectId)
	end

	self.effectIdTab[effectCid] = tab
end

function m:PlayAnim(anim, loop)
	self:__PlayAnim(anim, loop)
end

function m:__InitAnimationElement()
	if self.goSpineRoot == nil then
		self.animaCtrl = nil

		return
	end

	self.animaCtrl = self.goSpineRoot.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

	if self.animaCtrl ~= nil then
		self:__PlayAnim(self.controller.CfgData.DefaultAction, true)
	end
end

function m:__StopAnim()
	if self.animaCtrl == nil then
		return
	end

	self.animaCtrl.state:SetEmptyAnimation(0, 0)
end

function m:__PlayAnim(name, loop)
	if self.animaCtrl == nil then
		return
	end

	if name == nil or name == "" then
		return
	end

	if self.animaCtrl.AnimationName == name then
		return
	end

	self.curAnimName = name
	self.curAnimLoop = loop

	self.animaCtrl.state:SetAnimation(0, name, loop)
end

function m:__IsAnimationEnd()
	if self.animaCtrl == nil then
		return true
	end

	if self.animaCtrl.state:GetCurrent(0) == nil then
		return true
	end

	return self.animaCtrl.state:GetCurrent(0).IsComplete
end

function m:__OnAnimationUpdate()
	if LuaCodeInterface.GameObjIsDestroy(self.animaCtrl) then
		return
	end

	if self.curAnimLoop then
		return
	end

	if self.animaCtrl.AnimationName ~= self.controller.CfgData.DefaultAction and self:__IsAnimationEnd() then
		self:__PlayAnim(self.controller.CfgData.DefaultAction, true)
	end
end

function m:__InitTipElement()
	if self.goTip == nil then
		self.talkComponent = nil
	else
		self.talkComponent = MemoryStoryElemTalkComponent.New(self.goTip)
	end
end

function m:EnterTalking()
	self.isTalking = true
end

function m:ExitTalking()
	self.isTalking = false

	self:HideTip()
end

function m:HideTip()
	if self.talkComponent == nil then
		return
	end

	self.talkComponent:HideTalk()
end

function m:ShowTip(content)
	if self.talkComponent == nil then
		return
	end

	local right = self:IsLookForward()

	if right then
		self.talkComponent:ShowLeftTalk(content)
	else
		self.talkComponent:ShowRightTalk(content)
	end
end

function m:__InitCollider()
	if self.goTrigger ~= nil then
		self.Collider = self.goTrigger:GetComponent(typeof(UnityEngine.Collider2D))
	else
		self.Collider = nil
	end
end

function m:ColliderBoundsIntersects(collider)
	if LuaCodeInterface.GameObjIsDestroy(self.Collider) or LuaCodeInterface.GameObjIsDestroy(collider) then
		return false
	end

	return self.Collider.bounds:Intersects(collider.bounds)
end

function m:OnUpdate()
	self:__OnAnimationUpdate()
end

function m:OnDestroy()
	self:__BaseDestroy()
end

function m:__BaseDestroy()
	self.viewRoot.gameObject:SetActive(false)
	self:__DestroyEntity()
	UnityEngine.GameObject.Destroy(self.viewRoot.gameObject)

	self.viewRoot = nil
	self.controller = nil
end

function m:__DestroyEntity()
	self:__StopAnim()
	self:__RemoveAllEffect()
	self:__SetOutlineActive(false)
	self:__SetOutlineLightActive(false)

	if self.talkComponent ~= nil then
		self.talkComponent:OnDestroy()
	end

	self:__HideEntity()
end

return m
