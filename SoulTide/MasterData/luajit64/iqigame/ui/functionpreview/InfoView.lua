-- chunkname: @IQIGame\\UI\\FunctionPreview\\InfoView.lua

local InfoView = {}

function InfoView.New(view)
	local obj = Clone(InfoView)

	obj:Init(view)

	return obj
end

function InfoView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfCondition = self.goCondition:GetComponent("Text")
	self.tfDetail = self.goDetail:GetComponent("Text")
	self.imgBg = self.goBg:GetComponent("Image")
end

function InfoView:Refresh(cfgForecastData)
	self.tfCondition.text = FunctionPreviewUIApi:GetString("openInfoDesc", cfgForecastData.ConditionInfo)
	self.tfDetail.text = FunctionPreviewUIApi:GetString("goDetail", cfgForecastData.Desc)

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgForecastData.Image), self.imgBg)
end

function InfoView:OnHide()
	AssetUtil.UnloadAsset(self)
end

function InfoView:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return InfoView
