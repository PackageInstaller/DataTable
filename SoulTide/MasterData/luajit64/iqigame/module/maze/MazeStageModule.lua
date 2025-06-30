-- chunkname: @IQIGame\\Module\\Maze\\MazeStageModule.lua

local m = {
	STATE_RESET = "Reset",
	STATE_HIDE = "Hide",
	LoadedEntityNum = 0,
	ChangeAnimationTime = 0,
	IsPlayingShowState = false,
	STATE_SHOW = "Show",
	IsShow = false,
	DialogIndex = 0,
	AnimationCid = 0,
	StagePool = {},
	EntityIdList = {},
	RendererOriginalSortingData = {}
}

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateOnShowElementEntityFailure(sender, args)
		self:OnShowElementEntityFailure(sender, args)
	end

	function self.DelegateOnShowBubble(sender, args)
		self:OnShowBubble(sender, args)
	end

	function self.DelegateOnHideBubble(sender, args)
		self:OnHideBubble(sender, args)
	end

	function self.DelegateOnNextDialog(sender, args)
		self:OnNextDialog(sender, args)
	end

	function self.DelegateOnDialogComplete()
		self:OnDialogComplete()
	end

	self.StageRoot = UnityEngine.GameObject.Find("Main Camera/MazeStage/Root")
	self.StageRoot.transform.localPosition = Vector3(10000, 0, 0)

	self:AddListeners()
end

function m:AddListeners()
	GameEntry.LuaEvent:Subscribe(MazeStageShowBubbleEventArgs.EventId, self.DelegateOnShowBubble)
	GameEntry.LuaEvent:Subscribe(MazeStageHideBubbleEventArgs.EventId, self.DelegateOnHideBubble)
	GameEntry.LuaEvent:Subscribe(MazeStageNextDialogEventArgs.EventId, self.DelegateOnNextDialog)
	EventDispatcher.AddEventListener(EventID.MazeStageDialogComplete, self.DelegateOnDialogComplete)
end

function m:RemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(MazeStageShowBubbleEventArgs.EventId, self.DelegateOnShowBubble)
	GameEntry.LuaEvent:Unsubscribe(MazeStageHideBubbleEventArgs.EventId, self.DelegateOnHideBubble)
	GameEntry.LuaEvent:Unsubscribe(MazeStageNextDialogEventArgs.EventId, self.DelegateOnNextDialog)
	EventDispatcher.RemoveEventListener(EventID.MazeStageDialogComplete, self.DelegateOnDialogComplete)
end

function m:ShowStage(cid)
	local cfgMazeStageData = CfgMazeStageTable[cid]

	if self.CurrentCfgMazeStageData ~= nil then
		self:HideStage()
	end

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeStage, true)
	MazeModule.CommandSwitch(false)
	MazeModule.CloseMazeManualUI()

	self.CurrentCfgMazeStageData = cfgMazeStageData
	self.DialogIndex = 0
	self.AnimationCid = 0

	local stagePrefabPath = self:GetPrefabPath(self.CurrentCfgMazeStageData)
	local stageObj = self.StagePool[stagePrefabPath]

	if stageObj == nil then
		AssetUtil.LoadAsset(self, stagePrefabPath, self.OnLoadPrefabSuccess, nil)
	else
		self:OnLoadStage(stageObj)
	end

	if not UIModule.HasUI(Constant.UIControllerName.MazeStageAssistantUI) and not UIModule.IsLoadingUI(Constant.UIControllerName.MazeStageAssistantUI) then
		UIModule.Open(Constant.UIControllerName.MazeStageAssistantUI, Constant.UILayer.DefaultUI)
	end
end

function m:GetPrefabPath(cfgMazeStageData)
	if cfgMazeStageData.Prefab ~= "" then
		return UIGlobalApi.GetPrefabRoot("/ART_Prefabs/Scene/Stage" .. cfgMazeStageData.Prefab)
	end

	local cfgMazeLevelResData = CfgMazeLevelResTable[MazeDataModule.MazeLevelResID]

	if cfgMazeLevelResData.StagePrefab ~= "" then
		return UIGlobalApi.GetPrefabRoot("/ART_Prefabs/Scene/Stage" .. cfgMazeLevelResData.StagePrefab)
	end

	logError("没有找到任何地台预设。MazeLevelResId: " .. MazeDataModule.MazeLevelResID .. ", MazeStageId: " .. cfgMazeStageData.Id)
end

function m:ChangeAnimation(animationCid)
	if self.CurrentStageObj == nil then
		logError("改变地台动画出错，地台已经隐藏")

		return
	end

	MazeModule.CommandSwitch(false)

	self.DialogIndex = 0
	self.AnimationCid = animationCid
	self.IsPlayingShowState = false

	local cfgMazeStageAnimationData = CfgMazeStageAnimationTable[animationCid]
	local animator = self.CurrentStageObj:GetComponent(typeof(UnityEngine.Animator))

	animator:SetTrigger(cfgMazeStageAnimationData.AnimationName)

	self.ChangeAnimationTime = UnityEngine.Time.realtimeSinceStartup
end

function m:OnLoadPrefabSuccess(assetName, asset, duration, userData)
	local stageObj = UnityEngine.Object.Instantiate(asset)

	self.StagePool[assetName] = stageObj

	self:OnLoadStage(stageObj, userData)
end

function m:OnLoadStage(stageObj)
	if self.CurrentCfgMazeStageData == nil then
		return
	end

	self.CurrentStageObj = stageObj
	self.CurrentStageObjAnimator = self.CurrentStageObj:GetComponent(typeof(UnityEngine.Animator))

	self.CurrentStageObj.transform:SetParent(self.StageRoot.transform, false)
	self.CurrentStageObj:SetActive(true)

	self.CurrentStageObjAnimator.runtimeAnimatorController = nil
	self.LoadedEntityNum = 0

	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)

	local dollDataList = MazeDataModule.GetActiveDollDataList()
	local dollParentTrans = {}

	for i = 1, 5 do
		local trans = self.CurrentStageObj.transform:Find("Element/Soul/Root/Point" .. i)

		if trans ~= nil then
			dollParentTrans[i] = trans:Find("SpineRootSoul")

			if dollParentTrans[i] == nil then
				logError("迷宫地台[" .. self.CurrentStageObj.name .. "]上找不到人偶挂点Element/Soul/Root/Point" .. i .. "/SpineRootSoul(注意区分大小写和空格)")
			end

			local shadowTrans = trans:Find("Shadow")

			if shadowTrans ~= nil then
				shadowTrans.gameObject:SetActive(i <= #dollDataList)
			end
		else
			logError("迷宫地台找不到人偶挂点Element/Soul/Root/Point" .. i .. "(注意区分大小写和空格)")
		end
	end

	for i = 1, #dollDataList do
		local trans = dollParentTrans[i]
		local dollPOD = dollDataList[i]
		local cfgDressData = CfgDressTable[dollPOD.dress3DCid]
		local cfgSoulResData = CfgSoulResTable[cfgDressData.SoulResID]
		local entityId = GameEntry.Entity:GenerateEntityID()

		table.insert(self.EntityIdList, entityId)

		local timer = FrameTimer.New(function()
			GameEntry.Entity:ShowElement(entityId, cfgSoulResData.EntityId, 0, trans, Vector3.zero, nil, false)
		end, 1)

		timer:Start()
	end

	local elementRootTrans = self.CurrentStageObj.transform:Find("Element/Element/Root")

	if elementRootTrans ~= nil then
		local activeNpcIndexes = {}

		for i = 1, #self.CurrentCfgMazeStageData.NpcEntity do
			local npcEntityCid = self.CurrentCfgMazeStageData.NpcEntity[i]

			if npcEntityCid ~= 0 then
				activeNpcIndexes[i] = i

				local trans = elementRootTrans:Find("Point" .. i)

				if trans ~= nil then
					local npcParentTrans = trans:Find("SpineRootElement")

					if npcParentTrans == nil then
						npcParentTrans = trans:Find("SpineRootSoul")
					end

					if npcParentTrans == nil then
						logError("迷宫地台[" .. self.CurrentStageObj.name .. "]上找不到Npc挂点Element/Element/Root/Point" .. i .. "/SpineRootElement(或SpineRootSoul)(注意区分大小写和空格)")
					end

					local entityId = GameEntry.Entity:GenerateEntityID()

					table.insert(self.EntityIdList, entityId)

					local timer = FrameTimer.New(function()
						GameEntry.Entity:ShowElement(entityId, self.CurrentCfgMazeStageData.NpcEntity[i], 0, npcParentTrans, Vector3.zero, nil, false)
					end, 1)

					timer:Start()
				else
					logError("迷宫地台[" .. self.CurrentStageObj.name .. "]上找不到Npc挂点Element/Element/Root/Point" .. i .. "(注意区分大小写和空格)")
				end
			end
		end

		for i = 0, elementRootTrans.childCount - 1 do
			local childTrans = elementRootTrans:GetChild(i)
			local shadowTrans = childTrans:Find("Shadow")

			if shadowTrans ~= nil then
				local startIndex, endIndex = string.find(childTrans.name, "Point")

				if startIndex == 1 then
					local pointIndex = tonumber(string.sub(childTrans.name, endIndex + 1))

					if pointIndex ~= nil then
						shadowTrans.gameObject:SetActive(activeNpcIndexes[pointIndex] ~= nil)
					end
				end
			end
		end
	end
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
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)

	local renderers = self.CurrentStageObj:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	for i = 0, renderers.Length - 1 do
		local renderer = renderers[i]

		self.RendererOriginalSortingData[renderer:GetInstanceID()] = {
			layer = renderer.sortingLayerID,
			order = renderer.sortingOrder
		}
		renderer.sortingLayerID = LuaCodeInterface.SortingLayerNameToID("Top")
		renderer.sortingOrder = 0
	end

	AssetUtil.LoadAsset(self, UIGlobalApi.GetAnimationPath("/Stage/Controller" .. self.CurrentCfgMazeStageData.AnimatorController), self.OnLoadControllerSuccess)
end

function m:OnLoadControllerSuccess(assetName, asset, duration, userData)
	local animator = self.CurrentStageObj:GetComponent(typeof(UnityEngine.Animator))

	animator.runtimeAnimatorController = asset
	self.CheckStateName = m.STATE_SHOW
	self.IsPlayingShowState = true

	self:RecoverSpeed()

	self.IsShow = true

	EventDispatcher.Dispatch(EventID.MazeStagePlay, true)

	self.StageRoot.transform.localPosition = Vector3.zero
end

function m:Update(realElapseSeconds)
	if self.CurrentStageObj == nil then
		return
	end

	if self.CheckStateName ~= nil or self.AnimationCid ~= 0 then
		if self.CheckStateName == m.STATE_SHOW then
			if self.CurrentStageObjAnimator:GetStateNormalizedTime(m.STATE_SHOW) > 1 then
				self.CheckStateName = nil

				MazeModule.CommandSwitch(true)
			end
		elseif self.CheckStateName == m.STATE_HIDE and self.CurrentStageObjAnimator:GetStateNormalizedTime(m.STATE_RESET) > 1 then
			self.CheckStateName = nil

			self:HideStage()
		end

		if self.AnimationCid ~= 0 then
			local cfgMazeStageAnimationData = CfgMazeStageAnimationTable[self.AnimationCid]

			if self.CurrentStageObjAnimator:GetStateNormalizedTime(cfgMazeStageAnimationData.AnimationName) > 1 and UnityEngine.Time.realtimeSinceStartup - self.ChangeAnimationTime > 0.5 then
				self.AnimationCid = 0

				MazeModule.CommandSwitch(true)
			end
		end
	end
end

function m:StartHideStage()
	if self.CurrentStageObj == nil then
		logError("隐藏地台出错，地台已经隐藏")

		return
	end

	self.CheckStateName = m.STATE_HIDE
	self.IsPlayingShowState = false

	local animator = self.CurrentStageObj:GetComponent(typeof(UnityEngine.Animator))

	animator:SetTrigger(m.STATE_HIDE)
	UIModule.Close(Constant.UIControllerName.MazeStageAssistantUI)
end

function m:HideStage(isShutdown)
	self.CurrentCfgMazeStageData = nil

	if self.CurrentStageObj == nil then
		logError("内部隐藏地台出错，self.CurrentStageObj == nil")

		return
	end

	if isShutdown then
		local animator = self.CurrentStageObj:GetComponent(typeof(UnityEngine.Animator))

		animator.speed = 0
	end

	local renderers = self.CurrentStageObj:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

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

		if isShutdown then
			local entity = GameEntry.Entity:GetEntity(entityId)

			if entity ~= nil then
				entity.gameObject.transform.localScale = Vector3.one
				entity.gameObject.transform.localPosition = Vector3.one

				local spineRenderers = entity:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

				for j = 0, spineRenderers.Length - 1 do
					local renderer = spineRenderers[j]

					if renderer.sharedMaterial ~= nil and renderer.sharedMaterial:HasProperty("_Color") then
						local materialPropertyBlock = renderer:GetPropertyBlock()

						materialPropertyBlock:SetColor("_Color", Color.white)
						renderer:SetPropertyBlock()
					else
						logError("Spine [" .. entity.gameObject.name .. "] 的节点 [" .. renderer.name .. "] SharedMaterial为空或其SharedMaterial的Shader里没有_Color属性。")
					end
				end
			end
		end

		GameEntry.Entity:HideEntity(entityId)
	end

	self.EntityIdList = {}
	self.LoadedEntityNum = 0

	self.CurrentStageObj:SetActive(false)

	self.CurrentStageObj = nil
	self.CurrentStageObjAnimator = nil
	self.StageRoot.transform.localPosition = Vector3(10000, 0, 0)
	self.IsShow = false

	EventDispatcher.Dispatch(EventID.MazeStagePlay, false)
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MazeStage, false)

	if not isShutdown then
		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_CLOSE_MAZE_STAGE)
		MazeModule.ResumeCommandCountdown()
	end
end

function m:OnShowBubble(sender, args)
	local pointNames = {}

	for i = 0, args.PointNames.Length - 1 do
		table.insert(pointNames, args.PointNames[i])
	end

	EventDispatcher.Dispatch(EventID.MazeStageShowBubble, args.Type, args.BubbleId, pointNames)
end

function m:OnHideBubble(sender, args)
	EventDispatcher.Dispatch(EventID.MazeStageHideBubble, args.Type, args.BubbleId, args.PointName)
end

function m:OnNextDialog(sender, args)
	local animator = self.CurrentStageObj:GetComponent(typeof(UnityEngine.Animator))

	animator.speed = 0
	self.DialogIndex = self.DialogIndex + 1

	EventDispatcher.Dispatch(EventID.MazeStageNextDialog)
end

function m:OnDialogComplete()
	self:RecoverSpeed()
end

function m:RecoverSpeed()
	if self.CurrentStageObj ~= nil then
		local animator = self.CurrentStageObj:GetComponent(typeof(UnityEngine.Animator))
		local speed = PlayerModule.GetMazeStageSpeed()

		animator.speed = speed
	end
end

function m:SetSpeed(speed)
	if self.CurrentStageObj ~= nil then
		local animator = self.CurrentStageObj:GetComponent(typeof(UnityEngine.Animator))

		if animator.speed ~= 0 then
			animator.speed = speed
		end
	end

	EventDispatcher.Dispatch(EventID.MazeStageChangeSpeed)
end

function m:Dispose()
	self:RemoveListeners()

	if self.CurrentCfgMazeStageData ~= nil then
		self:HideStage()
	end

	for path, stageObj in pairs(self.StagePool) do
		UnityEngine.Object.Destroy(stageObj)
	end

	self.StagePool = nil
	self.StageRoot = nil
	self.CurrentStageObj = nil
	self.CurrentStageObjAnimator = nil

	AssetUtil.UnloadAsset(self)
end

return m
