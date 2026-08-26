-- chunkname: @modules/logic/versionactivity3_6/yami/view/common/V3a6YaMiProductItem.lua

module("modules.logic.versionactivity3_6.yami.view.common.V3a6YaMiProductItem", package.seeall)

local V3a6YaMiProductItem = class("V3a6YaMiProductItem", ListScrollCellExtend)

function V3a6YaMiProductItem:onInitView()
	self._simageproductsicon = gohelper.findChildSingleImage(self.viewGO, "root/#simage_productsicon")
	self._imagelevel = gohelper.findChildImage(self.viewGO, "root/#simage_levelicon")
	self._golock = gohelper.findChild(self.viewGO, "root/#go_lock")
	self._simageproductslockicon = gohelper.findChildSingleImage(self.viewGO, "root/#go_lock/#simage_productsicon")
	self._goselect = gohelper.findChild(self.viewGO, "root/#go_select")
	self._goreddot = gohelper.findChild(self.viewGO, "root/#go_reddot")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiProductItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V3a6YaMiProductItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function V3a6YaMiProductItem:_btnclickOnClick()
	return
end

function V3a6YaMiProductItem:_editableInitView()
	return
end

function V3a6YaMiProductItem:_editableAddEvents()
	return
end

function V3a6YaMiProductItem:_editableRemoveEvents()
	return
end

function V3a6YaMiProductItem:onUpdateMO(mo)
	self._mo = mo

	gohelper.setActive(self._golock, mo.isLock)
	gohelper.setActive(self._imagelevel.gameObject, not mo.isLock)

	local ratingCo = V3a6YaMiConfig.instance:getRatingCo(self._mo.rating)

	if ratingCo and not string.nilorempty(ratingCo.icon) then
		UISpriteSetMgr.instance:setV3a6YaMiSprite(self._imagelevel, ratingCo.icon)
	end

	local icon = ResUrl.getV3a6YaMiItemSingleBg(mo.co.icon)

	self._simageproductsicon:LoadImage(icon)
	self._simageproductslockicon:LoadImage(icon)
end

function V3a6YaMiProductItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function V3a6YaMiProductItem:onDestroyView()
	self._simageproductsicon:UnLoadImage()
	self._simageproductslockicon:UnLoadImage()
end

return V3a6YaMiProductItem
