-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/V3a6YaMiSelectHeroHandbookItem.lua

module("modules.logic.versionactivity3_6.yami.view.game.V3a6YaMiSelectHeroHandbookItem", package.seeall)

local V3a6YaMiSelectHeroHandbookItem = class("V3a6YaMiSelectHeroHandbookItem", V3a6YaMiSelectHeroItem)

function V3a6YaMiSelectHeroHandbookItem:_btnclickOnClick()
	local selectIndex = V3a6YaMiHeroHandbookListModel.instance:getSelectIndex()

	if self._mo.isLock then
		-- block empty
	else
		self._view.viewContainer:onEquipHero(self._mo.id, selectIndex == self._index)
	end

	if selectIndex == self._index then
		V3a6YaMiHeroHandbookListModel.instance:setSelectIndex()
	else
		V3a6YaMiHeroHandbookListModel.instance:setSelectIndex(self._index)
	end

	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onSelectHeroHandbook, self._mo.id)
	self:_refreshSelect(selectIndex ~= self._index)
end

function V3a6YaMiSelectHeroHandbookItem:onUpdateMO(mo)
	self.viewContainer = self._view.viewContainer

	V3a6YaMiSelectHeroHandbookItem.super.onUpdateMO(self, mo)

	local index = self._view.viewContainer:getIndexEquipedHero(mo.id)
	local isEquip = index ~= nil and not mo.isLock

	gohelper.setActive(self._goselectNum, isEquip)

	if index then
		self._txtselectNum.text = index
	end

	local selectIndex = V3a6YaMiHeroHandbookListModel.instance:getSelectIndex()

	self:_refreshSelect(selectIndex == self._index)
end

function V3a6YaMiSelectHeroHandbookItem:_refreshSelect(isSelect)
	local equipindex = self._view.viewContainer:getIndexEquipedHero(self._mo.id)
	local isEquip = equipindex ~= nil and not self._mo.isLock

	gohelper.setActive(self._goselectNum, isEquip)
	gohelper.setActive(self._goselect, isSelect and not isEquip)
end

function V3a6YaMiSelectHeroHandbookItem:_editableInitView()
	V3a6YaMiSelectHeroHandbookItem.super._editableInitView(self)

	self._txtselectNum = gohelper.findChildText(self._goselectNum, "#txt_num")
	self._imgselect = gohelper.findChildImage(self.viewGO, "root/#go_select")

	local color = self._imgselect.color

	color.a = 0.5
	self._imgselect.color = color
end

return V3a6YaMiSelectHeroHandbookItem
