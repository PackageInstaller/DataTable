-- chunkname: @IQIGame\\UI\\Girl\\BackGround\\BackGroundRenderCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextUseTag, GirlUIApi:GetString("BGTextUseTag"))
	self:AddListener()
	self:SetSelect(false)
	self:SetCurrentUse(false)
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:UpdateView()
	if self.backGroundData then
		local path = UIGlobalApi.GetImagePath(self.backGroundData:GetConfigData().Icon)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.TextName, self.backGroundData:GetConfigData().Name)
		self.LockTag:SetActive(not self.backGroundData.unlock)
	end
end

function m:SetCurrentUse(top)
	self.UseTag:SetActive(top)
end

function m:SetSelect(top)
	self.Check:SetActive(top)
end

function m:SetData(data)
	self.backGroundData = data

	self:UpdateView()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
