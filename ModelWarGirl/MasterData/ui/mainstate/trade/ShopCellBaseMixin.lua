-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\ShopCellBaseMixin.lua

local ShopCellBaseMixin = {}

function ShopCellBaseMixin:initBaseUI(clickEnabled)
	self.imgLock = UIControls.Image(self, "ContentPanel/ImgLock")

	if UIControls.checkControlFunc(self, "ContentPanel/ImgLock/BgCondition") then
		self.bgLock = UIControls.Panel(self, "ContentPanel/ImgLock/BgCondition")
		self.textLock = UIControls.Label(self, "ContentPanel/ImgLock/BgCondition/Text")
	end

	if UIControls.checkControlFunc(self, "ContentPanel/SkinPanel") then
		self.panelSkin = UIControls.Panel(self, "ContentPanel/SkinPanel")
		self.imgSkinQuality = UIControls.Image(self, "ContentPanel/SkinPanel/ImgQuality")
		self.btnSkinPreview = UIControls.Button(self, "ContentPanel/SkinPanel/BtnPreview")

		self.btnSkinPreview:addEventClick(self.onSkinPreviewClick)
	end
end

function ShopCellBaseMixin:checkLocked(shopItem)
	if shopItem:isLocked() then
		self.imgLock:setVisible(true)

		if self.bgLock then
			if shopItem.shortLockHint then
				self.bgLock:setVisible(true)
				self.textLock:setText(shopItem.shortLockHint)
			elseif shopItem.lockHint and shopItem.lockHint ~= "" then
				self.bgLock:setVisible(true)
				self.textLock:setText(shopItem.lockHint)
			else
				self.bgLock:setVisible(false)
				self.textLock:setText("")
			end
		end
	else
		self.imgLock:setVisible(false)
	end
end

function ShopCellBaseMixin:checkBasePanel(shopItem)
	local object = shopItem.object

	if self.panelSkin then
		if object and object:isSkin() then
			self.panelSkin:setVisible(true)

			local skinQualityPath = object:getQualityIconPath()

			if skinQualityPath then
				self.imgSkinQuality:setImage(skinQualityPath[1], skinQualityPath[2])
			end
		else
			self.panelSkin:setVisible(false)
		end
	end
end

function ShopCellBaseMixin:onSkinPreviewClick(shopItem)
	if self.item and self.item.object and self.item.object.clientData then
		local skinData = self.item.object.clientData
		local skinPreviewTips = UIManager.getUI("skinPreviewTips")

		skinPreviewTips:setObject(skinData, self.item.object, self)
	end
end

return ShopCellBaseMixin
