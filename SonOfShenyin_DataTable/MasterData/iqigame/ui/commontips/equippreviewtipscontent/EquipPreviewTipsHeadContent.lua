-- chunkname: @IQIGame\\UI\\CommonTips\\EquipPreviewTipsContent\\EquipPreviewTipsHeadContent.lua

local EquipPreviewTipsHeadContent = {}

function EquipPreviewTipsHeadContent.New(view)
	local obj = Clone(EquipPreviewTipsHeadContent)

	obj:__Init(view)

	return obj
end

function EquipPreviewTipsHeadContent:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__AddListeners()
end

function EquipPreviewTipsHeadContent:__AddListeners()
	return
end

function EquipPreviewTipsHeadContent:__RemoveListeners()
	return
end

function EquipPreviewTipsHeadContent:Dispose()
	self:__RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function EquipPreviewTipsHeadContent:SetData(itemData)
	local cfgData = itemData:GetCfg()

	AssetUtil.LoadImage(self, CommonTipsApi:GetQualityBackground(cfgData.Quality), self.qualityBg:GetComponent("Image"))

	self.equipNameText:GetComponent("Text").text = CommonEquipTipsUIApi:GetEquipName(cfgData.Name, cfgData.Quality)
	self.equipTypeText:GetComponent("Text").text = CommonEquipTipsUIApi:GetEquipTypeText()

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgData.Icon), self.equipImg:GetComponent("Image"))
end

return EquipPreviewTipsHeadContent
