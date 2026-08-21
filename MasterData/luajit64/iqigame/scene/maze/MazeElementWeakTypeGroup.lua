-- chunkname: @IQIGame\\Scene\\Maze\\MazeElementWeakTypeGroup.lua

local m = {
	IsVisible = false,
	WaitingForUnloadAsset = false,
	Icons = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view
	self.BackgroundTrans = self.View.transform:Find("Background")

	local iconContainerTrans = self.View.transform:Find("WeakType")

	for i = 1, iconContainerTrans.childCount do
		local icon = iconContainerTrans:Find("Icon" .. i)

		self.Icons[i] = icon
	end

	self.IsVisible = true
end

function m:SetData(weakTypes)
	if self.LoadedIconNum ~= nil then
		logError("资源正在加载中，该组件不允许反复刷新或重用")

		return
	end

	self.WeakTypes = weakTypes
	self.LoadedIconNum = 0

	for i = 1, #self.Icons do
		local weakType = weakTypes[i]
		local iconTrans = self.Icons[i]

		iconTrans.gameObject:SetActive(weakType ~= nil)

		if weakType ~= nil then
			local iconPath = MiscApi:GetString("SoulDamageTypeIcon", weakTypes[i])
			local spriteRenderer = iconTrans:GetComponent(typeof(UnityEngine.SpriteRenderer))

			spriteRenderer.enabled = false

			AssetUtil.LoadAsset(self, iconPath, self.OnLoadSuccess, self.OnLoadFail, i)
		end
	end

	self:Layout(#weakTypes)
end

function m:OnLoadSuccess(assetName, asset, duration, userData)
	local index = userData
	local spriteRenderer = self.Icons[index]:GetComponent(typeof(UnityEngine.SpriteRenderer))

	spriteRenderer.enabled = self.IsVisible
	spriteRenderer.sprite = LuaCodeInterface.ToSprite(asset)
	self.LoadedIconNum = self.LoadedIconNum + 1

	if self.LoadedIconNum == #self.WeakTypes then
		self:LoadAllComplete()
	end
end

function m:OnLoadFail(assetName, status, errorMessage, userData)
	self.LoadedIconNum = self.LoadedIconNum + 1

	if self.LoadedIconNum == #self.WeakTypes then
		self:LoadAllComplete()
	end
end

function m:LoadAllComplete()
	if self.WaitingForUnloadAsset then
		self:UnloadAsset()

		self.WaitingForUnloadAsset = false
	end

	self.LoadedIconNum = nil
end

function m:Layout(num)
	local iconCenterGap = MazeSceneApi:GetString("ElementWeakTypeGap")

	for i = 1, #self.Icons do
		local iconTrans = self.Icons[i]
		local pos = iconTrans.localPosition

		pos.x = -1 * iconCenterGap * (num - 1) * 0.5 + (i - 1) * iconCenterGap
		iconTrans.localPosition = pos
	end

	local bgRelativeIconWidth, bgMargin = MazeSceneApi:GetString("ElementWeakTypeBGMargin")
	local bgScale = self.BackgroundTrans.localScale

	bgScale.x = bgRelativeIconWidth * num + bgMargin * 2
	self.BackgroundTrans.localScale = bgScale
end

function m:UnloadAsset()
	for i = 1, #self.Icons do
		local iconTrans = self.Icons[i]
		local spriteRenderer = iconTrans:GetComponent(typeof(UnityEngine.SpriteRenderer))

		spriteRenderer.sprite = nil
		spriteRenderer.enabled = true
	end

	AssetUtil.UnloadAsset(self)
end

function m:SetVisible(value)
	if self.IsVisible == value then
		return
	end

	self.IsVisible = value

	local renderers = self.View:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	for i = 0, renderers.Length - 1 do
		renderers[i].enabled = value
	end
end

function m:Dispose()
	if self.LoadedIconNum ~= nil then
		self.WaitingForUnloadAsset = true
	else
		self:UnloadAsset()
	end

	self.View = nil
	self.BackgroundTrans = nil

	for i = 1, #self.Icons do
		self.Icons[i] = nil
	end
end

return m
