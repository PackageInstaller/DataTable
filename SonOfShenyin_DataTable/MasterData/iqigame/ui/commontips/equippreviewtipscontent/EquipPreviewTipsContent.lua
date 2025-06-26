-- chunkname: @IQIGame\\UI\\CommonTips\\EquipPreviewTipsContent\\EquipPreviewTipsContent.lua

local EquipPreviewTipsHeadContent = require("IQIGame.UI.CommonTips.EquipPreviewTipsContent.EquipPreviewTipsHeadContent")
local EquipPreviewTipsInfoContent = require("IQIGame.UI.CommonTips.EquipPreviewTipsContent.EquipPreviewTipsInfoContent")
local EquipPreviewTipsContent = {}

function EquipPreviewTipsContent.New(view)
	local obj = Clone(EquipPreviewTipsContent)

	obj:__Init(view)

	return obj
end

function EquipPreviewTipsContent:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.headContent = EquipPreviewTipsHeadContent.New(self.TopParent)
	self.infoContent = EquipPreviewTipsInfoContent.New(self.ContentScrollView)

	self:__AddListeners()
end

function EquipPreviewTipsContent:__AddListeners()
	return
end

function EquipPreviewTipsContent:__RemoveListeners()
	return
end

function EquipPreviewTipsContent:Dispose()
	self:__RemoveListeners()
	self.headContent:Dispose()
	self.infoContent:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function EquipPreviewTipsContent:SetData(userData)
	local itemData = userData.data

	self.headContent:SetData(itemData)
	self.infoContent:SetData(itemData)
end

return EquipPreviewTipsContent
