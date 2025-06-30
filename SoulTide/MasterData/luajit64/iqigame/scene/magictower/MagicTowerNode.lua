-- chunkname: @IQIGame\\Scene\\MagicTower\\MagicTowerNode.lua

local m = {
	SortingOrder = 0,
	IsLoading = false,
	EntityId = 0
}

function m.New(cellPOD, parentTrans, position, sortingOrder)
	local obj = Clone(m)

	obj:Init(cellPOD, parentTrans, position, sortingOrder)

	return obj
end

function m:Init(cellPOD, parentTrans, position, sortingOrder)
	self.CellPOD = cellPOD
	self.SortingOrder = sortingOrder

	function self.DelegateOnShowNodeEntitySuccess(sender, args)
		self:OnShowNodeEntitySuccess(sender, args)
	end

	function self.DelegateOnShowNodeEntityFailure(sender, args)
		self:OnShowNodeEntityFailure(sender, args)
	end

	self:AddEventListeners()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	local cfgMagicTowerCellDataData = CfgMagicTowerCellDataTable[self.CellPOD.dataId]

	self.IsLoading = true

	GameEntry.Entity:ShowMazeNode(self.EntityId, UIGlobalApi.GetPrefabRoot(cfgMagicTowerCellDataData.CellPrefab), 0, parentTrans, position)
end

function m:AddEventListeners()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowNodeEntitySuccess)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowNodeEntityFailure)
end

function m:RemoveEventListeners()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowNodeEntitySuccess)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowNodeEntityFailure)
end

function m:OnShowNodeEntitySuccess(sender, args)
	if args.Entity.Id == self.EntityId then
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowNodeEntitySuccess)
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowNodeEntityFailure)

		self.gameObject = args.Entity.gameObject

		local renderers = self.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			local renderer = renderers[i]

			renderer.sortingOrder = self.SortingOrder
		end

		self:OnShow()

		self.IsLoading = false

		EventDispatcher.Dispatch(EventID.MagicTowerLoadEntityComplete)
	end
end

function m:OnShowNodeEntityFailure(sender, args)
	if args.Entity.Id == self.EntityId then
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowNodeEntitySuccess)
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowNodeEntityFailure)

		self.IsLoading = false

		EventDispatcher.Dispatch(EventID.MagicTowerLoadEntityComplete)
	end
end

function m:OnShow()
	return
end

function m:PlayEffectOnRoot(effectCid)
	GameEntry.Effect:PlayMountPointEffect(effectCid, Constant.MountPoint.PointRoot, 0, self.View, 0, 0, 0, LuaCodeInterface.SortingLayerNameToID("Element"), 2, 1, true)
end

function m:Dispose()
	self:RemoveEventListeners()
	GameEntry.Entity:HideEntity(self.EntityId)

	self.gameObject = nil
	self.CellPOD = nil
end

return m
