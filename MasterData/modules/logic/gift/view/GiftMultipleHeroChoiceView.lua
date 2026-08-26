-- chunkname: @modules/logic/gift/view/GiftMultipleHeroChoiceView.lua

module("modules.logic.gift.view.GiftMultipleHeroChoiceView", package.seeall)

local GiftMultipleHeroChoiceView = class("GiftMultipleHeroChoiceView", BaseView)

function GiftMultipleHeroChoiceView:onInitView()
	self._goselect = gohelper.findChild(self.viewGO, "root/showContent/group_1/#go_select")
	self._btnSelected = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Selected")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._btnClose = gohelper.findChildButton(self.viewGO, "root/Title/#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GiftMultipleHeroChoiceView:addEvents()
	self._btnSelected:AddClickListener(self._btnSelectedOnClick, self)
	self._btnClose:AddClickListener(self.closeThis, self)
end

function GiftMultipleHeroChoiceView:removeEvents()
	self._btnSelected:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function GiftMultipleHeroChoiceView:_btnSelectedOnClick()
	if self.displayType == SkinDiscountCompensateEnum.SelectDisplayType.DisplayOnly then
		return
	end

	local curParam = self.packageList[self.curIndex]
	local itemConfig = ItemConfig.instance:getItemConfig(curParam[1], curParam[2])
	local paramList = string.split(itemConfig.effect, "|")
	local nameList = {}
	local itemList = {}
	local maxSkillNameList = {}
	local maxSkillCount = 0

	for index, param in ipairs(paramList) do
		local detailParam = string.split(param, "@")
		local heroParam = string.splitToNumber(detailParam[1], "#")
		local itemParam = string.split(detailParam[2], "&")
		local heroId = heroParam[2]
		local heroName = string.format("<color=#AC5320>%s</color>", HeroConfig.instance:getHeroCO(heroId).name)

		table.insert(nameList, heroName)

		if HeroModel.instance:isMaxExSkill(heroId, true) then
			local itemName = self:getExchangeItemName(itemParam)

			table.insert(itemList, itemName)
			table.insert(maxSkillNameList, heroName)

			maxSkillCount = maxSkillCount + 1
		end
	end

	if maxSkillCount <= 0 then
		if not MessageBoxIdDefine.HeroSelfSelectConfirmTip then
			local messageBoxId = MessageBoxIdDefine.HeroSelfSelectConfirmTip2

			if maxSkillCount <= 0 then
				local heroNameStr = table.concat(nameList, luaLang("v3a7_skin_gift_hero_max_skill_tip_and_1"))

				GameFacade.showMessageBox(messageBoxId, MsgBoxEnum.BoxType.Yes_No, self.realUseItem, nil, nil, self, nil, nil, heroNameStr)
			else
				local heroNameStr = table.concat(maxSkillNameList, luaLang("v3a7_skin_gift_hero_max_skill_tip_and_1"))
				local itemDesc = table.concat(itemList, luaLang("v3a7_skin_gift_hero_max_skill_tip_and_1"))

				GameFacade.showMessageBox(messageBoxId, MsgBoxEnum.BoxType.Yes_No, self.realUseItem, nil, nil, self, nil, nil, heroNameStr, itemDesc)
			end
		end
	end
end

function GiftMultipleHeroChoiceView:getExchangeItemName(itemParam)
	local nameList = {}

	for _, param in ipairs(itemParam) do
		local singleItemParam = string.splitToNumber(param, "#")
		local itemConfig = ItemConfig.instance:getItemConfig(singleItemParam[1], singleItemParam[2])
		local num = singleItemParam[3]

		if num > 1 then
			table.insert(nameList, string.format("<color=#AC5320>%s*%s</color>", itemConfig.name, num))
		else
			table.insert(nameList, string.format("<color=#AC5320>%s</color>", itemConfig.name))
		end
	end

	return table.concat(nameList, luaLang("v3a7_skin_gift_hero_max_skill_tip_and_2"))
end

function GiftMultipleHeroChoiceView:realUseItem()
	local data = {}
	local o = {}

	o.materialId = self.viewParam.param.id
	o.quantity = self.viewParam.quantity

	table.insert(data, o)
	CharacterModel.instance:setGainHeroViewToastState(true)
	ItemRpc.instance:sendUseItemRequest(data, self.curIndex - 1, self.closeThis, self)
end

function GiftMultipleHeroChoiceView:_editableInitView()
	self.heroGroupItemList = {}
	self.groupParent = gohelper.findChild(self.viewGO, "root/#scroll_List/Viewport/Content")
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "root/Title/txt_Title")
	self.txtTitleEn = gohelper.findChildTextMesh(self.viewGO, "root/titlen")
	self.goItem = gohelper.findChild(self.viewGO, "root/#scroll_List/Viewport/Content/go_item")

	gohelper.setActive(self.goItem, false)

	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "root/txt_Descr")
end

function GiftMultipleHeroChoiceView:onUpdateParam()
	return
end

function GiftMultipleHeroChoiceView:onOpen()
	self:checkParam()
	self:refreshHeroGroup()
	self:refreshSelect()
	self:refreshTitle()
end

function GiftMultipleHeroChoiceView:refreshTitle()
	local config = self.config

	self.txtTitle.text = config.name

	local descList = {}
	local isHeroMaxSkill1 = false
	local isHeroMaxSkill2 = false

	if self.itemId == StoreEnum.V3a7_MultipleHeroChoiceItemId then
		for index, packageData in ipairs(self.packageList) do
			local itemConfig = ItemConfig.instance:getItemConfig(packageData[1], packageData[2])
			local heroParam = GameUtil.splitString2(itemConfig.effect, true)
			local heroId1 = heroParam[1][2]
			local heroId2 = heroParam[2][2]

			if not isHeroMaxSkill1 and HeroModel.instance:isMaxExSkill(heroId1, true) then
				isHeroMaxSkill1 = true
			end

			if not isHeroMaxSkill2 and HeroModel.instance:isMaxExSkill(heroId2, true) then
				isHeroMaxSkill2 = true
			end
		end
	end

	if not isHeroMaxSkill1 and not isHeroMaxSkill2 then
		table.insert(descList, luaLang("p_v3a7_cumulativerechargeselectview_txt_desc"))
	end

	if isHeroMaxSkill2 then
		table.insert(descList, luaLang("v3a7_skin_gift_hero_max_skill_tip_2"))
	end

	if isHeroMaxSkill1 then
		table.insert(descList, luaLang("v3a7_skin_gift_hero_max_skill_tip_1"))
	end

	self.txtDesc.text = table.concat(descList, "\n")
end

function GiftMultipleHeroChoiceView:checkParam()
	if not self.viewParam or not self.viewParam.itemId then
		return
	end

	local itemId = self.viewParam.itemId

	self.itemId = itemId
	self.config = ItemConfig.instance:getItemCo(itemId)
	self.displayType = self.viewParam.type or SkinDiscountCompensateEnum.SelectDisplayType.DisplayOnly
end

function GiftMultipleHeroChoiceView:refreshHeroGroup()
	local config = self.config

	if not config or string.nilorempty(config.effect) then
		return
	end

	local packageList = GameUtil.splitString2(config.effect, true)

	self.packageList = packageList

	for index, packageData in ipairs(packageList) do
		local item = self:getGroupItem(index)
		local itemConfig = ItemConfig.instance:getItemConfig(packageData[1], packageData[2])
		local heroParam = GameUtil.splitString2(itemConfig.effect, true)
		local heroId1 = heroParam[1][2]
		local heroId2 = heroParam[2][2]

		item.imageRole1:LoadImage(ResUrl.getGiftMultipleHeroSingleBg(heroId1))
		item.imageRole2:LoadImage(ResUrl.getGiftMultipleHeroSingleBg(heroId2))
		item.imageName1:LoadImage(ResUrl.getGiftMultipleHeroNameSingleBg(heroId1))
		item.imageName2:LoadImage(ResUrl.getGiftMultipleHeroNameSingleBg(heroId2))

		local exSkillCount1 = HeroModel.instance:getHeroSkillCount(heroId1, true)
		local exSkillCount2 = HeroModel.instance:getHeroSkillCount(heroId2, true)

		gohelper.setActive(item.goExSkill1, exSkillCount1 > 0)
		gohelper.setActive(item.goExSkill2, exSkillCount2 > 0)

		if exSkillCount1 > 0 then
			item.imageExSkill1.fillAmount = math.max(0, exSkillCount1 / CharacterEnum.MaxSkillExLevel)
		end

		if exSkillCount2 > 0 then
			item.imageExSkill2.fillAmount = math.max(0, exSkillCount2 / CharacterEnum.MaxSkillExLevel)
		end
	end
end

function GiftMultipleHeroChoiceView:getGroupItem(index)
	if not self.heroGroupItemList[index] then
		local itemGo = gohelper.cloneInPlace(self.goItem, "item_" .. index)

		gohelper.setActive(itemGo, true)

		local item = self:getUserDataTb_()

		item.itemGo = item
		item.goSelect = gohelper.findChild(itemGo, "#go_select")
		item.btnClick = gohelper.findChildButton(itemGo, "#btn_click")

		item.btnClick:AddClickListener(self.onClickItem, {
			target = self,
			index = index
		})

		item.btnClickName1 = gohelper.getClick(gohelper.findChild(itemGo, "name_1/Image"))
		item.btnClickName2 = gohelper.getClick(gohelper.findChild(itemGo, "name_2/Image"))
		item.imageRole1 = gohelper.findChildSingleImage(itemGo, "role_1")
		item.imageRole2 = gohelper.findChildSingleImage(itemGo, "role_2")
		item.imageName1 = gohelper.findChildSingleImage(itemGo, "name_1")
		item.imageName2 = gohelper.findChildSingleImage(itemGo, "name_2")

		item.btnClickName1:AddClickListener(self.onClickHeroItem, {
			heroIndex = 1,
			target = self,
			index = index
		})
		item.btnClickName2:AddClickListener(self.onClickHeroItem, {
			heroIndex = 2,
			target = self,
			index = index
		})

		item.btnDetail1 = gohelper.findChildButton(itemGo, "#btn_click")
		item.goExSkill1 = gohelper.findChild(itemGo, "name_1/#go_exskill")
		item.imageExSkill1 = gohelper.findChildImage(itemGo, "name_1/#go_exskill/#image_exskill")
		item.goExSkill2 = gohelper.findChild(itemGo, "name_2/#go_exskill")
		item.imageExSkill2 = gohelper.findChildImage(itemGo, "name_2/#go_exskill/#image_exskill")
		self.heroGroupItemList[index] = item

		return item
	end

	return self.heroGroupItemList[index]
end

function GiftMultipleHeroChoiceView.onClickItem(param)
	local target = param.target
	local index = param.index

	target:clickItem(index)
end

function GiftMultipleHeroChoiceView.onClickHeroItem(param)
	local target = param.target
	local index = param.index
	local heroIndex = param.heroIndex

	target:clickHeroItem(index, heroIndex)
end

function GiftMultipleHeroChoiceView:clickItem(index)
	if self.displayType == SkinDiscountCompensateEnum.SelectDisplayType.DisplayOnly then
		return
	end

	if self.curIndex == index then
		return
	end

	self.curIndex = index

	self:refreshSelect()
end

function GiftMultipleHeroChoiceView:clickHeroItem(index, heroIndex)
	local curParam = self.packageList[index]
	local itemConfig = ItemConfig.instance:getItemConfig(curParam[1], curParam[2])
	local heroParam = GameUtil.splitString2(itemConfig.effect, true)
	local heroConfig = HeroConfig.instance:getHeroCO(heroParam[heroIndex][2])

	if heroConfig then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			showHome = false,
			heroId = heroConfig.id
		})
	end
end

function GiftMultipleHeroChoiceView:refreshSelect()
	local showSelect = self.displayType == SkinDiscountCompensateEnum.SelectDisplayType.Select

	for index, heroItem in ipairs(self.heroGroupItemList) do
		gohelper.setActive(heroItem.goSelect, showSelect and self.curIndex == index)
	end

	gohelper.setActive(self._btnSelected, showSelect and self.curIndex ~= nil)
end

function GiftMultipleHeroChoiceView:onClose()
	return
end

function GiftMultipleHeroChoiceView:onDestroyView()
	if self.heroGroupItemList then
		for _, item in ipairs(self.heroGroupItemList) do
			item.btnClick:RemoveClickListener()
			item.btnClickName1:RemoveClickListener()
			item.btnClickName2:RemoveClickListener()
		end
	end

	tabletool.clear(self.heroGroupItemList)

	self.heroGroupItemList = nil
end

return GiftMultipleHeroChoiceView
