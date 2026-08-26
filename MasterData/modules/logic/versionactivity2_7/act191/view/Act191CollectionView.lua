-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191CollectionView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191CollectionView", package.seeall)

local Act191CollectionView = class("Act191CollectionView", BaseView)

function Act191CollectionView:onInitView()
	self._goEmpty = gohelper.findChild(self.viewGO, "bg/#go_Empty")
	self._goInfo = gohelper.findChild(self.viewGO, "bg/#go_Info")
	self._goCTag1 = gohelper.findChild(self.viewGO, "bg/#go_Info/#go_CTag1")
	self._txtCTag1 = gohelper.findChildText(self.viewGO, "bg/#go_Info/#go_CTag1/#txt_CTag1")
	self._goCTag2 = gohelper.findChild(self.viewGO, "bg/#go_Info/#go_CTag2")
	self._txtCTag2 = gohelper.findChildText(self.viewGO, "bg/#go_Info/#go_CTag2/#txt_CTag2")
	self._simageCIcon = gohelper.findChildSingleImage(self.viewGO, "bg/#go_Info/#simage_CIcon")
	self._txtCName = gohelper.findChildText(self.viewGO, "bg/#go_Info/#txt_CName")
	self._txtCDesc = gohelper.findChildText(self.viewGO, "bg/#go_Info/scroll_desc/Viewport/go_desccontent/#txt_CDesc")
	self._btnEquip = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#go_Info/#btn_Equip")
	self._btnUnEquip = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#go_Info/#btn_UnEquip")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "bg/#scroll_ItemList")
	self._goItemContent = gohelper.findChild(self.viewGO, "bg/#scroll_ItemList/Viewport/#go_ItemContent")
	self._goTeam = gohelper.findChild(self.viewGO, "bg/#go_Team")
	self._imageLevel = gohelper.findChildImage(self.viewGO, "bg/#go_Team/level/#image_Level")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191CollectionView:addEvents()
	self._btnEquip:AddClickListener(self._btnEquipOnClick, self)
	self._btnUnEquip:AddClickListener(self._btnUnEquipOnClick, self)
end

function Act191CollectionView:removeEvents()
	self._btnEquip:RemoveClickListener()
	self._btnUnEquip:RemoveClickListener()
end

function Act191CollectionView:_btnEquipOnClick()
	self.equipping = true

	self.gameInfo:replaceItemInTeam(self.showItemUid, self.curSlotIndex)
end

function Act191CollectionView:_btnUnEquipOnClick()
	self.gameInfo:removeItemInTeam(self.showItemUid)
end

function Act191CollectionView:_editableInitView()
	local goLevel = gohelper.findChild(self._goTeam, "level")

	self.animLevel = goLevel:GetComponent(gohelper.Type_Animator)
	self.animInfo = self._goInfo:GetComponent(gohelper.Type_Animator)

	SkillHelper.addHyperLinkClick(self._txtCDesc)

	self._goItemList = self._scrollItemList.gameObject
	self.equipItemList = {}
	self.showItemUid = nil
	self.equipPosTrList = {}
	self.slotItemList = {}

	for i = 1, 4 do
		self.equipPosTrList[i] = gohelper.findChild(self._goTeam, "Team/bg/mask" .. i .. "/image").transform

		local equipTbl = self:getUserDataTb_()

		equipTbl.go = gohelper.findChild(self._goTeam, "Team/collection" .. i)
		equipTbl.transform = equipTbl.go.transform
		equipTbl.goEmpty = gohelper.findChild(equipTbl.go, "go_Empty")
		equipTbl.goCollection = gohelper.findChild(equipTbl.go, "go_Collection")
		equipTbl.imageRare = gohelper.findChildImage(equipTbl.go, "go_Collection/image_Rare")
		equipTbl.simageIcon = gohelper.findChildSingleImage(equipTbl.go, "go_Collection/simage_Icon")
		equipTbl.goSelect = gohelper.findChild(equipTbl.go, "go_Collection/go_Select")
		equipTbl.goAddEffect = gohelper.findChild(equipTbl.go, "go_AddEffect")
		equipTbl.goPreAdd = gohelper.findChild(equipTbl.go, "go_PreAdd")

		local btnClick = gohelper.findChildButtonWithAudio(equipTbl.go, "btn_Click")

		self.addClickCb(self, btnClick, self.onClickSlot, self, i)
		CommonDragHelper.instance:registerDragObj(equipTbl.go, self._beginDrag, nil, self._endDrag, self._checkDrag, self, i)

		self.slotItemList[i] = equipTbl
	end
end

function Act191CollectionView:onOpen()
	self.addEventCb(self, Activity191Controller.instance, Activity191Event.ClickCollectionItem, self.onClickCollectionItem, self)
	self.addEventCb(self, Activity191Controller.instance, Activity191Event.UpdateTeamInfo, self.onUpdateTeam, self)

	self.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	self.teamInfo = self.gameInfo:getTeamInfo()

	self:refreshUI()
	self:refreshHeroInfo()

	if not self.viewParam.index then
		self:onClickSlot(self.viewParam.index)
	end
end

function Act191CollectionView:onDestroyView()
	for _, item in ipairs(self.slotItemList) do
		CommonDragHelper.instance:unregisterDragObj(item.go)
	end

	TaskDispatcher.cancelTask(self.delayRefreshInfo, self)
end

function Act191CollectionView:refreshUI()
	self.heroIdMap = {}
	self.itemUIdMap = {}

	for i = 1, 4 do
		local info = Activity191Helper.matchKeyInArray(self.teamInfo.battleHeroInfo, i)

		if info then
			self.heroIdMap[i] = info.heroId or 0
		end

		if info then
			self.itemUIdMap[i] = info.itemUid1 or 0
		end
	end

	local rankCfg = Activity191Config.instance:getRankCfg(self.gameInfo.rank)

	if rankCfg then
		UISpriteSetMgr.instance:setAct174Sprite(self._imageLevel, "act191_level_" .. string.lower(rankCfg.fightLevel))
	end

	self:refreshItemList()
	self:refreshInfo()
	self:refreshEquipInfo()
	self:refreshEquipSelect()
end

function Act191CollectionView:onClickCollectionItem(uid)
	if self.showItemUid then
		local isChange = self.showItemUid ~= uid

		self.showItemUid = uid

		self:refreshInfo(isChange)
		self:refreshEquipSelect()
	end
end

function Act191CollectionView:onClickSlot(index)
	if self.dragging then
		return
	end

	self.curSlotIndex = index

	local uid = self.itemUIdMap[index]

	for k, item in ipairs(self.slotItemList) do
		gohelper.setActive(item.goPreAdd, k == index and uid == 0)
	end

	if uid ~= 0 then
		Activity191Controller.instance:dispatchEvent(Activity191Event.ClickCollectionItem, uid)
	end
end

function Act191CollectionView:refreshItemList()
	local itemInfoList = {}

	for _, itemInfo in ipairs(self.gameInfo.warehouseInfo.item) do
		local itemUid = itemInfo.uid
		local inTeam = self.gameInfo:isItemInTeam(itemUid)

		if not inTeam then
			itemInfoList[#itemInfoList + 1] = itemInfo
		end
	end

	table.sort(itemInfoList, function(a, b)
		local aCfg = Activity191Config.instance:getCollectionCo(a.itemId)
		local bCfg = Activity191Config.instance:getCollectionCo(b.itemId)

		if aCfg then
			if not aCfg.rare then
				local aRare = 0

				if bCfg then
					if not bCfg.rare then
						local bRare = 0

						return bRare < aRare
					end
				end
			end
		end
	end)

	for k, itemInfo in ipairs(itemInfoList) do
		if not self.equipItemList[k] then
			local go = self:getResInst(Activity191Enum.PrefabPath.CollectionItem, self._goItemContent)

			self.equipItemList[k] = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191CollectionItem)
		end

		self.equipItemList[k]:setData(itemInfo)
	end

	for k = #itemInfoList + 1, #self.equipItemList do
		self.equipItemList[k]:setActive(false)
	end
end

function Act191CollectionView:refreshInfo(isSwitch)
	TaskDispatcher.cancelTask(self.delayRefreshInfo, self)

	if isSwitch then
		self.animInfo:Play("switch", 0, 0)
		TaskDispatcher.runDelay(self.delayRefreshInfo, self, 0.16)
	elseif self.showItemUid then
		self:delayRefreshInfo()
	end

	gohelper.setActive(self._goEmpty, not self.showItemUid)
	gohelper.setActive(self._goInfo, self.showItemUid)
end

function Act191CollectionView:delayRefreshInfo()
	local itemInfo = self.gameInfo:getItemInfoInWarehouse(self.showItemUid)
	local config = Activity191Config.instance:getCollectionCo(itemInfo.itemId)

	self._simageCIcon:LoadImage(ResUrl.getRougeSingleBgCollection(config.icon))

	local rareColor = Activity191Enum.CollectionColor[config.rare]

	self._txtCName.text = string.format("<#%s>%s</color>", rareColor, config.title)
	self._txtCDesc.text = SkillHelper.buildDesc(config.desc)

	if string.nilorempty(config.label) then
		gohelper.setActive(self._goCTag1, false)
		gohelper.setActive(self._goCTag2, false)
	else
		local labelList = string.split(config.label, "#")

		for i = 1, 2 do
			local str = labelList[i]

			self["_txtCTag" .. i].text = str

			gohelper.setActive(self["_goCTag" .. i], str)
		end
	end

	local inTeam = self.gameInfo:isItemInTeam(self.showItemUid)

	gohelper.setActive(self._btnEquip, not inTeam)
	gohelper.setActive(self._btnUnEquip, inTeam)
end

function Act191CollectionView:refreshHeroInfo()
	for i = 1, 4 do
		local heroGo = gohelper.findChild(self._goTeam, "Team/hero" .. i)
		local goEmpty = gohelper.findChild(heroGo, "go_Empty")
		local goHero = gohelper.findChild(heroGo, "go_Hero")
		local heroId = self.heroIdMap[i]

		if heroId ~= 0 then
			local cloneGo = self:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, goHero)
			local headItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, Act191HeroHeadItem)

			headItem:setData(heroId)
		end

		gohelper.setActive(goEmpty, heroId == 0)
		gohelper.setActive(goHero, heroId ~= 0)
	end
end

function Act191CollectionView:refreshEquipInfo()
	for i = 1, 4 do
		local slotItem = self.slotItemList[i]
		local uid = self.itemUIdMap[i]

		if uid ~= 0 then
			if self.equipping and i == self.curSlotIndex then
				gohelper.setActive(slotItem.goAddEffect, false)
				gohelper.setActive(slotItem.goAddEffect, true)
				AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_equip_creation)
			end

			local itemInfo = self.gameInfo:getItemInfoInWarehouse(uid)
			local itemCo = Activity191Config.instance:getCollectionCo(itemInfo.itemId)

			UISpriteSetMgr.instance:setAct174Sprite(slotItem.imageRare, "act174_propitembg_" .. itemCo.rare)
			slotItem.simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(itemCo.icon))
			gohelper.setActive(slotItem.goCollection, true)
			gohelper.setActive(slotItem.goEmpty, false)
		else
			gohelper.setActive(slotItem.goCollection, false)
			gohelper.setActive(slotItem.goEmpty, true)
		end
	end
end

function Act191CollectionView:refreshEquipSelect()
	for _, item in ipairs(self.equipItemList) do
		local itemUid = item.itemInfo.uid

		item:setSelect(itemUid == self.showItemUid)
	end

	for i = 1, 4 do
		local slotItem = self.slotItemList[i]

		if slotItem then
			gohelper.setActive(slotItem.goSelect, self.itemUIdMap[i] == self.showItemUid)
		end
	end
end

function Act191CollectionView:_beginDrag()
	self.dragging = true

	gohelper.setAsLastSibling(self._goTeam)
end

function Act191CollectionView:_endDrag(index, pointerEventData)
	self.dragging = false

	local slotItem = self.slotItemList[index]

	ZProj.TweenHelper.KillByObj(slotItem.transform)

	local screenPos = pointerEventData.position
	local findIndex

	for k, trans in ipairs(self.equipPosTrList) do
		if gohelper.isMouseOverGo(trans, screenPos) then
			findIndex = k

			break
		end
	end

	if findIndex and findIndex ~= index then
		self.equipping = true

		self.gameInfo:exchangeItem(index, findIndex)
		gohelper.setActive(slotItem.goCollection, false)
	end

	local startPos = self.equipPosTrList[index].position

	transformhelper.setPos(slotItem.transform, startPos.x + 0.65, startPos.y, startPos.z)
end

function Act191CollectionView:_checkDrag(index)
	local itemUid = self.itemUIdMap[index]

	if itemUid and itemUid ~= 0 then
		return false
	else
		return true
	end
end

function Act191CollectionView:onUpdateTeam()
	self.showItemUid = nil
	self.teamInfo = self.gameInfo:getTeamInfo()

	if self.equipping then
		GameFacade.showToast(ToastEnum.Act191EquipTip)
	end

	self:refreshUI()
	self:selectEmptySlot()

	self.equipping = false

	local rankMark = self.gameInfo.rankMark

	if rankMark > 0 then
		self.animLevel:Play("levelup", 0, 0)
	elseif rankMark < 0 then
		self.animLevel:Play("swicth", 0, 0)
	end

	self.gameInfo:clearRankMark()
end

function Act191CollectionView:selectEmptySlot()
	for i = 1, 4 do
		local itemUid = self.itemUIdMap[i]

		if itemUid == 0 then
			self:onClickSlot(i)

			return
		end
	end

	self:onClickSlot(4)
end

return Act191CollectionView
