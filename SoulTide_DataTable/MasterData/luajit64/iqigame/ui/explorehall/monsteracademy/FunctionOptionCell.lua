-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\FunctionOptionCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateBtnSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSelf)
end

function m:SetData(data)
	self.areaFunctionData = data

	UGUIUtil.SetText(self.TextName, self.areaFunctionData.cfgFunction.ButtonWord)
	self.Item:SetActive(false)
	self.Spend:SetActive(false)

	if self.areaFunctionData.cfgFunction.ButtonImage ~= nil and self.areaFunctionData.cfgFunction.ButtonImage ~= "" then
		self.Item:SetActive(true)

		local path = UIGlobalApi.GetImagePath(self.areaFunctionData.cfgFunction.ButtonImage)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	end

	if self.areaFunctionData.cfgFunction.CostShowImage ~= nil and self.areaFunctionData.cfgFunction.CostShowImage ~= "" then
		self.Spend:SetActive(true)

		local path = UIGlobalApi.GetImagePath(self.areaFunctionData.cfgFunction.CostShowImage)

		AssetUtil.LoadImage(self, path, self.SpendImg:GetComponent("Image"))
	end
end

function m:OnBtnSelf()
	if self.selectCallBack then
		self.selectCallBack(self.areaFunctionData.cfgID)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.selectCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
