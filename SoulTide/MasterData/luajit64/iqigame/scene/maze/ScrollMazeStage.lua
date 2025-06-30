-- chunkname: @IQIGame\\Scene\\Maze\\ScrollMazeStage.lua

local m = {
	VirtualDistance = 0,
	CurrentAnimationPhase = 0,
	QuickFightStarted = false,
	IsStartEvent = false,
	NpcMoveSpeed = 0.1,
	LoadedEntityNum = 0,
	EntityIdList = {},
	RendererOriginalSortingData = {}
}

function m.New(mainCamera)
	local obj = Clone(m)

	obj:Init(mainCamera)

	return obj
end

function m:Init(mainCamera)
	self.MainCamera = mainCamera

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateOnShowElementEntityFailure(sender, args)
		self:OnShowElementEntityFailure(sender, args)
	end

	function self.DelegateOnUpdateElement(elementPOD, oldNodeId)
		self:OnUpdateElement(elementPOD, oldNodeId)
	end

	function self.DelegateOnHeroCorrectPosition()
		self:OnHeroCorrectPosition()
	end

	function self.DelegateOnEndDialog(mazeSelectionCid)
		self:OnEndDialog(mazeSelectionCid)
	end

	self.Root = UnityEngine.GameObject.Find("Main Camera/ScrollStage/Root")

	self:AddListeners()
end

function m:AddListeners()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
	EventDispatcher.AddEventListener(EventID.MazeUpdateElement, self.DelegateOnUpdateElement)
	EventDispatcher.AddEventListener(EventID.MazeHeroCorrectPosition, self.DelegateOnHeroCorrectPosition)
	EventDispatcher.AddEventListener(EventID.MazeScrollEndDialog, self.DelegateOnEndDialog)
end

function m:RemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateElement, self.DelegateOnUpdateElement)
	EventDispatcher.RemoveEventListener(EventID.MazeHeroCorrectPosition, self.DelegateOnHeroCorrectPosition)
	EventDispatcher.RemoveEventListener(EventID.MazeScrollEndDialog, self.DelegateOnEndDialog)
end

function m:Refresh(stageObj, onComplete)
	self:Clear()
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.ScrollMaze, true)

	self.OnRefreshComplete = onComplete

	stageObj.transform:SetParent(self.Root.transform, false)

	self.TwoDimensionSeriesComponents = stageObj:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.TwoDimensionSeriesComponent))
	self.Animator = stageObj:GetComponentInChildren(typeof(UnityEngine.Animator))
	self.SealProgressCom = stageObj:GetComponentInChildren(typeof(IQIGame.Onigao.Game.AnimationImageFillHelper))

	if self.SealProgressCom ~= nil then
		self.SealProgressCom.min = 0
	end

	local dollDataList = MazeDataModule.GetActiveDollDataList()

	for i = 1, 5 do
		local dollPOD = dollDataList[i]
		local soulPointTrans = self.Animator.transform:Find("Element/Soul/Root/Point" .. i)
		local dollPointTrans = soulPointTrans:Find("SpineRootSoul")
		local shadowTrans = soulPointTrans:Find("Shadow")

		if shadowTrans ~= nil then
			shadowTrans.gameObject:SetActive(dollPOD ~= nil)
		end

		if dollPOD ~= nil then
			local cfgDressData = CfgDressTable[dollPOD.dress3DCid]
			local cfgSoulResData = CfgSoulResTable[cfgDressData.SoulResID]
			local entityId = GameEntry.Entity:GenerateEntityID()

			table.insert(self.EntityIdList, entityId)
			GameEntry.Entity:ShowElement(entityId, cfgSoulResData.EntityId, 0, dollPointTrans, Vector3.zero, nil, false)
		end
	end

	self.NpcNodeTransform = self.Animator.transform:Find("Element/Element/Root/Point1/SpineRootElementHp")
end

function m:OnShowElementEntitySuccess(sender, args)
	if table.indexOf(self.EntityIdList, args.Entity.Id) ~= -1 then
		local skeletonAnimation = args.Entity:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation), true)

		if skeletonAnimation ~= nil then
			skeletonAnimation.transform.localRotation = Quaternion.identity
		end

		self.LoadedEntityNum = self.LoadedEntityNum + 1

		if self.LoadedEntityNum == #self.EntityIdList then
			self:LoadEntityComplete()
		end
	end
end

function m:OnShowElementEntityFailure(sender, args)
	if table.indexOf(self.EntityIdList, args.EntityId) ~= -1 then
		self.LoadedEntityNum = self.LoadedEntityNum + 1

		if self.LoadedEntityNum == #self.EntityIdList then
			self:LoadEntityComplete()
		end
	end
end

function m:LoadEntityComplete()
	local renderers = self.Root:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	for i = 0, renderers.Length - 1 do
		local renderer = renderers[i]

		self.RendererOriginalSortingData[renderer:GetInstanceID()] = {
			layer = renderer.sortingLayerID,
			order = renderer.sortingOrder
		}
		renderer.sortingLayerID = LuaCodeInterface.SortingLayerNameToID("Top")
		renderer.sortingOrder = 0
	end

	if self.OnRefreshComplete ~= nil then
		self.OnRefreshComplete()

		self.OnRefreshComplete = nil
	end
end

function m:Clear()
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.ScrollMaze, false)

	if self.Animator ~= nil then
		self.Animator.speed = 0
	end

	local renderers = self.Root:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	for i = 0, renderers.Length - 1 do
		local renderer = renderers[i]
		local sortingData = self.RendererOriginalSortingData[renderer:GetInstanceID()]

		if sortingData ~= nil then
			renderer.sortingLayerID = sortingData.layer
			renderer.sortingOrder = sortingData.order
		end
	end

	self.RendererOriginalSortingData = {}

	for i = 1, #self.EntityIdList do
		local entityId = self.EntityIdList[i]
		local entity = GameEntry.Entity:GetEntity(entityId)

		if entity ~= nil then
			entity.gameObject.transform.localScale = Vector3.one
			entity.gameObject.transform.localPosition = Vector3.one

			local meshRenderers = entity:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

			for j = 0, meshRenderers.Length - 1 do
				local meshRenderer = meshRenderers[j]

				if meshRenderer.sharedMaterial ~= nil and meshRenderer.sharedMaterial:HasProperty("_Color") then
					local materialPropertyBlock = meshRenderer:GetPropertyBlock()

					materialPropertyBlock:SetColor("_Color", Color.white)
					meshRenderer:SetPropertyBlock()
				else
					logError("Spine [" .. entity.gameObject.name .. "] 的节点 [" .. meshRenderer.name .. "] SharedMaterial为空或其SharedMaterial的Shader里没有_Color属性。")
				end
			end
		end

		GameEntry.Entity:HideEntity(entityId)
	end

	self.EntityIdList = {}
	self.LatestElementId = nil

	while self.Root.transform.childCount > 0 do
		local childTrans = self.Root.transform:GetChild(0)

		childTrans.parent = nil

		UnityEngine.Object.Destroy(childTrans.gameObject)
	end

	self.TwoDimensionSeriesComponents = nil
	self.Animator = nil
	self.SealProgressCom = nil
	self.LoadedEntityNum = 0
	self.NpcNodeTransform = nil
	self.CfgMazeSelectionData = nil
	self.VirtualDistance = 0
	self.IsStartEvent = false
end

function m:PlayBorn()
	self:Trigger(Constant.ScrollMazeAnim.AnimName_Born, Constant.ScrollMazeAnim.Phase_Default)
end

function m:PlayStart(isNotRestore)
	local duration

	duration = isNotRestore and 2 or 0

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, function()
		self:Trigger(Constant.ScrollMazeAnim.AnimName_Start, Constant.ScrollMazeAnim.Phase_Default)
	end, duration)

	timer:Start()
end

function m:Trigger(triggerName, phase)
	self.CurrentAnimationName = triggerName
	self.CurrentAnimationPhase = phase

	self.Animator:SetTrigger(triggerName)
end

function m:Update()
	if self.CurrentAnimationName == Constant.ScrollMazeAnim.AnimName_Start then
		if self.Animator:GetStateNormalizedTime(Constant.ScrollMazeAnim.AnimName_Start) > 1 then
			EventDispatcher.Dispatch(EventID.MazeScrollReady)

			self.CurrentAnimationName = nil
		end
	elseif self.CurrentAnimationName == Constant.ScrollMazeAnim.AnimName_Quick_Fight then
		if self.Animator:GetStateNormalizedTime(Constant.ScrollMazeAnim.AnimName_Quick_Fight) > 1 then
			if self.OnPlayQuickFightComplete ~= nil then
				self.OnPlayQuickFightComplete()

				self.OnPlayQuickFightComplete = nil
			end

			self.CurrentAnimationName = nil
		end
	elseif self.CurrentAnimationName == Constant.ScrollMazeAnim.AnimName_Run then
		local position = self.NpcNodeTransform.localPosition

		position.x = position.x + self.NpcMoveSpeed * UnityEngine.Time.deltaTime
		self.NpcNodeTransform.localPosition = position
		self.VirtualDistance = self.VirtualDistance + self.NpcMoveSpeed * UnityEngine.Time.deltaTime * -1

		for i = 0, self.TwoDimensionSeriesComponents.Length - 1 do
			local tdsComponent = self.TwoDimensionSeriesComponents[i]

			tdsComponent.value = self.VirtualDistance
		end

		if self.NpcNodeTransform.localPosition.x <= self.CfgMazeSelectionData.EntityOffset then
			local triggerName = self.CfgMazeSelectionData.TriggerAnimation

			if triggerName == "" then
				triggerName = Constant.ScrollMazeAnim.AnimName_TempStart
			end

			self:Trigger(triggerName, Constant.ScrollMazeAnim.Phase_CustomStart)
		end
	end

	if self.CurrentAnimationName ~= nil and self.CfgMazeSelectionData ~= nil then
		local startTriggerName = self.CfgMazeSelectionData.TriggerAnimation

		if startTriggerName == "" then
			startTriggerName = Constant.ScrollMazeAnim.AnimName_TempStart
		end

		local endTriggerName

		if self.QuickFightStarted then
			endTriggerName = Constant.ScrollMazeAnim.AnimName_QuickFightDelete
		else
			endTriggerName = self.CfgMazeSelectionData.DeleteAnimation

			if endTriggerName == "" then
				endTriggerName = Constant.ScrollMazeAnim.AnimName_TempEnd
			end
		end

		if self.CurrentAnimationPhase == Constant.ScrollMazeAnim.Phase_CustomStart and self.CurrentAnimationName == startTriggerName then
			if self.Animator:GetStateNormalizedTime(self.CurrentAnimationName) > 1 then
				self.CurrentAnimationName = nil

				if #self.CfgMazeSelectionData.ScrollDialog == 0 then
					self:EndSelect()
				else
					EventDispatcher.Dispatch(EventID.MazeScrollStartDialog, self.CfgMazeSelectionData.Id, self.CfgMazeSelectionData.ScrollDialog)
				end
			end
		elseif self.CurrentAnimationPhase == Constant.ScrollMazeAnim.Phase_CustomEnd and self.CurrentAnimationName == endTriggerName and self.Animator:GetStateNormalizedTime(self.CurrentAnimationName) > 1 then
			self.CurrentAnimationName = nil
			self.IsStartEvent = false
			self.QuickFightStarted = false

			self:ClearElementEntity()
			EventDispatcher.Dispatch(EventID.MazeScrollReady)
		end
	end
end

function m:StartEvent(cfgMazeSelectionData)
	self.IsStartEvent = true

	self:ClearElementEntity()

	self.CfgMazeSelectionData = cfgMazeSelectionData

	local position = self.NpcNodeTransform.position
	local bottomLeftPoint = self.MainCamera:ViewportToWorldPoint(Vector2(1, 0))

	position.x = bottomLeftPoint.x + 5
	self.NpcNodeTransform.position = position

	local entityId = GameEntry.Entity:GenerateEntityID()

	self.LatestElementId = entityId

	table.insert(self.EntityIdList, entityId)
	GameEntry.Entity:ShowElement(entityId, cfgMazeSelectionData.Entity, 0, self.NpcNodeTransform, Vector3.zero, nil, false)
	self:Trigger(Constant.ScrollMazeAnim.AnimName_Run, Constant.ScrollMazeAnim.Phase_Default)

	self.NpcMoveSpeed = self.NpcNodeTransform.localPosition.x / MazeSceneApi:GetString("ScrollMazeDuration") * -1

	if self.SealProgressCom ~= nil then
		self.SealProgressCom.max = 1
	end
end

function m:ClearElementEntity()
	if self.LatestElementId == nil then
		return
	end

	GameEntry.Entity:HideEntity(self.LatestElementId)

	local index = table.indexOf(self.EntityIdList, self.LatestElementId)

	if index ~= -1 then
		table.remove(self.EntityIdList, index)
	else
		logError("移除实体失败，不在队列中")
	end

	self.LoadedEntityNum = self.LoadedEntityNum - 1
	self.LatestElementId = nil
end

function m:OnUpdateElement(elementPOD, oldNodeId)
	if elementPOD.IsRemoved and self.IsStartEvent then
		local triggerName

		if self.QuickFightStarted then
			triggerName = Constant.ScrollMazeAnim.AnimName_QuickFightDelete
		else
			triggerName = self.CfgMazeSelectionData.DeleteAnimation

			if triggerName == "" then
				triggerName = Constant.ScrollMazeAnim.AnimName_TempEnd
			end
		end

		self:Trigger(triggerName, Constant.ScrollMazeAnim.Phase_CustomEnd)
	end
end

function m:OnHeroCorrectPosition()
	self:ClearElementEntity()
end

function m:PlayQuickFight(onPlayQuickFightComplete)
	self.OnPlayQuickFightComplete = onPlayQuickFightComplete
	self.QuickFightStarted = true

	self:Trigger(Constant.ScrollMazeAnim.AnimName_Quick_Fight, Constant.ScrollMazeAnim.Phase_Default)
end

function m:EndSelect()
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_SELECTION_PANEL_END, {
		SelectIndex = 1
	})
end

function m:OnEndDialog(mazeSelectionCid)
	if self.CfgMazeSelectionData.Id == mazeSelectionCid then
		self:EndSelect()
	end
end

function m:Dispose()
	self:RemoveListeners()
	self:Clear()

	self.Root = nil
	self.OnRefreshComplete = nil
	self.MainCamera = nil
end

return m
