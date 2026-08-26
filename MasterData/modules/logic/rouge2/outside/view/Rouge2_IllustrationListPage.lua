-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_IllustrationListPage.lua

module("modules.logic.rouge2.outside.view.Rouge2_IllustrationListPage", package.seeall)

local Rouge2_IllustrationListPage = class("Rouge2_IllustrationListPage", ListScrollCellExtend)

function Rouge2_IllustrationListPage:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_IllustrationListPage:addEvents()
	return
end

function Rouge2_IllustrationListPage:removeEvents()
	return
end

function Rouge2_IllustrationListPage:_editableInitView()
	self._goList = self:getUserDataTb_()
	self._itemList = self:getUserDataTb_()

	for i = 1, Rouge2_OutsideEnum.IllustrationNumOfPage do
		self._goList[i] = gohelper.findChild(self.viewGO, tostring(i))
	end
end

function Rouge2_IllustrationListPage:_getItem(index)
	local item = self._itemList[index]

	if not item then
		local go = self._goList[index]
		local path = self._view.viewContainer._viewSetting.otherRes[2]
		local itemGo = self._view.viewContainer:getResInst(path, go)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, Rouge2_IllustrationListItem)
		self._itemList[index] = item
	end

	return item
end

function Rouge2_IllustrationListPage:_editableAddEvents()
	return
end

function Rouge2_IllustrationListPage:_editableRemoveEvents()
	return
end

function Rouge2_IllustrationListPage:onUpdateMO(mo)
	for i = 1, Rouge2_OutsideEnum.IllustrationNumOfPage do
		local itemMo = mo[i]
		local go = self._goList[i]

		gohelper.setActive(go, itemMo ~= nil)

		if itemMo then
			local item = self:_getItem(i)

			item:onUpdateMO(itemMo)
		end
	end
end

function Rouge2_IllustrationListPage:onSelect(isSelect)
	return
end

function Rouge2_IllustrationListPage:onDestroyView()
	return
end

return Rouge2_IllustrationListPage
