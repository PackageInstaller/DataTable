-- chunkname: @IQIGame\\UI\\TurntableGame\\TurntableGameCell.lua

local m = {
	Index = 0,
	IsHighlight = false,
	AngleType = 0
}

function m.New(view, angleType, itemIconBtnPool, onClick)
	local obj = Clone(m)

	obj:Init(view, angleType, itemIconBtnPool, onClick)

	return obj
end

function m:Init(view, angleType, itemIconBtnPool, onClick)
	self.View = view
	self.AngleType = angleType
	self.ItemIconBtnPool = itemIconBtnPool
	self.OnClickCallback = onClick

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickIcon()
		self:OnClickIcon()
	end
end

function m:OnObtain(index)
	self.Index = index

	local angle = self.AngleType * (index - 1)

	self.View.transform.localRotation = Quaternion.Euler(0, 0, angle)
	self.ItemIconBtn = self.ItemIconBtnPool:Obtain()

	self.ItemIconBtn.transform:SetParent(self.IconNode.transform, false)

	self.ItemIconBtn.transform.rotation = Quaternion.identity

	self.ItemIconBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickIcon)
end

function m:SetData(iconPath)
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(iconPath), self.ItemIconBtn:GetComponentInChildren(typeof(UnityEngine.UI.Image)))
end

function m:OnRelease()
	self.ItemIconBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickIcon)
	self.ItemIconBtnPool:Release(self.ItemIconBtn)

	self.ItemIconBtn = nil
end

function m:OnClickIcon()
	self.OnClickCallback(self.Index)
end

function m:SetHighlight(value, isInit)
	if not isInit and not self.IsHighlight and value then
		GameEntry.Sound:PlaySound(10509, Constant.SoundGroup.UI)
	end

	self.IsHighlight = value

	self.HighlightBg:SetActive(value)
	self.NormalBg:SetActive(not value)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.ItemIconBtnPool = nil
	self.OnClickCallback = nil
end

return m
