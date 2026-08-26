-- chunkname: @modules/logic/character/view/CharacterBackpackSearchFilterView.lua

module("modules.logic.character.view.CharacterBackpackSearchFilterView", package.seeall)

local CharacterBackpackSearchFilterView = class("CharacterBackpackSearchFilterView", BaseView)

function CharacterBackpackSearchFilterView:onInitView()
	self._btnclosefilterview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closefilterview")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "container/#btn_reset")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "container/#btn_confirm")
	self._goEditorbtn = gohelper.findChild(self.viewGO, "container/Btns")
	self._btnSave = gohelper.findChildButtonWithAudio(self.viewGO, "container/Btns/#btn_Save")
	self._btnCancel = gohelper.findChildButtonWithAudio(self.viewGO, "container/Btns/#btn_Cancel")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterBackpackSearchFilterView:addEvents()
	self._btnclosefilterview:AddClickListener(self._btnclosefilterviewOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnSave:AddClickListener(self._btnSaveOnClick, self)
	self._btnCancel:AddClickListener(self._btnCancelOnClick, self)
end

function CharacterBackpackSearchFilterView:removeEvents()
	self._btnclosefilterview:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function CharacterBackpackSearchFilterView:_btnSaveOnClick()
	self:_onCloseEditor(true)
end

function CharacterBackpackSearchFilterView:_btnCancelOnClick()
	self:_onCloseEditor()
end

function CharacterBackpackSearchFilterView:_btnclosefilterviewOnClick()
	self:closeThis()
end

function CharacterBackpackSearchFilterView:_btnresetOnClick()
	for i = 1, CharacterBackpackEnum.dmgItemCount do
		self._selectDmgs[i] = false
	end

	for i = 1, CharacterBackpackEnum.attrItemCount do
		self._selectAttrs[i] = false
	end

	self._selectDestiny = nil

	CharacterSearchFilterModel.instance:clearSelectTag()
	self:_refreshView()
end

function CharacterBackpackSearchFilterView:_btnconfirmOnClick()
	local dmgs, careers = CharacterSearchFilterModel.instance:onComfirmSearchFilter(self._selectDmgs, self._selectAttrs)

	CharacterSearchFilterModel.instance:setSelectDestiny(self._selectDestiny)

	local filterParam = {}

	filterParam.dmgs = dmgs
	filterParam.destiny = self._selectDestiny
	filterParam.careers = careers

	CharacterModel.instance:filterCardListByDmgAndCareer(filterParam, false, self._filterType)

	local param = {}

	param.dmgs = self._selectDmgs
	param.attrs = self._selectAttrs
	param.dmgs1 = dmgs
	param.careers1 = careers
	param.destiny = self._selectDestiny

	CharacterController.instance:dispatchEvent(CharacterEvent.FilterBackpack, param)
	self:closeThis()
end

function CharacterBackpackSearchFilterView:_editableInitView()
	self._dmgItems = self:getUserDataTb_()
	self._destinyItems = self:getUserDataTb_()
	self._attrItems = self:getUserDataTb_()
	self._dmgContainer = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/dmgContainer")

	for i = 1, CharacterBackpackEnum.dmgItemCount do
		local go = gohelper.findChild(self._dmgContainer, "#go_dmg" .. i)
		local item = self:_getItem(go)

		item.click:AddClickListener(self._dmgBtnOnClick, self, i)
		table.insert(self._dmgItems, item)
	end

	self._destinyContainer = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/destinyContainer")

	for i = 1, CharacterBackpackEnum.destinyItemCount do
		local go = gohelper.findChild(self._destinyContainer, "#go_tag" .. i)
		local item = self:_getItem(go)

		item.click:AddClickListener(self._destinyBtnOnClick, self, i)
		table.insert(self._destinyItems, item)
	end

	self._attrContainer = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/attrContainer")

	for i = 1, CharacterBackpackEnum.attrItemCount do
		local go = gohelper.findChild(self._attrContainer, "#go_attr" .. i)
		local item = self:_getItem(go)

		item.click:AddClickListener(self._attrBtnOnClick, self, i)
		table.insert(self._attrItems, item)
	end

	self._scroll = gohelper.findChildScrollRect(self.viewGO, "container/Scroll View")
	self._tagItems = self:getUserDataTb_()
	self._editorTag = self:getUserDataTb_()
	self._tagRoot = self:getUserDataTb_()
	self._editorTags = {}
	self._readyAddLowTag = {}

	for _, type in pairs(CharacterBackpackEnum.LocalTags) do
		self._tagRoot[type] = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/container" .. type + 1)
	end

	self._tagRoot[CharacterBackpackEnum.TagId.CharacterFeaturesLow] = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/container5")
	self._tagPrefab = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/#go_tag")
	self._goEditor = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/Edit")

	local goeditorItem = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/container5/#go_Edit")

	self._editorItem = self:_getItem(goeditorItem)

	self._editorItem.click:AddClickListener(self._onClickEditor, self)
	gohelper.setActive(self._tagPrefab, false)
	gohelper.setActive(self._goEditor, false)
	gohelper.setActive(self._goEditorbtn, false)
end

function CharacterBackpackSearchFilterView:_getLocalTagItem(id, root)
	local item = self._tagItems[id]

	if not item then
		local type = CharacterSearchFilterModel.instance:getTagTypeById(id)
		local go = gohelper.clone(self._tagPrefab, root)

		item = self:_getItem(go)
		item.goPlus = gohelper.findChild(go, "selected/#go_Plus")
		item.goMinus = gohelper.findChild(go, "selected/#go_Minus")
		item.type = type
		item.id = id
		item.go.name = "tag_" .. id

		item.click:AddClickListener(self._onClickLocalTag, self, item)

		self._tagItems[id] = item
	end

	return item
end

function CharacterBackpackSearchFilterView:_getItem(go)
	local item = self:getUserDataTb_()

	item.go = go
	item.unselected = gohelper.findChild(go, "unselected")
	item.selected = gohelper.findChild(go, "selected")
	item.txtunselected = gohelper.findChildText(go, "unselected/info1")
	item.txtselected = gohelper.findChildText(go, "selected/info2")
	item.click = gohelper.findChildButtonWithAudio(go, "click")
	item.canvasGroup = gohelper.onceAddComponent(go, typeof(UnityEngine.CanvasGroup))

	return item
end

function CharacterBackpackSearchFilterView:_onClickLocalTag(item)
	if self._isEditing then
		if item.type == CharacterBackpackEnum.TagId.CharacterFeaturesLow then
			local isEditorTags = self:_isAddLowTag(item.id)

			if isEditorTags then
				if not self._goEditor then
					local root = self._tagRoot[item.type]

					gohelper.addChildPosStay(root, item.go)
					gohelper.setActive(item.goPlus, isEditorTags)
					gohelper.setActive(item.goMinus, not isEditorTags)

					self._readyAddLowTag[item.id] = not isEditorTags

					gohelper.setAsLastSibling(self._editorItem.go)
					TaskDispatcher.runDelay(self._refreshScrollVNP, self, 0)
				end
			end
		end
	else
		local select = CharacterSearchFilterModel.instance:selectLocalTag(item.id)

		gohelper.setActive(item.selected, select)
		gohelper.setActive(item.unselected, not select)
	end
end

function CharacterBackpackSearchFilterView:_onClickEditor()
	if not self._isEditing then
		self:_onOpenEditor()
	end
end

function CharacterBackpackSearchFilterView:_refreshScrollVNP()
	self._scroll.verticalNormalizedPosition = 0
end

function CharacterBackpackSearchFilterView:_onCloseEditor(isSave)
	for id, isAdd in pairs(self._readyAddLowTag) do
		if isSave then
			if isAdd ~= self._editorTags[id] then
				self._editorTags[id] = isAdd

				CharacterSearchFilterModel.instance:addEditorLowTags(id, isAdd)
			end
		else
			local item = self._tagItems[id]

			if item then
				local type = CharacterBackpackEnum.TagId.CharacterFeaturesLow

				if self._editorTags[id] then
					if not self._tagRoot[type] then
						local root = self._goEditor

						gohelper.addChildPosStay(root, item.go)
					end
				end
			end
		end
	end

	if isSave then
		CharacterSearchFilterModel.instance:saveEditorTags()
	end

	self._readyAddLowTag = {}

	gohelper.setActive(self._goEditor, false)
	gohelper.setActive(self._editorItem.go, true)
	gohelper.setActive(self._goEditorbtn, false)

	self._isEditing = false

	self:_refreshEditor()
	CharacterSearchFilterModel.instance:setEditing(false)
	gohelper.setAsLastSibling(self._editorItem.go)
end

function CharacterBackpackSearchFilterView:_onOpenEditor()
	gohelper.setActive(self._goEditor, true)
	gohelper.setActive(self._goEditorbtn, true)
	gohelper.setActive(self._editorItem.go, false)
	TaskDispatcher.runDelay(self._refreshScrollVNP, self, 0)

	self._isEditing = true

	self:_refreshEditor()
	CharacterSearchFilterModel.instance:setEditing(true)
end

function CharacterBackpackSearchFilterView:_refreshEditor()
	local alpha = self._isEditing and 0.5 or 1

	for _, item in pairs(self._dmgItems) do
		local isSelect = CharacterSearchFilterModel.instance:isSelectLocalTag(item.id)

		item.canvasGroup.alpha = isSelect and 1 or alpha
	end

	for i, item in pairs(self._destinyItems) do
		local isSelect = CharacterSearchFilterModel.instance:getSelectDestiny() == i

		item.canvasGroup.alpha = isSelect and 1 or alpha
	end

	for _, item in pairs(self._attrItems) do
		local isSelect = CharacterSearchFilterModel.instance:isSelectLocalTag(item.id)

		item.canvasGroup.alpha = isSelect and 1 or alpha
	end

	for _, item in pairs(self._tagItems) do
		self:_refreshLocalTagStatus(item)
	end
end

function CharacterBackpackSearchFilterView:_attrBtnOnClick(i)
	if not self._isEditing then
		self._selectAttrs[i] = not self._selectAttrs[i]

		self:_refreshView()
	end
end

function CharacterBackpackSearchFilterView:_dmgBtnOnClick(i)
	if not self._isEditing then
		if not self._selectDmgs[i] then
			self._selectDmgs[3 - i] = self._selectDmgs[i]
		end

		self._selectDmgs[i] = not self._selectDmgs[i]

		self:_refreshView()
	end
end

function CharacterBackpackSearchFilterView:_destinyBtnOnClick(i)
	if not self._isEditing then
		if self._selectDestiny == i then
			self._selectDestiny = nil
		else
			self._selectDestiny = i
		end

		self:_refreshView()
	end
end

function CharacterBackpackSearchFilterView:onUpdateParam()
	return
end

function CharacterBackpackSearchFilterView:onOpen()
	self._selectDmgs = self.viewParam and self.viewParam.dmgs
	self._selectDestiny = self.viewParam and self.viewParam.destiny
	self._selectAttrs = self.viewParam and self.viewParam.attrs

	if not self._selectDmgs then
		self._selectDmgs = {}

		local dmgs = CharacterSearchFilterModel.instance:getSelectDmgs()

		for _, dmg in ipairs(dmgs) do
			self._selectDmgs[dmg] = true
		end
	end

	self._selectDestiny = self._selectDestiny or CharacterSearchFilterModel.instance:getSelectDestiny()

	if not self._selectAttrs then
		self._selectAttrs = {}

		local attrs = CharacterSearchFilterModel.instance:getSelectAttrs()

		for _, attr in ipairs(attrs) do
			self._selectAttrs[attr] = true
		end
	end

	if self.viewParam then
		self._filterType = self.viewParam.filterType or CharacterEnum.FilterType.BackpackHero
	end

	self._isEditing = CharacterSearchFilterModel.instance:isEditing()

	if self._isEditing then
		self._readyAddLowTag = CharacterSearchFilterModel.instance:getReadyAddLowTags()

		self:_onOpenEditor()
	end

	self:_refreshView()
end

function CharacterBackpackSearchFilterView:_refreshView()
	for i, item in ipairs(self._dmgItems) do
		local select = self._selectDmgs[i]

		gohelper.setActive(item.selected, select)
		gohelper.setActive(item.unselected, not select)
	end

	for i, item in ipairs(self._destinyItems) do
		local select = self._selectDestiny == i

		gohelper.setActive(item.selected, select)
		gohelper.setActive(item.unselected, not select)
	end

	for i, item in ipairs(self._attrItems) do
		local select = self._selectAttrs[i]

		gohelper.setActive(item.selected, select)
		gohelper.setActive(item.unselected, not select)
	end

	self:_refreshShowLocalTag()
end

function CharacterBackpackSearchFilterView:_refreshShowLocalTag()
	local addLowTags = CharacterSearchFilterModel.instance:getAddLowTags()

	self._editorTags = {}

	if addLowTags then
		for i, id in ipairs(addLowTags) do
			self._editorTags[id] = true
		end

		for _, type in pairs(CharacterBackpackEnum.LocalTags) do
			local tagCos = CharacterSearchFilterModel.instance:getLocalTags(type)

			if tagCos then
				for _, co in ipairs(tagCos) do
					self:_refreshLocalTag(co, self._tagRoot[type])
				end
			end
		end
	end

	local lowTagCos = CharacterSearchFilterModel.instance:getLocalTags(CharacterBackpackEnum.TagId.CharacterFeaturesLow)

	if lowTagCos then
		for i, co in ipairs(lowTagCos) do
			local isEditorTags = self:_isAddLowTag(co.id)
			local type = CharacterBackpackEnum.TagId.CharacterFeaturesLow

			if isEditorTags then
				if not self._tagRoot[type] then
					local root = self._goEditor

					self:_refreshLocalTag(co, root)
				end
			end
		end
	end

	gohelper.setAsLastSibling(self._editorItem.go)
end

function CharacterBackpackSearchFilterView:_isAddLowTag(tagId)
	local isEditorTags = self._editorTags[tagId]

	if isEditorTags then
		if self._readyAddLowTag[tagId] == false then
			return false
		end
	elseif self._readyAddLowTag[tagId] then
		return true
	end

	return isEditorTags
end

function CharacterBackpackSearchFilterView:_refreshLocalTag(co, root)
	root = root or self._goEditor

	local id = co.id
	local item = self:_getLocalTagItem(id, root)

	self:_refreshLocalTagStatus(item)

	item.txtunselected.text = co.tagName
	item.txtselected.text = co.tagName
end

function CharacterBackpackSearchFilterView:_refreshLocalTagStatus(item)
	local id = item.id
	local select = CharacterSearchFilterModel.instance:isSelectLocalTag(id)
	local isLow = item.type == CharacterBackpackEnum.TagId.CharacterFeaturesLow

	if self._isEditing then
		local isCanEditor = isLow
		local isEditorTags = self:_isAddLowTag(id)

		gohelper.setActive(item.selected, isCanEditor or select)
		gohelper.setActive(item.unselected, not isCanEditor and not select)
		gohelper.setActive(item.goPlus, isCanEditor and not isEditorTags)
		gohelper.setActive(item.goMinus, isCanEditor and isEditorTags)
		gohelper.setActive(item.go, true)

		item.canvasGroup.alpha = (isLow or not self._isEditing) and 1 or 0.5
	end
end

function CharacterBackpackSearchFilterView:onClose()
	if self._isEditing then
		CharacterSearchFilterModel.instance:cacheReadyAddLowTags(self._readyAddLowTag)
	end
end

function CharacterBackpackSearchFilterView:onDestroyView()
	for _, item in pairs(self._dmgItems) do
		item.click:RemoveClickListener()
	end

	for _, item in pairs(self._destinyItems) do
		item.click:RemoveClickListener()
	end

	for _, item in pairs(self._attrItems) do
		item.click:RemoveClickListener()
	end

	for _, item in pairs(self._tagItems) do
		item.click:RemoveClickListener()
	end

	self._editorItem.click:RemoveClickListener()
	TaskDispatcher.cancelTask(self._refreshScrollVNP, self)
end

return CharacterBackpackSearchFilterView
