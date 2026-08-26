-- chunkname: @modules/logic/versionactivity1_2/trade/view/ActivityQuoteRewardItem.lua

module("modules.logic.versionactivity1_2.trade.view.ActivityQuoteRewardItem", package.seeall)

local ActivityQuoteRewardItem = class("ActivityQuoteRewardItem", UserDataDispose)

function ActivityQuoteRewardItem:ctor(go)
	self:__onInit()

	self.go = go
	self.imageIcon = gohelper.findChildSingleImage(self.go, "simage_icon")
	self.imageRare = gohelper.findChildImage(self.go, "image_rarebg")
	self.textCount = gohelper.findChildText(self.go, "txt_count")
end

function ActivityQuoteRewardItem:setData(data)
	self.data = data

	if not data then
		gohelper.setActive(self.go, false)

		return
	end

	gohelper.setActive(self.go, true)

	self.textCount.text = data.progress >= data.maxProgress and string.format("%s/%s", data.progress, data.maxProgress) or string.format("<color=#ff8949>%s</color>/%s", data.progress, data.maxProgress)

	local itemCfg, iconPath = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, tonumber(data.listenerParam))

	if itemCfg.rare then
		if not itemCfg.rare then
			local rare = 5

			UISpriteSetMgr.instance:setVersionActivityTrade_1_2Sprite(self.imageRare, "bg_wupindi_" .. tostring(rare))
			self.imageIcon:LoadImage(iconPath)
		end
	end
end

function ActivityQuoteRewardItem:destory()
	self.imageIcon:UnLoadImage()
	self:__onDispose()
end

return ActivityQuoteRewardItem
