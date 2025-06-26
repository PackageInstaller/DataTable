-- chunkname: @IQIGame\\Scene\\RestaurantOperation\\RestaurantOperationNPC.lua

local RestaurantOperationNPC = {
	isWorking = false,
	entityId = 0
}
local RestaurantOperationNPCAI = require("IQIGame.Scene.RestaurantOperation.RestaurantOperationNPCAI")

function RestaurantOperationNPC.New(view)
	local obj = Clone(RestaurantOperationNPC)

	obj:Init(view)

	return obj
end

function RestaurantOperationNPC:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ai = RestaurantOperationNPCAI.New(self.View)

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

function RestaurantOperationNPC:Refresh(data, position, walkArea, parent)
	self.roPlayerData = data

	self.View.transform:SetParent(parent, false)

	self.View.transform.localPosition = position
	self.walkArea = walkArea

	UGUIUtil.SetText(self.TextName, self.roPlayerData:GetCfgData().Name)

	if self.roPlayerData.posInfo and self.roPlayerData.posInfo.postType > 0 then
		UGUIUtil.SetText(self.TextType1, CfgRestaurantOperationPostControlTable[self.roPlayerData.posInfo.postType].PostName)
		self.Type1:SetActive(true)
	else
		self.Type1:SetActive(false)
	end

	self:SetActive(true)
	self:ShowSpine()
end

function RestaurantOperationNPC:OnUpdate()
	self.ai:OnUpdate()
end

function RestaurantOperationNPC:OnHide()
	self:DisposeEntity()
	self.ai:OnHide()
end

function RestaurantOperationNPC:OnAddListener()
	EventDispatcher.AddEventListener(EventID.RORefreshNpcAiMoveEvent, self.DelegateRefreshNpcAiMove)
	EventDispatcher.AddEventListener(EventID.RONpcTalkEvent, self.DelegateNpcTalk)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowSpineSuccessDelegate)
end

function RestaurantOperationNPC:OnRemoveListener()
	EventDispatcher.RemoveEventListener(EventID.RORefreshNpcAiMoveEvent, self.DelegateRefreshNpcAiMove)
	EventDispatcher.RemoveEventListener(EventID.RONpcTalkEvent, self.DelegateNpcTalk)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowSpineSuccessDelegate)
end

function RestaurantOperationNPC:OnShowSpineSuccess(sender, args)
	if self.entityId ~= args.Entity.Id then
		return
	end

	local animationName = "idle"

	if self.roPlayerData:GetAreaType() == RestaurantOperationConstant.WalkAreaType.Restaurant_Dining_Table then
		animationName = "sit"
	elseif self.roPlayerData:IsWorker() then
		local cfgData = self.roPlayerData:GetCfgPostControlData()
		local index = math.random(1, #cfgData.RetroactiveBehavior)

		animationName = cfgData.RetroactiveBehavior[index]
	end

	local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

	animation.state:SetAnimation(0, animationName, true)

	if self.walkArea and self.walkArea:IsMoveArea() then
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

	self:RefreshBubble()
end

function RestaurantOperationNPC:RefreshBubble()
	if self.bubbleTimer then
		self.bubbleTimer:Stop()
	end

	if self.roPlayerData then
		local cfgData = self.roPlayerData:GetCfgData()

		if #cfgData.BubbleDisplay > 0 then
			local cd = cfgData.BubbleDisplay[1]
			local tim = cfgData.BubbleDisplay[2]

			self.bubbleTimer = Timer.New(function()
				self:RefreshBubble()
				self:ShowBubble(tim)
			end, cd)

			self.bubbleTimer:Start()
		end
	end
end

function RestaurantOperationNPC:ShowBubble(time)
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

function RestaurantOperationNPC:OnRefreshNpcAiMove(roCid, isMove)
	if self.roPlayerData.cid == roCid and self.ai and self.walkArea and self.walkArea:IsMoveArea() then
		if isMove then
			self.ai:StartWalk()
			self.ai:StartAITimer()
		else
			self.ai:StopWalk()
			self.ai:StopAITimer()
		end
	end
end

function RestaurantOperationNPC:OnNpcTalk(rodCid)
	if self.roPlayerData.cid == rodCid then
		local cfgROPlayerData = CfgRestaurantOperationPlayerTable[rodCid]
		local index = math.random(1, #cfgROPlayerData.ChatGroup)

		self:Talk(cfgROPlayerData.ChatGroup[index])
	end
end

function RestaurantOperationNPC:Talk(chatWordCid)
	if self.timer then
		self.timer:Stop()
	end

	self.timer = Timer.New(function()
		self.ChatTip:SetActive(false)
	end, 3)

	self.timer:Start()

	local cfgData = CfgRestaurantOperationChatWordTable[chatWordCid]
	local str = string.gsub(cfgData.ChatWord, "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName)

	UGUIUtil.SetText(self.TextChat, str)
	self.ChatTip:SetActive(true)
end

function RestaurantOperationNPC:ShowSpine()
	self:DisposeEntity()

	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.entityId, self.roPlayerData:GetCfgData().PlayerSpine, 0, self.goSpineRoot.transform, Vector3.zero)
end

function RestaurantOperationNPC:DisposeEntity()
	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end
end

function RestaurantOperationNPC:SetActive(vs)
	if not vs then
		self:OnHide()
	end

	self.isWorking = vs

	self.View:SetActive(vs)
end

function RestaurantOperationNPC:OnDestroy()
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

	self.roPlayerData = nil
	self.timer = nil
	self.isWorking = false

	self:OnHide()
	self.ai:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
	self.ai = nil
end

return RestaurantOperationNPC
