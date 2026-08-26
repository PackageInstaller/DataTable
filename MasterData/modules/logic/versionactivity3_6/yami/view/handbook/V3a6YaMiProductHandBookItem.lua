-- chunkname: @modules/logic/versionactivity3_6/yami/view/handbook/V3a6YaMiProductHandBookItem.lua

module("modules.logic.versionactivity3_6.yami.view.handbook.V3a6YaMiProductHandBookItem", package.seeall)

local V3a6YaMiProductHandBookItem = class("V3a6YaMiProductHandBookItem", V3a6YaMiProductItem)

function V3a6YaMiProductHandBookItem:_btnclickOnClick()
	self._listModel:selectCell(self._index, true)
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onSelectHandbookProduct, self._mo.id)

	if self._mo.isNew and not self._mo.isLock then
		self._mo:refreshNewTag(false)
	end
end

function V3a6YaMiProductHandBookItem:_editableInitView()
	self._listModel = V3a6YaMiProductHandbookListModel.instance
end

return V3a6YaMiProductHandBookItem
