-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_MaterialListRow.lua

module("modules.logic.rouge2.outside.view.Rouge2_MaterialListRow", package.seeall)

local Rouge2_MaterialListRow = class("Rouge2_MaterialListRow", ListScrollCellExtend)

function Rouge2_MaterialListRow:onInitView()
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#go_title/#txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "#go_title/#txt_Title/#txt_TitleEn")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_title/#image_icon")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "#go_collectionitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MaterialListRow:addEvents()
	return
end

function Rouge2_MaterialListRow:removeEvents()
	return
end

function Rouge2_MaterialListRow:_editableInitView()
	gohelper.setActive(self._gocollectionitem, false)
	gohelper.setActive(self._txtTitleEn, false)
	gohelper.setActive(self._imageicon, false)

	self._itemList = self:getUserDataTb_()

	for i = 1, Rouge2_OutsideEnum.CollectionListRowNum do
		local go = gohelper.cloneInPlace(self._gocollectionitem)
		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_MaterialListItem)

		table.insert(self._itemList, comp)
	end

	self._gridLayout = self.viewGO:GetComponentInChildren(gohelper.Type_GridLayoutGroup)
end

function Rouge2_MaterialListRow:_editableAddEvents()
	return
end

function Rouge2_MaterialListRow:_editableRemoveEvents()
	return
end

function Rouge2_MaterialListRow:onUpdateMO(mo)
	self._mo = mo

	for i, v in ipairs(self._itemList) do
		v:onUpdateMO(mo[i])
	end

	local isShowTitle = mo.type ~= nil

	gohelper.setActive(self._gotitle, isShowTitle)

	local padding = self._gridLayout.padding

	padding.top = isShowTitle and 61 or 0
	self._gridLayout.padding = padding

	if not isShowTitle then
		return
	end

	local langName = "p_rouge2illustrated_txt_type" .. mo.type
	local title = luaLang(langName)

	if not title then
		return
	end

	self._txtTitle.text = title
end

function Rouge2_MaterialListRow:onSelect(isSelect)
	return
end

function Rouge2_MaterialListRow:onDestroyView()
	return
end

return Rouge2_MaterialListRow
