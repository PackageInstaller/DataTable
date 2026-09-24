-- chunkname: @modules/logic/fight/view/FightQteTipView.lua

module("modules.logic.fight.view.FightQteTipView", package.seeall)

local FightQteTipView = class("FightQteTipView", BaseView)

function FightQteTipView:onInitView()
	self.closeClick = gohelper.findChildClick(self.viewGO, "#btn_close")
	self.closeIconClick = gohelper.findChildClick(self.viewGO, "panel/close_icon")
	self.goArrow = gohelper.findChild(self.viewGO, "panel/#scroll_tips/arrow")

	gohelper.setActive(self.goArrow, false)

	self.goTipItem = gohelper.findChild(self.viewGO, "panel/#scroll_tips/viewport/content/#go_tipsitem")

	gohelper.setActive(self.goTipItem, false)

	self.tipItemDict = {}
end

function FightQteTipView:addEvents()
	self.addClickCb(self, self.closeClick, self.closeThis, self)
	self.addClickCb(self, self.closeIconClick, self.closeThis, self)
end

function FightQteTipView:onOpen()
	self:refreshUI()
end

local EntityMoList = {}

function FightQteTipView:refreshUI()
	local entityMoList = EntityMoList

	tabletool.clear(entityMoList)
	FightDataHelper.entityMgr:getMyNormalList(entityMoList)

	for _, tipItem in pairs(self.tipItemDict) do
		gohelper.setActive(tipItem.tipGo, false)
	end

	for _, entityMo in ipairs(entityMoList) do
		if entityMo:isQteEntity() then
			local tipItem = self.tipItemDict[entityMo.uid]

			if not tipItem then
				tipItem = self:createTipItem(entityMo)
				self.tipItemDict[entityMo.uid] = tipItem
			end

			self:refreshTipItem(tipItem, entityMo)
		end
	end
end

function FightQteTipView:createTipItem(entityMo)
	local tipItem = self:getUserDataTb_()

	tipItem.tipGo = gohelper.cloneInPlace(self.goTipItem)
	tipItem.goHeroItem = gohelper.findChild(tipItem.tipGo, "heroitem")
	tipItem.entityItem = FightQteEntityItemHelper.createEntityItem(entityMo, FightQteEntityItemBase.UseType.QTETip)

	tipItem.entityItem:setParent(tipItem.goHeroItem)
	tipItem.entityItem:startLoad()

	tipItem.txtName = gohelper.findChildText(tipItem.tipGo, "#txt_name")
	tipItem.txtCost = gohelper.findChildText(tipItem.tipGo, "cost/#txt_num")
	tipItem.imageCostType = gohelper.findChildImage(tipItem.tipGo, "cost/icon/#image_point")
	tipItem.txtQteSkillDesc = gohelper.findChildText(tipItem.tipGo, "qte/#txt_qte")

	SkillHelper.addHyperLinkClick(tipItem.txtQteSkillDesc)

	tipItem.extraItem = gohelper.findChild(tipItem.tipGo, "extra/#txt_extra")

	gohelper.setActive(tipItem.extraItem, false)

	tipItem.extraItemList = {}
	tipItem.goLine = gohelper.findChild(tipItem.tipGo, "line")

	return tipItem
end

function FightQteTipView:createTipExtraItem(goExtraItem)
	local extraItem = self:getUserDataTb_()

	extraItem.goExtraItem = gohelper.cloneInPlace(goExtraItem)
	extraItem.txtExtra = extraItem.goExtraItem:GetComponent(gohelper.Type_TextMesh)

	SkillHelper.addHyperLinkClick(extraItem.txtExtra)

	return extraItem
end

function FightQteTipView:refreshTipItem(tipItem, entityMo)
	gohelper.setActive(tipItem.tipGo, true)
	tipItem.entityItem:refreshUI()

	local entityName = entityMo:getEntityName()
	local groupCo = entityMo:getQteGroupCo()
	local activeSkillCo = groupCo and lua_skill.configDict[groupCo.activeId]

	if activeSkillCo then
		local costType, cost = FightHelper.getQTESkillCost(activeSkillCo)

		tipItem.txtCost.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_common_double_param"), luaLang("multiple"), cost)

		local image = FightQteEntityItemHelper.getCostTypeImage(costType)

		UISpriteSetMgr.instance:setFightSprite(tipItem.imageCostType, image)

		tipItem.txtQteSkillDesc.text = SkillHelper.getSkillDesc(entityName, activeSkillCo)
		tipItem.txtName.text = activeSkillCo.name
	end

	local extraIndex = 0
	local passive1Co = groupCo and lua_skill.configDict[groupCo.passiveId1]

	if passive1Co then
		extraIndex = extraIndex + 1

		local extraItem = tipItem.extraItemList[extraIndex]

		if not extraItem then
			extraItem = self:createTipExtraItem(tipItem.extraItem)

			table.insert(tipItem.extraItemList, extraItem)
		end

		extraItem.txtExtra.text = SkillHelper.getSkillDesc(entityName, passive1Co)

		gohelper.setActive(extraItem.goExtraItem, true)
	end

	local passive2Co = groupCo and lua_skill.configDict[groupCo.passiveId2]

	if passive2Co then
		extraIndex = extraIndex + 1

		local extraItem = tipItem.extraItemList[extraIndex]

		if not extraItem then
			extraItem = self:createTipExtraItem(tipItem.extraItem)

			table.insert(tipItem.extraItemList, extraItem)
		end

		extraItem.txtExtra.text = SkillHelper.getSkillDesc(entityName, passive2Co)

		gohelper.setActive(extraItem.goExtraItem, true)
	end

	for i = extraIndex + 1, #tipItem.extraItemList do
		local extraItem = tipItem.extraItemList[i]

		gohelper.setActive(extraItem.goExtraItem, false)
	end
end

function FightQteTipView:onDestroyView()
	tabletool.clear(EntityMoList)

	for _, tipItem in pairs(self.tipItemDict) do
		if tipItem.entityItem then
			tipItem.entityItem:dispose()

			tipItem.entityItem = nil
		end
	end

	tabletool.clear(self.tipItemDict)
end

return FightQteTipView
