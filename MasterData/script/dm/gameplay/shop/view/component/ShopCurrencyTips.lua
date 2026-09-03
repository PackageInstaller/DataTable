-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/component/ShopCurrencyTips.lua

ShopCurrencyTips = class("ShopCurrencyTips", BaseWidget, _M)

local currencyTipsMap = {
	Shop3 = "Shop_Tip1",
	Shop5 = "Shop_Tip3",
	Shop4 = "Shop_Tip2",
	Shop7 = "Shop_Tip4"
}

function ShopCurrencyTips.class:createWidgetNode()
	local resFile = "asset/ui/ShopPopTip.csb"

	return cc.CSLoader:createNode(resFile)
end

function ShopCurrencyTips:initialize(view, shopId)
	super.initialize(self, view)
	self:initSubviews(view, shopId)
end

function ShopCurrencyTips:dispose()
	self._closeView = true

	super.dispose(self)
end

function ShopCurrencyTips:initSubviews(view, shopId)
	self._view = view

	self._view:setVisible(false)

	self._paoImg = view:getChildByFullName("paoimg")

	self:refreshPopTip(shopId)
end

function ShopCurrencyTips:refreshPopTip(shopId)
	local des = currencyTipsMap[tostring(shopId)]

	if des then
		local str = Strings:get(des)
		local label = cc.Label:createWithTTF(str, TTF_FONT_FZYH_R, 18)

		label:setAnchorPoint(0.5, 1)

		local width = label:getContentSize().width

		if width > 165 then
			label:setDimensions(165, 0)
		end

		local height = label:getContentSize().height

		if height <= 24 then
			local newWidth = math.max(85, width + 30)

			self._paoImg:setContentSize(cc.size(newWidth, 70))
			label:setPosition(self._paoImg:getPositionX() + newWidth / 2 - 2, 57)
		else
			self._paoImg:setContentSize(cc.size(195, 100))
			label:setPosition(72, 85)
		end

		label:addTo(self._view)
	else
		self._paoImg:setVisible(false)
	end
end
