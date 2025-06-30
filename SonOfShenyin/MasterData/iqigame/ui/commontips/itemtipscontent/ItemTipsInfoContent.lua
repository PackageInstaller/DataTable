-- chunkname: @IQIGame\\UI\\CommonTips\\ItemTipsContent\\ItemTipsInfoContent.lua

local TipsSourcesElement = require("IQIGame.UI.CommonTips.Element.TipsSourcesElement")
local ItemTipsInfoContent = {}

function ItemTipsInfoContent.New(view)
	local obj = Clone(ItemTipsInfoContent)

	obj:Init(view)

	return obj
end

function ItemTipsInfoContent:Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.sourcesElement = TipsSourcesElement.New(self.TipsSourcesContent)

	self:AddListeners()
end

function ItemTipsInfoContent:AddListeners()
	return
end

function ItemTipsInfoContent:RemoveListeners()
	return
end

function ItemTipsInfoContent:Dispose()
	self:RemoveListeners()
	self.sourcesElement:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function ItemTipsInfoContent:SetData(itemData, params)
	self.Content:SetActive(false)

	local cfgData = itemData:GetCfg()

	self.itemIntroText:GetComponent("Text").text = cfgData.ItemTips

	if LuaUtility.StrIsNullOrEmpty(cfgData.ItemStory) then
		self.itemBackstoryText:SetActive(false)
	else
		self.itemBackstoryText:SetActive(true)

		self.itemBackstoryText:GetComponent("Text").text = cfgData.ItemStory
	end

	if params.cbParams.hideSource then
		self.sourcesElement:Hide()
	else
		self.sourcesElement:Show(cfgData.Source)
	end

	self.Content:SetActive(true)

	self.Content.transform.localPosition = Vector3.New(0, 0, 0)
end

return ItemTipsInfoContent
