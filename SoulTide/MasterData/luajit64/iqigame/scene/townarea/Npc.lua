-- chunkname: @IQIGame\\Scene\\TownArea\\Npc.lua

local Npc = {
	entityId = 0,
	INTERVAL = 3
}
local AI = require("IQIGame.Scene.TownArea.AI")

function Npc.New(view)
	local obj = Clone(Npc)

	obj:Init(view)

	return obj
end

function Npc:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ai = AI.New(self.View)
	self.tfTip = self.goTip:GetComponent("Text")

	function self.onClickBtnSelfDelegate()
		self:OnClickBtnSelf()
	end

	function self.onShowSpineSuccessDelegate(sender, args)
		self:OnShowSpineSuccess(sender, args)
	end

	self.timer = Timer.New(function()
		self:OnTimer()
	end, self.INTERVAL, 1)
end

function Npc:Refresh(id, position, walkArea)
	self.View.transform:SetParent(walkArea[3], false)

	self.cfgTownAreaNpcData = CfgTownAreaNpcTable[id]
	self.walkArea = walkArea

	self:SetActive(true)

	self.View.transform.localPosition = position

	self:StopTimer()
	self:ShowSpine()
	self:OnAddListener()
end

function Npc:OnUpdate()
	self.ai:OnUpdate()
end

function Npc:OnHide()
	self:OnRemoveListener()
	self:DisposeEntity()
	self:StopTimer()
	self.ai:OnHide()
end

function Npc:OnDestroy()
	self:OnHide()
	self.ai:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.ai = nil
	self.timer = nil
end

function Npc:OnAddListener()
	self:OnRemoveListener()

	if self.goBtnSelf ~= nil then
		EventTriggerListener.Get(self.goBtnSelf).onClick = self.onClickBtnSelfDelegate
	end

	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowSpineSuccessDelegate)
end

function Npc:OnRemoveListener()
	if self.goBtnSelf ~= nil then
		EventTriggerListener.Get(self.goBtnSelf).onClick = nil
	end

	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowSpineSuccessDelegate)
end

function Npc:OnClickBtnSelf()
	self:StartTimer()
end

function Npc:OnShowSpineSuccess(sender, args)
	if self.entityId ~= args.Entity.Id then
		return
	end

	local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

	animation.state:SetAnimation(0, "idle", true)
	self.ai:StartAI(animation, self.walkArea)
end

function Npc:StartTimer()
	self.tfTip.text = TownAreaUIApi:GetString("npcTip", self.cfgTownAreaNpcData.Word[math.random(1, #self.cfgTownAreaNpcData.Word)])

	self.goTip.transform.parent.gameObject:SetActive(true)
	self.timer:Stop()
	self.timer:Reset(function()
		self:OnTimer()
	end, self.INTERVAL, 1)
	self.timer:Start()
end

function Npc:StopTimer()
	self.goTip.transform.parent.gameObject:SetActive(false)
	self.timer:Stop()
end

function Npc:OnTimer()
	self:StopTimer()
end

function Npc:ShowSpine()
	self:DisposeEntity()

	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.entityId, self.cfgTownAreaNpcData.Spine, 0, self.goSpineRoot.transform, Vector3.zero)
end

function Npc:DisposeEntity()
	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end
end

function Npc:SetActive(vs)
	if not vs then
		self:OnHide()
	end

	self.isWorking = vs

	self.View:SetActive(vs)
end

return Npc
