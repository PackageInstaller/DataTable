-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\RestaurantOperationFunction\\ROFunctionItemCell.lua

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

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateBtnSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSelf)
end

function m:SetData(functionID)
	self.functionID = functionID

	UGUIUtil.SetText(self.TextFunctionName, CfgRestaurantOperationFunctionControlTable[self.functionID].FunctionName)

	local path = UIGlobalApi.GetImagePath(CfgRestaurantOperationFunctionControlTable[self.functionID].FunctionIcon)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
end

function m:OnBtnSelf()
	if self.clickSelfCallBack then
		self.clickSelfCallBack(self.functionID)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.clickSelfCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
