-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mibaoshopsell/view/WangYeShopSellView.lua

module("logic.extensions.mibaoshopsell.view.WangYeShopSellView", package.seeall)

local WangYeShopSellView = class("WangYeShopSellView", ShopSellBaseView)

function WangYeShopSellView:buildUI()
	WangYeShopSellView.super.buildUI(self)

	for i = 1, 4 do
		self._items[i].txtName = self:getTxt(string.format("itemParent/item%d/txtName", i))
	end
end

function WangYeShopSellView:_initViewShow(activityId)
	WangYeShopSellView.super._initViewShow(self, activityId)

	if self._goodsCfg then
		local prizes = MaterialMgr.changeItemStrArr(self._goodsCfg.content)
		local rewardCount = #prizes

		for i = 1, 4 do
			if i <= rewardCount then
				local matType, cfgId = MaterialMgr.getMatParams(prizes[i])

				self._items[i].txtName.text = MaterialMgr.getMaterialsName(matType, cfgId)
			end
		end
	end
end

return WangYeShopSellView
