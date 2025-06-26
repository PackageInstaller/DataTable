-- chunkname: @IQIGame\\UI\\Girl\\RandomSecretary\\RandomSecretaryCell.lua

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
	self:SetSelect(false)
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.data = data

	self:UpdateView()
end

function m:UpdateView()
	if self.data then
		local path = UIGlobalApi.GetImagePath(self.data:GetCfgData().Url)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.TextSoulName, self.data:GetCfgData().SoulName)
		UGUIUtil.SetText(self.TextDecorationName, self.data:GetCfgData().Name)
		self.Live2D:SetActive(self.data:GetCfgData().SecretaryType == Constant.GirlOnDutyShowType.ShowType_LIVE2D)
		self.Spine:SetActive(self.data:GetCfgData().SecretaryType == Constant.GirlOnDutyShowType.ShowType_Spine)
		self.Oath:SetActive(self.data:GetCfgData().SecretaryType == Constant.GirlOnDutyShowType.ShowType_Oath)
		self:SetSelect(self.data.isSelect)
	end
end

function m:SetSelect(top)
	self.Check:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
