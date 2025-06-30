-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\FruitCleanGame\\FruitGameItemCell.lua

local m = {
	isSelect = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.EffectSuccess:SetActive(false)
	self.EffectFail:SetActive(false)

	function self.DelegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateBtnSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSelf)
end

function m:SetData(data)
	self.EffectSuccess:SetActive(false)
	self.EffectFail:SetActive(false)

	self.fruitData = data

	self:UpdateView()
	self:ShowLine({})
end

function m:SetSelect(select)
	self.isSelect = select

	self.Check:SetActive(select)
end

function m:CleanFruit()
	self.ImgIcon:SetActive(false)
end

function m:ShowLine(showType)
	self.lineParent:SetActive(#showType > 0)

	for i = 1, 4 do
		self["line" .. i]:SetActive(false)
	end

	for i, v in pairs(showType) do
		self["line" .. v]:SetActive(true)
	end
end

function m:UpdateView()
	self.ImgIcon:SetActive(false)

	if self.fruitData:GetCfgData() then
		local path = UIGlobalApi.GetImagePath(self.fruitData:GetCfgData().ImageIcon)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
		self.ImgIcon:SetActive(not self.fruitData.isClean)
	end
end

function m:OnBtnSelf()
	if self.fruitData.isClean then
		return
	end

	if self.clickCallBack then
		self.clickCallBack(self)
	end
end

function m:PlayEffect(top)
	if self.timer then
		self.timer:Stop()
	end

	if top then
		self.EffectSuccess:SetActive(true)
	else
		self.EffectFail:SetActive(true)
	end

	self.timer = Timer.New(function()
		self.EffectSuccess:SetActive(false)
		self.EffectFail:SetActive(false)
	end, 0.5)

	self.timer:Start()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.clickCallBack = nil

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
