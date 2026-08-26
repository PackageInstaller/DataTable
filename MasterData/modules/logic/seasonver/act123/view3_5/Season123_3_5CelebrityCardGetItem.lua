-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5CelebrityCardGetItem.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5CelebrityCardGetItem", package.seeall)

local Season123_3_5CelebrityCardGetItem = class("Season123_3_5CelebrityCardGetItem", BaseViewExtended)

function Season123_3_5CelebrityCardGetItem:onInitView()
	self._gorare1 = gohelper.findChild(self.viewGO, "#go_rare1")
	self._gorare2 = gohelper.findChild(self.viewGO, "#go_rare2")
	self._gorare3 = gohelper.findChild(self.viewGO, "#go_rare3")
	self._gorare4 = gohelper.findChild(self.viewGO, "#go_rare4")
	self._gorare5 = gohelper.findChild(self.viewGO, "#go_rare5")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5CelebrityCardGetItem:addEvents()
	return
end

function Season123_3_5CelebrityCardGetItem:removeEvents()
	return
end

function Season123_3_5CelebrityCardGetItem:onRefreshViewParam(uid, noClick, equipId)
	self._uid = uid
	self._noClick = noClick
	self._equipId = equipId
end

function Season123_3_5CelebrityCardGetItem:onOpen()
	self:refreshData(self._uid)
end

function Season123_3_5CelebrityCardGetItem:refreshData(uid)
	local item_id = self:_getItemID(uid)

	self._itemId = item_id

	self:_checkCreateIcon()
	self._icon:updateData(item_id)
	self._icon:setIndexLimitShowState(true)
end

function Season123_3_5CelebrityCardGetItem:_checkCreateIcon()
	if not self._icon then
		self._icon = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, Season123_3_5CelebrityCardEquip)

		self._icon:setClickCall(self.onBtnClick, self)

		if self._noClick then
			local canvasGroup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))

			canvasGroup.interactable = false
			canvasGroup.blocksRaycasts = false
		end
	end
end

function Season123_3_5CelebrityCardGetItem:onBtnClick()
	if self._noClick then
		return
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Season123EquipCard, self._itemId)
end

function Season123_3_5CelebrityCardGetItem:_getItemID(uid)
	local item_id
	local parent_view = self:getParentView()

	if parent_view and parent_view.isItemID and parent_view:isItemID() then
		item_id = uid
	else
		local actId = Season123Model.instance:getCurSeasonId()
		local tar_equip = Season123Model.instance:getAllItemMo(actId)

		item_id = tar_equip[uid] and tar_equip[uid].itemId
	end

	item_id = self._equipId or item_id

	return item_id
end

function Season123_3_5CelebrityCardGetItem:onClose()
	return
end

function Season123_3_5CelebrityCardGetItem:onDestroyView()
	if self._icon then
		self._icon:setClickCall(nil, nil)
		self._icon:disposeUI()
	end
end

return Season123_3_5CelebrityCardGetItem
