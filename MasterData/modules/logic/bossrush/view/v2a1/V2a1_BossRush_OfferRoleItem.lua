-- chunkname: @modules/logic/bossrush/view/v2a1/V2a1_BossRush_OfferRoleItem.lua

module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_OfferRoleItem", package.seeall)

local V2a1_BossRush_OfferRoleItem = class("V2a1_BossRush_OfferRoleItem", ListScrollCellExtend)

function V2a1_BossRush_OfferRoleItem:onInitView()
	self._imagerare = gohelper.findChildImage(self.viewGO, "role/#image_rare")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "role/#simage_heroicon")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "role/#image_career")
	self._txtname = gohelper.findChildText(self.viewGO, "role/#txt_name")
	self._txtnameEn = gohelper.findChildText(self.viewGO, "role/#txt_name/#txt_nameEn")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._goclick = gohelper.findChild(self.viewGO, "#go_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a1_BossRush_OfferRoleItem:addEvents()
	return
end

function V2a1_BossRush_OfferRoleItem:removeEvents()
	return
end

function V2a1_BossRush_OfferRoleItem:_editableInitView()
	self._uiclick = SLFramework.UGUI.UIClickListener.Get(self._goclick)

	self._uiclick:AddClickListener(self._btnclickOnClick, self)
end

function V2a1_BossRush_OfferRoleItem:_btnclickOnClick()
	BossRushEnhanceRoleViewListModel.instance:setSelect(self._mo.characterId)
end

function V2a1_BossRush_OfferRoleItem:_editableAddEvents()
	return
end

function V2a1_BossRush_OfferRoleItem:_editableRemoveEvents()
	return
end

function V2a1_BossRush_OfferRoleItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshItem()
end

function V2a1_BossRush_OfferRoleItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function V2a1_BossRush_OfferRoleItem:onDestroyView()
	self._simageheroicon:UnLoadImage()
	self._uiclick:RemoveClickListener()
end

function V2a1_BossRush_OfferRoleItem:_refreshItem()
	local heroId = self._mo.characterId
	local heroConfig = HeroConfig.instance:getHeroCO(heroId)
	local skinId = heroConfig.skinId
	local skinConfig = SkinConfig.instance:getSkinCo(skinId)

	self._simageheroicon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))

	self._txtname.text = heroConfig.name
	self._txtnameEn.text = heroConfig.nameEng

	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. heroConfig.career)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. CharacterEnum.Color[heroConfig.rare])
end

return V2a1_BossRush_OfferRoleItem
