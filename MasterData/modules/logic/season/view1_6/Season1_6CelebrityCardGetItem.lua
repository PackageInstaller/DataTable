-- chunkname: @modules/logic/season/view1_6/Season1_6CelebrityCardGetItem.lua

module("modules.logic.season.view1_6.Season1_6CelebrityCardGetItem", package.seeall)

local Season1_6CelebrityCardGetItem = class("Season1_6CelebrityCardGetItem", BaseViewExtended)

function Season1_6CelebrityCardGetItem:onInitView()
	self._gorare1 = gohelper.findChild(self.viewGO, "#go_rare1")
	self._gorare2 = gohelper.findChild(self.viewGO, "#go_rare2")
	self._gorare3 = gohelper.findChild(self.viewGO, "#go_rare3")
	self._gorare4 = gohelper.findChild(self.viewGO, "#go_rare4")
	self._gorare5 = gohelper.findChild(self.viewGO, "#go_rare5")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_6CelebrityCardGetItem:addEvents()
	return
end

function Season1_6CelebrityCardGetItem:removeEvents()
	return
end

function Season1_6CelebrityCardGetItem:onRefreshViewParam(uid, noClick, equipId)
	self._uid = uid
	self._noClick = noClick
	self._equipId = equipId
end

function Season1_6CelebrityCardGetItem:onOpen()
	self:refreshData(self._uid)
end

function Season1_6CelebrityCardGetItem:refreshData(uid)
	local item_id = self:_getItemID(uid)

	self._itemId = item_id

	self:_checkCreateIcon()
	self._icon:updateData(item_id)
end

function Season1_6CelebrityCardGetItem:_checkCreateIcon()
	if not self._icon then
		self._icon = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, Season1_6CelebrityCardEquip)

		self._icon:setClickCall(self.onBtnClick, self)

		if self._noClick then
			local canvasGroup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))

			canvasGroup.interactable = false
			canvasGroup.blocksRaycasts = false
		end
	end
end

function Season1_6CelebrityCardGetItem:onBtnClick()
	if self._noClick then
		return
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.EquipCard, self._itemId)
end

function Season1_6CelebrityCardGetItem:_getItemID(uid)
	local item_id
	local parent_view = self:getParentView()

	if parent_view and parent_view.isItemID and parent_view:isItemID() then
		item_id = uid
	else
		local tar_equip_104 = Activity104Model.instance:getAllItemMo()

		item_id = tar_equip_104[uid] and tar_equip_104[uid].itemId
	end

	item_id = self._equipId or item_id

	return item_id
end

function Season1_6CelebrityCardGetItem:onClose()
	return
end

function Season1_6CelebrityCardGetItem:onDestroyView()
	if self._icon then
		self._icon:setClickCall(nil, nil)
		self._icon:disposeUI()
	end
end

return Season1_6CelebrityCardGetItem
