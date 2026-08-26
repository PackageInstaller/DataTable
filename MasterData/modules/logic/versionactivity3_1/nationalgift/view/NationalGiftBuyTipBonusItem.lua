-- chunkname: @modules/logic/versionactivity3_1/nationalgift/view/NationalGiftBuyTipBonusItem.lua

module("modules.logic.versionactivity3_1.nationalgift.view.NationalGiftBuyTipBonusItem", package.seeall)

local NationalGiftBuyTipBonusItem = class("NationalGiftBuyTipBonusItem", LuaCompBase)

function NationalGiftBuyTipBonusItem:init(go, co)
	self.go = go
	self._config = co
	self._gorewarditem = gohelper.findChild(self.go, "go_rewards/rewarditem")
	self._imageNum = gohelper.findChildImage(self.go, "image_Num")
	self._gotips = gohelper.findChild(self.go, "go_tips")

	self:_initItem()
end

function NationalGiftBuyTipBonusItem:_initItem()
	gohelper.setActive(self.go, true)
	UISpriteSetMgr.instance:setStoreGoodsSprite(self._imageNum, "releasegift_img_num" .. tostring(self._config.id), true)

	self._rewardItems = {}
end

function NationalGiftBuyTipBonusItem:refresh()
	local isGiftHasBuy = NationalGiftModel.instance:isGiftHasBuy()

	gohelper.setActive(self._gotips, not isGiftHasBuy and self._config.id == 1)
	self:_refreshRewards()
end

function NationalGiftBuyTipBonusItem:_onItemClick(index)
	local rewardCos = string.split(self._config.bonus, "|")
	local itemCo = string.splitToNumber(rewardCos[index], "#")

	MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
end

function NationalGiftBuyTipBonusItem:_refreshRewards()
	local rewardCos = string.split(self._config.bonus, "|")

	for index, reward in ipairs(rewardCos) do
		if not self._rewardItems[index] then
			local item = {}

			item.go = gohelper.cloneInPlace(self._gorewarditem)
			item.imgquality = gohelper.findChildImage(item.go, "img_quality")
			item.simageitem = gohelper.findChildSingleImage(item.go, "simage_Item")
			item.txtnum = gohelper.findChildText(item.go, "image_NumBG/txt_Num")
			item.btnclick = gohelper.findChildButtonWithAudio(item.go, "click")

			item.btnclick:AddClickListener(self._onItemClick, self, index)

			self._rewardItems[index] = item
		end

		gohelper.setActive(self._rewardItems[index].go, true)

		local rewards = string.splitToNumber(reward, "#")
		local co, icon = ItemModel.instance:getItemConfigAndIcon(rewards[1], rewards[2])

		UISpriteSetMgr.instance:setNationalGiftSprite(self._rewardItems[index].imgquality, "bg_pinjidi_" .. tostring(co.rare), true)
		self._rewardItems[index].simageitem:LoadImage(icon)

		self._rewardItems[index].txtnum.text = luaLang("multiple") .. rewards[3]
	end
end

function NationalGiftBuyTipBonusItem:destroy()
	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			item.btnclick:RemoveClickListener()
			item.simageitem:UnLoadImage()
		end

		self._rewardItems = nil
	end
end

return NationalGiftBuyTipBonusItem
