-- chunkname: @modules/logic/sp02/paomian/shop/view/Sp02_PaoMian_ShopCardView.lua

module("modules.logic.sp02.paomian.shop.view.Sp02_PaoMian_ShopCardView", package.seeall)

local Sp02_PaoMian_ShopCardView = class("Sp02_PaoMian_ShopCardView", StorePlayerCardView)

function Sp02_PaoMian_ShopCardView:_editableInitView()
	Sp02_PaoMian_ShopCardView.super._editableInitView(self)

	self._goBg = gohelper.findChild(self.viewGO, "#bg_effect")

	gohelper.setActive(self._goBg, false)
end

function Sp02_PaoMian_ShopCardView:_showSocialItem()
	Sp02_PaoMian_ShopCardView.super._showSocialItem(self)
	gohelper.setActive(self._socialitem, false)
end

return Sp02_PaoMian_ShopCardView
