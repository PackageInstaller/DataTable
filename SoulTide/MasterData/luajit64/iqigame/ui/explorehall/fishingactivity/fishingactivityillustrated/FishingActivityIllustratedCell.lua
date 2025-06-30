-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivityIllustrated\\FishingActivityIllustratedCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.FishIllustratedData = data

	self.Lock:SetActive(not self.FishIllustratedData.isUnlock)
	self.ImgDown:SetActive(self.FishIllustratedData.isUnlock)
	self.ImgUp:SetActive(self.FishIllustratedData.isUnlock)
	self.ImgQuality:SetActive(self.FishIllustratedData.isUnlock)
	self.ImgLock:GetComponent("GrayComponent"):SetGray(not self.FishIllustratedData.isUnlock)
	UGUIUtil.SetText(self.TextNum, self.FishIllustratedData.captureTimes)

	if self.FishIllustratedData.isUnlock then
		local path = CommonSlotUIApi:GetString("QualityBackgroundPath", self.FishIllustratedData:GetCfgData().Quality)

		AssetUtil.LoadImage(self, path, self.ImgQuality:GetComponent("Image"))
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.FishIllustratedData:GetCfgData().Icon), self.ImgDown:GetComponent("Image"))
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.FishIllustratedData:GetCfgData().Icon), self.ImgUp:GetComponent("Image"))
	else
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.FishIllustratedData:GetCfgData().Icon), self.ImgLock:GetComponent("Image"))
	end
end

function m:SetSelect(top)
	self.goDown:SetActive(not top)
	self.goUp:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
