-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\CardGame\\CardGameItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnSelf()
		self:OnBtnSelf()
	end

	self.EffectSuccess:SetActive(false)
	self.EffectFail:SetActive(false)
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

	self.cardData = data

	self:UpdateView()
end

function m:UpdateView()
	local path = UIGlobalApi.GetImagePath(self.cardData:GetCfgData().ImageIcon)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	self.Lock:SetActive(not self.cardData.isOpen)
end

function m:OnBtnSelf()
	if self.cardData.isOpen then
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
