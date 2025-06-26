-- chunkname: @IQIGame\\UI\\FormationUI\\FormationChooseSoulSubTabBtn.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(soulData, isCurrent, isUsing)
	local cfgSoulResData = soulData:GetCfgSoulRes2D()
	local path = UIGlobalApi.GetImagePath(cfgSoulResData.SoulFormationImage)

	self.Icon:SetActive(false)
	AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"), self.OnSuccess, self.OnFail)
	UGUIUtil.SetText(self.LvLabelText, FormationChooseSoulUIApi:GetString("TabBtnLevelLabel"))
	UGUIUtil.SetText(self.LvValueText, soulData.lv)
	self.StarGrid:GetComponent("SimpleStarComponent"):UpdateView(5, soulData:GetCfgSoulQuality().Quality)
	self.CurTag:SetActive(isCurrent)
	self.UsingTag:SetActive(not isCurrent and isUsing)
end

function m:OnSuccess(assetName, asset, duration, userData)
	self.Icon:SetActive(true)
end

function m:OnFail(assetName, status, errorMessage, userData)
	self.Icon:SetActive(true)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
