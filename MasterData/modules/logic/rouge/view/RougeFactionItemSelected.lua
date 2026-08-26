-- chunkname: @modules/logic/rouge/view/RougeFactionItemSelected.lua

module("modules.logic.rouge.view.RougeFactionItemSelected", package.seeall)

local RougeFactionItemSelected = class("RougeFactionItemSelected", RougeFactionItem_Base)

function RougeFactionItemSelected:onInitView()
	self._txtcoin = gohelper.findChildText(self.viewGO, "detail/coin/#txt_coin")
	self._txtbag = gohelper.findChildText(self.viewGO, "detail/bag/#txt_bag")
	self._txtgroup = gohelper.findChildText(self.viewGO, "detail/group/#txt_group")
	self._gobag = gohelper.findChild(self.viewGO, "detail/baglayout/#go_bag")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "detail/baglayout/#btn_check")
	self._scrolldesc2 = gohelper.findChildScrollRect(self.viewGO, "detail/beidong/#scroll_desc2")
	self._godescitem = gohelper.findChild(self.viewGO, "detail/beidong/#scroll_desc2/Viewport/Content/#go_descitem")
	self._gobtnitem = gohelper.findChild(self.viewGO, "detail/zhouyu/content/#go_btnitem")
	self._godetail = gohelper.findChild(self.viewGO, "detail/zhouyu/#go_detail")
	self._txtdec = gohelper.findChildText(self.viewGO, "detail/zhouyu/#go_detail/#txt_dec")
	self._detailimageicon = gohelper.findChildImage(self.viewGO, "detail/zhouyu/#go_detail/icon")
	self._goBg = gohelper.findChild(self.viewGO, "#go_Bg")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#image_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txten = gohelper.findChildText(self.viewGO, "#txt_name/#txt_en")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_desc")
	self._txtscrollDesc = gohelper.findChildText(self.viewGO, "#scroll_desc/viewport/content/#txt_scrollDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeFactionItemSelected:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
end

function RougeFactionItemSelected:removeEvents()
	self._btncheck:RemoveClickListener()
end

function RougeFactionItemSelected:_editableInitView()
	self._txtdec.text = ""
	self._detailTrans = self._godetail.transform

	RougeFactionItem_Base._editableInitView(self)
	gohelper.setActive(self._godescitem, false)
	gohelper.setActive(self._gobtnitem, false)

	local limitScrollRectCmp1 = self._scrolldesc.gameObject:GetComponent(gohelper.Type_LimitedScrollRect)
	local limitScrollRectCmp2 = self._scrolldesc2.gameObject:GetComponent(gohelper.Type_LimitedScrollRect)

	self:_onSetScrollParentGameObject(limitScrollRectCmp1)
	self:_onSetScrollParentGameObject(limitScrollRectCmp2)

	self._descItemList = {
		self:_create_RougeFactionItemSelected_DescItem(1),
		(self:_create_RougeFactionItemSelected_DescItem(2))
	}
	self._btnItemList = {
		self:_create_RougeFactionItemSelected_BtnItem(1),
		(self:_create_RougeFactionItemSelected_BtnItem(2))
	}

	gohelper.setActive(self._godetail, true)
	self:_deselectAllBtnItems()
	self.addEventCb(self, RougeController.instance, RougeEvent.UpdateUnlockSkill, self._onUpdateUnlockSkill, self)
end

function RougeFactionItemSelected:onDestroyView()
	RougeFactionItem_Base.onDestroyView(self)
	GameUtil.onDestroyViewMemberList(self, "_descItemList")
	GameUtil.onDestroyViewMemberList(self, "_btnItemList")
	self.removeEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self._onTouchScreen, self)

	if self._collectionSlotComp then
		self._collectionSlotComp:destroy()

		self._collectionSlotComp = nil
	end
end

function RougeFactionItemSelected:setData(mo)
	RougeFactionItem_Base.setData(self, mo)

	local staticData = self:staticData()
	local startViewAllInfo = staticData.startViewAllInfo
	local styleCO = mo.styleCO

	if not startViewAllInfo[RougeEnum.StartViewEnum.coin] then
		if not startViewAllInfo[RougeEnum.StartViewEnum.power] then
			local dtPower = 0

			if not startViewAllInfo[RougeEnum.StartViewEnum.powerLimit] then
				local dtPowerLimit = 0

				if not startViewAllInfo[RougeEnum.StartViewEnum.capacity] then
					local dtCapacity = 0

					self._txtcoin.text = styleCO.coin + startViewAllInfo[RougeEnum.StartViewEnum.coin]
					self._txtbag.text = tostring(styleCO.power + dtPower) .. "/" .. tostring(styleCO.powerLimit + dtPowerLimit)
					self._txtgroup.text = styleCO.capacity + dtCapacity

					self:_initOrRefreshDescItemList(mo)
					self:_initOrRefreshBtnItemList(mo)
					self:_initOrRefreshCollectonSlot(mo)
				end
			end
		end
	end
end

function RougeFactionItemSelected:_create_RougeFactionItemSelected_DescItem(index)
	index = index or #self._descItemList

	local newItem = self:_createItem(self._godescitem, RougeFactionItemSelected_DescItem)

	newItem:setIndex(index)

	return newItem
end

function RougeFactionItemSelected:_initOrRefreshDescItemList(mo)
	local styleCO = mo.styleCO
	local descList = RougeConfig1.instance:calcStyleCOPassiveSkillDescsList(styleCO)

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

function RougeFactionItemSelected:_create_RougeFactionItemSelected_BtnItem(index)
	index = index or #self._btnItemList

	local newItem = self:_createItem(self._gobtnitem, RougeFactionItemSelected_BtnItem)

	newItem:setIndex(index)

	return newItem
end

function RougeFactionItemSelected:_initOrRefreshBtnItemList(mo)
	local styleCO = mo.styleCO

	self._skillIds = {}

	self:_initOrRefreshActiveSkillItemList(styleCO)
	self:_initOrRefreshMapSkillItemList(styleCO)
	self:_initOrRefreshUnlockSkillItemList(styleCO)

	if self._skillIds then
		if not #self._skillIds then
			local totalSkillCount = 0

			for i = totalSkillCount + 1, #self._btnItemList do
				local item = self._btnItemList[i]

				item:setData(nil)
			end
		end
	end
end

function RougeFactionItemSelected:_initOrRefreshActiveSkillItemList(styleCO)
	local activeSkillList = string.splitToNumber(styleCO.activeSkills, "#")

	for _, skillId in ipairs(activeSkillList) do
		local itemIndex = self:_getCanUseItemIndex()
		local item = self._btnItemList[itemIndex]

		if not item then
			item = self:_create_RougeFactionItemSelected_BtnItem(itemIndex)
			self._btnItemList[itemIndex] = item
		end

		item:setData(RougeEnum.SkillType.Style, skillId, true)
		table.insert(self._skillIds, skillId)
	end
end

function RougeFactionItemSelected:_initOrRefreshMapSkillItemList(styleCO)
	local mapSkillList = string.splitToNumber(styleCO.mapSkills, "#")

	for _, skillId in ipairs(mapSkillList) do
		local itemIndex = self:_getCanUseItemIndex()
		local item = self._btnItemList[itemIndex]

		if not item then
			item = self:_create_RougeFactionItemSelected_BtnItem(itemIndex)
			self._btnItemList[itemIndex] = item
		end

		item:setData(RougeEnum.SkillType.Map, skillId, true)
		table.insert(self._skillIds, skillId)
	end
end

function RougeFactionItemSelected:_initOrRefreshUnlockSkillItemList(styleCO)
	local gameRecordInfo = RougeOutsideModel.instance:getRougeGameRecord()
	local skillCos = RougeDLCConfig101.instance:getStyleUnlockSkills(styleCO.id)

	for _, skillCo in ipairs(skillCos or {}) do
		local isUsing = RougeDLCHelper.isCurrentUsingContent(skillCo.version)

		if isUsing then
			local itemIndex = self:_getCanUseItemIndex()
			local item = self._btnItemList[itemIndex]

			if not item then
				item = self:_create_RougeFactionItemSelected_BtnItem(itemIndex)
				self._btnItemList[itemIndex] = item
			end

			local skillType = skillCo.type
			local isUnlock = gameRecordInfo:isSkillUnlock(skillCo.type, skillCo.skillId)

			item:setData(skillType, skillCo.skillId, isUnlock)
			table.insert(self._skillIds, skillCo.skillId)
		end
	end
end

function RougeFactionItemSelected:_getCanUseItemIndex()
	return (self._skillIds or nil) and (#self._skillIds + 1 or 0)
end

function RougeFactionItemSelected:_initOrRefreshCollectonSlot(mo)
	if not self._collectionSlotComp then
		self._collectionSlotComp = RougeCollectionSlotComp.Get(self._gobag, RougeCollectionHelper.StyleCollectionSlotParam)

		local styleCO = mo.styleCO
		local layoutId = styleCO.layoutId
		local bagSize = RougeCollectionConfig.instance:getCollectionInitialBagSize(layoutId)
		local slotMOList = self:_createInitialCollections(layoutId)

		self._collectionSlotComp:onUpdateMO(bagSize.col, bagSize.row, slotMOList)
	end
end

function RougeFactionItemSelected:_createInitialCollections(layoutId)
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

function RougeFactionItemSelected:_createItem(srcGo, luaClass)
	local newGo = gohelper.cloneInPlace(srcGo, luaClass.__cname)
	local newItem = luaClass.New(self)

	newItem:init(newGo)

	return newItem
end

function RougeFactionItemSelected:_btnItemOnSelectIndex(index, isUnLocked)
	local item = self._btnItemList[index]

	item:setSelected(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)

	self._btnItemLastSelectIndex = index

	if not isUnLocked then
		local skillId = self._skillIds[index]

		RougeDLCController101.instance:openRougeFactionLockedTips({
			skillId = skillId
		})

		return
	end

	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	self:_setActiveDetail(true)
end

function RougeFactionItemSelected:_onTouchScreen()
	self:_deselectAllBtnItems()
end

function RougeFactionItemSelected:_setActiveDetail(isActive)
	GameUtil.setActive01(self._detailTrans, isActive)

	if isActive then
		self:_resetDetailPos()
	end
end

function RougeFactionItemSelected:_deselectAllBtnItems()
	self:_setActiveDetail(false)

	if self._btnItemLastSelectIndex then
		local item = self._btnItemList[self._btnItemLastSelectIndex]

		if item then
			item:setSelected(false)
		end

		self._btnItemLastSelectIndex = nil

		return
	end

	for _, item in ipairs(self._btnItemList) do
		item:setSelected(false)
	end
end

function RougeFactionItemSelected:_btncheckOnClick()
	local params = {
		collectionCfgIds = self._collectionCfgIds
	}

	RougeController.instance:openRougeCollectionInitialView(params)
end

local kDetailOffsetX = 303

function RougeFactionItemSelected:_resetDetailPos()
	local item = self._btnItemList[#self._btnItemList]

	if not item then
		return
	end

	local targetTrans = item:transform()

	if not targetTrans then
		return
	end

	local localPosV2 = recthelper.rectToRelativeAnchorPos(targetTrans.position, self._detailTrans.parent)

	self._detailTrans.localPosition = Vector3.New(localPosV2.x + kDetailOffsetX, localPosV2.y, 0)
end

function RougeFactionItemSelected:_onUpdateUnlockSkill(skillType, skillId)
	local index = tabletool.indexOf(self._skillIds, skillId)

	if not index then
		return
	end

	local item = self._btnItemList[index]

	if item then
		item:onUnlocked()
	end
end

return RougeFactionItemSelected
