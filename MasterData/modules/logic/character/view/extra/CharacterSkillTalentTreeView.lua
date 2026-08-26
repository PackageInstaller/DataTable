-- chunkname: @modules/logic/character/view/extra/CharacterSkillTalentTreeView.lua

module("modules.logic.character.view.extra.CharacterSkillTalentTreeView", package.seeall)

local CharacterSkillTalentTreeView = class("CharacterSkillTalentTreeView", BaseView)

function CharacterSkillTalentTreeView:onInitView()
	self._goselect = gohelper.findChild(self.viewGO, "talentTree/talenttreeitem/#go_select")
	self._godark = gohelper.findChild(self.viewGO, "talentTree/talenttreeitem/#go_dark")
	self._imagedarkIcon = gohelper.findChildImage(self.viewGO, "talentTree/talenttreeitem/#go_dark/#image_darkIcon")
	self._golock = gohelper.findChild(self.viewGO, "talentTree/talenttreeitem/#go_lock")
	self._gocanlvup = gohelper.findChild(self.viewGO, "talentTree/talenttreeitem/#go_canlvup")
	self._gomaxEffect = gohelper.findChild(self.viewGO, "talentTree/talenttreeitem/#go_canlvup/#go_maxEffect")
	self._imagecanupicon = gohelper.findChildImage(self.viewGO, "talentTree/talenttreeitem/#go_canlvup/#image_icon")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "talentTree/talenttreeitem/#btn_click")
	self._gotreeType1 = gohelper.findChild(self.viewGO, "talentTree/#go_treeType1")
	self._gotreeType2 = gohelper.findChild(self.viewGO, "talentTree/#go_treeType2")
	self._gotreeType3 = gohelper.findChild(self.viewGO, "talentTree/#go_treeType3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkillTalentTreeView:addEvents()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, self._onChoiceHero3124TalentTreeReply, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onResetHero3124TalentTreeReply, self._onResetHero3124TalentTreeReply, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, self._onCancelHero3124TalentTreeReply, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onClickTalentTreeNode, self._onClickTalentTreeNode, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onCloseSkillTalentTipView, self._onCloseSkillTalentTipView, self)
end

function CharacterSkillTalentTreeView:removeEvents()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, self._onChoiceHero3124TalentTreeReply, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onResetHero3124TalentTreeReply, self._onResetHero3124TalentTreeReply, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, self._onCancelHero3124TalentTreeReply, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onClickTalentTreeNode, self._onClickTalentTreeNode, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onCloseSkillTalentTipView, self._onCloseSkillTalentTipView, self)
end

function CharacterSkillTalentTreeView:_onChoiceHero3124TalentTreeReply()
	self:_refreshView()
end

function CharacterSkillTalentTreeView:_onCancelHero3124TalentTreeReply()
	self:_refreshView()
end

function CharacterSkillTalentTreeView:_onResetHero3124TalentTreeReply()
	self:_refreshView()
end

function CharacterSkillTalentTreeView:_onClickTalentTreeNode(sub, level)
	self:_cancelAllSelectNodesEffect()

	local nodeMos = self.skillTalentMo:getLightOrCancelNodes(sub, level)

	for _, mo in pairs(nodeMos) do
		local item = self:_getNodeItem(mo.co.sub, mo.co.level)

		item:showSelectEffect(true)
		table.insert(self._lightNodes, {
			sub = mo.co.sub,
			level = mo.co.level
		})
	end

	if self._clickNodeItem then
		self._clickNodeItem:showSelect(false)
	end

	self._clickNodeItem = self:_getNodeItem(sub, level)

	self._clickNodeItem:showSelect(true)
end

function CharacterSkillTalentTreeView:_onCloseSkillTalentTipView(sub, level)
	if self._clickNodeItem then
		self._clickNodeItem:showSelect(false)
	end

	self:_cancelAllSelectNodesEffect()
end

function CharacterSkillTalentTreeView:_cancelAllSelectNodesEffect()
	for _, node in pairs(self._lightNodes) do
		local item = self:_getNodeItem(node.sub, node.level)

		item:showSelectEffect(false)
	end

	self._lightNodes = {}
end

function CharacterSkillTalentTreeView:_editableInitView()
	self.treeNodeItems = self:getUserDataTb_()
	self._lightNodes = {}
	self._gonodeItem = gohelper.findChild(self.viewGO, "talentTree/talenttreeitem")

	gohelper.setActive(self._gonodeItem, false)
end

function CharacterSkillTalentTreeView:onUpdateParam()
	return
end

function CharacterSkillTalentTreeView:onOpen()
	self.heroMo = self.viewParam

	local extraMo = self.heroMo.extraMo

	self.skillTalentMo = extraMo:getSkillTalentMo()

	self:_refreshSubTree()
	self:_refreshView()
end

function CharacterSkillTalentTreeView:onClose()
	return
end

function CharacterSkillTalentTreeView:onDestroyView()
	return
end

function CharacterSkillTalentTreeView:_refreshSubTree()
	for i = 1, CharacterExtraEnum.TalentSkillSubCount do
		local treeMo = self.skillTalentMo:getTreeMosBySub(i)
		local moList = treeMo:getTreeMoList()

		for _, mo in ipairs(moList) do
			local nodeItem = self:_getNodeItem(i, mo.level)

			nodeItem:onUpdateMO(mo)
		end

		local item = self:_getTreeItem(i)

		item.txtName.text = luaLang("characterskilltalent_sub_" .. i)
	end
end

function CharacterSkillTalentTreeView:_refreshView()
	if self.treeNodeItems then
		for sub, treeitem in pairs(self.treeNodeItems) do
			if treeitem.nodeItems then
				for _, nodeItem in ipairs(treeitem.nodeItems) do
					nodeItem:refreshStatus()
				end
			end

			local count = self.skillTalentMo:getTreeLightCount(sub)

			gohelper.setActive(treeitem.golv2, count == 1 or count == 2)

			if treeitem.golv3 then
				for _, v in ipairs(treeitem.golv3) do
					gohelper.setActive(v, count == 3)
				end
			end

			local icon = self.skillTalentMo:getSubIconPath(sub)

			UISpriteSetMgr.instance:setUiCharacterSprite(treeitem.imageicon, icon)
		end
	end
end

function CharacterSkillTalentTreeView:_getNodeItem(sub, level)
	local item = self:_getTreeItem(sub)
	local nodeItems = item.nodeItems

	if not nodeItems then
		nodeItems = self:getUserDataTb_()

		for j = 1, CharacterExtraEnum.TalentSkillTreeNodeCount do
			local root = gohelper.findChild(item.treeGo, "go_talentitem" .. j)
			local itemGo = gohelper.clone(self._gonodeItem, root, j)

			gohelper.setActive(itemGo, true)
			recthelper.setAnchor(itemGo.transform, 0, 0)

			local nodeItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, CharacterSkillTalentTreeNode)
			local linePath = string.format("go_lineContent/go_line%d", j)
			local lineGo = gohelper.findChild(item.treeGo, linePath)

			nodeItem:setLineGo(lineGo)

			local golv3 = gohelper.findChild(lineGo, "#lv3")

			if item.golv3 and golv3 then
				table.insert(item.golv3, golv3)
			end

			table.insert(nodeItems, nodeItem)
		end

		item.nodeItems = nodeItems
	end

	return nodeItems[level]
end

function CharacterSkillTalentTreeView:_getTreeItem(sub)
	local item = self.treeNodeItems[sub]

	if not item then
		item = self:getUserDataTb_()

		local go = self["_gotreeType" .. sub]

		item.treeGo = go

		local treeInfo = gohelper.findChild(go, "treeInfo")

		item.txtName = gohelper.findChildText(treeInfo, "txt_typeName")
		item.treeInfo = treeInfo
		item.imageicon = gohelper.findChildImage(treeInfo, "icon")
		item.golv2 = gohelper.findChild(treeInfo, "#lv2")
		item.golv3 = self:getUserDataTb_()

		table.insert(item.golv3, gohelper.findChild(treeInfo, "#lv3"))

		self.treeNodeItems[sub] = item
	end

	return item
end

return CharacterSkillTalentTreeView
