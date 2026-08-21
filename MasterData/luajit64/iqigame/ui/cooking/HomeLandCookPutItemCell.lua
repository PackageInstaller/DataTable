-- chunkname: @IQIGame\\UI\\Cooking\\HomeLandCookPutItemCell.lua

HomeLandCookPutItemCell = {}

function HomeLandCookPutItemCell.__New(itemCellView, index)
	local itemCell = Clone(HomeLandCookPutItemCell)

	itemCell:Init(itemCellView, index)

	return itemCell
end

function HomeLandCookPutItemCell:Init(view, index)
	self.goView = view
	self.index = index

	self:AddListener()
	self:UpdateItem(nil)
end

function HomeLandCookPutItemCell:AddListener()
	return
end

function HomeLandCookPutItemCell:RemoveListener()
	return
end

function HomeLandCookPutItemCell:UpdateItem(itemID, top)
	self.putInItem = itemID

	local iconObj = self.goView.transform:Find("CookSlot/Icon").gameObject
	local nameObj = self.goView.transform:Find("Name").gameObject

	if self.putInItem == 0 or self.putInItem == nil then
		iconObj:SetActive(false)
		nameObj:SetActive(false)
	else
		iconObj:SetActive(true)
		nameObj:SetActive(true)

		local cfgItemData = CfgItemTable[self.putInItem]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), iconObj:GetComponent("Image"))
		UGUIUtil.SetText(self.goView.transform:Find("Name/Text_TitleName").gameObject, cfgItemData.Name)
	end
end

function HomeLandCookPutItemCell:RemoveItem()
	if self.putInItem ~= nil and self.removeItemCallBack then
		self.removeItemCallBack(self.index, self.putInItem)
	end
end

function HomeLandCookPutItemCell:Dispose()
	self:RemoveListener()

	self.removeItemCallBack = nil
	self.putInItem = nil

	AssetUtil.UnloadAsset(self)
	UnityEngine.GameObject.Destroy(self.goView)
end

return HomeLandCookPutItemCell
