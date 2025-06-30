-- chunkname: @IQIGame\\Scene\\AmusementPark\\AmusementParkNPC.lua

local m = {
	isWorking = false,
	entityId = 0
}
local AmusementParkNPCAI = require("IQIGame.Scene.AmusementPark.AmusementParkNPCAI")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ai = AmusementParkNPCAI.New(self)

	function self.onShowSpineSuccessDelegate(sender, args)
		self:OnShowSpineSuccess(sender, args)
	end

	function self.DelegateRefreshNpcAiMove(roCid, isMove)
		self:OnRefreshNpcAiMove(roCid, isMove)
	end

	function self.DelegateNpcTalk(roCid)
		self:OnNpcTalk(roCid)
	end

	self.ChatTip:SetActive(false)
	self:OnAddListener()
end

function m:RefreshStatic(roleID)
	self.cfgParkRoleData = CfgAmusementParkRoleTable[roleID]

	self:SetActive(true)
end

function m:Refresh(data, position, walkArea, buildAreaData)
	self.cfgParkRoleData = data
	self.View.name = "Npc_" .. self.cfgParkRoleData.Id
	self.walkArea = walkArea
	self.buildAreaData = buildAreaData

	if self.walkArea then
		self.View.transform:SetParent(self.walkArea.trans, false)
	end

	if position then
		self.View.transform.localPosition = position
	end

	self:SetActive(true)
	self:ShowSpine()
end

function m:OnUpdate()
	self.ai:OnUpdate()
end

function m:OnHide()
	self:DisposeEntity()
	self.ai:OnHide()
end

function m:OnAddListener()
	EventDispatcher.AddEventListener(EventID.APNpcTalkEvent, self.DelegateNpcTalk)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowSpineSuccessDelegate)
end

function m:OnRemoveListener()
	EventDispatcher.RemoveEventListener(EventID.APNpcTalkEvent, self.DelegateNpcTalk)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowSpineSuccessDelegate)
end

function m:OnShowSpineSuccess(sender, args)
	if self.entityId ~= args.Entity.Id then
		return
	end

	local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

	animation.state:SetAnimation(0, "idle", true)

	if self.walkArea then
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
		renderers[i].sortingLayerID = LuaCodeInterface.SortingLayerNameToID("Default")

		if self.buildAreaData then
			renderers[i].sortingOrder = 2 + self.buildAreaData.pos
		else
			renderers[i].sortingOrder = 3
		end
	end

	self:RefreshBubble()
end

function m:RefreshBubble()
	if self.bubbleTimer then
		self.bubbleTimer:Stop()
	end

	if self.cfgParkRoleData and #self.cfgParkRoleData.BubbleDisplay > 0 then
		local cd = self.cfgParkRoleData.BubbleDisplay[1]
		local tim = self.cfgParkRoleData.BubbleDisplay[2]

		self.bubbleTimer = Timer.New(function()
			self:RefreshBubble()
			self:ShowBubble(tim)
		end, cd)

		self.bubbleTimer:Start()
	end
end

function m:ShowBubble(time)
	if self.showBubbleTime then
		self.showBubbleTime:Stop()
	end

	local index = math.random(1, self.Emo.transform.childCount)

	for i = 0, self.Emo.transform.childCount - 1 do
		local show = i + 1 == index

		self.Emo.transform:GetChild(i).gameObject:SetActive(show)
	end

	self.showBubbleTime = Timer.New(function()
		for i = 0, self.Emo.transform.childCount - 1 do
			self.Emo.transform:GetChild(i).gameObject:SetActive(false)
		end
	end, time)

	self.showBubbleTime:Start()
end

function m:OnRefreshNpcAiMove(roCid, isMove)
	if self.cfgParkRoleData.Id == roCid and self.ai and self.walkArea then
		if isMove then
			self.ai:StartWalk()
			self.ai:StartAITimer()
		else
			self.ai:StopWalk()
			self.ai:StopAITimer()
		end
	end
end

function m:OnNpcTalk(rodCid)
	if self.cfgParkRoleData.Id == rodCid then
		local index = math.random(1, #self.cfgParkRoleData.ChatGroup)

		self:Talk(self.cfgParkRoleData.ChatGroup[index])
	end
end

function m:Talk(chatWordCid)
	if self.timer then
		self.timer:Stop()
	end

	self.timer = Timer.New(function()
		self.ChatTip:SetActive(false)
	end, 3)

	self.timer:Start()

	local cfgData = CfgAmusementParkChatWordTable[chatWordCid]
	local str = string.gsub(cfgData.ChatWord, "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName)

	UGUIUtil.SetText(self.TextChat, str)
	self.ChatTip:SetActive(true)
end

function m:ShowSpine()
	self:DisposeEntity()

	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.entityId, self.cfgParkRoleData.PlayerSpine, 0, self.goSpineRoot.transform, Vector3.zero, nil, false)
end

function m:DisposeEntity()
	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end
end

function m:SetActive(vs)
	if not vs then
		self:OnHide()
	end

	self.isWorking = vs

	self.View:SetActive(vs)
end

function m:OnDestroyStaticNPC()
	self:OnRemoveListener()

	if self.bubbleTimer then
		self.bubbleTimer:Stop()
	end

	self.bubbleTimer = nil

	if self.showBubbleTime then
		self.showBubbleTime:Stop()
	end

	self.showBubbleTime = nil

	if self.timer then
		self.timer:Stop()
	end

	self.cfgParkRoleData = nil
	self.timer = nil
	self.isWorking = false

	self:OnHide()
	self.ai:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:OnDestroy()
	self:OnRemoveListener()

	if self.bubbleTimer then
		self.bubbleTimer:Stop()
	end

	self.bubbleTimer = nil

	if self.showBubbleTime then
		self.showBubbleTime:Stop()
	end

	self.showBubbleTime = nil

	if self.timer then
		self.timer:Stop()
	end

	self.cfgParkRoleData = nil
	self.timer = nil
	self.isWorking = false

	self:OnHide()
	self.ai:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
