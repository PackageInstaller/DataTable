-- chunkname: @modules/logic/rouge/view/RougeFactionIllustrationDetailItem.lua

module("modules.logic.rouge.view.RougeFactionIllustrationDetailItem", package.seeall)

local RougeFactionIllustrationDetailItem = class("RougeFactionIllustrationDetailItem", ListScrollCellExtend)

function RougeFactionIllustrationDetailItem:onInitView()
	self._txtcoin = gohelper.findChildText(self.viewGO, "Select/detail/coin/#txt_coin")
	self._txtbag = gohelper.findChildText(self.viewGO, "Select/detail/bag/#txt_bag")
	self._txtgroup = gohelper.findChildText(self.viewGO, "Select/detail/group/#txt_group")
	self._gobag = gohelper.findChild(self.viewGO, "Select/detail/baglayout/#go_bag")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "Select/detail/baglayout/#btn_check")
	self._godescitem = gohelper.findChild(self.viewGO, "Select/detail/beidong/#Scroll_Desc/Viewport/Content/#go_descitem")
	self._goskillitem = gohelper.findChild(self.viewGO, "Select/detail/zhouyu/#go_skillcontainer/#go_skills/#go_skillitem")
	self._godetail2 = gohelper.findChild(self.viewGO, "Select/detail/zhouyu/#go_skillcontainer/#go_detail2")
	self._imageskillicon = gohelper.findChildImage(self.viewGO, "Select/detail/zhouyu/#go_skillcontainer/#go_detail2/#image_skillicon")
	self._txtdec2 = gohelper.findChildText(self.viewGO, "Select/detail/zhouyu/#go_skillcontainer/#go_detail2/#txt_dec2")
	self._goBg = gohelper.findChild(self.viewGO, "Select/#go_Bg")
	self._imageicon = gohelper.findChildImage(self.viewGO, "Select/#image_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "Select/#txt_name")
	self._txten = gohelper.findChildText(self.viewGO, "Select/#txt_name/#txt_en")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "Select/#scroll_desc")
	self._txtscrollDesc = gohelper.findChildText(self.viewGO, "Select/#scroll_desc/viewport/content/#txt_scrollDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeFactionIllustrationDetailItem:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
end

function RougeFactionIllustrationDetailItem:removeEvents()
	self._btncheck:RemoveClickListener()
end

function RougeFactionIllustrationDetailItem:_refreshAllBtnStatus(selectBtnIndex)
	for index, skillItem in ipairs(self._skillItemList) do
		local isSelect = selectBtnIndex == index

		self:_setBtnStatus(isSelect, skillItem.gonormal, skillItem.goselect)
	end
end

function RougeFactionIllustrationDetailItem:_setBtnStatus(isSelected, normalGo, selectedGo)
	gohelper.setActive(normalGo, not isSelected)
	gohelper.setActive(selectedGo, isSelected)
end

function RougeFactionIllustrationDetailItem:_btncheckOnClick()
	local params = {
		collectionCfgIds = self._collectionCfgIds
	}

	RougeController.instance:openRougeCollectionInitialView(params)
end

function RougeFactionIllustrationDetailItem:_editableInitView()
	self._skillItemList = self:getUserDataTb_()

	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, self._onTouchScreenUp, self)
	gohelper.setActive(self._godetail2, false)

	self._descItemList = {
		self:_create_RougeFactionItemSelected_DescItem(1),
		(self:_create_RougeFactionItemSelected_DescItem(2))
	}
end

function RougeFactionIllustrationDetailItem:_onTouchScreenUp()
	if self._showTips then
		self._showTips = false

		return
	end

	gohelper.setActive(self._godetail2, false)
	self:_refreshAllBtnStatus()
end

function RougeFactionIllustrationDetailItem:_editableAddEvents()
	return
end

function RougeFactionIllustrationDetailItem:_editableRemoveEvents()
	return
end

function RougeFactionIllustrationDetailItem:onUpdateMO(mo)
	self._mo = mo
	self._txtname.text = mo.name
	self._txtcoin.text = mo.coin
	self._txtbag.text = tostring(mo.power) .. "/" .. tostring(mo.powerLimit)
	self._txtgroup.text = mo.capacity
	self._txtscrollDesc.text = mo.desc

	self:_initSkill()
	self:_initOrRefreshDescItemList(mo)
	self:_initOrRefreshCollectonSlot(mo)
	UISpriteSetMgr.instance:setRouge2Sprite(self._imageicon, string.format("%s_light", self._mo.icon))

	local showNewFlag = RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Faction, self._mo.id) ~= nil

	if showNewFlag then
		local season = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(season, RougeEnum.FavoriteType.Faction, self._mo.id)
	end
end

function RougeFactionIllustrationDetailItem:_initOrRefreshCollectonSlot(styleCO)
	self._collectionSlotComp = self._collectionSlotComp or RougeCollectionSlotComp.Get(self._gobag, RougeCollectionHelper.StyleShowCollectionSlotParam)

	local layoutId = styleCO.layoutId
	local bagSize = RougeCollectionConfig.instance:getCollectionInitialBagSize(layoutId)
	local slotMOList = self:_createInitialCollections(layoutId)

	self._collectionSlotComp:onUpdateMO(bagSize.col, bagSize.row, slotMOList)
end

function RougeFactionIllustrationDetailItem:_createInitialCollections(layoutId)
	local collectionInfos = RougeCollectionConfig.instance:getStyleInitialCollections(layoutId)

	if not collectionInfos then
		return
	end

	local slotMOList = {}

	self._collectionCfgIds = {}

	for index, info in ipairs(collectionInfos) do
		local slotMO = RougeCollectionSlotMO.New()
		local serverInfo = {
			item = {
				id = index,
				itemId = info.cfgId
			},
			rotation = info.rotation,
			pos = info.pos
		}

		slotMO:init(serverInfo)
		table.insert(slotMOList, slotMO)
		table.insert(self._collectionCfgIds, info.cfgId)
	end

	return slotMOList
end

function RougeFactionIllustrationDetailItem:_initSkill()
	local totalSkills = self:_getAllSkills()
	local rougeConfig = RougeOutsideModel.instance:config()
	local useMap = {}

	for index, skillMo in ipairs(totalSkills) do
		local skillItem = self:_getOrCreateSkillItem(index)
		local skillCo = rougeConfig:getSkillCo(skillMo.type, skillMo.skillId)
		local icon = skillCo and skillCo.icon

		if not string.nilorempty(icon) then
			UISpriteSetMgr.instance:setRouge2Sprite(skillItem.imagenormalicon, icon, true)
			UISpriteSetMgr.instance:setRouge2Sprite(skillItem.imagselecticon, icon .. "_light", true)
		else
			logError(string.format("未配置肉鸽流派技能图标, 技能类型 = %s, 技能id = %s", skillMo.type, skillMo.skillId))
		end

		self["_skillDesc" .. index] = skillCo.desc
		self["_skillIcon" .. index] = skillCo.icon

		gohelper.setActive(skillItem.viewGO, true)

		useMap[skillItem] = true
	end

	for _, skillItem in ipairs(self._skillItemList) do
		if not useMap[skillItem] then
			gohelper.setActive(skillItem.viewGO, false)
		end
	end
end

function RougeFactionIllustrationDetailItem:_getOrCreateSkillItem(index)
	if self._skillItemList then
		local skillItem = self._skillItemList[index]

		if not self._skillItemList then
			skillItem = self:getUserDataTb_()
			self._skillItemList.viewGO = gohelper.cloneInPlace(self._goskillitem, "item_" .. index)
			self._skillItemList.gonormal = gohelper.findChild(self._skillItemList.viewGO, "go_normal")
			self._skillItemList.imagenormalicon = gohelper.findChildImage(self._skillItemList.viewGO, "go_normal/image_icon")
			self._skillItemList.goselect = gohelper.findChild(self._skillItemList.viewGO, "go_select")
			self._skillItemList.imagselecticon = gohelper.findChildImage(self._skillItemList.viewGO, "go_select/image_icon")
			self._skillItemList.btnclick = gohelper.findChildButtonWithAudio(self._skillItemList.viewGO, "btn_click")

			self._skillItemList.btnclick:AddClickListener(self._btnskillOnClick, self, index)
			table.insert(self._skillItemList, self._skillItemList)
		end

		return self._skillItemList
	end
end

function RougeFactionIllustrationDetailItem:_btnskillOnClick(index)
	self._showTips = true
	self._txtdec2.text = self["_skillDesc" .. index]

	UISpriteSetMgr.instance:setRouge2Sprite(self._imageskillicon, self["_skillIcon" .. index], true)
	gohelper.setActive(self._godetail2, false)
	gohelper.setActive(self._godetail2, true)
	self:_refreshAllBtnStatus(index)
end

function RougeFactionIllustrationDetailItem:_removeAllSkillClickListener()
	if self._skillItemList then
		for _, skillItem in pairs(self._skillItemList) do
			if skillItem.btnclick then
				skillItem.btnclick:RemoveClickListener()
			end
		end
	end
end

function RougeFactionIllustrationDetailItem:_getAllSkills()
	local totalSkills = {}
	local activeSkillList = string.splitToNumber(self._mo.activeSkills, "#")

	for _, skillId in ipairs(activeSkillList) do
		table.insert(totalSkills, {
			type = RougeEnum.SkillType.Style,
			skillId = skillId
		})
	end

	local mapSkillList = string.splitToNumber(self._mo.mapSkills, "#")

	for _, skillId in ipairs(mapSkillList) do
		table.insert(totalSkills, {
			type = RougeEnum.SkillType.Map,
			skillId = skillId
		})
	end

	local skillCos = RougeDLCConfig101.instance:getStyleUnlockSkills(self._mo.id)

	for _, skillCo in ipairs(skillCos or {}) do
		table.insert(totalSkills, {
			type = skillCo.type,
			skillId = skillCo.skillId
		})
	end

	return totalSkills
end

function RougeFactionIllustrationDetailItem:_createItem(srcGo, luaClass)
	local newGo = gohelper.cloneInPlace(srcGo, luaClass.__cname)
	local newItem = luaClass.New(self)

	newItem:init(newGo)

	return newItem
end

function RougeFactionIllustrationDetailItem:_create_RougeFactionItemSelected_DescItem(index)
	index = index or #self._descItemList

	local newItem = self:_createItem(self._godescitem, RougeFactionItemSelected_DescItem)

	newItem:setIndex(index)

	return newItem
end

function RougeFactionIllustrationDetailItem:_initOrRefreshDescItemList(mo)
	local descList = RougeConfig1.instance:calcStyleCOPassiveSkillDescsList(mo)

	for i, desc in ipairs(descList) do
		local item = self._descItemList[i]

		if not item then
			item = self:_create_RougeFactionItemSelected_DescItem(i)
			self._descItemList[i] = item
		end

		item:setData(desc)
	end

	for i = #descList + 1, #self._descItemList do
		local item = self._descItemList[i]

		item:setData(nil)
	end
end

function RougeFactionIllustrationDetailItem:onSelect(isSelect)
	return
end

function RougeFactionIllustrationDetailItem:onDestroyView()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, self._onTouchScreenUp, self)
	GameUtil.onDestroyViewMemberList(self, "_descItemList")

	if self._collectionSlotComp then
		self._collectionSlotComp:destroy()

		self._collectionSlotComp = nil
	end

	self:_removeAllSkillClickListener()
end

return RougeFactionIllustrationDetailItem
