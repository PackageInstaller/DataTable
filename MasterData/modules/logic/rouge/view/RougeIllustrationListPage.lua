-- chunkname: @modules/logic/rouge/view/RougeIllustrationListPage.lua

module("modules.logic.rouge.view.RougeIllustrationListPage", package.seeall)

local RougeIllustrationListPage = class("RougeIllustrationListPage", ListScrollCellExtend)

function RougeIllustrationListPage:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeIllustrationListPage:addEvents()
	return
end

function RougeIllustrationListPage:removeEvents()
	return
end

function RougeIllustrationListPage:_editableInitView()
	self._goList = self:getUserDataTb_()
	self._itemList = self:getUserDataTb_()

	for i = 1, RougeEnum.IllustrationNumOfPage do
		self._goList[i] = gohelper.findChild(self.viewGO, tostring(i))
	end
end

function RougeIllustrationListPage:_getItem(index)
	local item = self._itemList[index]

	if not item then
		local go = self._goList[index]
		local path = self._view.viewContainer._viewSetting.otherRes[2]
		local itemGo = self._view.viewContainer:getResInst(path, go)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, RougeIllustrationListItem)
		self._itemList[index] = item
	end

	return item
end

function RougeIllustrationListPage:_editableAddEvents()
	return
end

function RougeIllustrationListPage:_editableRemoveEvents()
	return
end

function RougeIllustrationListPage:onUpdateMO(mo)
	gohelper.setActive(self.viewGO, not mo.isSplitSpace)

	if mo.isSplitSpace then
		return
	end

	for i = 1, RougeEnum.IllustrationNumOfPage do
		local itemMo = mo[i]
		local go = self._goList[i]

		gohelper.setActive(go, itemMo ~= nil)

		if itemMo then
			local item = self:_getItem(i)

			item:onUpdateMO(itemMo)
		end
	end
end

function RougeIllustrationListPage:onSelect(isSelect)
	return
end

function RougeIllustrationListPage:onDestroyView()
	return
end

return RougeIllustrationListPage
