-- chunkname: @modules/logic/reactivity/view/ReactivityRuleItem.lua

module("modules.logic.reactivity.view.ReactivityRuleItem", package.seeall)

local ReactivityRuleItem = class("ReactivityRuleItem", ListScrollCell)

function ReactivityRuleItem:init(go)
	self.reward1 = self:createReward(gohelper.findChild(go, "#reward1"))
	self.reward2 = self:createReward(gohelper.findChild(go, "#reward2"))
end

function ReactivityRuleItem:createReward(go)
	local item = self:getUserDataTb_()

	item.go = go
	item.imageBg = gohelper.findChildImage(go, "image_bg")
	item.simageReward = gohelper.findChildSingleImage(go, "simage_reward")
	item.imageCircle = gohelper.findChildImage(go, "image_circle")
	item.txtCount = gohelper.findChildTextMesh(go, "txt_rewardcount")
	item.btn = gohelper.findButtonWithAudio(go)

	item.btn:AddClickListener(ReactivityRuleItem.onClickItem, item)

	return item
end

function ReactivityRuleItem.onClickItem(itemTab)
	if not itemTab.data then
		return
	end

	MaterialTipController.instance:showMaterialInfo(itemTab.data.type, itemTab.data.id, false)
end

function ReactivityRuleItem:addEventListeners()
	return
end

function ReactivityRuleItem:removeEventListeners()
	return
end

function ReactivityRuleItem:onUpdateMO(mo)
	self._mo = mo

	local data1 = {
		quantity = 1,
		type = mo.typeId,
		id = mo.itemId
	}
	local param = string.splitToNumber(mo.price, "#")
	local data2 = {
		type = param[1],
		id = param[2],
		quantity = param[3]
	}

	self:updateReward(self.reward1, data1)
	self:updateReward(self.reward2, data2)
end

function ReactivityRuleItem:updateReward(item, data)
	item.data = data
	item.txtCount.text = string.format("<size=25>×</size>%s", data.quantity)

	local config, icon = ItemModel.instance:getItemConfigAndIcon(data.type, data.id)

	item.simageReward:LoadImage(icon)
	UISpriteSetMgr.instance:setUiFBSprite(item.imageBg, "bg_pinjidi_" .. config.rare)
	UISpriteSetMgr.instance:setUiFBSprite(item.imageCircle, "bg_pinjidi_lanse_" .. config.rare)
end

function ReactivityRuleItem:destoryReward(item)
	item.simageReward:UnLoadImage()
	item.btn:RemoveClickListener()
end

function ReactivityRuleItem:onDestroy()
	self:destoryReward(self.reward1)
	self:destoryReward(self.reward2)
end

return ReactivityRuleItem
