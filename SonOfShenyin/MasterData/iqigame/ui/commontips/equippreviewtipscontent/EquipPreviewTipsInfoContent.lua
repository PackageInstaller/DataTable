-- chunkname: @IQIGame\\UI\\CommonTips\\EquipPreviewTipsContent\\EquipPreviewTipsInfoContent.lua

local EquipTipsSuitElement = require("IQIGame.UI.CommonTips.Element.EquipTipsSuitElement")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local __suitNameItem = {}

function __suitNameItem.New(view)
	local obj = Clone(__suitNameItem)

	obj:__Init(view)

	return obj
end

function __suitNameItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function __suitNameItem:Hide()
	self.gameObject:SetActive(false)
end

function __suitNameItem:SetData(name)
	self.suitContentText:GetComponent("Text").text = name

	self.gameObject:SetActive(true)
end

function __suitNameItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local EquipPreviewTipsInfoContent = {}

EquipPreviewTipsInfoContent.SuitNameItem = __suitNameItem

function EquipPreviewTipsInfoContent.New(view)
	local obj = Clone(EquipPreviewTipsInfoContent)

	obj:__Init(view)

	return obj
end

function EquipPreviewTipsInfoContent:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.suitView = EquipTipsSuitElement.New(self.suitEffectParent)
	self.suitAwakenView = EquipTipsSuitElement.New(self.suitAwakenEffectParent)

	self.suitNamePrefab:SetActive(false)

	local suitNamePrefabParent = self.suitNamePrefab.transform.parent

	self.suitNamePool = UIViewObjectPool.New(self.suitNamePrefab, suitNamePrefabParent, function(_view)
		return self.SuitNameItem.New(_view)
	end)
	self.suitTipsText:GetComponent("Text").text = CommonEquipTipsUIApi:GetEquipSuitTitleText()

	self:__AddListeners()
end

function EquipPreviewTipsInfoContent:__AddListeners()
	return
end

function EquipPreviewTipsInfoContent:__RemoveListeners()
	return
end

function EquipPreviewTipsInfoContent:Dispose()
	self:__RemoveListeners()
	self.suitNamePool:ForItems(function(_item)
		_item:Dispose()
	end)
	self.suitView:Dispose()

	self.suitView = nil

	self.suitAwakenView:Dispose()

	self.suitAwakenView = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function EquipPreviewTipsInfoContent:SetData(itemData)
	local cfgData = itemData:GetCfg()
	local suitId = cfgData.LikeId

	self.suitView:SetData(suitId, Constant.Equip.SuitType.Normal)
	self.suitAwakenView:SetData(suitId, Constant.Equip.SuitType.Awaken)
	self:__RefreshSuitNameData(suitId, cfgData.Quality)

	self.Content.transform.localPosition = Vector3.New(0, 0, 0)
end

function EquipPreviewTipsInfoContent:__RefreshSuitNameData(suitId, quality)
	self.suitNamePool:ForItems(function(_item)
		_item:Hide()
	end)

	local suitItems = EquipModule.GetAllEquipSuitItemBySuitIdAndQuality(suitId, quality)

	for i = 1, #suitItems do
		local viewItem = self.suitNamePool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		viewItem:SetData(suitItems[i].Name)
	end
end

return EquipPreviewTipsInfoContent
