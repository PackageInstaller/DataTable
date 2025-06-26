-- chunkname: @IQIGame\\Scene\\Maze\\MazeNode.lua

local m = {
	EntityId = 0,
	NodeEffectDataCid = 0,
	NodeEffectPlayId = 0
}

function m.New(areaNodeData, parentTrans)
	local obj = Clone(m)

	obj:Init(areaNodeData, parentTrans)

	return obj
end

function m:Init(areaNodeData, parentTrans)
	self.NodeData = areaNodeData

	function self.DelegateOnShowNodeEntitySuccess(sender, args)
		self:OnShowNodeEntitySuccess(sender, args)
	end

	function self.DelegateOnShowNodeEntityFailure(sender, args)
		self:OnShowNodeEntityFailure(sender, args)
	end

	function self.DelegateOnNodeUpdate(nodeData, isNewActive)
		self:OnNodeUpdate(nodeData, isNewActive)
	end

	self:AddEventListeners()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	local cfgMazePathNodeData = CfgMazePathNodeTable[areaNodeData.CID]
	local position = Vector3(areaNodeData.x, areaNodeData.y, 0)

	self.IsLoading = true

	GameEntry.Entity:ShowMazeNode(self.EntityId, "Assets/03_Prefabs/ART_Prefabs/Scene" .. cfgMazePathNodeData.Prefab .. ".prefab", 0, parentTrans, position)
end

function m:AddEventListeners()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowNodeEntitySuccess)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowNodeEntityFailure)
	EventDispatcher.AddEventListener(EventID.MazeUpdateNodeData, self.DelegateOnNodeUpdate)
end

function m:RemoveEventListeners()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowNodeEntitySuccess)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowNodeEntityFailure)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateNodeData, self.DelegateOnNodeUpdate)
end

function m:OnShowNodeEntitySuccess(sender, args)
	if args.Entity.Id == self.EntityId then
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowNodeEntitySuccess)
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowNodeEntityFailure)

		self.gameObject = args.Entity.gameObject

		local renderers = self.gameObject.transform:Find("Normal"):GetComponentsInChildren(typeof(UnityEngine.Renderer))

		self.NormalViewRenderers = {}

		for i = 0, renderers.Length - 1 do
			self.NormalViewRenderers[i + 1] = renderers[i]
		end

		renderers = self.gameObject.transform:Find("Complete"):GetComponentsInChildren(typeof(UnityEngine.Renderer))
		self.CompleteViewRenderers = {}

		for i = 0, renderers.Length - 1 do
			self.CompleteViewRenderers[i + 1] = renderers[i]
		end

		local compassNode = self.gameObject.transform:Find("Compass")

		if compassNode ~= nil then
			renderers = compassNode:GetComponentsInChildren(typeof(UnityEngine.Renderer))
			self.CompassViewRenderers = {}

			for i = 0, renderers.Length - 1 do
				self.CompassViewRenderers[i + 1] = renderers[i]
			end
		end

		self:OnShow()

		self.IsLoading = false

		EventDispatcher.Dispatch(EventID.MazeNodeCreate, self.NodeData)
		EventDispatcher.Dispatch(EventID.MazeLoadEntityComplete, self, Constant.Maze.EntityTypeMazeNode)
	end
end

function m:OnShowNodeEntityFailure(sender, args)
	if args.EntityId == self.EntityId then
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowNodeEntitySuccess)
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowNodeEntityFailure)

		self.IsLoading = false

		EventDispatcher.Dispatch(EventID.MazeLoadEntityComplete, self, Constant.Maze.EntityTypeMazeNode)
		logError("MazeNode资源加载失败，资源路径：" .. tostring(args.EntityAssetName))
	end
end

function m:OnShow()
	self:UpdateNode()
end

function m:UpdateAppearanceByCompleteState()
	local isNormalShow = not self.NodeData.IsComplete and self.NodeData.IsActive

	for i = 1, #self.NormalViewRenderers do
		self.NormalViewRenderers[i].enabled = isNormalShow
	end

	for i = 1, #self.CompleteViewRenderers do
		self.CompleteViewRenderers[i].enabled = self.NodeData.IsComplete and self.NodeData.IsActive
	end

	if self.CompassViewRenderers ~= nil then
		for i = 1, #self.CompassViewRenderers do
			self.CompassViewRenderers[i].enabled = isNormalShow and self.NodeData.ExploreWeight > 0 and not self.NodeData.IsPastComplete
		end
	end

	local cfgMazePathNodeData = CfgMazePathNodeTable[self.NodeData.CID]

	EntityShowUtil.SetAlpha(self.gameObject, not self.NodeData.IsComplete and cfgMazePathNodeData.Type == Constant.Maze.NodeTypeSecretPassage and MazeSceneApi:GetString("Type3NodeAlpha") or 1)
end

function m:OnNodeUpdate(nodeData, isNewActive)
	if self.NodeData.NodeId == nodeData.NodeId then
		if isNewActive then
			local cfgMazePathNodeData = CfgMazePathNodeTable[nodeData.CID]

			if cfgMazePathNodeData.ShowType == 0 then
				self.Timer = Timer.New(function()
					self.Timer = nil

					self:PlayShow()
				end, 0.8)

				self.Timer:Start()
			end
		else
			self:UpdateNode()
		end
	end
end

function m:UpdateNode()
	self:SetVisible(self.NodeData.IsActive)
	self:UpdateAppearanceByCompleteState()
	self:UpdateEffect(self.NodeData.EffectType, self.NodeData.IsActive)
end

function m:UpdateEffect(nodeEffectDataCid, isActive)
	if isActive and self.NodeEffectDataCid == nodeEffectDataCid then
		return
	end

	if self.NodeEffectPlayId ~= 0 then
		MazeModule.StopEffect(self.NodeEffectPlayId)

		self.NodeEffectPlayId = 0
	end

	if not isActive then
		return
	end

	self.NodeEffectDataCid = nodeEffectDataCid

	if nodeEffectDataCid ~= 0 then
		local cfgMazePathNodeEffectData = CfgMazePathNodeEffectTable[nodeEffectDataCid]

		if cfgMazePathNodeEffectData.Effect ~= 0 then
			self.NodeEffectPlayId = MazeModule.PlayMaskedMountPointEffect(cfgMazePathNodeEffectData.Effect, 50000, self.EntityId, self.gameObject, 0, 0, 0, 0, 0)
		end
	end
end

function m:PlayShow()
	if self.gameObject == nil then
		return
	end

	self:OnShow()

	local tween = self.gameObject:GetComponentInChildren(typeof(TweenScale), true)

	if tween ~= nil then
		tween:ResetToBeginning()

		tween.enabled = true

		tween:PlayForward()
	end
end

function m:SetVisible(value)
	if self.gameObject == nil then
		return
	end

	self.IsVisible = value

	local spriteRenderers = self.gameObject:GetComponentsInChildren(typeof(UnityEngine.SpriteRenderer))

	for i = 0, spriteRenderers.Length - 1 do
		spriteRenderers[i].enabled = value
	end

	local collider = self.gameObject:GetComponentInChildren(typeof(UnityEngine.Collider2D))

	collider.enabled = value
end

function m:GetCameraFocusPosition()
	local position = Vector3()

	position.x = self.gameObject.transform.position.x
	position.y = self.gameObject.transform.position.y + MazeSceneApi:GetString("CameraLookHeroOffsetY")
	position.z = MazeModule.MazeScene.MainCamera.transform.position.z

	return position
end

function m:AddPath(path)
	self.Paths = self.Paths or {}

	table.insert(self.Paths, path)
end

function m:Dispose()
	if self.Timer ~= nil then
		self.Timer:Stop()
	end

	if self.NodeEffectPlayId ~= 0 then
		MazeModule.StopEffect(self.NodeEffectPlayId)

		self.NodeEffectPlayId = 0
	end

	self:RemoveEventListeners()
	GameEntry.Entity:HideEntityWithData(self.EntityId)
	EventDispatcher.Dispatch(EventID.MazeNodeDispose, self.NodeData)

	self.gameObject = nil
	self.NodeData = nil
	self.Paths = nil
	self.NormalViewRenderers = nil
	self.CompleteViewRenderers = nil
	self.CompassViewRenderers = nil
end

return m
