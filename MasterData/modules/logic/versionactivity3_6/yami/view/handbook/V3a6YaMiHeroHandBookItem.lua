-- chunkname: @modules/logic/versionactivity3_6/yami/view/handbook/V3a6YaMiHeroHandBookItem.lua

module("modules.logic.versionactivity3_6.yami.view.handbook.V3a6YaMiHeroHandBookItem", package.seeall)

local V3a6YaMiHeroHandBookItem = class("V3a6YaMiHeroHandBookItem", V3a6YaMiHeroItem)

function V3a6YaMiHeroHandBookItem:_btnclickOnClick()
	self._listModel:selectCell(self._index, true)
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onSelectHandbookHero, self._mo.id)

	if self._mo.isNew and not self._mo.isLock then
		self._mo:refreshNewTag(false)
	end
end

function V3a6YaMiHeroHandBookItem:onUpdateMO(mo)
	self.viewContainer = self._view.viewContainer

	V3a6YaMiHeroHandBookItem.super.onUpdateMO(self, mo)
end

function V3a6YaMiHeroHandBookItem:_editableInitView()
	self._listModel = V3a6YaMiHeroHandbookListModel.instance

	V3a6YaMiHeroHandBookItem.super._editableInitView(self)
end

return V3a6YaMiHeroHandBookItem
