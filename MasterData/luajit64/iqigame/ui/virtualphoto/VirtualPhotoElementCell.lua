-- chunkname: @IQIGame\\UI\\VirtualPhoto\\VirtualPhotoElementCell.lua

local m = {
	EntityId = 0
}

function m.New(view, rootCanvas, loadSpineRequestFunc, onSpineLoaded)
	local obj = Clone(m)

	obj:Init(view, rootCanvas, loadSpineRequestFunc, onSpineLoaded)

	return obj
end

function m:Init(view, rootCanvas, loadSpineRequestFunc, onSpineLoaded)
	self.View = view
	self.RootCanvas = rootCanvas
	self.LoadSpineRequestFunc = loadSpineRequestFunc
	self.OnSpineLoadedCallback = onSpineLoaded

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	self.DefaultImageSize = self.ImageNode.transform.sizeDelta

	self:AddListeners()
end

function m:AddListeners()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:RemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:SetData(cfgVirtualPhotoElementData)
	self.CfgVirtualPhotoElementData = cfgVirtualPhotoElementData

	self:HideEntity()

	local isSpine = self.CfgVirtualPhotoElementData.EntityId ~= 0

	self.SpineNode:SetActive(isSpine)
	self.ImageNode:SetActive(not isSpine)

	if isSpine then
		self.EntityId = GameEntry.Entity:GenerateEntityID()

		self.LoadSpineRequestFunc(self, self.ShowEntity, false)
	else
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.CfgVirtualPhotoElementData.ImagePath), self.ImageNode:GetComponent("Image"), self.onLoadImageSuccess)
	end

	UGUIUtil.SetText(self.ElementNameText, cfgVirtualPhotoElementData.Name)
end

function m.ShowEntity(cell)
	GameEntry.Entity:ShowElement(cell.EntityId, cell.CfgVirtualPhotoElementData.EntityId, 0, cell.SpineNode.transform, Vector3.zero)
end

function m:OnShowElementEntitySuccess(sender, args)
	if args.Entity.Id == self.EntityId then
		local trans = args.Entity.transform

		setGameObjectLayers(trans, "UI")

		local renderer = trans:GetComponentInChildren(typeof(UnityEngine.Renderer))

		renderer.sortingOrder = self.RootCanvas.sortingOrder + 1
		self.EntityOriginalSortingLayer = renderer.sortingLayerName
		renderer.sortingLayerName = "Default"

		self.OnSpineLoadedCallback()
		self:StopSpine(self.CfgVirtualPhotoElementData.Motion, self.CfgVirtualPhotoElementData.TimePoint)
	end
end

function m:onLoadImageSuccess(assetName, asset, duration, userData)
	local sprite = LuaCodeInterface.ToSprite(asset)
	local whRatio = sprite.rect.w / sprite.rect.h
	local standardWhRatio = self.DefaultImageSize.x / self.DefaultImageSize.y
	local finalWith = 1
	local finalHeight = 1

	if standardWhRatio < whRatio then
		finalWith = self.DefaultImageSize.x
		finalHeight = finalWith / whRatio
	else
		finalHeight = self.DefaultImageSize.y
		finalWith = finalHeight * whRatio
	end

	self.ImageNode.transform.sizeDelta = Vector2(finalWith, finalHeight)
end

function m:StopSpine(animationName, time)
	self.OriginalSpineEntryAnimName = animationName

	local spineAnim = self.SpineNode:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

	self.OriginalSpineLoop = spineAnim.loop
	spineAnim.loop = false
	spineAnim.AnimationName = animationName

	local entry = spineAnim.AnimationState:GetCurrent(0)

	self.OriginalSpineEntryStartTime = entry.AnimationStart
	entry.AnimationStart = time
	self.OriginalSpineEntryEndTime = entry.AnimationEnd
	entry.AnimationEnd = time
end

function m:RecoverSpine()
	if self.OriginalSpineEntryAnimName == nil then
		return
	end

	local spineAnim = self.SpineNode:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

	spineAnim.loop = self.OriginalSpineLoop
	spineAnim.AnimationName = self.OriginalSpineEntryAnimName

	local entry = spineAnim.AnimationState:GetCurrent(0)

	entry.AnimationStart = self.OriginalSpineEntryStartTime
	entry.AnimationEnd = self.OriginalSpineEntryEndTime
	self.OriginalSpineEntryAnimName = nil
	self.OriginalSpineLoop = nil
	self.OriginalSpineEntryStartTime = nil
	self.OriginalSpineEntryEndTime = nil
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		if self.EntityOriginalSortingLayer ~= nil then
			local renderer = self.SpineNode:GetComponentInChildren(typeof(UnityEngine.Renderer))

			renderer.sortingLayerName = self.EntityOriginalSortingLayer
			self.EntityOriginalSortingLayer = nil
		end

		self:RecoverSpine()
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0

		self.LoadSpineRequestFunc(self, self.ShowEntity, true)
	end
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	self:HideEntity()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.RootCanvas = nil
	self.OnSpineLoadedCallback = nil
	self.CfgVirtualPhotoElementData = nil
end

return m
