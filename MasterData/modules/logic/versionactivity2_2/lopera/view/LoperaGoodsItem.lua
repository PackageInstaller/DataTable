-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaGoodsItem.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaGoodsItem", package.seeall)

local LoperaGoodsItem = class("LoperaGoodsItem", ListScrollCellExtend)

function LoperaGoodsItem:onInitView()
	self._imageicon = gohelper.findChildImage(self.viewGO, "#image_Icon")
	self._iconBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#image_Icon")
	self._numText = gohelper.findChildText(self.viewGO, "image_NumBG/#txt_Num")
	self._goNewFlag = gohelper.findChild(self.viewGO, "#go_New")
	self._canvasGroup = self.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LoperaGoodsItem:addEvents()
	if self._iconBtn then
		self._iconBtn:AddClickListener(self._iconBtnClick, self)
	end
end

function LoperaGoodsItem:removeEvents()
	if self._iconBtn then
		self._iconBtn:RemoveClickListener()
	end
end

function LoperaGoodsItem:_iconBtnClick()
	if self._itemCount > 0 then
		gohelper.setActive(self._goNewFlag, false)
	end

	LoperaController.instance:dispatchEvent(LoperaEvent.GoodItemClick, self._idx)
end

function LoperaGoodsItem:_editableInitView()
	return
end

function LoperaGoodsItem:_editableAddEvents()
	return
end

function LoperaGoodsItem:_editableRemoveEvents()
	return
end

function LoperaGoodsItem:onUpdateMO(mo)
	self._mo = mo

	self:setItemId(mo.itemId)

	if (mo.quantity or mo.getQuantity) and not mo.quantity then
		local quantity = mo:getQuantity()
	end
end

function LoperaGoodsItem:onUpdateData(itemCfg, itemCount, idx, params)
	self._cfg = itemCfg
	self._idx = idx
	self._itemCount = itemCount
	self._numText.text = itemCount

	local showNewFlag = false

	if params and params.showNewFlag then
		showNewFlag = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_2LoperaItemNewFlag .. itemCfg.itemId, 0) == 0 and itemCount > 0
	end

	gohelper.setActive(self._goNewFlag, showNewFlag)

	if showNewFlag then
		GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Version2_2LoperaItemNewFlag .. self._cfg.itemId, 1)
	end

	self:_refreshIcon(itemCfg.itemId, itemCfg)

	if self._canvasGroup then
		self._canvasGroup.alpha = itemCount > 0 and 1 or 0.5
	end
end

function LoperaGoodsItem:setItemId(itemId)
	self._itemId = itemId

	self:_refreshIcon(itemId)
end

function LoperaGoodsItem:setShowCount(isShow, bgEnabled)
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

function LoperaGoodsItem:setCountStr(countStr)
	self._txtcount.text = countStr
end

function LoperaGoodsItem:_refreshIcon(itemId, itemCfg)
	itemCfg = itemCfg or Activity168Config.instance:getGameItemCfg(VersionActivity2_2Enum.ActivityId.Lopera, itemId)

	UISpriteSetMgr.instance:setLoperaItemSprite(self._imageicon, itemCfg.icon, false)
end

function LoperaGoodsItem:onDestroyView()
	return
end

LoperaGoodsItem.prefabPath = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_goodsitem_temporary.prefab"
LoperaGoodsItem.prefabPath2 = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_goodsitem2_temporary.prefab"
LoperaGoodsItem.prefabPath3 = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_goodsitem3_temporary.prefab"

return LoperaGoodsItem
