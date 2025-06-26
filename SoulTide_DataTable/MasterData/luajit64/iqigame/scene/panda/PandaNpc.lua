-- chunkname: @IQIGame\\Scene\\Panda\\PandaNpc.lua

local PandaNpc = {
	entityId = 0
}
local PandaNpcAI = require("IQIGame.Scene.Panda.PandaNpcAI")

function PandaNpc.New(view)
	local obj = Clone(PandaNpc)

	obj:Init(view)

	return obj
end

function PandaNpc:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ai = PandaNpcAI.New(self.View)

	UGUIUtil.SetText(self.goTip, "")
	self.goTip.transform.parent.gameObject:SetActive(false)

	function self.onShowSpineSuccessDelegate(sender, args)
		self:OnShowSpineSuccess(sender, args)
	end
end

function PandaNpc:Refresh(id, position, walkArea)
	self.id = id

	self.View.transform:SetParent(walkArea[3], false)

	self.cfgPandaEventData = CfgPandaEventListTable[id]
	self.walkArea = walkArea

	self:SetActive(true)

	self.View.transform.localPosition = position

	self:ShowSpine()
	self:OnAddListener()
end

function PandaNpc:OnUpdate()
	self.ai:OnUpdate()
end

function PandaNpc:OnHide()
	self:OnRemoveListener()
	self:DisposeEntity()
	self.ai:OnHide()
end

function PandaNpc:OnDestroy()
	self:OnHide()
	self.ai:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
	self.ai = nil
end

function PandaNpc:OnAddListener()
	self:OnRemoveListener()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowSpineSuccessDelegate)
end

function PandaNpc:OnRemoveListener()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowSpineSuccessDelegate)
end

function PandaNpc:OnShowSpineSuccess(sender, args)
	if self.entityId ~= args.Entity.Id then
		return
	end

	local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

	animation.state:SetAnimation(0, "idle", true)

	if self.cfgPandaEventData.Type == 1 or self.cfgPandaEventData.Type == 2 then
		self.ai:StartAI(animation, self.walkArea)
	end

	local spineRenderers = args.Entity:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

	for j = 0, spineRenderers.Length - 1 do
		local renderer = spineRenderers[j]

		renderer.enabled = true
	end

	local renderers = args.Entity:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for i = 0, renderers.Length - 1 do
		renderers[i].enabled = true
	end
end

function PandaNpc:ShowSpine()
	self:DisposeEntity()

	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.entityId, self.cfgPandaEventData.Spine, 0, self.goSpineRoot.transform, Vector3.zero)
end

function PandaNpc:DisposeEntity()
	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end
end

function PandaNpc:SetActive(vs)
	if not vs then
		self:OnHide()
	end

	self.isWorking = vs

	self.View:SetActive(vs)
end

return PandaNpc
