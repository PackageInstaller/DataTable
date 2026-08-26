-- chunkname: @modules/logic/rouge/view/RougeCollectionListRow.lua

module("modules.logic.rouge.view.RougeCollectionListRow", package.seeall)

local RougeCollectionListRow = class("RougeCollectionListRow", ListScrollCellExtend)

function RougeCollectionListRow:onInitView()
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#go_title/#txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "#go_title/#txt_Title/#txt_TitleEn")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_title/#image_icon")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "#go_collectionitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionListRow:addEvents()
	return
end

function RougeCollectionListRow:removeEvents()
	return
end

function RougeCollectionListRow:_editableInitView()
	gohelper.setActive(self._gocollectionitem, false)
	gohelper.setActive(self._txtTitleEn, false)

	self._itemList = self:getUserDataTb_()

	for i = 1, RougeEnum.CollectionListRowNum do
		local go = gohelper.cloneInPlace(self._gocollectionitem)
		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, RougeCollectionListItem)

		table.insert(self._itemList, comp)
	end

	self._gridLayout = self.viewGO:GetComponentInChildren(gohelper.Type_GridLayoutGroup)
end

function RougeCollectionListRow:_editableAddEvents()
	return
end

function RougeCollectionListRow:_editableRemoveEvents()
	return
end

function RougeCollectionListRow:onUpdateMO(mo)
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

	local tagConfig = RougeCollectionConfig.instance:getTagConfig(mo.type)

	if not tagConfig then
		return
	end

	self._txtTitle.text = tagConfig.name

	UISpriteSetMgr.instance:setRougeSprite(self._imageicon, tagConfig.iconUrl)
end

function RougeCollectionListRow:onSelect(isSelect)
	return
end

function RougeCollectionListRow:onDestroyView()
	return
end

return RougeCollectionListRow
