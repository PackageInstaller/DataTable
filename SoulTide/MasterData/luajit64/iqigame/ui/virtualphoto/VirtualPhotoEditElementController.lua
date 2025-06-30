-- chunkname: @IQIGame\\UI\\VirtualPhoto\\VirtualPhotoEditElementController.lua

local m = {
	Index = 0,
	EntityId = 0,
	id = 0,
	IsSelected = false,
	IsPreviewMode = false
}

function m.New(id, cid, rootCanvas)
	local obj = Clone(m)

	obj:Init(id, cid, rootCanvas)

	return obj
end

function m:Init(id, cid, rootCanvas)
	self.Id = id
	self.RootCanvas = rootCanvas
	self.View = UnityEngine.GameObject("ElementRoot_" .. tostring(id))
	self.View.layer = LayerMask.NameToLayer("UI")

	local scale = VirtualPhotoEditUIApi:GetString("DefaultElementScale")

	self.View.transform.localScale = Vector3(scale, scale, 1)

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	self:AddListeners()
	self:SetData(cid)
end

function m:AddListeners()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:RemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:SetIndex(value)
	self.Index = value

	self:UpdateLayer()
end

function m:SetData(cid)
	self:ShowElement(cid)
end

function m:ShowElement(cid)
	self.CfgVirtualPhotoElementData = CfgVirtualPhotoElementTable[cid]

	local isSpine = self.CfgVirtualPhotoElementData.EntityId ~= 0

	if isSpine then
		self.EntityId = GameEntry.Entity:GenerateEntityID()

		GameEntry.Entity:ShowElement(self.EntityId, self.CfgVirtualPhotoElementData.EntityId, 0, self.View.transform, Vector3.zero)
	else
		self.ImageSpriteGO = UnityEngine.GameObject("Sprite")

		self.ImageSpriteGO.transform:SetParent(self.View.transform, false)

		self.ImageSpriteGO.layer = LayerMask.NameToLayer("UI")

		self.ImageSpriteGO:AddComponent(typeof(UnityEngine.SpriteRenderer))
		self:UpdateLayer()
		self:UpdateTransparency()
		AssetUtil.LoadAsset(self, UIGlobalApi.GetImagePath(self.CfgVirtualPhotoElementData.ImagePath), self.onLoadImageSuccess)
	end
end

function m:onLoadImageSuccess(assetName, asset, duration, userData)
	local sprite = LuaCodeInterface.ToSprite(asset)
	local spriteRenderer = self.ImageSpriteGO:GetComponent(typeof(UnityEngine.SpriteRenderer))

	spriteRenderer.sprite = sprite
end

function m:OnShowElementEntitySuccess(sender, args)
	if args.Entity.Id == self.EntityId then
		self.SpineGO = args.Entity.gameObject

		setGameObjectLayers(self.SpineGO.transform, "UI")

		local meshRenderer = self.SpineGO:GetComponentInChildren(typeof(UnityEngine.Renderer))

		self.EntityOriginalSortingLayer = meshRenderer.sortingLayerName
		meshRenderer.sortingLayerName = "Default"

		self:StopSpine(self.CfgVirtualPhotoElementData.Motion, self.CfgVirtualPhotoElementData.TimePoint)
		self:UpdateLayer()
		self:UpdateTransparency()
	end
end

function m:UpdateLayer()
	local sortingOrder = self.RootCanvas.sortingOrder + 1 + self.Index

	if self.SpineGO ~= nil then
		local meshRenderer = self.SpineGO:GetComponentInChildren(typeof(UnityEngine.Renderer))

		meshRenderer.sortingOrder = sortingOrder
	end

	if self.ImageSpriteGO ~= nil then
		local spriteRenderer = self.ImageSpriteGO:GetComponent(typeof(UnityEngine.SpriteRenderer))

		spriteRenderer.sortingOrder = sortingOrder
	end
end

function m:StopSpine(animationName, time)
	self.OriginalSpineEntryAnimName = animationName

	local spineAnim = self.SpineGO:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

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

	local spineAnim = self.SpineGO:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

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

function m:SetSelect(value)
	self.IsSelected = value

	self:UpdateTransparency()
end

function m:SetPreviewMode(value)
	self.IsPreviewMode = value

	self:UpdateTransparency()
end

function m:UpdateTransparency()
	if self.SpineGO ~= nil then
		EntityShowUtil.SetAlpha(self.SpineGO, (self.IsSelected or self.IsPreviewMode) and 1 or 0.5)
	end

	if self.ImageSpriteGO ~= nil then
		EntityShowUtil.SetAlpha(self.ImageSpriteGO, (self.IsSelected or self.IsPreviewMode) and 1 or 0.5)
	end
end

function m:Flip()
	local localScale = self.View.transform.localScale

	localScale.x = localScale.x * -1
	self.View.transform.localScale = localScale
end

function m:Move(deltaX, deltaY)
	local position = self.View.transform.position

	position.x = position.x + deltaX
	position.y = position.y + deltaY
	self.View.transform.position = position
end

function m:Scale(scale)
	local localScale = self.View.transform.localScale

	localScale = localScale * scale
	self.View.transform.localScale = localScale
end

function m:Rotate(angle)
	local rotation = self.View.transform.rotation
	local eulerAngle = rotation:ToEulerAngles()

	rotation = Quaternion.Euler(eulerAngle.x, eulerAngle.y, angle)
	self.View.transform.rotation = rotation
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		if self.SpineGO ~= nil then
			self:RecoverSpine()

			local meshRenderer = self.SpineGO:GetComponentInChildren(typeof(UnityEngine.Renderer))

			meshRenderer.sortingLayerName = self.EntityOriginalSortingLayer
		end

		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function m:ClearSprite()
	if self.ImageSpriteGO ~= nil then
		local spriteRenderer = self.ImageSpriteGO:GetComponent(typeof(UnityEngine.SpriteRenderer))

		spriteRenderer.sprite = nil
	end
end

function m:Dispose()
	self:RemoveListeners()
	self:HideEntity()
	self:ClearSprite()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.RootCanvas = nil
	self.SpineGO = nil
	self.ImageSpriteGO = nil
end

return m
