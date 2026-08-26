-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaGoodsItem.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaGoodsItem", package.seeall)

local AiZiLaGoodsItem = class("AiZiLaGoodsItem", ListScrollCellExtend)

function AiZiLaGoodsItem:onInitView()
	self._imagerare = gohelper.findChildImage(self.viewGO, "#image_rare")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#image_icon")
	self._imageselected = gohelper.findChildImage(self.viewGO, "#image_selected")
	self._gocount = gohelper.findChild(self.viewGO, "#go_count")
	self._txtcount = gohelper.findChildText(self.viewGO, "#go_count/#txt_count")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._goredPoint = gohelper.findChild(self.viewGO, "#go_redPiont")
	self._imagecountBG = gohelper.findChildImage(self.viewGO, "#go_count")
	self._singleicon = gohelper.findChildSingleImage(self.viewGO, "#image_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaGoodsItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function AiZiLaGoodsItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function AiZiLaGoodsItem:_btnclickOnClick()
	if self._itemId then
		MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.V1a5AiZiLa, self._itemId)
	end
end

function AiZiLaGoodsItem:_editableInitView()
	gohelper.setActive(self._imageselected, false)
	self:setShowCount(true)
end

function AiZiLaGoodsItem:_editableAddEvents()
	return
end

function AiZiLaGoodsItem:_editableRemoveEvents()
	return
end

function AiZiLaGoodsItem:onUpdateMO(mo)
	self._mo = mo

	self:setItemId(mo.itemId)

	if mo.quantity or mo.getQuantity then
		if not mo.quantity then
			local quantity = mo:getQuantity()

			self:setCountStr(quantity)
		end
	end
end

function AiZiLaGoodsItem:onSelect(isSelect)
	gohelper.setActive(self._imageselected, isSelect)
end

function AiZiLaGoodsItem:setItemId(itemId)
	self._itemId = itemId

	self:_refreshIcon(itemId)
end

function AiZiLaGoodsItem:setShowCount(isShow, bgEnabled)
	if self._isShow ~= isShow then
		self._isShow = isShow

		gohelper.setActive(self._gocount, isShow)
	end

	if bgEnabled == true then
		self._imagecountBG.enabled = true
	elseif bgEnabled == false then
		self._imagecountBG.enabled = false
	end
end

function AiZiLaGoodsItem:setCountStr(countStr)
	self._txtcount.text = countStr
end

function AiZiLaGoodsItem:_refreshIcon(itemId)
	itemId = itemId or self._itemId

	if itemId ~= self._lastItemId then
		local cfg = AiZiLaConfig.instance:getItemCo(itemId)

		if cfg then
			self._lastItemId = itemId

			self._singleicon:LoadImage(ResUrl.getV1a5AiZiLaItemIcon(cfg.icon))
			UISpriteSetMgr.instance:setV1a5AiZiLaSprite(self._imagerare, AiZiLaEnum.RareIcon[cfg.rare])
		end
	end
end

function AiZiLaGoodsItem:onDestroyView()
	self._singleicon:UnLoadImage()
end

AiZiLaGoodsItem.prefabPath = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_goodsitem.prefab"
AiZiLaGoodsItem.prefabPath2 = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_goodsitem2.prefab"

return AiZiLaGoodsItem
