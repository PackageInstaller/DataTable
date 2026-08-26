-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_SearchFilterView.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_SearchFilterView", package.seeall)

local V3a9_BossRush_SearchFilterView = class("V3a9_BossRush_SearchFilterView", CharacterBackpackSearchFilterView)

function V3a9_BossRush_SearchFilterView:_editableInitView()
	self._dmgItems = self:getUserDataTb_()
	self._destinyItems = self:getUserDataTb_()
	self._attrItems = self:getUserDataTb_()
	self._godmg = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/#go_dmg")
	self._dmgContainer = gohelper.findChild(self._godmg, "dmgContainer")

	for i = 1, CharacterBackpackEnum.dmgItemCount do
		local go = gohelper.findChild(self._dmgContainer, "#go_dmg" .. i)
		local item = self:_getItem(go)

		item.click:AddClickListener(self._dmgBtnOnClick, self, i)
		table.insert(self._dmgItems, item)
	end

	gohelper.setActive(self._godmg, false)

	self._godestiny = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/#go_destiny")
	self._destinyContainer = gohelper.findChild(self._godestiny, "destinyContainer")

	for i = 1, CharacterBackpackEnum.destinyItemCount do
		local go = gohelper.findChild(self._destinyContainer, "#go_tag" .. i)
		local item = self:_getItem(go)

		item.click:AddClickListener(self._destinyBtnOnClick, self, i)
		table.insert(self._destinyItems, item)
	end

	gohelper.setActive(self._godestiny, false)

	self._goattr = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/#go_attr")
	self._attrContainer = gohelper.findChild(self._goattr, "attrContainer")

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
	self._gotagcontainer = self:getUserDataTb_()
	self._editorTags = {}
	self._readyAddLowTag = {}

	for _, type in pairs(CharacterBackpackEnum.LocalTags) do
		self._gotagcontainer[type] = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/#go_container" .. type + 1)
		self._tagRoot[type] = gohelper.findChild(self._gotagcontainer[type], "container" .. type + 1)
	end

	self._tagRoot[CharacterBackpackEnum.TagId.CharacterFeaturesLow] = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/#go_container5/container5")
	self._tagPrefab = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/#go_tag")
	self._goEditor = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/Edit")

	local goeditorItem = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/Content/#go_container5/container5/#go_Edit")

	self._editorItem = self:_getItem(goeditorItem)

	self._editorItem.click:AddClickListener(self._onClickEditor, self)
	gohelper.setActive(self._tagPrefab, false)
	gohelper.setActive(self._goEditor, false)
	gohelper.setActive(self._goEditorbtn, false)
	gohelper.setActive(goeditorItem, false)

	for _, go in pairs(self._gotagcontainer) do
		gohelper.setActive(go, false)
	end
end

function V3a9_BossRush_SearchFilterView:_refreshShowLocalTag()
	local tagCos = V3a9_BossRushExpandBondModel.instance:getBattleTagCos()

	if tagCos then
		for type, cos in pairs(tagCos) do
			for _, co in ipairs(cos) do
				self:_refreshLocalTag(co, self._tagRoot[type])
			end

			gohelper.setActive(self._gotagcontainer[type], true)
		end
	end
end

function V3a9_BossRush_SearchFilterView:_refreshLocalTag(co, root)
	local id = co.id
	local item = self:_getLocalTagItem(id, root)

	self:_refreshLocalTagStatus(item)

	item.txtunselected.text = co.tagName
	item.txtselected.text = co.tagName
end

function V3a9_BossRush_SearchFilterView:_refreshLocalTagStatus(item)
	local id = item.id
	local select = self:_isSelectLocalTag(id)

	gohelper.setActive(item.selected, select)
	gohelper.setActive(item.unselected, not select)
	gohelper.setActive(item.goPlus, false)
	gohelper.setActive(item.goMinus, false)
	gohelper.setActive(item.go, true)

	item.canvasGroup.alpha = 1
end

function V3a9_BossRush_SearchFilterView:onOpen()
	V3a9_BossRush_SearchFilterView.super.onOpen(self)

	if self.viewParam then
		if not self.viewParam.EnterType then
			local enterType = V3a9BossRushEnum.SearchFilterType.HeroGroup

			gohelper.setActive(self._goattr, enterType == V3a9BossRushEnum.SearchFilterType.HeroGroup)
		end
	end
end

function V3a9_BossRush_SearchFilterView:_onClickLocalTag(item)
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
		local select = self:_onSelectLocalTag(item.id)

		gohelper.setActive(item.selected, select)
		gohelper.setActive(item.unselected, not select)
	end
end

function V3a9_BossRush_SearchFilterView:_onSelectLocalTag(tagId)
	local tagCo = lua_character_battle_tag.configDict[tagId]
	local type = tagCo and V3a9BossRushEnum.SearchFilterTagType[tagCo.typeid]
	local selectTag = CharacterSearchFilterModel.instance:getSelectLocalTags()

	selectTag = selectTag or {}

	if selectTag[type] then
		local index = tabletool.indexOf(selectTag[type], tagId)
		local isSelect = index ~= nil

		if isSelect then
			table.remove(selectTag[type], index)
		else
			selectTag[type] = selectTag[type] or {}

			table.insert(selectTag[type], tagId)
		end

		return not isSelect
	end
end

function V3a9_BossRush_SearchFilterView:_isSelectLocalTag(tagId)
	local tagCo = lua_character_battle_tag.configDict[tagId]
	local type = tagCo and V3a9BossRushEnum.SearchFilterTagType[tagCo.typeid]
	local selectTag = CharacterSearchFilterModel.instance:getSelectLocalTags()

	if selectTag then
		::label_8_0::

		local var_8_0 = selectTag[type]

		if selectTag[type] then
			local index = tabletool.indexOf(selectTag[type], tagId)

			return index ~= nil
		end
	end
end

return V3a9_BossRush_SearchFilterView
