-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGamePlayerRecruit\\PlaceGameSoulHeadCell.lua

local m = {
	checkState = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnFire()
		self:OnBtnFire()
	end

	self:AddListener()
	self:SetSelect(false)
end

function m:AddListener()
	if self.BtnFire then
		self.BtnFire:GetComponent("Button").onClick:AddListener(self.DelegateBtnFire)
	end
end

function m:RemoveListener()
	if self.BtnFire then
		self.BtnFire:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnFire)
	end
end

function m:OnBtnFire()
	if self.placeGameSoulData == nil then
		return
	end

	if not self.placeGameSoulData:GetCfgPlaceGameSoulData().IsDismiss then
		NoticeModule.ShowNotice(21045098)

		return
	end

	NoticeModule.ShowNotice(21045099, function()
		PlaceGameModule.Dismissal(self.placeGameSoulData.placeGameSoulPOD.cid)
	end, nil)
end

function m:SetMouseEnabled(value)
	self.View:GetComponent("Button").interactable = value

	local graphics = self.View:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true)

	for i = 0, graphics.Length - 1 do
		graphics[i].raycastTarget = value
	end
end

function m:SetData(placeGameSoulData)
	self.placeGameSoulData = placeGameSoulData

	self:UpdateView()
end

function m:UpdateView()
	if self.placeGameSoulData then
		local cfgSoulResData = CfgSoulResTable[self.placeGameSoulData:GetCfgPlaceGameSoulData().SoulResID]
		local path = UIGlobalApi.GetImagePath(cfgSoulResData.HeadIcon)

		AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))
		UGUIUtil.SetText(self.TextLevel, self.placeGameSoulData.placeGameSoulPOD.level)
	end
end

function m:SetSelect(top)
	self.checkState = top

	if self.Check then
		self.Check:SetActive(top)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
